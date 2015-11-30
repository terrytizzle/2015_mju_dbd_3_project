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
	String proj_id = request.getParameter("id");
	String proj_name = request.getParameter("name");
/*	String user_id = request.getParameter("PMId");
	String user_name = request.getParameter("PMName");*/
	String proj_start = request.getParameter("start");
	String proj_finish = request.getParameter("finish");
	String proj_owner = request.getParameter("pro_owner");
	String proj_describe = request.getParameter("describe");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (proj_name == null || proj_name.trim().length() == 0) {
		errorMsgs.add("프로젝트명을 반드시 입력해주세요.");
/*	} else if (user_id == null || user_id.trim().length() == 0) {
		errorMsgs.add("부서를 반드시 입력해주세요.");
	} else if (user_name == null || user_name.trim().length() == 0) { 
		errorMsgs.add("연봉을 반드시 입력해주세요."); */
	} else if (proj_start == null || proj_start.trim().length() == 0) {
		errorMsgs.add("프로젝트 시작일자를 반드시 입력해주세요.");
	} else if (proj_finish == null || proj_finish.trim().length() == 0) {
		errorMsgs.add("프로젝트 종료일자를 반드시 입력해주세요.");
	} else if (proj_owner == null || proj_owner.trim().length() == 0) {
		errorMsgs.add("발주처를 반드시 입력해주세요.");
	}

	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"UPDATE project " +
					"SET project_name=?" +
					"WHERE project_id=?"
					);
			stmt.setString(1, proj_name);
			stmt.setString(2, proj_id);
			
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


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
			<b><%= proj_name %></b>의 정보가 수정되었습니다.
		</div>
		<div class="form-group">
			<a href="../main.jsp" class="btn btn-default">목록으로</a>
		</div>
		<%}%>
	</div>
	



</body>