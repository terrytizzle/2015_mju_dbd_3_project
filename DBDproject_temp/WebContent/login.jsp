<!-- 완성본은 아니지만 DB와 연동해서 로그인 하는 기능을 구현해본 페이지입니다.
이후 수정이 될 예정임 -->
<%@ page language ="java" contentType ="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="8kb" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> 로그인 기능 test</title>
	<style>
	.error{background:#936; color:#fff; padding:10px; margin:10px 0;}
	</style>
</head>
<body>
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
 String sql = "select worker_id,worker_pswd,worker_name from worker";
 pstmt = con.prepareStatement(sql);
 rs = pstmt.executeQuery();

  while(rs.next()) {
 String user_id = rs.getString("worker_id");
 String user_pwd = rs.getString("worker_pswd");
 String user_name = rs.getString("worker_name");

 	if(request.getMethod() == "POST"){
				String id = request.getParameter("id");
				String pwd = request.getParameter("pwd");

				if(id == null || pwd == null || id.length() == 0 || pwd.length() == 0){
				%>
					<div class="error">아이디와 비밀번호를 입력하세요<div>
				<%
				}else if(id.equals(user_id) && pwd.equals(user_pwd)){
				//로그인 성공
					session.setAttribute("userId", user_id);
					session.setAttribute("userName", user_name);
					response.sendRedirect("ex2.jsp");
				}else{
				%>
					<div class="error"> 아이디나 비밀번호가 잘못되었습니다.</div>
				<%
				}
			}
		}
 } catch(Exception e) {
 out.println(e);
 } finally {
 if(pstmt != null) {try {pstmt.close();} catch(SQLException sqle) {}}
 if(con != null) {try {con.close();} catch(SQLException sqle) {}}
 }

%>
	<form method="post">
		ID: <input type="text" name="id">
		password: <input type="password" name="pwd">
		<input type="submit" value="login">
	</form>
</body>
</html>