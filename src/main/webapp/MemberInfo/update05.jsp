<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form method = "post" action = "update05_process.jsp">
		<p> 아이디 : <input type = "text" name = "id">
		<p> 패스워드 : <input type = "password" name = "passwd">
		<p> 이름 : <input type = "text" name = "name">
		<p> 이메일 : <input type = "text" name = "email">
		<p> <input type = "submit" values = "전송">	
	</form>

</body>
</html>