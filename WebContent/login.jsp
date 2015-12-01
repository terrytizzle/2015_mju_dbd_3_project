<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" buffer="8kb"%>
<%@ page import="java.sql.*"%>

<%
	String errorMsg = null;

	String actionUrl = "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>

	<div class="container">
		<fieldset>
			<legend class="legend">Login</legend>

			<%
				request.setCharacterEncoding("utf-8");
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {
					String DB_SERVER = "localhost:3306";
					String DB_SERVER_USERNAME = "root";
					String DB_SERVER_PASSWORD = "admin";
					String DB_DATABASE = "mjsolution";
					String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/" + DB_DATABASE;

					Class.forName("com.mysql.jdbc.Driver");
					con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
					String sql = "select * from worker";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();

					while (rs.next()) {
						String user_id = rs.getString("worker_id");
						String user_name = rs.getString("worker_name");
						String user_pwd = rs.getString("worker_pswd");
						String user_birth = rs.getString("worker_birth");
						String user_dept = rs.getString("worker_dept");
						String user_salary = rs.getString("worker_salary");
						String user_entrance = rs.getString("worker_entrance");
						String user_terminate = rs.getString("worker_terminate");
						String user_email = rs.getString("worker_email");
						String user_final_edu = rs.getString("worker_final_edu");
						String user_pos_name = rs.getString("pos_name");
					
						if (request.getMethod() == "POST") {
							String id = request.getParameter("id");
							String pwd = request.getParameter("pwd");
							
							if (id == null || pwd == null || id.length() == 0 || pwd.length() == 0) {
							%>
							<div class="error">
							
							<%
							session.setAttribute("userId", "empty");
							response.sendRedirect("first_page.jsp");
							
							} else if (id.equals(user_id) && pwd.equals(user_pwd)) {
										//로그인 성공
										session.setAttribute("userId", user_id);
										session.setAttribute("userName", user_name);
										session.setAttribute("userPwd", user_pwd);
										session.setAttribute("userBirth", user_birth);
										session.setAttribute("userDept", user_dept);
										session.setAttribute("userSalary", user_name);
										session.setAttribute("userEntrance", user_entrance);
										session.setAttribute("userTerminate", user_terminate);
										session.setAttribute("userEmail", user_email);
										session.setAttribute("userFinaledu", user_final_edu);
										session.setAttribute("userPosname", user_pos_name);

										response.sendRedirect("first_page.jsp");
							} else {
								%>
								
								<%
								session.setAttribute("userId", "wrong");
								response.sendRedirect("first_page.jsp");
							}
						}
					}
				} catch (Exception e) {
							out.println(e);
						} finally {
							if (pstmt != null) {
								try {
									pstmt.close();
								} catch (SQLException sqle) {
								}
							}
							if (con != null) {
								try {
									con.close();
								} catch (SQLException sqle) {
								}
							}
						}
					%>
					</div>
					<form method="post">
						ID: <input type="text" name="id"> 
						password: <input type="password" name="pwd"> 
						<input type="submit" value="login">
					</form>
		</fieldset>
	</div>
</body>
</html>