<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<%
	String errorMsg = null;
	String actionUrl = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>main page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</html>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>
	<div class="container">
		<div>
			<form class="form-horizontal" action="<%=actionUrl%>" method="post">
				<fieldset>
					<legend class="legend"> TITLE</legend>
					<div id="warp">
						<div id="top">
							<p>환영합니다. <%=session.getAttribute("userName")%>님</p>
						</div id="logo">
						<div>
							<fieldset>
								<h1>인사관리시스템</h1>
							</fieldset>
						</div>
						<div id="middle">
							<div id="menu">
							
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
									String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/"
											+ DB_DATABASE;
							
									Class.forName("com.mysql.jdbc.Driver");
									con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME,
											DB_SERVER_PASSWORD);
									
										
									String sql = "select worker_name, authorization from worker natural join position where worker_name = '" + session.getAttribute("userName") +"'";
										 
									pstmt = con.prepareStatement(sql);
									rs = pstmt.executeQuery();
										
									if(rs.next()) {
										int authorLevel = rs.getInt("authorization");
										%> 
										<fieldset>
										<p> <%=session.getAttribute("userName")%>님은 현재 권한레벨 : <%=authorLevel%> 입니다. </p></br>
										
										<%
										if(authorLevel <= 2){
												%>
													<a class="nodec" href="./worker/showWorker.jsp">직원조회</a></br> 
													<a class="nodec" href="./project/showProject.jsp">프로젝트 조회</a></br>
												<%
											}
										else if(authorLevel == 3){
											if(session.getAttribute("userDept").equals("인사")){
												%>
													<a class="nodec" href="./worker/showWorker.jsp">직원관리</a></br> 
													
													<a class="nodec" href="./worker/administrator.jsp">관리자 페이지</a></br>
												<%
											}else{%>
													<a class="nodec" href="./worker/showWorker.jsp">직원 조회</a></br>
											<%
											}
													%><a class="nodec" href="./project/showProject.jsp">프로젝트 조회</a></br>
										<% 
										}
										 else if(authorLevel == 4 || authorLevel == 5 ){
											 %>
											 		<a class="nodec" href="./worker/showWorker.jsp">직원조회</a></br> 
													<a class="nodec" href="./project/showProject.jsp">프로젝트 관리</a></br>
											<%
										 }
										 else if(authorLevel <= 7){
											%>
													<a class="nodec" href="./worker/showWorker.jsp">직원조회</a></br> 
													<a class="nodec" href="./project/showProject.jsp">프로젝트 조회</a></br>
												<%
										 } else{
												%><p> 기능을 사용할 수 있는 권한이 없습니다. </p><%
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
							<div id="maincontents">
								<fieldset>
									<p>success main</p>
									<fieldset>
										<legend>main content</legend>
										<p>
											MJ solution <br>
									</fieldset>
								</fieldset>
							</div>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>

</body>