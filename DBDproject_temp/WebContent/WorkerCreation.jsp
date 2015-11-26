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
	<p>신입/경력 직원 생성</p>
	<form name="form1" method="post" action="loginTest.jsp">
		<p>
			직원이름 : <input type="text" name="id">
		</p>
		<p>
			직원pw : <input type="password" name="passwd">
		</p>
		<p>
			생일 : <input type="text" name="birth">
		</p>
		<p>
			부서 : <input type="text" name="dept">
		</p>
		<p>
			연봉 : <input type="text" name="salary">
		</p>
		<p>
			입사일 : <input type="text" name="entrance">
		</p>
		<p>
			퇴사일 : <input type="text" name="terminate">
		</p>
		<p>
			이메일 : <input type="text" name="email">
		</p>
		<p>
			최종학력 : <input type="text" name="final_edu">
		</p>
		<p>
			직급명 : <input type="text" name="pos_name">
		</p>
		<p>
			<input type="submit" name="Submit" value="직원 생성">
		</p>
	</form>
</body>
</html>