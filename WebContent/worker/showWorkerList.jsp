<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

	
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
<title>전체 직원</title>
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
	 if(session.getAttribute("userId") == null){ 
	%>

	<script type=text/javascript>
			alert("권한이 없습니다. 로그인하세요.");
			window.location.replace("../login.jsp");
		</script>
	<%
	 }
	%>
	
	
	<div class="container">
		<div>
				<fieldset>
					<div class="form-group">
					<legend class="legend"> 전체 직원
						<a href="showWorker.jsp" class="btn btn-primary">직원 조회</a>
						</div>
					</legend>
					<table class="table table-bordered table-stripped">
				<thead>
							<tr>
								<th>직원번호</th>
								<th>직원이름</th>
								<th>생일</th>
								<th>부서</th>
								<th>연봉</th>
								<th>입사일</th>
								<th>퇴사일</th>
								<th>이메일</th>
								<th>최종학력</th>
								<th>직급</th>
								<%
								if(session.getAttribute("userId") != null){	
									if(session.getAttribute("userDept").equals("인사") && session.getAttribute("userPosname").equals("부장")){
										
								%>
								<th></th>
								<% }}%>
							</tr>
						</thead>

						<%
					
							pstmt = con.prepareStatement("select * from worker order by worker_id");
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
						%>
						<tbody>
							<tr>
								<td><%=id%></td>
								<td><%=name%></td>
								<td><%=birth%></td>
								<td><%=dept%></td>
								<td><%=salary%></td>
								<td><%=entrance%></td>
								<td><%=terminate%></td>
								<td><%=email%></td>
								<td><%=final_edu%></td>
								<td><%=p_name%></td>
								<% 
								if(session.getAttribute("userDept").equals("인사") && session.getAttribute("userPosname").equals("부장")){	
								%>
								<td><a href="workerCreation.jsp?userId=<%=rs.getInt("worker_id")%>" class="btn btn-xs">modify</a> 
								<%
								if(session.getAttribute("userId").equals("1")){
								%> 
								<a href="#" class="btn btn-xs btn-danger" data-action="delete" data-id="<%=rs.getInt("worker_id")%>">delete</a>
								 <%}%>
								 </td>
								<%} %>
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
		<%
			if(session.getAttribute("userId") != null){	
			if(session.getAttribute("userDept").equals("인사") && session.getAttribute("userPosname").equals("부장")){
		%>
		<div class="form-group">
			<a href="workerCreation.jsp" class="btn btn-primary">Add Worker</a>
		</div>
		<%  }} %>
	</div>

</body>
<script>
	$(function() {
		$("a[data-action='delete']").click(function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				location = 'deleteWorker.jsp?id=' + $(this).attr('data-id');
			}
			return false;
		});
	});
</script>