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

<%
	// 변수 초기화
	Connection conn = null;		// DB 를 연결하는 객체 
	
	String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";		// MSSQL Driver에 접속
	String url = "jdbc:sqlserver://localhost:1433;DatabaseName=myDB";
	
	Class.forName (driver);		// MSSQL 드라이버 로드함
	conn = DriverManager.getConnection (url, "sa" , "1234");


%>


</body>
</html>