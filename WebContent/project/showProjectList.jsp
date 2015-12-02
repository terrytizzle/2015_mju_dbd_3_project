<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
  
  
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
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>전체 프로젝트</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/base.css" rel="stylesheet">
<script src="../js/jquery-1.8.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</html>
</head>
<body> 
	<jsp:include page="../share/header.jsp">
		<jsp:param name="current1" value="home1" />
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
					<legend class="legend"> 전체 프로젝트
						<a href="showProject.jsp" class="btn btn-primary">프로젝트 조회</a>
						</div>
					</legend>
					<table class="table table-bordered table-stripped">
				<thead>
				 <tr>
					 <th>프로젝트 ID</th>
					 <th>프로젝트 이름</th>
					 <th>시작일자</th>
					 <th>종료일자</th>
					 <th>발주처</th>
					 <th>프로젝트 설명</th>
					 <%
								if(session.getAttribute("userId") != null){	
									if(session.getAttribute("userPosname").equals("과장") || session.getAttribute("userPosname").equals("차장")){
										
								%>
								<th></th>
					<% }}%>
				 </tr>
				 </thead>
				 
				<%
					pstmt = con.prepareStatement("select * from project order by project_id");
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
					String id = rs.getString("project_id");
					String name = rs.getString("project_name");
					String start_date = rs.getString("project_start");
					String finish_date = rs.getString("project_finish");
					String owner = rs.getString("project_owner");
					String describe = rs.getString("project_describe");
				%> 
				<tbody>
					<tr>
						<td> <%=id%> </td>
						<td> <%=name%> </td>
						<td> <%=start_date%> </td>
						<td> <%=finish_date%> </td>
						<td> <%=owner%> </td>
						<td> <%=describe%> </td>
							<% 
						if(session.getAttribute("userPosname").equals("과장") || session.getAttribute("userPosname").equals("차장")){	
						%>
						<td><a href="projectCreation.jsp?projectId=<%=rs.getInt("project_id")%>" class="btn btn-xs">modify</a>
						<%
						if(session.getAttribute("userId").equals("1")){
						%> 
						<a href="#" class="btn btn-xs btn-danger" data-action="delete" data-id="<%=rs.getInt("project_id")%>">delete</a>
							 <%}%>
							</td>
							 <%}%>
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
			if(session.getAttribute("userPosname").equals("과장") || session.getAttribute("userPosname").equals("차장")){
		%>
		<div class="form-group">
			<a href="projectCreation.jsp" class="btn btn-primary">Add Project</a>
		</div>
		<%
			}}
		%>
	</div>

</body>
<script>
	$(function() {
		$("a[data-action='delete']").click(function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				location = 'deleteProject.jsp?id=' + $(this).attr('data-id');
			}
			return false;
		});
	});
</script>