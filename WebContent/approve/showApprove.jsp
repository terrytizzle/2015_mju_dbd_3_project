<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

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
<title>관리자 페이지</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</html>
<body>
	<jsp:include page="../share/header.jsp">
	<jsp:param name="current" value="home" /> 
	</jsp:include>

	<div class="container">
			<div>

			<form name="form1" method="post" action="showApprove.jsp">
				<fieldset>
					<legend class="legend"> 승인 대기 프로젝트 </legend>
							
				<table class="table table-bordered table-stripped">
						<thead>
							<tr>
								<th>프로젝트 ID</th>
								<th>프로젝트명</th>
								<th>시작일</th>
								<th>종료일</th>
								<th>발주처</th>
								<th>설명</th>
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
 
	String sql = "select * from project where project_status='0'";
	pstmt = con.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	while(rs.next()) {
		String id = rs.getString("project_id");
		String name = rs.getString("project_name");
		String start_date = rs.getString("project_start");
		String finish_date = rs.getString("project_finish");
		String owner = rs.getString("project_owner");
		String describe = rs.getString("project_describe");
		String status = rs.getString("project_status");
		
%>
					<tbody>
							<tr>
								<td><%=id%></td>
								<td><%=name%></td>
								<td><%=start_date%></td>
								<td><%=finish_date%></td>
								<td><%=owner%></td>
								<td><%=describe%></td>
								<td>
								<a href="approveCreation.jsp?projectId=<%=rs.getInt("project_id")%>" class="btn btn-xs">modify</a>
								</td>
							</tr>
						</tbody>
		
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
				</fieldset>
			</form>
		</div>
		
	</div>

</body>
