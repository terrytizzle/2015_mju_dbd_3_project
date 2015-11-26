<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>프로젝트 조회</title>
 </head>
 <body>
 <table width="80%" border="1">
 <tr>
 <td>프로젝트 ID</td>
 <td>프로젝트 이름</td>
 <td width="200">시작일자</td>
 <td width="200">종료일자</td>
 <td width="200">발주처</td>
 <td width="200">프로젝트 설명</td>
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
 String sql = "select * from project"; //sql 실행구문
 pstmt = con.prepareStatement(sql);
 rs = pstmt.executeQuery();

 while(rs.next()) {
 String id = rs.getString("project_id");
 String name = rs.getString("project_name");
 String start_date = rs.getString("project_start");
 String finish_date = rs.getString("project_finish");
 String owner = rs.getString("project_owner");
 String describe = rs.getString("project_describe");
%> 

<tr>
 <td width="100"> <%=id%> </td>
 <td width="100"> <%=name%> </td>
 <td width="100"> <%=start_date%> </td>
 <td width="100"> <%=finish_date%> </td>
 <td width="100"> <%=owner%> </td>
 <td width="100"> <%=describe%> </td>
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
 </body>
</html> 