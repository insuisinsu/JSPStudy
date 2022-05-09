<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폼에서 넘겨받은 값을 DB에 저장하는 파일</title>
</head>
<body>

<%@ include file = "dbconn_oracle.jsp" %>

<%
	request.setCharacterEncoding("UTF-8"); // 폼에서 넘김 한글을 처리하기 위함

	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");

	Statement stmt = null;			// Statement 객체 : SQL 쿼리 구문을 담아서 실행하는 객체
	
	try{
		
		String sql = "INSERT INTO mbTbl ( idx, id, pass, name, email ) Values (seq_mbTbl_idx.nextval, '" + id + "','"+  passwd + "','" + name+"','" + email + "') ";

	
		stmt = conn.createStatement();		//connection 객체를 통해서 statement 객체 생성
		stmt.executeUpdate(sql);			//statement 객체를 통해서 sql 을 실행함
		// -> stmt.executeUpdate(sql) : sql <== insert, update, delete 문
		// -> etmt.executeQuery(sql)  : sql <== select 문
		
		out.println("테이블 삽입에 성공 했습니다.");
		
	}catch(Exception ex){
		out.println("mbTbl 테이블에 삽입을 실패했습니다.");
		out.println(ex.getMessage());
	}finally{
		if(stmt != null)
			stmt.close();
		if(conn != null)
			conn.close();
	}
	
%>

<%= id %> <p>
<%= passwd %> <p>
<%= name %> <p>
<%= email %>




</body>
</html>