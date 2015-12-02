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
	
	
	
	String proj_id = request.getParameter("id");
	String proj_name = request.getParameter("name");
/*	String user_id = request.getParameter("PMId");
	String user_name = request.getParameter("PMName");*/
	String proj_start = request.getParameter("start");
	String proj_finish = request.getParameter("finish");
	String proj_owner = request.getParameter("pro_owner");
	String proj_describe = request.getParameter("describe");
	
	
	List <String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (proj_id == null || proj_id.trim().length() == 0) {
		errorMsgs.add("프로젝트ID를 반드시 입력해주세요.");
	} else if (proj_name == null || proj_name.trim().length() == 0) {
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
					"INSERT INTO project(project_id, project_name, project_start, project_finish, project_owner, project_describe) " +
					"VALUES(?, ?, ?, ?, ?, ?)"
					);
			stmt.setString(1, proj_id);
			stmt.setString(2, proj_name);
/*			stmt.setString(3, user_id);
			stmt.setString(4, user_name); */
			stmt.setString(3, proj_start);
			stmt.setString(4, proj_finish);
			stmt.setString(5, proj_owner);
			stmt.setString(6, proj_describe);
			
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




<!DOCTYPE html>
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

	<%
	 if(session.getAttribute("userId") == null){ 
	%>

	<script type=text/javascript>
			alert("권한이 없습니다. 로그인하세요.");
			window.location.replace("../login.jsp");
		</script>
	<%
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
		 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
		 	</div>
	 	<% } else if (result == 1) { %>
	 		<div class="alert alert-success">
	 			<b><%= proj_name %></b>가 등록되었습니다.
	 		</div>
		 	<div class="form-group">
		 		<a href="../main.jsp" class="btn">목록으로</a>
		 	</div>
	 		
	 	<%}%>
 	</div>




</body>