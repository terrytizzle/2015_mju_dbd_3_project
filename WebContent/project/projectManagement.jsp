<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>

<%
	String errorMsg = null;

	String actionUrl = "";
		
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Worker Management</title>
</head>
<body>
		<%
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
 String sql = "select * from worker natural join position"; //sql 실행구문
 pstmt = con.prepareStatement(sql);
 rs = pstmt.executeQuery();

 while(rs.next()) {
 String id = rs.getString("worker_id");
%>
	<p>신입/경력 직원 정보 관리</p>
	<form name="form1" method="post" action="loginTest.jsp">
	<p>
			직원ID : <%=id%>
		</p>
		<p>
			직원이름 : <input type="text" name="id">
		</p>
		<p>
			직원pw : <input type="password" name="passwd">
		</p>
		<p>
			생일 : <input type="text" name="birth">
		</p>
		<p>
			부서 : <input type="text" name="dept">
		</p>
		<p>
			연봉 : <input type="text" name="salary">
		</p>
		<p>
			입사일 : <input type="text" name="entrance">
		</p>
		<p>
			퇴사일 : <input type="text" name="terminate">
		</p>
		<p>
			이메일 : <input type="text" name="email">
		</p>
		<p>
			최종학력 : <input type="text" name="final_edu">
		</p>
		<p>
			직급명 : <input type="text" name="pos_name">
		</p>
		<p>
			<input type="submit" name="Submit" value="정보 수정">
		</p>
	</form>
	
	<%
 }
 } catch(Exception e) {
 out.println(e);
 } finally {
 if(rs != null) {try {rs.close();} catch(SQLException sqle) {}}
 if(pstmt != null) {try {pstmt.close();} catch(SQLException sqle) {}}
 if(con != null) {try {con.close();} catch(SQLException sqle) {}}
 }
%>
</body>
</html>