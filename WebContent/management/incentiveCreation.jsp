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
	String incentive = "";
	

	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("userId"));
	} catch (Exception e) {
	}

	if (id > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "incentiveUpdate.jsp";

		try {
			Class.forName("com.mysql.jdbc.Driver");

			// DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM worker natural join personal_management WHERE worker_id = ?");
			stmt.setInt(1, id);

			// 수행
			rs = stmt.executeQuery();

			if (rs.next()) {
				user_id = rs.getString("worker_id");
				user_name = rs.getString("worker_name");
				incentive = rs.getString("incentive");

				
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
		actionUrl = "incentiveUpdate.jsp";
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인센티브 지급</title>
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
					<legend class="legend">인센티브 지급</legend>

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
						<label class="col-sm-2 control-label" for="name">현재 인센티브</label>
						<div class="col-sm-3">
							<%=incentive%>%
						</div>
					</div>
					</th>
				</tr>
				<tr>
					<th>
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="incentive">지급할 인센티브</label>
						<div class="col-sm-3">
							 <input type="text" class="form-control" name="incentive"value="<%=incentive%>">
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