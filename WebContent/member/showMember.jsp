<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";
	request.setCharacterEncoding("utf-8");

	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	
	
	String proj_id = request.getParameter("id");
	String member_id = request.getParameter("member_id");
	String works_name = request.getParameter("works_name");
	String start = request.getParameter("start");
	String finish = request.getParameter("finish");
	String duty = request.getParameter("duty");

		try {
		%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>프로젝트 조회</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		 	<div class="form-group">
		 		<h1>works_for 인원현황</h1>
		 		<table class="table table-bordered table-stripped">
						<thead>
							<tr>
								<th>프로젝트 번호</th>
								<th>직원 ID</th>
								<th>직무명</th>
								<th>시작일</th>
								<th>종료일</th>
								<th>직무</th>
							</tr>
						</thead>
					 		<%
					 		stmt = conn.prepareStatement("SELECT * FROM works_for ORDER BY project_id;");
					 		rs = stmt.executeQuery();
					 		while (rs.next()) {
					 			String p_id = rs.getString("project_id");
					 			String w_id = rs.getString("worker_id");
					 			String w_name = rs.getString("works_name");
					 			String w_start = rs.getString("works_start");
					 			String w_finish = rs.getString("works_finish");
					 			String w_duty = rs.getString("works_duty");
					 		%>
						<tbody>
							<tr>
								<td><%=p_id%></td>
								<td><%=w_id%></td>
								<td><%=w_name%></td>
								<td><%=w_start%></td>
								<td><%=w_finish%></td>
								<td><%=w_duty%></td>
							</tr>
						</tbody>
						<%
					 		}
						}catch (Exception e) {
								out.println(e);
						} finally {
						// 무슨 일이 있어도 리소스를 제대로 종료
						if (rs != null) try{rs.close();} catch(SQLException e) {}
						if (stmt != null) try{stmt.close();} catch(SQLException e) {}
						if (conn != null) try{conn.close();} catch(SQLException e) {}
					}
						%>
			 	</table>
		 	</div>
 	</div>
</body>
</html>