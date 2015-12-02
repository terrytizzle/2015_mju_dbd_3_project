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
<title>평가페이지</title>
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

			<form name="form1" method="post" action="projectEval.jsp">
				<fieldset>
					<legend class="legend"> 프로젝트 검색 </legend>
					<p>
						<input type="text" name="projeckInfo" size=30> <input type="submit" name="Submit" value="조회하기">
					</p>


					<table class="table table-bordered table-stripped">
						<thead>
							<tr>
								<th>프로젝트번호</th>
								<th>프로젝트이름</th>
								<th>시작일자</th>
								<th>종료일자</th>
								<th>발주처</th>
								<th>프로젝트설명</th>
								<th></th>
							</tr>
						</thead>

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
								String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/" + DB_DATABASE;
								Class.forName("com.mysql.jdbc.Driver");
								con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
								if (request.getMethod() == "POST") {
									String projectInfo = request.getParameter("projeckInfo");

									String sql = "select * from project where project_id= '" + projectInfo + "' or project_name= '"
											+ projectInfo + "'";

									if (projectInfo.isEmpty()) {
										sql = "SELECT * FROM project ORDER BY project_id LIMIT " + startPos + ", " + numInPage;
									}

									pstmt = con.prepareStatement(sql);
									rs = pstmt.executeQuery();
									String gender;

									while (rs.next()) {
										String id = rs.getString("project_id");
										String name = rs.getString("project_name");
										String sdate = rs.getString("project_start");
										String fdate = rs.getString("project_finish");
										String owner = rs.getString("project_owner");
										String desribe = rs.getString("project_describe");


										if (projectInfo.equals(id) || projectInfo.equals(name)) {
						%>
						<tbody>
							<tr>
								<td><a href="workerEval_Info.jsp?projectId=<%=rs.getInt("project_id")%>" class="btn btn-xs"><%=id%></a></td>
								<td><%=name%></td>
								<td><%=sdate%></td>
								<td><%=fdate%></td>
								<td><%=owner%></td>
								<td><%=desribe%></td>
							</tr>
						</tbody>
						<%
							}
									}
									if (!rs.first()) {
						%>
						<p>해당 프로젝트가 없습니다.</p>
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
				</fieldset>
			</form>
		</div>
			</div>
</body>
</html>