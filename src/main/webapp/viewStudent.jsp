<%@page import="program.Student"%>
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
<a href="addStudent.html">Add Student</a><br>
<a href="assignStudentToClass.jsp">Assign Student</a>

<h1>The Following Students are listed</h1>
<%
	SessionFactory sf  = HibernateUtil.getSessionFactory();
	Session hibernateSession = sf.openSession();
	List<Student> students = hibernateSession.createQuery("from Student").list();
%>
<table>
<tr>
<th>Name </th>
<th>Last Name </th>
<th>Assigned Class </th>
</tr>
	<%		
		for(Student student : students){
			out.print("<tr>");	
			out.print("<td>" + student.getfname() + "</td>");
			out.print("<td>" + student.getlname() + "</td>");
			out.print("<td>" + getClassName(student) + "</td>");
			out.print("</tr>");	
		}
	%>
</table>

<%!
	public String getClassName(Student student){
	if (student.getClasses() == null){
		return "no class assigned";
	}
	else{
		return student.getClasses().getName();
	}
}
%>
</body>
</html>