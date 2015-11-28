<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	// DB ������ ���� �غ�
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";
	
	request.setCharacterEncoding("utf-8");

	// Request�� ID�� �ִ��� Ȯ��
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}
	String userid = request.getParameter("userid");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (userid == null || userid.trim().length() == 0) {
		errorMsgs.add("ID�� �ݵ�� �Է����ּ���.");
	}

	
	if (name == null || name.trim().length() == 0) {
		errorMsgs.add("�̸��� �ݵ�� �Է����ּ���.");
	}
	
	if (phone == null || name.trim().length() == 0 ) {
		errorMsgs.add("��ȭ��ȣ�� �ݵ�� �Է����ּ���.");
	}

	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"UPDATE users " +
					"SET  userid=?, name=?, email=?, phone=? " +
					"WHERE id=?"
					);
			stmt.setString(1,  userid);
			stmt.setString(2,  name);
			stmt.setString(3,  email);
			stmt.setString(4,  phone);
			stmt.setInt(5,  id);
			
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("���濡 �����Ͽ����ϴ�.");
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
<link rel="stylesheet" type="text/css" href="./CSS/style.css" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</html>
<body>
	<jsp:include page="share/header.jsp">
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
			<a onclick="history.back();" class="btn btn-default">�ڷ� ���ư���</a>
		</div>
		<% } else if (result == 1) { %>
		<div class="alert alert-success">
			<b><%= name %></b>�� ������ �����Ǿ����ϴ�.
		</div>
		<div class="form-group">
			<a href="index.jsp" class="btn btn-default">�������</a>
		</div>
		<%}%>
	</div>
	



</body>