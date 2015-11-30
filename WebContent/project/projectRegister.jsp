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
	
	String project_id = rs.getString("project_id");
	String project_name = rs.getString("project_name");
	String worker_id = rs.getString("worker_id");
	String worker_name = rs.getString("worker_name");
	String project_start = rs.getString("project_start");
	String project_finish = rs.getString("project_finish");
	String project_owner = rs.getString("project_owner");
	String project_describe = rs.getString("project_describe");
	
	List <String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (project_id == null || project_id.trim().length() == 0) {
		errorMsgs.add("프로젝트 ID를 반드시 입력해주세요.");
	} else if (project_name == null || project_name.length() < 6) {
		errorMsgs.add("프로젝트명을 반드시 입력해주세요.");
	} else if (worker_id == null || worker_id.trim().length() == 0) {
		errorMsgs.add("PM Id를 반드시 입력해주세요.");
	} else if (worker_name == null || worker_name.trim().length() == 0) {
		errorMsgs.add("PM명을 반드시 입력해주세요.");
	} else if (project_start == null || project_start.trim().length() == 0) {
		errorMsgs.add("시작일을 반드시 입력해주세요.");
	} else if (project_finish == null || project_finish.trim().length() == 0) {
		errorMsgs.add("종료일을 반드시 입력해주세요.");
	} else if (project_owner == null || project_owner.trim().length() == 0) {
		errorMsgs.add("발주처를 반드시 입력해주세요.");
	}
	
	
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO project(project_id, project_name, project_start, project_finish, project_owner, project_describe ) " +
					"VALUES(?, ?, ?, ?, ?, ?)"
					);
			stmt.setString(1, project_id);
			stmt.setString(2, project_name);
			stmt.setString(3, project_start);
			stmt.setString(4, project_finish);
			stmt.setString(5, project_owner);
			stmt.setString(6, project_describe);
			
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("등록에 실패하였습니다.");
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




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>main page</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</head>
</html>
<body>
	<jsp:include page="../share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>

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
		 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
		 	</div>
	 	<% } else if (result == 1) { %>
	 		<div class="alert alert-success">
	 			<b><%= user_name %></b>님이 등록되었습니다.
	 		</div>
		 	<div class="form-group">
		 		<a href="../main.jsp" class="btn">목록으로</a>
		 	</div>
	 		
	 	<%}%>
 	</div>




</body>