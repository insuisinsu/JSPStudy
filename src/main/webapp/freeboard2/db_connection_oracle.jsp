<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle DB Connection </title>
</head>
<body>

<%
	//변수 초기화 
	Connection conn = null;      //DB를 연결하는 객체 
	String driver = "oracle.jdbc.driver.OracleDriver";      //Oracle Driver에 접속 
	String url = "jdbc:oracle:thin:@localhost:1521:XE"; 
	Boolean connect = false; 		//접속이 잘되는지 확인 하는 변수 
	
	try {
		Class.forName (driver) ; 		//오라클 드라이버 로드함. 
		conn= DriverManager.getConnection (url, "hr2", "1234");
		
		connect = true; 
		conn.close(); 
		
	}catch (Exception e){
		connect=false;
		e.printStackTrace(); 
	}

%>

<%
	if (connect == true){
		out.println ("오라클 DB에 잘 연결 되어습니다. ");
	}else {
		out.println ( "오라클 DB연결에 실패 하였습니다. "); 
	}

%>









</body>
</html>