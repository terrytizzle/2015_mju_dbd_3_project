<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*" import="java.util.*" 
    %>

<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";
	
	request.setCharacterEncoding("utf-8");
	
	String user_id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String pwd_confirm = request.getParameter("pwd_confirm");
	String user_name = request.getParameter("name");
	String user_birth = request.getParameter("birth");
	String user_dept = request.getParameter("dept");
	String user_salary = request.getParameter("salary");
	String user_enterance = request.getParameter("enterance");
	String user_terminate = request.getParameter("terminate");
	String user_email = request.getParameter("email");
	String user_final_edu = request.getParameter("final_edu");
	String user_pos_name = request.getParameter("pos_name");
	
	
	List <String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (user_id == null || user_id.trim().length() == 0) {
		errorMsgs.add("ID를 반드시 입력해주세요.");
	} else if (pwd == null || pwd.length() < 6) {
		errorMsgs.add("비밀번호는 6자 이상 입력해주세요.");
	} else if (!pwd.equals(pwd_confirm)) {
		errorMsgs.add("비밀번호가 일치하지 않습니다.");
	} else if (user_birth == null || user_birth.trim().length() == 0) {
		errorMsgs.add("생일을 반드시 입력해주세요.");
	} else if (user_dept == null || user_dept.trim().length() == 0) {
		errorMsgs.add("부서를 반드시 입력해주세요.");
	} else if (user_salary == null || user_salary.trim().length() == 0) {
		errorMsgs.add("연봉을 반드시 입력해주세요.");
	} else if (user_enterance == null || user_enterance.trim().length() == 0) {
		errorMsgs.add("입사일자를 반드시 입력해주세요.");
	} else if (user_email == null || user_email.trim().length() == 0) {
		errorMsgs.add("메일 주소를 반드시 입력해주세요.");
	} else if (user_final_edu == null || user_final_edu.trim().length() == 0) {
		errorMsgs.add("최종 학력을 반드시 입력해주세요.");
	} else if (user_pos_name == null || user_pos_name.trim().length() == 0) {
		errorMsgs.add("직급을 반드시 입력해주세요.");
	}
	
	
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO worker(worker_id, worker_name, worker_pswd, worker_birth, worker_dept, worker_salary, worker_enterance, worker_ternimate, worker_email, worker_final_edu, pos_name) " +
					"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
					);
			stmt.setString(1, user_id);
			stmt.setString(2, user_name);
			stmt.setString(3, pwd);
			stmt.setString(4, user_birth);
			stmt.setString(5, user_dept);
			stmt.setString(6, user_salary);
			stmt.setString(7, user_enterance);
			stmt.setString(8, user_terminate);
			stmt.setString(9, user_email);
			stmt.setString(10, user_final_edu);
			stmt.setString(11, user_pos_name);
			
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