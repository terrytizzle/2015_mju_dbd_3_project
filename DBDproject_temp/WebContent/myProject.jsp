<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�� ������Ʈ ��ȸ</title>
 </head>
 <body>
 
  <form name="form1" method="post" action="mypage.jsp">
 <input type="submit" name="Submit" value="������ ��ȸ"></form>
 
 <form name="form2" method="post" action="mypageEdit.jsp">
 <input type="submit" name="Submit" value="������ ����"> </form>
 
 <form name="form3" method="post" action="myProject.jsp">
 <input type="submit" name="Submit" value="�� ������Ʈ ��ȸ"></form>
 
 <form name="form4" method="post" action="projectEval.jsp">
 <input type="submit" name="Submit" value="�� ������Ʈ ��"></form>
 
 <table width="80%" border="1">
 <tr>
 <td>������Ʈ ID</td>
 <td>������Ʈ �̸�</td>
  <td width="200">������</td>
 <td width="200">���� ��������</td>
 <td width="200">���� ��������</td>
 <td width="200">PM</td>
 <td width="200">������</td>
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
 String sql = "select * from works_for,project,worker where works_for.project_id = project.project_id and works_for.worker_id = worker.worker_id"; //sql ���౸��
 pstmt = con.prepareStatement(sql);
 rs = pstmt.executeQuery();

 while(rs.next()) {
 String id = rs.getString("project_id");
 String name = rs.getString("project_name");
 String start_date = rs.getString("project_start");
 String finish_date = rs.getString("project_finish");
 String duty = rs.getString("works_duty");
%> 

<tr>
 <td width="100"> <%=id%> </td>
 <td width="100"> <%=name%> </td>
  <td width="100"> <%=duty%> </td>
 <td width="100"> <%=start_date%> </td>
 <td width="100"> <%=finish_date%> </td>
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