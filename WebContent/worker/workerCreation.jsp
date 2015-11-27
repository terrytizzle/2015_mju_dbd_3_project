<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	String errorMsg = null;

	String actionUrl;
	// DB ������ ���� �غ�
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";

	// ����� ������ ���� ���� �ʱ�ȭ
	String worker_id = "";
	String worker_name = "";
	String worker_pswd = "";
	String worker_dept = "";
	String worker_salary = "";
	String worker_entrance = "";
	String worker_terminate = "";
	String worker_email = "";
	String worker_final_edu = "";

	// Request�� ID�� �ִ��� Ȯ��
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("worker_id"));
	} catch (Exception e) {
	}

	if (id > 0) {
		// Request�� id�� ������ update���� ����
		actionUrl = "workerUpdate.jsp";
	} else {
		actionUrl = "workerRegister.jsp";
	}
	try {
		Class.forName("com.mysql.jdbc.Driver");

		// DB ����
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

		// ���� �غ�
		stmt = conn.prepareStatement("SELECT * FROM worker WHERE id = ?");
		stmt.setInt(1, id);

		// ����
		rs = stmt.executeQuery();

		if (rs.next()) {
			worker_id = rs.getString("worker_id");
			worker_name = rs.getString("worker_name");
			worker_pswd = rs.getString("worker_pswd");
			worker_dept = rs.getString("worker_dept");
			worker_salary = rs.getString("worker_salary");
			worker_entrance = rs.getString("worker_entrance");
			worker_terminate = rs.getString("worker_terminate");
			worker_email = rs.getString("worker_email");
			worker_final_edu = rs.getString("worker_final_edu");
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
	<p>����/��� ���� ����</p>
	<form name="form1" method="post" action="loginTest.jsp">


		<div class="form-group ">
			<label class="col-sm-2 control-label" for="userid">ID</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" name="userid"
					value="<%=userid%>">
			</div>
		</div>

		<div class="form-group ">
			<label class="col-sm-2 control-label" for="name">Name</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" placeholder="ȫ�浿"
					name="name" value="<%=name%>">
			</div>
		</div>

		<%-- �ű� ������ ���� ��й�ȣ �Է�â�� ��Ÿ�� --%>
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
			<label class="col-sm-2 control-label" for="email">E-mail</label>
			<div class="col-sm-3">
				<input type="email" class="form-control"
					placeholder="WOW@blizzard.com" name="email" value="<%=email%>">
			</div>
		</div>


		<div class="form-group ">
			<label class="col-sm-2 control-label" for="phone">Phone
				Number</label>
			<div class="col-sm-3">
				<input type="phone" class="form-control" placeholder="010-9959-5663"
					name="phone" value="<%=phone%>">
			</div>
		</div>

		<div class="form-group">
			<input type=button value="Cancel"
				OnClick="javascript:history.back(-1)"
				class="col-sm-offset-2 btn btn-default"> <input
				type="submit" class="btn btn-default btn-primary" value="Sign in">
			\
		</div>
	</form>
</body>
</html>