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
<title>마이페이지</title>
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
					<legend class="legend"> My프로젝트 </legend>
					
					<table class="table table-bordered table-stripped">
						<thead>
							<tr>
								<th>프로젝트번호</th>
								<th>프로젝트이름</th>
								<th>시작일자</th>
								<th>종료일자</th>
							</tr>
						</thead>

						<%
							String userId=(String)session.getAttribute("userId");
						request.setCharacterEncoding("utf-8");
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
						String sql = "select p.project_id, p.project_name, p.project_start, p.project_finish from project p join works_for w on p.project_id = w.project_id where w.worker_id='"+userId+"'";
						 			
						pstmt = con.prepareStatement(sql);
									rs = pstmt.executeQuery();
									while (rs.next()) {
										String id = rs.getString("project_id");
										String name = rs.getString("project_name");
										String sdate = rs.getString("project_start");
										String fdate = rs.getString("project_finish");
						%>
						<tbody>
							<tr>
								<td><a href="workerEval_Info.jsp?projectId=<%=id%>&userId=<%=userId%>" class="btn btn-xs"><%=id%></a></td>
								<td><%=name%></td>
								<td><%=sdate%></td>
								<td><%=fdate%></td>
							</tr>
						</tbody>
						<%
							}
							if (!rs.first()) {
						%>
						<p>해당 프로젝트가 없습니다.</p>
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
			</form>
		</div>
			</div>
</body>
</html>