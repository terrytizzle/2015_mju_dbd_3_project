<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<%
	String errorMsg = null;

	String actionUrl = "";
		
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Page Name</title>
<link href="http://localhost:8080/2015_mju_dbd_3_project/css/bootstrap.min.css" rel="stylesheet">
<link href="http://localhost:8080/2015_mju_dbd_3_project/css/base.css" rel="stylesheet">
<script src="http://localhost:8080/2015_mju_dbd_3_project/js/jquery-1.8.2.min.js"></script>
<script src="http://localhost:8080/2015_mju_dbd_3_project/js/bootstrap.min.js"></script>
</html>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>

	<div class="container">
		<div>
			<form class="form-horizontal" action="<%=actionUrl%>" method="post">
				<fieldset>
					<legend class="legend"> TITLE</legend>








				</fieldset>
			</form>
		</div>
	</div>
</body>