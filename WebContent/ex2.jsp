<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	String errorMsg = null;

	String actionUrl = "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 기능 test</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
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
						if (session.getAttribute("userId") == null) {
					%>
					<p>login</p>
					<p>
						<a href="login.jsp">로그인</a>
					</p>
					<%
						} else {
					%>
					<p>로그인 성공.</p>
					<br> 직원ID :<%=session.getAttribute("userId")%><br> <br>
					직원이름 :<%=session.getAttribute("userName")%><br> <br> 직원생일
					:<%=session.getAttribute("userBirth")%><br> <br> 직원부서 :<%=session.getAttribute("userDept")%><br>
					<br> 직원연봉 :<%=session.getAttribute("userSalary")%><br> <br>
					직원입사일자 :<%=session.getAttribute("userEnterance")%><br> <br>
					직원퇴직일자 :
					<%=session.getAttribute("userTerminate")%><br> <br> 직원이메일
					:
					<%=session.getAttribute("userEmail")%><br> <br> 직원최종학력 :
					<%=session.getAttribute("userFinaledu")%><br> <br> 직원최종학력
					:
					<%=session.getAttribute("userPosname")%><br> <a
						href="logout.jsp">로그아웃</a> <a href="main.jsp">메인으로</a>
					<%
		}
	%>
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>