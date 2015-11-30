<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
    
<%	
	String errorMsg = null;

	String actionUrl = "";
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";

	// 사용자 정보를 위한 변수 초기화
	String project_id = "";
	String project_name = "";
	String worker_id = "";
	String worker_name = "";
	String project_start = "";
	String project_finish = "";
	String project_owner = "";
	String project_describe = "";

	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("userId"));
	} catch (Exception e) {
	}

	if (id > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "projectUpdate.jsp";

		try {
			Class.forName("com.mysql.jdbc.Driver");

			// DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM project WHERE project_id = ?");
			stmt.setInt(1, id);

			// 수행
			rs = stmt.executeQuery();

			if (rs.next()) {
				project_id = rs.getString("project_id");
				project_name = rs.getString("project_name");
				worker_id = rs.getString("worker_id");
				worker_name = rs.getString("worker_name");
				project_start = rs.getString("project_start");
				project_finish = rs.getString("project_finish");
				project_owner = rs.getString("project_owner");
				project_describe = rs.getString("project_describe");

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
		actionUrl = "projectRegister.jsp";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Make Project</title>
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
					<legend class="legend">make project</legend>

				
			  		<div class="form-group ">
						<label class="col-sm-2 control-label" for="id">프로젝트 ID</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="id" value="<%=project_id%>">
						</div>
					</div>
					
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="name">프로젝트명</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" placeholder="A프로젝트" name="name" value="<%=project_name%>">
						</div>
					</div>
					
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="PMId">PM id</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="PMId" value="<%=worker_id%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="PMName">PM명</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="PMName" value="<%=worker_name%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="start">시작일</label>
						<div class="col-sm-3">
							<input type="datetime" class="form-control" name="start" value="<%=project_start%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="finish">종료일</label>
						<div class="col-sm-3">
							<input type="datetime" class="form-control" name="start" value="<%=project_finish%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="pro_owner">발주처</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="pro_owner" value="<%=project_owner%>">
						</div>
					</div>


					<div class="form-group ">
						<label class="col-sm-2 control-label" for="describe">설명</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="describe" value="<%=project_describe%>">
						</div>
					</div>
	
					<div class="form-group">
						<input type=button value="Cancel" OnClick="javascript:history.back(-1)" class="col-sm-offset-2 btn btn-default">
						<% if (id <= 0) { %>
						<input type="submit" class="btn btn-default btn-primary" value="add">
						<% } else { %>
						<input type="submit" class="btn btn-default btn-primary" value="Modify">
						<% } %>
					</div>
				</fieldset>
			</form>
		</div>
	</div>

 </body>
</html> 