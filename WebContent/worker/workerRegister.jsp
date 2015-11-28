<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*" import="java.util.*" 
    %>

<%
	// DB ������ ���� �غ�
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";
	
	request.setCharacterEncoding("utf-8");
	
	String user_id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String pwd_confirm = request.getParameter("pwd_confirm");
	String user_name = request.getParameter("name");
	String user_birth = request.getParameter("birth");
	String user_dept = request.getParameter("dept");
	String user_salary = request.getParameter("salary");
	String user_enterance = request.getParameter("enterance");
	String user_terminate = request.getParameter("terminate");
	String user_email = request.getParameter("email");
	String user_final_edu = request.getParameter("final_edu");
	String user_pos_name = request.getParameter("pos_name");
	
	
	List <String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (user_id == null || user_id.trim().length() == 0) {
		errorMsgs.add("ID�� �ݵ�� �Է����ּ���.");
	} else if (pwd == null || pwd.length() < 6) {
		errorMsgs.add("��й�ȣ�� 6�� �̻� �Է����ּ���.");
	} else if (!pwd.equals(pwd_confirm)) {
		errorMsgs.add("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
	} else if (user_birth == null || user_birth.trim().length() == 0) {
		errorMsgs.add("������ �ݵ�� �Է����ּ���.");
	} else if (user_dept == null || user_dept.trim().length() == 0) {
		errorMsgs.add("�μ��� �ݵ�� �Է����ּ���.");
	} else if (user_salary == null || user_salary.trim().length() == 0) {
		errorMsgs.add("������ �ݵ�� �Է����ּ���.");
	} else if (user_enterance == null || user_enterance.trim().length() == 0) {
		errorMsgs.add("�Ի����ڸ� �ݵ�� �Է����ּ���.");
	} else if (user_email == null || user_email.trim().length() == 0) {
		errorMsgs.add("���� �ּҸ� �ݵ�� �Է����ּ���.");
	} else if (user_final_edu == null || user_final_edu.trim().length() == 0) {
		errorMsgs.add("���� �з��� �ݵ�� �Է����ּ���.");
	} else if (user_pos_name == null || user_pos_name.trim().length() == 0) {
		errorMsgs.add("������ �ݵ�� �Է����ּ���.");
	}
	
	
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO worker(worker_id, worker_name, worker_pswd, worker_birth, worker_dept, worker_salary, worker_enterance, worker_ternimate, worker_email, worker_final_edu, pos_name) " +
					"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
					);
			stmt.setString(1, user_id);
			stmt.setString(2, user_name);
			stmt.setString(3, pwd);
			stmt.setString(4, user_birth);
			stmt.setString(5, user_dept);
			stmt.setString(6, user_salary);
			stmt.setString(7, user_enterance);
			stmt.setString(8, user_terminate);
			stmt.setString(9, user_email);
			stmt.setString(10, user_final_edu);
			stmt.setString(11, user_pos_name);
			
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("��Ͽ� �����Ͽ����ϴ�.");
			}
		} catch (SQLException e) {
			errorMsgs.add("SQL ����: " + e.getMessage());
		} finally {
			// ���� ���� �־ ���ҽ��� ����� ����
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
%>    




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>main page</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</head>
</html>
<body>
	<jsp:include page="../share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>

	<div class="container">
 		<% if (errorMsgs.size() > 0) { %>
 			<div class="alert alert-danger">
 				<h3>Errors:</h3>
 				<ul>
 					<% for(String msg: errorMsgs) { %>
 						<li><%=msg %></li>
 					<% } %>
 				</ul>
 			</div>
		 	<div class="form-group">
		 		<a onclick="history.back();" class="btn">�ڷ� ���ư���</a>
		 	</div>
	 	<% } else if (result == 1) { %>
	 		<div class="alert alert-success">
	 			<b><%= user_name %></b>���� ��ϵǾ����ϴ�.
	 		</div>
		 	<div class="form-group">
		 		<a href="../main.jsp" class="btn">�������</a>
		 	</div>
	 		
	 	<%}%>
 	</div>




</body>