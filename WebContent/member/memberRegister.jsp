<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" import="java.sql.*" import="java.util.*" %>

<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	PreparedStatement stmt2 = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";
	
	request.setCharacterEncoding("utf-8");

	String proj_id = request.getParameter("id");
	String member_id = request.getParameter("member_id");
	String works_name = request.getParameter("works_name");
	String start = request.getParameter("start");
	String finish = request.getParameter("finish");
	String duty = request.getParameter("duty");
	
	List <String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (proj_id == null || proj_id.trim().length() == 0) {
		errorMsgs.add("프로젝트 ID를 반드시 입력해주세요.");
	} else if (member_id == null || member_id.length() == 0) {
		errorMsgs.add("투입하는 직원의 id를 반드시 입력해주세요.");
	} else if (works_name == null || works_name.trim().length() == 0) {
		errorMsgs.add("직무명을 반드시 입력하세요");
	} else if (start == null || start.trim().length() == 0) {
		errorMsgs.add("시작일을 반드시 입력하세요.");
	} else if (finish == null || finish.trim().length() == 0) {
		errorMsgs.add("종료일을 반드시 입력하세요.");
	} else if (duty == null || duty.trim().length() == 0) {
		errorMsgs.add("직무를 반드시 입력하세요.");
	}
	
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO works_for(project_id, worker_id, works_name, works_start, works_finish,works_duty) " +
					"VALUES(?, ?, ?, ?, ?, ?)"
					);
			stmt.setString(1, proj_id);
			stmt.setString(2, member_id);
			stmt.setString(3, works_name);
			stmt.setString(4, start);
			stmt.setString(5, finish);
			stmt.setString(6, duty);
		
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("다시등록해주세요");
			}
		} catch (SQLException e) {
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
%>    

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main page</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</head>
</html>
<body>
	<jsp:include page="../share/header.jsp">
	<jsp:param name="current" value="home" />
	</jsp:include>

	<div class="container">
 		<% if (errorMsgs.size() > 0) { %>
 			<div class="alert alert-danger">
 				<h3>Errors:</h3>
 				<ul>
 					<% for(String msg: errorMsgs) { %>
 						<li><%=msg %></li>
 					<% } %>
 				</ul>
 			</div>
		 	<div class="form-group">
		 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
		 	</div>
	 	<% } else if (result == 1) { %>
	 		<div class="alert alert-success">
	 			<b><%= member_id %></b>님이 등록되었습니다.
	 			<a href="memberCreation.jsp" class="btn btn-primary" >다른인원 추가</a>
	 		</div>
	 		<div>
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
							try {
							conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
					 		stmt2 = conn.prepareStatement("SELECT * FROM works_for where project_id = '"+ proj_id +"';");
					 		rs = stmt2.executeQuery();
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
						if (stmt2 != null) try{stmt.close();} catch(SQLException e) {}
						if (conn != null) try{conn.close();} catch(SQLException e) {}
					}
						%>
			 	</table>
	 		</div>
	 	<% } %>
 	</div>
</body>