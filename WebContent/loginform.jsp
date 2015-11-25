<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인 test</title>
 </head>
 <body>
 <p>로그인 test</p>
 <form name="form1" method="post" action="loginTest.jsp">
 <p>아이디 : <input type="text" name="id"></p>
 <p>패스워드 : <input type="password" name="passwd"></p>
 <p><input type="submit" name="Submit" value="로그인"></p>
 </form>
 </body>
</html> 