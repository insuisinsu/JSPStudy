<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.text.ParseException" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form 에서 전달 받아 DB 에 저장</title>
</head>
<body>

<%@ include file = "dbconn_ms.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	String eno = request.getParameter("eno");
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	String manager = request.getParameter("manager");
	String hiredate = request.getParameter("hiredate");
	//String hiredate1 = String.valueOf(request.getParameter("hiredate"));
	//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	//Date hiredate = formatter.parse(hiredate1);
	
	String salary = request.getParameter("salary");
	String commission = request.getParameter("commission");
	String dno = request.getParameter("dno");
	
	Statement stmt = null;
	
	try{
		
		String sql = " insert into emp_copy";
		sql += " values(" + eno + ", " + ename + ", " + job + ", " + manager + ", " + "'"+hiredate+"'" + " ," + salary + ", " + commission + ", " + dno + ") ";
		
		stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		
		out.println("테이블 삽입에 성공했습니다.");
		
	}catch(Exception e){
		out.println("mbTbl 테이블에 삽입을 실패했습니다.");
		out.println(e.getMessage());
	}finally{
		if(stmt != null)
			stmt.close();
		if(conn != null)
			conn.close();
	}

%>

<p>
<%= eno %><p>
<%= ename %><p>
<%= job %><p>
<%= manager %><p>
<%= hiredate %><p>
<%= salary %><p>
<%= commission %><p>
<%= dno %>


</body>
</html>