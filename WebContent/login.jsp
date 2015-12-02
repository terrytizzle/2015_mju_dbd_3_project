<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" buffer="8kb"%>
<%@ page import="java.sql.*"%>

<%
	String errorMsg = null;
	String actionUrl;

	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	PreparedStatement stmt2 = null;
	PreparedStatement stmt3 = null;
	ResultSet rs = null;
	
	
	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";

	// 사용자 정보를 위한 변수 초기화
	String user_id = "";
	String user_name = "";
	String user_pwd = "";
	String user_birth = "";
	String user_dept = "";
	String user_salary = "";
	String user_entrance = "";
	String user_terminate = "";
	String user_email = "";
	String user_final_edu = "";
	String user_pos_name = "";
	String userWorks_name = "";
	String user_project_id = "";
	
	//post
	String id = request.getParameter("id");
	String name_ = request.getParameter("name_");
	String password = request.getParameter("password");

	boolean login = false;

	try {
		Class.forName("com.mysql.jdbc.Driver");

		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.prepareStatement("SELECT * FROM worker");
		
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			user_id = rs.getString("worker_id");
			user_name = rs.getString("worker_name");
			user_pwd = rs.getString("worker_pswd");
			user_birth = rs.getString("worker_birth");
			user_dept = rs.getString("worker_dept");
			user_salary = rs.getString("worker_salary");
			user_entrance = rs.getString("worker_entrance");
			user_terminate = rs.getString("worker_terminate");
			user_email = rs.getString("worker_email");
			user_final_edu = rs.getString("worker_final_edu");
			user_pos_name = rs.getString("pos_name");
			
			

			
			if (user_id.equals(id) && user_pwd.equals(password)) {
				// 로그인 성공
				session.setAttribute("userId", user_id);
				session.setAttribute("userName", user_name);
				session.setAttribute("userPwd", user_pwd);
				session.setAttribute("userBirth", user_birth);
				session.setAttribute("userDept", user_dept);
				session.setAttribute("userSalary", user_name);
				session.setAttribute("userEntrance", user_entrance);
				session.setAttribute("userTerminate", user_terminate);
				session.setAttribute("userEmail", user_email);
				session.setAttribute("userFinaledu", user_final_edu);
				session.setAttribute("userPosname", user_pos_name);
				login = true;
				break;
			}
		}
		
		stmt2 = conn.prepareStatement("select works_name from works_For where worker_id='" + user_id +"'");
		rs = stmt2.executeQuery();
		while (rs.next()) {
			userWorks_name = rs.getString("works_name");
			if(userWorks_name.equals(null)){
				userWorks_name = "임시";
				session.setAttribute("userWorks_name", userWorks_name);
			}else{
			session.setAttribute("userWorks_name", userWorks_name);
			}
		}
		
		stmt3 = conn.prepareStatement("select project_id from works_For where worker_id='" + user_id +"'");
		rs = stmt3.executeQuery();
		while (rs.next()) {
			user_project_id = rs.getString("project_id");

			session.setAttribute("userProject_id", user_project_id);
		}
		
	} catch (SQLException e) {
		errorMsg = "SQL 에러 : " + e.getMessage();
	} finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException e) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException e) {
			}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="login" />
	</jsp:include>

	<div class="container">
		<form class="form-horizontal" action="" method="post">
			<fieldset>
				<legend class="legend">Login</legend>
				<%
					if (errorMsg != null && errorMsg.length() > 0) {
						// SQL 에러의 경우 에러 메시지 출력
						out.print("<div class='alert'>" + errorMsg + "</div>");
					}
					if (request.getMethod() == "POST") {
						if (id == null || password == null || id.length() == 0 || password.length() == 0) {
				%>
				<div class="error">아이디와 비밀번호를 입력하세요.</div>
				<%
					} else if (login) {
							// 로그인 성공
				%>
				<script type=text/javascript>
					alert(" 로그인 하였습니다.");
					window.location.replace("main.jsp");
				</script>
				<%
					} else {
				%>
				<div class="error">아이디나 비밀번호가 잘못되었습니다.</div>
				<%
					}
					}
				%>

				<div class="form-group ">
					<label class="col-sm-2 control-label" for="userid">ID</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" name="id">
					</div>
				</div>
				<div class="form-group ">
					<label class="col-sm-2 control-label" for="pwd">Password</label>
					<div class="col-sm-3">
						<input type="password" class="form-control" name="password">
					</div>
				</div>

				<div class="form-group">
					<input type=button value="Cancel" OnClick="javascript:history.back(-1)" class="col-sm-offset-2 btn btn-default"> <input type="submit" class="btn btn-default btn-primary" value="Login">
				</div>
			</fieldset>
		</form>
	</div>

</body>
</html>