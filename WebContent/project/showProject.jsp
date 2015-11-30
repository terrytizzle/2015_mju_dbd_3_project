<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
  
<%
	String errorMsg = null;

	String actionUrl = "";

	// ������ ����
	int pageNo = 1;

	try {
		pageNo = Integer.parseInt(request.getParameter("page"));
	} catch (NumberFormatException ex) {
	}

	int numInPage = 10; // ���������� ����� ������ ����
	int startPos = (pageNo - 1) * numInPage; // �� ��° ������ ���� �� ��������?
	int numItems, numPages;
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>������Ʈ ��ȸ</title>
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
 
	<div class="container">
		<div>
			
			<form name="form1" method="post" action="showProject.jsp">
				<fieldset>
					<legend class="legend"> ������Ʈ �˻� </legend>
					<p>
						<input type="text" name="projectInfo" size=30> <input type="submit" name="Submit" value="��ȸ�ϱ�">
					</p>
		
 			<table class="table table-bordered table-stripped">
				<thead>
				 <tr>
					 <th>������Ʈ ID</th>
					 <th>������Ʈ �̸�</th>
					 <th>��������</th>
					 <th>��������</th>
					 <th>����ó</th>
					 <th>������Ʈ ����</th>
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
					
					if (request.getMethod() == "POST") {
						String projectInfo = request.getParameter("projectInfo");
						
						String sql = "select * from project where project_id= '" + projectInfo + "' or project_name= '"
								+ projectInfo + "'";
						
						if (projectInfo.isEmpty()) {
							sql = "SELECT * FROM project ORDER BY project_id LIMIT " + startPos + ", " + numInPage;
						}
						
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						String gender;
						
						while(rs.next()) {
						String id = rs.getString("project_id");
						String name = rs.getString("project_name");
						String start_date = rs.getString("project_start");
						String finish_date = rs.getString("project_finish");
						String owner = rs.getString("project_owner");
						String describe = rs.getString("project_describe");
				
						if (projectInfo.equals(id) || projectInfo.equals(name)) {
				%> 
				<tbody>
					<tr>
						<td> <%=id%> </td>
						<td> <%=name%> </td>
						<td> <%=start_date%> </td>
						<td> <%=finish_date%> </td>
						<td> <%=owner%> </td>
						<td> <%=describe%> </td>
						<td>
							<a href="projectCreation.jsp?userId=<%=rs.getInt("project_id")%>" class="btn btn-xs">modify</a>
							<a href="#" class="btn btn-xs btn-danger" data-action="delete" data-id="<%=rs.getInt("project_id")%>">delete</a></td>
					</tr>
				</tbody>
				<%
					}
						}
						if (!rs.first()) {
				%>
				<p>�ش� ������Ʈ�� �����ϴ�.</p>
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
		<div class="form-group">
			<a href="projectCreation.jsp" class="btn btn-primary">Add Project</a>
		</div>
	</div>

</body>
<script>
	$(function() {
		$("a[data-action='delete']").click(function() {
			if (confirm("������ �����Ͻðڽ��ϱ�?")) {
				location = 'deleteProject.jsp?id=' + $(this).attr('data-id');
			}
			return false;
		});
	});
</script>