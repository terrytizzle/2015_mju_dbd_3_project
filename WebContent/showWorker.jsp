<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�������� ��ȸ</title>
 </head>
 <body>
 <table width="80%" border="1">
 <tr>
 <td>������ȣ</td>
 <td>�����̸�</td>
 <td width="200">��й�ȣ</td>
 <td width="200">����</td>
 <td width="200">�μ�</td>
 <td width="200">����</td>
 <td width="200">�Ի���</td>
 <td width="200">�����</td>
 <td width="200">�̸���</td>
 <td width="200">�����з�</td>
 <td width="200">����</td>
 </tr>
<%
 Connection con = null;
 PreparedStatement pstmt = null;
 ResultSet rs = null; 

 try {
 String DB_SERVER = "localhost:3306";
 String DB_SERVER_USERNAME = "root";
 String DB_SERVER_PASSWORD = "tiger";
 String DB_DATABASE = "mjsolution";

 String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/" + DB_DATABASE;

 Class.forName("com.mysql.jdbc.Driver");
 con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
 String sql = "select * from worker"; //sql ���౸��
 pstmt = con.prepareStatement(sql);
 rs = pstmt.executeQuery();

 while(rs.next()) {
 String id = rs.getString("worker_id");
 String name = rs.getString("worker_name");
 String pswd = rs.getString("worker_pswd");
 String birth = rs.getString("worker_birth");
 String dept = rs.getString("worker_dept");
 String salary = rs.getString("worker_salary");
 String enterance = rs.getString("worker_enterance");
 String terminate = rs.getString("worker_ternimate");
 String email = rs.getString("worker_email");
 String final_edu = rs.getString("worker_final_edu");
 String p_name = rs.getString("pos_name");
%> 

<tr>
 <td width="100"> <%=id%> </td>
 <td width="100"> <%=name%> </td>
 <td width="100"> <%=pswd%> </td>
 <td width="100"> <%=birth%> </td>
 <td width="100"> <%=dept%> </td>
 <td width="100"> <%=salary%> </td>
 <td width="100"> <%=enterance%> </td>
 <td width="100"> <%=terminate%> </td>
 <td width="100"> <%=email%> </td>
 <td width="100"> <%=final_edu%> </td>
 <td width="100"> <%=p_name%> </td>
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