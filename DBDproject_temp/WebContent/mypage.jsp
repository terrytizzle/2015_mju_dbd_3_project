<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�� ����</title>
</head>
<body>

 <form name="form1" method="post" action="mypage.jsp">
 <input type="submit" name="Submit" value="�� ���� ��ȸ"></form>
 
 <form name="form2" method="post" action="mypageEdit.jsp">
 <input type="submit" name="Submit" value="�� ���� ����"> </form>
 
 <form name="form3" method="post" action="myProject.jsp">
 <input type="submit" name="Submit" value="�� ������Ʈ ��ȸ"></form>
 
 <form name="form4" method="post" action="projectEval.jsp">
 <input type="submit" name="Submit" value="�� ������Ʈ ��"></form>

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
 String sql = "select * from worker"; //sql ���౸��
 pstmt = con.prepareStatement(sql);
 rs = pstmt.executeQuery();

 while(rs.next()) {
 String name = rs.getString("worker_name");
 String birth = rs.getString("worker_birth");
 String dept = rs.getString("worker_dept");
 String salary = rs.getString("worker_salary");
 String enterance = rs.getString("worker_enterance");
 String email = rs.getString("worker_email");
 String final_edu = rs.getString("worker_final_edu");
 String p_name = rs.getString("pos_name");
%>
	<table width="80%" border="1">
		
		<tr>
			<td>�����̸�</td>
			<td width="100"><%=name%></td>
			<td width="200">����</td>
			<td width="100"><%=birth%></td>
			<td width="200">�̸���</td>
			<td width="100"><%=email%></td>
		</tr>
		<tr>
			<td width="200">�����з�</td>
		    <td width="100"><%=final_edu%></td>
		</tr>
		<tr>
		    <td width="200">�μ�</td>
			<td width="100"><%=dept%></td>
			<td width="200">����</td>
			<td width="100"><%=p_name%></td>
	    </tr>
	    <tr>
			<td width="200">�Ի���</td>
			<td width="100"><%=enterance%></td>
	    </tr>
		<tr>
			<td width="200">����</td>
			<td width="100"><%=salary%></td>
		</tr>
			
			
			
			
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
