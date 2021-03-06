<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" import="java.sql.*" import="java.util.*" %>

<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";
	
	request.setCharacterEncoding("utf-8");

	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}
	String user_id = request.getParameter("id");
	String user_name = request.getParameter("name");
	String user_pname = request.getParameter("pname");

	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"UPDATE worker " +
					"SET pos_name=?" +
					"WHERE worker_id=?" +" and worker_name=?"
					);
			
			
			stmt.setString(1, user_pname);
			stmt.setString(2, user_id);
			stmt.setString(3, user_name);
		
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("변경에 실패하였습니다.");
			}
		} catch (SQLException e) {
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main page</title>
<link href="http://localhost:8080/2015_mju_dbd_3_project/css/bootstrap.min.css" rel="stylesheet">
<link href="http://localhost:8080/2015_mju_dbd_3_project/css/base.css" rel="stylesheet">
<script src="http://localhost:8080/2015_mju_dbd_3_project/js/jquery-1.8.2.min.js"></script>
<script src="http://localhost:8080/2015_mju_dbd_3_project/js/bootstrap.min.js"></script>
</html>
<body>
	<jsp:include page="../share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>
	
	<%
		if (session.getAttribute("userId") == null) {
	%>

	<script type=text/javascript>
		alert("잘못된 경로입니다.");
		window.location.replace("../login.jsp");
	</script>
	<%
		}
		if (session.getAttribute("userId") != null) {
			if (!(session.getAttribute("userDept").equals("인사")
					&& session.getAttribute("userPosname").equals("부장"))) {
	%>

	<script type=text/javascript>
		alert("권한이 없습니다.");
		window.location.replace("../main.jsp");
	</script>
	<%
		}
		}
	%>
	<div class="container">
		<% if (errorMsgs.size() > 0) { %>
		<div class="alert alert-danger">
			<h3>Errors:</h3>
			<ul>
				<% for(String msg: errorMsgs) { %>
				<li><%=msg %></li>
				<% } %>
			</ul>
		</div>
		<div class="form-group">
			<a onclick="history.back();" class="btn btn-default">뒤로 돌아가기</a>
		</div>
		<% } else if (result == 1) { %>
		<div class="alert alert-success">
			<b><%= user_name %></b>님의 직급이 <b> <%= user_pname %></b> (으)로 수정되었습니다.
		</div>
		<div class="form-group">
			<a href="workerManagement.jsp" class="btn btn-default">이전 목록으로</a>
		</div>
		<%}%>
	</div>
	



</body>