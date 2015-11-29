<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String errorMsg = null;

	String actionUrl;
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";

	// 사용자 정보를 위한 변수 초기화
	String user_id = "";
	String user_name = "";
	String user_pswd = "";
	String user_birth = "";
	String user_dept = "";
	String user_salary = "";
	String user_entrance = "";
	String user_terminate = "";
	String user_email = "";
	String user_final_edu = "";

	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("userId"));
	} catch (Exception e) {
	}

	if (id > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "workerUpdate.jsp";

		try {
			Class.forName("com.mysql.jdbc.Driver");

			// DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM worker WHERE worker_id = ?");
			stmt.setInt(1, id);

			// 수행
			rs = stmt.executeQuery();

			if (rs.next()) {
				user_id = rs.getString("worker_id");
				user_name = rs.getString("worker_name");
				user_pswd = rs.getString("worker_pswd");
				user_birth = rs.getString("worker_birth");
				user_dept = rs.getString("worker_dept");
				user_salary = rs.getString("worker_salary");
				user_entrance = rs.getString("worker_entrance");
				user_terminate = rs.getString("worker_terminate");
				user_email = rs.getString("worker_email");
				user_final_edu = rs.getString("worker_final_edu");
				

			}
		} catch (SQLException e) {
			errorMsg = "SQL 에러: " + e.getMessage();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
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
	} else {
		actionUrl = "workerRegister.jsp";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Worker Management</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</head>

<body>

	<jsp:include page="../share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>

	<div class="container">
		<div>
			<form class="form-horizontal" action="<%=actionUrl%>" method="post">
				<fieldset>
					<legend class="legend">Sign Up</legend>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="id">ID</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="id"
								value="<%=user_id%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="name">Name</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" placeholder="홍길동"
								name="name" value="<%=user_name%>">
						</div>
					</div>

					<%-- 신규 가입일 때만 비밀번호 입력창을 나타냄 --%>
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="pwd">Password</label>
						<div class="col-sm-3">
							<input type="password" class="form-control" name="pwd">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="pwd_confirm">Password
							Confirmation</label>
						<div class="col-sm-3">
							<input type="password" class="form-control" name="pwd_confirm">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="birth">Birth</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" placeholder="1990-10-09"
								name="birth" value="<%=user_birth%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="dept">Department</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="dept"
								value="<%=user_dept%>">
						</div>
					</div>


					<div class="form-group ">
						<label class="col-sm-2 control-label" for="salary">Salary</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="salary"
								value="<%=user_salary%>">
						</div>
					</div>


					<div class="form-group ">
						<label class="col-sm-2 control-label" for="entrance">Entrance</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="entrance"
								value="<%=user_entrance%>">
						</div>
					</div>


					<div class="form-group ">
						<label class="col-sm-2 control-label" for="terminate">Terminate</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="terminate"
								value="<%=user_terminate%>">
						</div>
					</div>


					<div class="form-group ">
						<label class="col-sm-2 control-label" for="email">E-mail</label>
						<div class="col-sm-3">
							<input type="email" class="form-control"
								placeholder="WOW@blizzard.com" name="email"
								value="<%=user_email%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="final_edu">Final_Edu</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="final_edu"
								value="<%=user_final_edu%>">
						</div>
					</div>

					<div class="form-group">
						<input type=button value="Cancel"
							OnClick="javascript:history.back(-1)"
							class="col-sm-offset-2 btn btn-default"> <input
							type="submit" class="btn btn-default btn-primary" value="Create">
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>