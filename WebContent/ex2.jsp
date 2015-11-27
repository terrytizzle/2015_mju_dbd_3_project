<%@ page language ="java" contentType ="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> 로그인 기능 test</title>
</head>
<body>
	<% if (session.getAttribute("userId") == null) { %>
	<p>login</p>
	<p><a href="login.jsp">로그인</a></p>
	<% } else { %>
	<p> 로그인 성공.</p> <br>
		사원이름 : <%= session.getAttribute("userName") %><br>
		<a href="logout.jsp">로그아웃</a>
		<a href="main.jsp">메인으로</a>
	<% } %> 
</body>
</html>