<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	String errorMsg = null;

	String actionUrl = "";

	// 페이지 설정
	int pageNo = 1;

	try {
		pageNo = Integer.parseInt(request.getParameter("page"));
	} catch (NumberFormatException ex) {}

	int numInPage = 10; // 한페이지에 출력할 아이템 개수
	int startPos = (pageNo - 1) * numInPage; // 몇 번째 아이템 부터 이 페이지에?
	int numItems, numPages;
	
	
	

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>팀원평가</title>
<link href="http://localhost:8080/2015_mju_dbd_3_project/css/bootstrap.min.css" rel="stylesheet">
<link href="http://localhost:8080/2015_mju_dbd_3_project/css/base.css" rel="stylesheet">
<script src="http://localhost:8080/2015_mju_dbd_3_project/js/jquery-1.8.2.min.js"></script>
<script src="http://localhost:8080/2015_mju_dbd_3_project/js/bootstrap.min.js"></script>
<script type = "text/javascript">
 
 
 </script>
</head>
<body>
<jsp:include page="../share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>
	
	<%
					String workerId = request.getParameter("workerId");
					String workerName = request.getParameter("workerName");
					
					if(workerId != null){
					session.setAttribute("wId", workerId);
					session.setAttribute("wName", workerName);
					}
					
					session.setAttribute("PM", "PM");
					String uWorks_name = (String)session.getAttribute("userWorks_name");
					String userId = (String)session.getAttribute("userId");
					String pId = (String)session.getAttribute("pId");
					String wId = (String)session.getAttribute("wId");
					String wName = (String)session.getAttribute("wName");
					String classify ="";
					String pm= (String)session.getAttribute("PM");
					%>
	<div class="container">
		<div>
		<fieldset>
					<legend class="legend"> 팀원 평가 </legend>
					<form name="form1" method="post" action="workerEval.jsp">
					<table class="table table-bordered table-stripped">
					
						<tbody>
							<tr>
								<td>직원ID : </td>
								<td><%=wId%></td>
							</tr>
							<tr>
								<td>직원이름 : </td>
								<td><%=wName%></td>
							</tr>
							<%
							
							//if( uWorks_name==pm){
								%>
								<tr>
								<td>평가 구분  : </td>
								<td>
								<input type="radio" name="classify_eval" value=1>PM
								<input type="radio" name="classify_eval" value=2>고객
								<input type="radio" name="classify_eval" value=3>동료
								</td>
							</tr>
								<%
							//}
							
							
							%>
							<tr>
								<td>업무 평가  : </td>
								<td>
								
								<input type="radio" name="worK_eval" value=1>1
								<input type="radio" name="worK_eval" value=2>2
								<input type="radio" name="worK_eval" value=3>3
								<input type="radio" name="worK_eval" value=4>4
								<input type="radio" name="worK_eval" value=5>5
								</td>
							</tr>
							<tr>
								<td>커뮤니케이션 평가  : </td>
								<td><input type="radio" name="commu_eval" value=1>1
								<input type="radio" name="commu_eval" value=2>2
								<input type="radio" name="commu_eval" value=3>3
								<input type="radio" name="commu_eval" value=4>4
								<input type="radio" name="commu_eval" value=5>5
								</td>
							</tr>
							<tr>
								<td>
									<input type="submit" name="Submit" value="저장">
								</td>
							</tr>
						</tbody>
					</table>
			</form>		
		<%
					
					Connection con = null;
					Connection conn=null;
					PreparedStatement pstmt = null;
					PreparedStatement pstmt2 = null;
					PreparedStatement pstmt3 = null;
					PreparedStatement stmt = null;
					ResultSet rs = null;
					ResultSet rss = null;
					try {
						String DB_SERVER = "localhost:3306";
						String DB_SERVER_USERNAME = "root";
						String DB_SERVER_PASSWORD = "admin";
						String DB_DATABASE = "mjsolution";
						String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/"+ DB_DATABASE;
						Class.forName("com.mysql.jdbc.Driver");
						con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME,	DB_SERVER_PASSWORD);
						
						if (request.getMethod() == "POST") {
						
							int work_eval= Integer.parseInt(request.getParameter("worK_eval"));
							int commu_eval= Integer.parseInt(request.getParameter("commu_eval"));
							int score = work_eval+commu_eval;
							
							//if(uWorks_name==pm){
								classify = request.getParameter("classify_eval"); //1은 PM 2는 고객 3은 동료
							//} else{
							//	classify="3";//동료
							//}
							
							String eval_id="";
							
							pstmt = con.prepareStatement(
									"INSERT INTO evaluation(eval_work, eval_communication, eval_score) " +
									"VALUES(?, ?, ?)"
									);
							pstmt.setInt(1, work_eval);
							pstmt.setInt(2, commu_eval);
							pstmt.setInt(3, score);
							pstmt.executeUpdate();

							String sql = "select Max(eval_id) as eval_id from evaluation";
							//conn = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME,	DB_SERVER_PASSWORD);
							stmt = con.prepareStatement(sql);
							rs = stmt.executeQuery();

							while (rs.next()) {
								eval_id = rs.getString("eval_id");
							}
							
							%>
							<p><%=wName%></p>
							<% 
							
							pstmt2 = con.prepareStatement(
									"INSERT INTO worker_eval(evaluator_id, worker_id, eval_id, classify) " +
									"VALUES(?, ?, ?, ?)"
									);
							pstmt2.setString(1, userId);
							pstmt2.setString(2, wId);
							pstmt2.setString(3, eval_id);
							pstmt2.setString(4, classify);
							pstmt2.executeUpdate();
							
							pstmt3 = con.prepareStatement(
									"INSERT INTO project_eval(project_id, eval_id) " +
									"VALUES(?, ?)"
									);
							pstmt3.setString(1, pId);
							pstmt3.setString(2, eval_id);
							pstmt3.executeUpdate();
							
							%>
				<table class="table table-bordered table-stripped">
						<thead>
							<tr>
								<th>평가번호</th>
								<th>프로젝트번호</th>
								<th>직원번호</th>
								<th>직원이름</th>
								<th>직무평가</th>
								<th>커뮤니케이션평가</th>
								<th>종합점수</th>
								<th>구분</th>
							</tr>
						</thead>
									<% 
									String ssql = "select a.eval_work, a.eval_communication, a.eval_score, b.classify from evaluation a join worker_eval b on a.eval_id=b.eval_id join project_eval c on a.eval_id = c.eval_id where a.eval_id='"+eval_id+"'";
									conn = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME,	DB_SERVER_PASSWORD);
									stmt = conn.prepareStatement(ssql);
									rss = stmt.executeQuery();
		
									while (rss.next()) {
										String eval_work = rss.getString("eval_work");
										String eval_communication = rss.getString("eval_communication");
										String eval_score = rss.getString("eval_score");
										String eval_classify = rss.getString("classify");
						%>
						<tbody>
							<tr>
								<td><%=eval_id%></td>
								<td><%=pId%></td>
								<td><%=wId%></td>
								<td><%=wName%></td>
								<td><%=eval_work%></td>
								<td><%=eval_communication%></td>
								<td><%=eval_score%></td>
								<td><%=eval_classify%></td>
							</tr>
						</tbody>
				</table>
							
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
						if (stmt != null) {
							try {
								stmt.close();

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
	</div>
</body>
</html>