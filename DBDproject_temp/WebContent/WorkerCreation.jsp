<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Worker Management</title>
</head>
<body>
	<p>����/��� ���� ����</p>
	<form name="form1" method="post" action="loginTest.jsp">
		<p>
			�����̸� : <input type="text" name="id">
		</p>
		<p>
			����pw : <input type="password" name="passwd">
		</p>
		<p>
			���� : <input type="text" name="birth">
		</p>
		<p>
			�μ� : <input type="text" name="dept">
		</p>
		<p>
			���� : <input type="text" name="salary">
		</p>
		<p>
			�Ի��� : <input type="text" name="entrance">
		</p>
		<p>
			����� : <input type="text" name="terminate">
		</p>
		<p>
			�̸��� : <input type="text" name="email">
		</p>
		<p>
			�����з� : <input type="text" name="final_edu">
		</p>
		<p>
			���޸� : <input type="text" name="pos_name">
		</p>
		<p>
			<input type="submit" name="Submit" value="���� ����">
		</p>
	</form>
</body>
</html>