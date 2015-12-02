<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<%
	String errorMsg = null;
	String actionUrl = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>main page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>

	<%
	 if(session.getAttribute("userId") == null){ 
	%>

	<script type=text/javascript>
			alert("권한이 없습니다. 로그인하세요.");
			window.location.replace("login.jsp");
		</script>
	<%
	 }
	%>


	<div class="container">
		<div>
			<form class="form-horizontal" action="<%=actionUrl%>" method="post">
				<fieldset>
					<legend class="legend"> TITLE</legend>
					<div id="warp">
						<div id="top">
							<%
								if (session.getAttribute("userName") == null) {
							%>
							<p>환영합니다.</p>
							<%
								} else {
							%>
							<p>
								환영합니다.
								<%=session.getAttribute("userName")%>님
							</p>
							<%
								}
							%>
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
										String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/" + DB_DATABASE;

										Class.forName("com.mysql.jdbc.Driver");
										con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);

										String sql = "select worker_name, authorization from worker natural join position where worker_name = '"
												+ session.getAttribute("userName") + "'";

										pstmt = con.prepareStatement(sql);
										rs = pstmt.executeQuery();

										while (rs.next()) {
											int authorLevel = rs.getInt("authorization");
								%>
								<fieldset>
									<p>
										<%=session.getAttribute("userDept")%>팀
										<%=session.getAttribute("userName")%>
										<%=session.getAttribute("userPosname")%>님은 현재 권한레벨 :
										<%=authorLevel%>
										입니다.
									</p>
									<p>
										<%=session.getAttribute("userWorks_name") %>
										직무를 맡고 있습니다.
									</p>
									</br>
									<%
										if (authorLevel <= 2) {
									%>
									<p>success m</p>
									<a class="nodec" href="./worker/showWorker.jsp">직원조회</a></br> <a class="nodec" href="./worker/workerManagement.jsp">직원관리</a></br> <a class="nodec" href="./project/showProject.jsp">프로젝트현황</a></br> <a class="nodec" href="./">D</a></br>
									<%
										}
												if (authorLevel == 5) {
									%>
									<a class="nodec" href="./">B</a></br>
									<%
										}
												if (authorLevel <= 7) {
									%>
									<a class="nodec" href="./worker/showWorker.jsp">직원조회</a></br>
									<%
										} else {
									%><p>기능을 사용할 수 있는 권한이 없습니다.</p>
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
</html>