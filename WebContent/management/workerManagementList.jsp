<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
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


	<div class="container">
		<div>
				<fieldset>
					<div class="form-group">
					<legend class="legend"> 전체 인사목록
						<a href="workerManagement.jsp" class="btn btn-primary">인사 변경 조회</a>
						</div>
					</legend>
							
				<table class="table table-bordered table-stripped">
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
			 pstmt = con.prepareStatement("select * from worker natural join personal_management order by worker_id");
			 rs = pstmt.executeQuery();
		
		
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