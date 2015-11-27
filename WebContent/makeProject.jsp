<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>프로젝트 생성</title>
 </head>
 <body>
 <p>프로젝트 생성 Test</p>
 <form name="form1" method="post" action="showProject.jsp">
 <p>프로젝트 ID : <input type="text" name="id"></p>
 <p>프로젝트 명 : <input type="text" name="name"></p>
 <p>PM명 : <input type="text" name="PM name"></p>
 <p>발주처 : <input type="text" name="Owner"></p>
 <p>프로젝트 내용 : <input type="text" name="describe"></p>
 <p>팀원 : 
 <table width="100px" border="1">
  
 <tr>
 <td>직원번호</td>
 <td>직원이름</td>
 </tr>

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
 String sql = "select * from worker"; //sql 실행구문
 pstmt = con.prepareStatement(sql);
 rs = pstmt.executeQuery();

 while(rs.next()) {
 String id = rs.getString("worker_id");
 String name = rs.getString("worker_name");

%>
 
 <tr>
 <td width="200"> <%=id%> </td>
 <td width="200"> <%=name%> </td>
 </tr>
 
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
 </table>

 <input type="submit" name="Submit" value="승인 요청"></p>

 </form>
 </body>
</html> 