<%@ page language ="java" contentType ="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
	로그아웃 되었습니다.
	<p>
	<a href="ex2.jsp">페이지로 돌아가기</a>
	<a href="main.jsp">메인으로</a>
</body>
</html>