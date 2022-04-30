<%@page import="program.Subject"%>
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
<a href="addSubject.html">Add Subject</a><br>

<h1>The Following Subjects are listed</h1>
<%
	SessionFactory sf  = HibernateUtil.getSessionFactory();
	Session hibernateSession = sf.openSession();
	List<Subject> subjects = hibernateSession.createQuery("from Subject").list();
%>
<table>
<tr>
<th>Subject Name </th>
</tr>
	<%		
		for(Subject subject : subjects){
			out.print("<tr>");	
			out.print("<td>" + subject.getName() + "</td>");
			out.print("</tr>");	
		}
	%>
</table>



</body>
</html>