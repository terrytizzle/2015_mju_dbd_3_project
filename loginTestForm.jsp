<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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