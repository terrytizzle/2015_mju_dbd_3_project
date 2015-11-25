<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
 <title>로그인</title>
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
 String sql = "select worker_id from worker";
 pstmt = con.prepareStatement(sql);
 rs = pstmt.executeQuery();

 while(rs.next()) {
 String id = request.getParameter("id");
 String passwd = request.getParameter("passwd");
 String user_id = rs.getString("worker_id"); // DB 안에서는 int 형인데 String 으로 되서 ..

 	%><p> <%=id%> </p><%
	 if(id == user_id){ // int 가 String 으로 변환되면서 값의 일치가 안될수도 있다고 생각함. . 수정 필요 
	 	%><p> 로그인 성공<%=user_id%></p><%
	 }else{
	 	%><p> 로그인 실패<%=user_id%></p><%
	 }
 }

 } catch(Exception e) {
 out.println(e);
 } finally {
 if(pstmt != null) {try {pstmt.close();} catch(SQLException sqle) {}}
 if(con != null) {try {con.close();} catch(SQLException sqle) {}}
 }
%>
 </body>
</html> 