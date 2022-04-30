<%@page import="program.Student"%>
<%@page import="program.Teacher"%>
<%@page import="program.Subject"%>
<%@page import="program.Classes"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="program.HibernateUtil"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="WelcomePage.html">Back to Main Menu</a><br>
<%String clas = request.getParameter("class");%>
<h1>Class Report for <%=clas%></h1>

<%
	SessionFactory sf  = HibernateUtil.getSessionFactory();
	Session hibernateSession = sf.openSession();
	List<Classes> classes = hibernateSession.createQuery("from Classes cl where cl.name='" + clas + "'").list();
	Classes clasForReport = classes.get(0);
%>
<table>
<tr>
<th>Subject Name </th>
<th>Teacher Name </th>
</tr>
<%	
	for(Subject subject: clasForReport.getSubjects()){
		out.print("<tr>");	
		out.print("<td>" + subject.getName() + "</td>");
		out.print("<td>" + getTeacherName(subject) + "</td>");
		out.print("</tr>");
	}
%>
</table>
<%!
	public String getTeacherName(Subject subject){
		Teacher teacher = subject.getTeacher();
		String name;
		String lname;
	
		if(teacher != null){
			name=teacher.getfname();
			lname = teacher.getLname();
			
			return name + " " + lname;
		}else{
			return "No Teacher assigned";
		}
}
%>
<table>
<br>
<tr>
<th>Listed Students</th>
</tr>
<%
	for(Student student : clasForReport.getStudents()){
		out.print("<tr>");
		out.print("<td>" + student.getfname() + " " + student.getlname() + "</td>");
		out.print("</tr>");
	}
%>
</table>
</body>
</html>