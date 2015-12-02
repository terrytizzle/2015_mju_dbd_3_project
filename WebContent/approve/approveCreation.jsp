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
	String proj_start = "";
	String proj_finish = "";
	String proj_owner = "";
	String proj_describe = "";
	String proj_status = "";
	
	// Request로 ID가 있는지 확인
	int project = 0;
	try {
		project = Integer.parseInt(request.getParameter("projectId"));
	} catch (Exception e) {
	}

	if (project > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "approveUpdate.jsp";
		
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
				proj_status = rs.getString("project_status");
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
		actionUrl = "approveRegister.jsp";
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
		<div>
		  <form class="form-horizontal" action="<%=actionUrl%>" method="post">
				<fieldset>
					<legend class="legend">프로젝트 승인확인</legend>

					
					<%
					  	if (project > 0) {
					  		out.println("<input type='hidden' name='id' value='"+project+"'>");
					  	}
				  	%>
					
				  	<%if(project<=0){ %>
				  	<div class="form-group">
				  		<h1>프로젝트 ID</h1>
				  	<%}  %>	
				  		<table class="table table-bordered table-stripped">
							<thead>
								<tr>
									<th>프로젝트 ID</th>
									<td><%=proj_id%></td>
								</tr>
							</thead>
			  				<thead>
								<tr>
									<th>프로젝트명</th>
									<td><%=proj_name%></td>
								</tr>
							</thead>
			  				<thead>
								<tr>
									<th>시작일</th>
									<td><%=proj_start%></td>
								</tr>
							</thead>
			  				<thead>
								<tr>
									<th>종료일</th>
									<td><%=proj_finish%></td>
								</tr>
							</thead>
			  				<thead>	
								<tr>
									<th>발주처</th>
									<td><%=proj_owner%></td>
								</tr>
							</thead>
			  				<thead>
								<tr>
									<th>프로젝트 설명</th>
									<td><%=proj_describe%></td>
								</tr>
							</thead>	
							</tbody>
				  		</table>
				  	</div>
				  
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="status">승인 상태</label>
						<div class="col-sm-3">
							<p>
							승인 허가<input type="radio" name="status" value="1">
							</p>
							<p>
							승인 대기<input type="radio" name="status" value="0" checked >
							</p>
							
						</div>
					</div>
					
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