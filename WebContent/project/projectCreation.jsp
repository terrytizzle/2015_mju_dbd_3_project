<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

	
	
	// 프로젝트 정보를 위한 변수 초기화
	String proj_id = "";
	String proj_name = "";
	String user_id = "";
	String user_name = "";
	String proj_start = "";
	String proj_finish = "";
	String proj_owner = "";
	String proj_describe = "";

	// Request로 ID가 있는지 확인
	int project = 0;
	try {
		project = Integer.parseInt(request.getParameter("projectId"));
	} catch (Exception e) {
	}

	if (project > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "projectUpdate.jsp";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");

			// DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM project WHERE project_id = ?");
			stmt.setInt(1, project);

			// 수행
			rs = stmt.executeQuery();

			if (rs.next()) {
				proj_id = rs.getString("project_id");
				proj_name = rs.getString("project_name");
				proj_start = rs.getString("project_start");
				proj_finish = rs.getString("project_finish");
				proj_owner = rs.getString("project_owner");
				proj_describe = rs.getString("project_describe");

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
<!DOCTYPE html>
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
					<legend class="legend">Make project</legend>

					<%
					  	if (project > 0) {
					  		out.println("<input type='hidden' name='id' value='"+project+"'>");
					  	}
				  	%>
				  	<%if(project<=0){ %>
			  		<div class="form-group ">
						<label class="col-sm-2 control-label" for="id">프로젝트 ID</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="id" value="<%=proj_id%>">
						</div>
					</div>
					<%}  %>	
					
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="name">프로젝트명</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" placeholder="A프로젝트" name="name" value="<%=proj_name%>">
						</div>
					</div>
					
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="start">시작일</label>
						<div class="col-sm-3">
							<input type="datetime" class="form-control" name="start" value="<%=proj_start%>">
						</div>
					</div>

						<div class="form-group ">
						<label class="col-sm-2 control-label" for="start">종료일</label>
						<div class="col-sm-3">
							<input type="datetime" class="form-control" name="finish" value="<%=proj_finish%>">
						</div>
					</div>
					
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="pro_owner">발주처</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="pro_owner" value="<%=proj_owner%>">
						</div>
					</div>


					<div class="form-group ">
						<label class="col-sm-2 control-label" for="describe">설명</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="describe" value="<%=proj_describe%>">
						</div>
					</div>
					
					
					<div class="form-group">
						<input type=button value="Cancel" OnClick="javascript:history.back(-1)" class="col-sm-offset-2 btn btn-default">
						<% if (project <= 0) { %>
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