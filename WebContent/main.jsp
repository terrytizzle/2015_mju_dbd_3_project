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
<title>main page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
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
					<div id="warp">
						<div id="top">
							<p>환영합니다. 000님</p>
						</div id="logo">
						<div>
							<fieldset>
								<h1>인사관리시스템</h1>
							</fieldset>
						</div>
						<div id="middle">
							<div id="menu">
								<fieldset>
									<p>success m</p>
									<a class="nodec" href="./">A</a></br> <a class="nodec" href="./">B</a></br>
									<a class="nodec" href="./">C</a></br> <a class="nodec" href="./">D</a></br>
								</fieldset>
							</div>
							<div id="maincontents">
								<fieldset>
									<p>success main</p>
									<fieldset>
										<legend>main content</legend>
										<p>
											MJ solution <br>
									</fieldset>
								</fieldset>
							</div>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>

</body>