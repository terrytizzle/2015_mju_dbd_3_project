<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

String[][] menu = {
{"http://localhost:8080/2015_mju_dbd_3_project/worker/showWorker.jsp", "직원조회" },
{"http://localhost:8080/2015_mju_dbd_3_project/project/showProject.jsp", "프로젝트 조회" },	
{"http://localhost:8080/2015_mju_dbd_3_project/approve/showApprove.jsp", "프로젝트 승인" },
{"http://localhost:8080/2015_mju_dbd_3_project/member/memberCreation.jsp", "팀원 관리" }
};
String currentMenu = request.getParameter("current");

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String dbUrl = "jdbc:mysql://localhost:3306/mjsolution";
String dbUser = "root";
String dbPassword = "admin";

String userid = "";
int id  = 0;

try {
	Class.forName("com.mysql.jdbc.Driver");

	conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	stmt = conn.prepareStatement("SELECT * FROM worker");
	rs = stmt.executeQuery();

	while(rs.next()) {
		userid = rs.getString("worker_name");
		id = rs.getInt("worker_id");
		
	}
} catch (SQLException e) {
} finally {
if (rs != null) try{rs.close();} catch(SQLException e) {}
if (stmt != null) try{stmt.close();} catch(SQLException e) {}
if (conn != null) try{conn.close();} catch(SQLException e) {}
}

%>

<!-- Navbar================================================== -->

<div class="container navbar navbar-inverse navbar-fixed-top" role="navigation">
	
	
	<div class="container-fluid">
		
		<div class="navbar-header">
			<a class="navbar-brand" href="http://localhost:8080/2015_mju_dbd_3_project/main.jsp">MJS</a>
		</div>
		<div class="collapse navbar-collapse" >
			<ul class="nav navbar-nav">
				<%
					for(String[] menuItem : menu) {
						if (currentMenu != null && currentMenu.equals(menuItem[1])) {
							out.println("<li class='active'>");
						} else {
							out.println("<li class=''>");
						}
			
						out.println("<a href='"+menuItem[0]+"'>"+menuItem[1]+"</a>");
						out.println("</li>");
					}
				%>
			</ul>
			<p class="navbar-text pull-right">
				<%
				if (session.getAttribute("userId") == null) { 
				%>
				<a href="http://localhost:8080/2015_mju_dbd_3_project/login.jsp" class = "navbar-link">login</a>
				<%
				} else{
					%>
				<a href="http://localhost:8080/2015_mju_dbd_3_project/logout.jsp?id=<%= session.getAttribute("userId")%>" class = "navbar-link">logout</a>
				<a href="http://localhost:8080/2015_mju_dbd_3_project/mypage/myPage.jsp?id=<%= session.getAttribute("userId")%>" class = "navbar-link">my page</a>
				
				<%
				if(session.getAttribute("userDept").equals("인사") && session.getAttribute("userPosname").equals("부장")){				
					%>
					<a href="http://localhost:8080/2015_mju_dbd_3_project/position/showPosition.jsp" class = "navbar-link">pos_page</a>
					<%}
				}
				 %>
			</p>
		</div>
		
	</div>
	
</div>


<div class="container container-fluid" style="padding-top: 50px">
	<h1>MJ Solution &amp; Database Design</h1>
</div>


