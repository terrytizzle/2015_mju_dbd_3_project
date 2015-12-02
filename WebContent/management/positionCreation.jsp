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
	String user_pname = "";
	

	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("userId"));
	} catch (Exception e) {
	}

	if (id > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "positionUpdate.jsp";

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
				user_pname = rs.getString("pos_name");
		
				

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

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>직급 변경</title>
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
					<legend class="legend">직급 변경</legend>

<table class="table table-bordered table-stripped">
			<tbody>
				<tr>

					<th><div class="form-group ">
						<label class="col-sm-2 control-label" for="id">직원 ID</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="id" value="<%=user_id%>">
						</div>
					</div></th>
				</tr>
				<tr>
					<th>
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="name">직원 이름</label>
						<div class="col-sm-3">
							 <input type="text" class="form-control" name="name"value="<%=user_name%>">
						</div>
					</div>
					</th>
				</tr>
				<tr>
					<th>
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="name">현재 직급</label>
						<div class="col-sm-3">
							<%=user_pname%>
						</div>
					</div>
					</th>
				</tr>
				<tr>
					<th>
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="pname">직급 변경</label>
						<div class="col-sm-3">
														<p>
							사장<input type="radio" name="pname" value="사장">
							</p>
														<p>
							이사<input type="radio" name="pname" value="이사">
							</p>
														<p>
							부장<input type="radio" name="pname" value="부장">
							</p>
														<p>
							차장<input type="radio" name="pname" value="차장">
							</p>
														<p>
							과장<input type="radio" name="pname" value="과장">
							</p>
														<p>
							대리<input type="radio" name="pname" value="대리">
							</p>
														<p>
							사원<input type="radio" name="pname" value="사원" checked >
							</p>
							
						</div>
					</div>
					</th>
				</tr>
				</tbody>
				</table>
					
					<div class="form-group">
						<input type=button value="Cancel" OnClick="javascript:history.back(-1)" class="col-sm-offset-2 btn btn-default">

						<input type="submit" class="btn btn-default btn-primary" value="Modify">
						
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>