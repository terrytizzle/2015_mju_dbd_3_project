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
<title>평가 조회</title>
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

			<form name="form1" method="post" action="showEval.jsp">
				<fieldset>
					<legend class="legend"> 직원 검색 </legend>
					<p>
						<input type="text" name="workerInfo" size=30> <input type="submit" name="Submit" value="조회하기">
					</p>


					<table class="table table-bordered table-stripped">
						<thead>
							<tr>
								<th>직원번호</th>
								<th>프로젝트번호</th>
								<th>직무</th>
								<th>PM 업무점수</th>
								<th>PM 소통점수</th>
								<th>고객 업무점수</th>
								<th>고객 소통점수</th>
								<th>동료 업무점수</th>
								<th>동료 소통점수</th>
								<th>평가여부</th>
							</tr>
						</thead>

						<%
							request.setCharacterEncoding("utf-8");
							Connection con = null;
							Connection conn = null;
							PreparedStatement pstmt = null;
							PreparedStatement pstmt1 = null;
							ResultSet rs = null;
							ResultSet rss = null;
							try {
								String DB_SERVER = "localhost:3306";
								String DB_SERVER_USERNAME = "root";
								String DB_SERVER_PASSWORD = "admin";
								String DB_DATABASE = "mjsolution";
								String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/" + DB_DATABASE;
								Class.forName("com.mysql.jdbc.Driver");
								con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
								conn = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
								if (request.getMethod() == "POST") {
									String workerInfo = request.getParameter("workerInfo");
									String workerId="";
									String worksName="";
									String projectId="";
									String classify="";
									String evalInOut="";
									String eval[]= new String[6];
									
									
									String ssql = "select worker_id, project_id, works_name from works_for where worker_id='"+workerInfo+"' order by project_id desc";
									
									pstmt1 = conn.prepareStatement(ssql);
									rss = pstmt1.executeQuery();
									while (rss.next()) {
										workerId = rss.getString("worker_id");
										projectId = rss.getString("project_id");
										worksName = rss.getString("works_name");
										eval[0]="";
										eval[1]="";
										eval[2]="";
										eval[3]="";
										eval[4]="";
										eval[5]="";
									
									String sql = "select classify, avg(a.eval_work) as avg_work, avg(a.eval_communication) as avg_communication  from evaluation a join worker_eval b on a.eval_id=b.eval_id join project_eval c on a.eval_id = c.eval_id where b.worker_id='"+workerInfo+"' and c.project_id='"+projectId+"' group by classify";
											
									if (workerInfo.isEmpty()) {
										sql = "SELECT * FROM worker ORDER BY worker_id LIMIT " + startPos + ", " + numInPage;
									}

									pstmt = con.prepareStatement(sql);
									rs = pstmt.executeQuery();

									while (rs.next()) {
										classify = rs.getString("classify");
										String avgWork = rs.getString("avg_work");
										String avgCommunication = rs.getString("avg_communication");
										evalInOut="평가";
										if(classify.equals("1")){
											eval[0]=avgWork;
											eval[1]=avgCommunication;
										} else if(classify.equals("2")){
											eval[2]=avgWork;
											eval[3]=avgCommunication;
										} else{
											eval[4]=avgWork;
											eval[5]=avgCommunication;
										}
									}
									if (!rs.first()) {
										evalInOut="미평가";
									}

						%>
						<tbody>
							<tr>
								<td><%=workerId%></td>
								<td><%=projectId%></td>
								<td><%=worksName%></td>
								<td><%=eval[0]%></td>
								<td><%=eval[1]%></td>
								<td><%=eval[2]%></td>
								<td><%=eval[3]%></td>
								<td><%=eval[4]%></td>
								<td><%=eval[5]%></td>
								<td><%=evalInOut%></td>
							</tr>
						</tbody>
						<%
						
						}
							if (!rss.first()) {
						%>
						<p>해당 직원이 없습니다.</p>
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
