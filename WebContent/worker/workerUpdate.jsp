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
	String user_birth = request.getParameter("birth");
	String user_dept = request.getParameter("dept");
	String user_salary = request.getParameter("salary");
	String user_entrance = request.getParameter("entrance");
	String user_terminate = request.getParameter("terminate");
	String user_email = request.getParameter("email");
	String user_final_edu = request.getParameter("final_edu");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (user_name == null || user_name.trim().length() == 0) {
		errorMsgs.add("이름를 반드시 입력해주세요.");
	} else if (user_birth == null || user_birth.trim().length() == 0) {
		errorMsgs.add("생일을 반드시 입력해주세요.");
	} else if (user_dept == null || user_dept.trim().length() == 0) {
		errorMsgs.add("부서를 반드시 입력해주세요.");
	} else if (user_salary == null || user_salary.trim().length() == 0) {
		errorMsgs.add("연봉을 반드시 입력해주세요.");
	} else if (user_entrance == null || user_entrance.trim().length() == 0) {
		errorMsgs.add("입사일자를 반드시 입력해주세요.");
	} else if (user_email == null || user_email.trim().length() == 0) {
		errorMsgs.add("메일 주소를 반드시 입력해주세요.");
	} else if (user_final_edu == null || user_final_edu.trim().length() == 0) {
		errorMsgs.add("최종 학력을 반드시 입력해주세요.");
	}

	if(user_terminate == ""){
		user_terminate = "1990-01-01";
	}
	
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"UPDATE worker " +
					"SET worker_name=?, worker_birth=?, worker_dept=?, worker_salary=?, worker_entrance=?, worker_terminate=?, worker_email=?, worker_final_edu=?" +
					"WHERE worker_id=?"
					);
			
			stmt.setString(1, user_name);
			stmt.setString(2, user_birth);
			stmt.setString(3, user_dept);
			stmt.setString(4, user_salary);
			stmt.setString(5, user_entrance);
			stmt.setString(6, user_terminate);
			stmt.setString(7, user_email);
			stmt.setString(8, user_final_edu);
			stmt.setInt(9, id);
			
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
<link href="http://localhost:9090/2015_mju_dbd_3_project/css/bootstrap.min.css" rel="stylesheet">
<link href="http://localhost:9090/2015_mju_dbd_3_project/css/base.css" rel="stylesheet">
<script src="http://localhost:9090/2015_mju_dbd_3_project/js/jquery-1.8.2.min.js"></script>
<script src="http://localhost:9090/2015_mju_dbd_3_project/js/bootstrap.min.js"></script>

<body>

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
				<%=user_terminate %>
			</ul>
		</div>
		<div class="form-group">
			<a onclick="history.back();" class="btn btn-default">뒤로 돌아가기</a>
		</div>
		<% } else if (result == 1) { %>
		<div class="alert alert-success">
			<b><%= user_name %></b>님 정보가 수정되었습니다.
		</div>
		<div class="form-group">
			<a href="../main.jsp" class="btn btn-default">목록으로</a>
		</div>
		<%}%>
	</div>
	

</body>
</html>