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

	String proj_id = "";
	String member_id = "";
	String works_name = "";
	String start = "";
	String finish = "";
	String duty = "";
	
%>    


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Works_for Management</title>
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
		  <form class="form-horizontal" action="memberRegister.jsp" method="post">
				<fieldset>
					<legend class="legend">Add Member in project</legend>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="p_id">프로젝트ID</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="id">
						</div>
					</div>	
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="member_id">멤버id</label>
						<input type=button value="직원조회" OnClick="window.open('../worker/showWorker.jsp','','width=1000 height=600')" class="col-sm-offset-2 btn btn-default">
						<div class="col-sm-3">
							<input type="text" class="form-control" name="member_id">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="works_name">직무명</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="works_name">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="start">시작일</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="start">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="birth">종료일</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" placeholder="1990-10-09" name="finish">
						</div>
					</div>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="dept">직무</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="duty">
						</div>
					</div class="form-group">
						<input type=button value="Cancel" OnClick="javascript:history.back(-1)" class="col-sm-offset-2 btn btn-default">
						<input type="submit" class="btn btn-default btn-primary" value="add">
					</div>
					
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>