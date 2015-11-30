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

	// ����� ������ ���� ���� �ʱ�ȭ
	String project_id = "";
	String project_name = "";
	String worker_id = "";
	String worker_name = "";
	String project_start = "";
	String project_finish = "";
	String project_owner = "";
	String project_describe = "";

	// Request�� ID�� �ִ��� Ȯ��
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("userId"));
	} catch (Exception e) {
	}

	if (id > 0) {
		// Request�� id�� ������ update���� ����
		actionUrl = "projectUpdate.jsp";

		try {
			Class.forName("com.mysql.jdbc.Driver");

			// DB ����
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

			// ���� �غ�
			stmt = conn.prepareStatement("SELECT * FROM project WHERE project_id = ?");
			stmt.setInt(1, id);

			// ����
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
			errorMsg = "SQL ����: " + e.getMessage();
		} finally {
			// ���� ���� �־ ���ҽ��� ����� ����
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
						<label class="col-sm-2 control-label" for="id">������Ʈ ID</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="id" value="<%=project_id%>">
						</div>
					</div>
					
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="name">������Ʈ��</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" placeholder="A������Ʈ" name="name" value="<%=project_name%>">
						</div>
					</div>
					
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="PMId">PM id</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="PMId" value="<%=worker_id%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="PMName">PM��</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="PMName" value="<%=worker_name%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="start">������</label>
						<div class="col-sm-3">
							<input type="datetime" class="form-control" name="start" value="<%=project_start%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="finish">������</label>
						<div class="col-sm-3">
							<input type="datetime" class="form-control" name="start" value="<%=project_finish%>">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="pro_owner">����ó</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="pro_owner" value="<%=project_owner%>">
						</div>
					</div>


					<div class="form-group ">
						<label class="col-sm-2 control-label" for="describe">����</label>
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