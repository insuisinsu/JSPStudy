<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method = "post" action = "insert01_process.jsp">
		<p> 아이디 : <input type = "text" name = "id">
		<p> 패스워드 : <input type = "password" name = "passwd">
		<p> 이름 : <input type = "text" name = "name">
		<p> 이메일 : <input type = "text" name = "email">
		<p> <input type = "submit" values = "전송">	
	</form>


</body>
</html>

<!--
	method = "post"
		. http 헤더 앞에 값을 넣어 전송
		. 보안이 높음
		. 전송 용량 제한이 없음
		. 파일 전송에 사용
	method = "get"
		. http 헤더 뒤에 값을 넣어 전송 (내용이 다 보임)
		. 보안에 취약함
		. 전송 용량이 제한적임
		. 게시판에서 사용 
	
 -->
 
 
 
 
 