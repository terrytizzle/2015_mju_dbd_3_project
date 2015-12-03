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
	int numInPage = 1000; // 한페이지에 출력할 아이템 개수
	int startPos = (pageNo - 1) * numInPage; // 몇 번째 아이템 부터 이 페이지에?
	int numItems, numPages;
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>인사 관리</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</html>
<body>
	<jsp:include page="../share/header.jsp">
	<jsp:param name="current" value="home" /> 
	</jsp:include>
<%
		if (session.getAttribute("userId") == null) {
	%>

	<script type=text/javascript>
		alert("잘못된 경로입니다.");
		window.location.replace("../login.jsp");
	</script>
	<%
		}
		if (session.getAttribute("userId") != null) {
			if (!(session.getAttribute("userDept").equals("인사")
					&& session.getAttribute("userPosname").equals("부장"))) {
	%>

	<script type=text/javascript>
		alert("권한이 없습니다.");
		window.location.replace("../main.jsp");
	</script>
	<%
		}
		}
	%>
	<div class="container">
			<div>
			<form name="form1" method="post" action="workerManagement.jsp">
				<fieldset>
					<div class="form-group">
					<legend class="legend"> 인사 변경
					<a href="workerManagementList.jsp" class="btn btn-primary">인사 변경 조회</a>
					</div> 
				</legend>
					
						<input type="text" name="workerInfo" size=30> <input type="submit" name="Submit" value="조회하기">
					
							
				<table class="table table-bordered table-stripped">
				

						
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
		
		
	 String workerInfo = request.getParameter("workerInfo");
	 
		String sql = "select * from worker natural join personal_management where worker_id= '" + workerInfo + "' or worker_name= '" + workerInfo + "'";
		 pstmt = con.prepareStatement(sql);
		 rs = pstmt.executeQuery();
		if (workerInfo.isEmpty()) {
			sql = "SELECT * FROM worker natural join personal_management ORDER BY worker_id LIMIT " + startPos + ", " + numInPage;
			 pstmt = con.prepareStatement(sql);
			 rs = pstmt.executeQuery();
		}
		%>
											<thead>
						<tr>
							<th>직원번호</th>
							<th>직원이름</th>
							<th>직급</th>
							<th>부서</th>
							<th>연봉</th>
							<th>입사일</th>
							<th>근속 기간</th>
							<th>인센티브</th>
						</tr>
					</thead>
		<%
		
while(rs.next()) {
		String id = rs.getString("worker_id");
		String name = rs.getString("worker_name");
		String dept = rs.getString("worker_dept");
		String salary = rs.getString("worker_salary");
		String entrance = rs.getString("worker_entrance");
		String p_name = rs.getString("pos_name");
		String incentive = rs.getString("incentive");
		String period = rs.getString("period");
		%>
					<tbody>
							<tr>
								<td><%=id%></td>
								<td><%=name%></td>
								<td><a href="positionCreation.jsp?userId=<%=rs.getInt("worker_id")%>" class="btn btn-xs"><%=p_name%></a></td>
								<td><%=dept%></td>
								<td><%=salary%></td>
								<td><%=entrance%></td>
								<td><%=period%>년</td>
								<td><a href="incentiveCreation.jsp?userId=<%=rs.getInt("worker_id")%>" placeholder=<%=incentive%> class="btn btn-xs"><%=incentive%></a>%</td>

							</tr>
						</tbody>
		
		<%
 }
 
 if (!rs.first()) {
		%>
		<p>해당 직원이 없습니다.</p>
		<%
			}
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