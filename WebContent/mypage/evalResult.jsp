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
	
	
	
	if (request.getMethod() == "POST") {
		int work_eval = Integer.parseInt(request.getParameter("worK_eval"));
		int commu_eval =  Integer.parseInt(request.getParameter("commu_eval"));
		int sum_eval = work_eval + commu_eval;
	%>
	<p><%=sum_eval %> </p>
	<% 
	request.setCharacterEncoding("utf-8");

	// Request로 ID가 있는지 확인
	
	Connection conn = null;
	PreparedStatement stmt = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
	String dbUser = "root";
	String dbPassword = "admin";
	
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO evaluation (`eval_work`, `eval_communication`, `eval_score`) " +
					"VALUES(?, ?, ?)"
					);
			stmt.setInt(1, work_eval);
			stmt.setInt(2, commu_eval);
			stmt.setInt(3, sum_eval);
			
		} catch (SQLException e) {
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>평가 결과</title>
<link href="http://localhost:8080/2015_mju_dbd_3_project/css/bootstrap.min.css" rel="stylesheet">
<link href="http://localhost:8080/2015_mju_dbd_3_project/css/base.css" rel="stylesheet">
<script src="http://localhost:8080/2015_mju_dbd_3_project/js/jquery-1.8.2.min.js"></script>
<script src="http://localhost:8080/2015_mju_dbd_3_project/js/bootstrap.min.js"></script>
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
					String id = "";
					try {
						id = request.getParameter("id");
					} catch (Exception e) {	}
					
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
						String sql = "select * from project where project_id= '" +id+ "'";

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
								<td><%=id%></td>
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
								
					<%
					request.setCharacterEncoding("utf-8");

					// Request로 ID가 있는지 확인
					
					con = null;
					pstmt = null;
					rs = null;
					try {
					String DB_SERVER = "localhost:3306";
					String DB_SERVER_USERNAME = "root";
					String DB_SERVER_PASSWORD = "admin";
					String DB_DATABASE = "mjsolution";
					String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/" + DB_DATABASE;
					Class.forName("com.mysql.jdbc.Driver");
					con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
						String sql = "select * from works_for where project_id= '" +id+ "'";

						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						String gender;

						while (rs.next()) {
							String workerId = rs.getString("worker_id");
							String name = rs.getString("works_name");
							String sdate = rs.getString("works_start");
							String fdate = rs.getString("works_finish");
							String duty = rs.getString("works_duty");
														
					%>
					
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><%=workerId%></td>
								<td><%=name%></td>
								<td><%=sdate%></td>
								<td><%=fdate%></td>
								<td><%=duty%></td>
								</tr>
						</tbody>
					</table>
			</fieldset>
		</div>
	</div>
	
	<div class="container">
		<div>
		<fieldset>
					<legend class="legend"> 평가 결과 </legend>
					<table class="table table-bordered table-stripped">
						<thead>
							<tr>
								<th>직원ID</th>
								<th>직원이름</th>
								<th>업무 평가 점수</th>
								<th>커뮤니케이션 평가 점수</th>
								<th>종합점수</th>
							</tr>
						</thead>
						<%
						sql = "select * from evaluation";

						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							String work_eval = rs.getString("eval_work");
							String commu_eval = rs.getString("eval_communication");
							String score = rs.getString("eval_score");
																					
					%>
						<tbody>
							<tr>
								<td><%=workerId%></td>
								<td><%=name%></td>
								<td><%=work_eval%></td>
								<td><%=commu_eval%></td>
								<td><%=score%></td>
							</tr>
							
						</tbody>
					</table>
			</form>		
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
						
			
		</fieldset>
		</div>
	</div>
</body>
</html>