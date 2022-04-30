package program;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;


/**
 * Servlet implementation class AssignStudent
 */
@WebServlet("/assignStudent")
public class AssignStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AssignStudent() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		@SuppressWarnings("unused")
		PrintWriter out = response.getWriter();
		
		// Step 1: Get details , user has entered
		String name = request.getParameter("name");
		String[] nameList = name.split(" ");
		//System.out.println("NameList: " + nameList);
		String classes = request.getParameter("class");
				
		// Step2: Create session
		SessionFactory sf  = HibernateUtil.getSessionFactory();
		Session session = sf.openSession();
		
		// Step 3: Begin Transaction
		Transaction tx = session.beginTransaction();
		
		String hql_classes= "from Classes where name='" + classes + "'";
		@SuppressWarnings("unchecked")
		List<Classes> clas = session.createQuery(hql_classes).list();
		
		String hql_student = "update Student s set s.classes=:n where s.fname=:sn and s.lname=:fn";
		
		@SuppressWarnings("unchecked")
		Query<Student> query = session.createQuery(hql_student);
		query.setParameter("n", clas.get(0));
		query.setParameter("sn", nameList[0]);
		query.setParameter("fn", nameList[1]);
		
		query.executeUpdate();

		
		// STep5: Commit transaction and close sessoin
		tx.commit();
		session.close();
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/viewStudent.jsp");
        dispatcher.forward(request, response); 
	}

}