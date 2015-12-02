<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<%
	String errorMsg = null;

	String actionUrl = "";
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Page Name</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
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



					<%
						if (session.getAttribute("userId") == null) {	// 접근제어 폼
					%>

					<script type=text/javascript>
						alert("권한이 없습니다. 로그인하세요.");
						window.location.replace("login.jsp");
					</script>
					<%
						}
					%>




				</fieldset>
			</form>
		</div>
	</div>
</body>