
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>직원정보 조회</title>
</head>
<body>
		
	<form name="form1" method="post" action="showWorker.jsp">
		<p>
			직원검색 <input type="text" name="workerInfo" size=30> <input
				type="submit" name="Submit" value="조회하기">
		</p>

	</form>
	
	<table width="80%" border="1">
		<tr>
			<td>직원번호</td>
			<td>직원이름</td>
			<td width="200">비밀번호</td>
			<td width="200">생일</td>
			<td width="200">부서</td>
			<td width="200">연봉</td>
			<td width="200">입사일</td>
			<td width="200">퇴사일</td>
			<td width="200">이메일</td>
			<td width="200">최종학력</td>
			<td width="200">직급</td>
		</tr>
	
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

		String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/"
				+ DB_DATABASE;

		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME,
				DB_SERVER_PASSWORD);
		if(request.getMethod() == "POST"){
			String workerInfo = request.getParameter("workerInfo");
			
			String sql = "select * from worker where worker_id= '" + workerInfo	+ "' or worker_name= '" + workerInfo+"'";
			 
			if(workerInfo.isEmpty()){
				 sql = "select * from worker";
				
			}
			
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					String id = rs.getString("worker_id");
					String name = rs.getString("worker_name");
					String pswd = rs.getString("worker_pswd");
					String birth = rs.getString("worker_birth");
					String dept = rs.getString("worker_dept");
					String salary = rs.getString("worker_salary");
					String entrance = rs.getString("worker_entrance");
					String terminate = rs.getString("worker_terminate");
					String email = rs.getString("worker_email");
					String final_edu = rs.getString("worker_final_edu");
					String p_name = rs.getString("pos_name");
	
		if(workerInfo.equals(id) || workerInfo.equals(name)){
		%>
		<tr>
			<td width="100"><%=id%></td>
			<td width="100"><%=name%></td>
			<td width="100"><%=pswd%></td>
			<td width="100"><%=birth%></td>
			<td width="100"><%=dept%></td>
			<td width="100"><%=salary%></td>
			<td width="100"><%=entrance%></td>
			<td width="100"><%=terminate%></td>
			<td width="100"><%=email%></td>
			<td width="100"><%=final_edu%></td>
			<td width="100"><%=p_name%></td>
		</tr>
		<% 
		} 
		}
		if(!rs.first()){
		 %>
			<p>해당 직원이 없습니다.</p>
			<%
		}
		}
			} catch (Exception e) {
				out.println(e);
			} finally {
				if (rs != null) {
					try {
						rs.close();
						
					} catch (SQLException sqle) {
						}
				}
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
	</table>
</body>
</html>