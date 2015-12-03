<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	String errorMsg = null;

	String actionUrl = "";

	// 페이지 설정
	int pageNo = 1;

	try {
		pageNo = Integer.parseInt(request.getParameter("page"));
	} catch (NumberFormatException ex) {
	}

	int numInPage = 10; // 한페이지에 출력할 아이템 개수
	int startPos = (pageNo - 1) * numInPage; // 몇 번째 아이템 부터 이 페이지에?
	int numItems, numPages;
	
	
	

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>팀원평가</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="../share/header.jsp">
		<jsp:param name="current" value="home" />
</jsp:include>
	
	
	<div class="container">
		<div>
		<fieldset>
					<legend class="legend"> 프로젝트 정보 </legend>
					<table class="table table-bordered table-stripped">
				
						<thead>
							<tr>
								<th>프로젝트번호</th>
								<th>프로젝트이름</th>
								<th>시작일자</th>
								<th>종료일자</th>
								<th>발주처</th>
								<th>프로젝트설명</th>
					<%
					request.setCharacterEncoding("utf-8");

					// Request로 ID가 있는지 확인
					String projectId = request.getParameter("projectId");
					String userId = (String)session.getAttribute("userId");
					session.setAttribute("pId", projectId);
					
					String userWorks_name="";
					
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
						String sql = "select * from project where project_id= '" +projectId+ "'";

						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						String gender;

						while (rs.next()) {
							String name = rs.getString("project_name");
							String sdate = rs.getString("project_start");
							String fdate = rs.getString("project_finish");
							String owner = rs.getString("project_owner");
							String desribe = rs.getString("project_describe");
							
					%>
					
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><%=projectId%></td>
								<td><%=name%></td>
								<td><%=sdate%></td>
								<td><%=fdate%></td>
								<td><%=owner%></td>
								<td><%=desribe%></td>
							</tr>
						</tbody>
						<%
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
		
		
		</fieldset>
		</div>
	</div>
	
	<div class="container">
		<div>
		<fieldset>
					<legend class="legend"> 팀원 정보 </legend>
					<table class="table table-bordered table-stripped">
				
						<thead>
							<tr>
								<th>팀원ID</th>
								<th>팀원이름</th>
								<th>시작일자</th>
								<th>종료일자</th>
								<th>직무</th>
								<th>업무</th>
							</tr>
						</thead>
					<%
					request.setCharacterEncoding("utf-8");

					// Request로 ID가 있는지 확인
					
					Connection conn = null;
					PreparedStatement stmt = null;
					PreparedStatement stmt2 = null;
					ResultSet rss = null;
					try {
					String DB_SERVER = "localhost:3306";
					String DB_SERVER_USERNAME = "root";
					String DB_SERVER_PASSWORD = "admin";
					String DB_DATABASE = "mjsolution";
					String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/" + DB_DATABASE;
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
						String sql = "select works_name from works_For where worker_id='"+userId+"' and project_id='"+projectId+"'";
						stmt2 = conn.prepareStatement(sql);
						rss = stmt2.executeQuery();
						while (rss.next()) {
							userWorks_name = rss.getString("works_name");
						}
						
						
						
						String ssql = "select w.worker_id, w.worker_name, f.works_name, f.works_start, f.works_finish, f.works_duty from worker w  join works_for f on w.worker_id = f.worker_id where f.project_id='" +projectId+ "'";
					
						stmt = conn.prepareStatement(ssql);
						rss = stmt.executeQuery();

						while (rss.next()) {
							String workerId = rss.getString("worker_id");
							String workerName =rss.getString("worker_name");
							String works_name = rss.getString("works_name");
							String sdate = rss.getString("works_start");
							String fdate = rss.getString("works_finish");
							String duty = rss.getString("works_duty");
							
							
							
					%>

						<tbody>
							<tr>
							<%if( userId.equals(workerId)){
							%>
								<td><%=workerId%></td>
							<%
							} else{
							%>
							<td><a href="workerEval.jsp?workerId=<%=workerId%>&projectId=<%=projectId%>&workerName=<%=workerName%>" target="_blank"class="btn btn-xs"><%=workerId%></a></td>
							<% 
								}
							%>	
								<td><%=workerName%></td>
								<td><%=sdate%></td>
								<td><%=fdate%></td>
								<td><%=works_name%></td>
								<td><%=duty%></td>
							</tr>
						</tbody>
				
	
					<%
					
					}
			
						
					} catch (Exception e) {
						out.println(e);
					} finally {
						if (rss != null) {
							try {
								rss.close();

							} catch (SQLException sqle) {
							}
						}
						if (stmt != null) {
							try {
								stmt.close();

							} catch (SQLException sqle) {
							}
						}
						if (conn != null) {
							try {
								conn.close();

							} catch (SQLException sqle) {
							}
						}
					}
						%>
			</table>
		</fieldset>
		</div>
	</div>
</body>
</html>