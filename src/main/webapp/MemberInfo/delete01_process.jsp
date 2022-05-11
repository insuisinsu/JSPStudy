<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete 를 통한 데이터 삭제</title>
</head>
<body>

<%@ include file = "dbconn_oracle.jsp" %>

<%
	//form 에서 넘겨 Request 객체의 getParameter 로 변수의 값을 받는다.
	request.setCharacterEncoding("UTF-8"); // 폼에서 넘김 한글을 처리하기 위함

	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	
	try{
		//레코드 삭제
		sql = "select id, pass from mbTbl where id = '"+id+"'";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			
			String rId = rs.getString("id");
			String rPass = rs.getString("pass");
			
			if(passwd.equals(rPass)){
				sql = "delete mbTbl where id = '" + id + "'";
				stmt.executeUpdate(sql);
				
				out.println("해다 아이디 : "+id+" 가 삭제되었습니다.");
			}else{
				out.println("패스워드가 일치하지 않습니다.");
			}
			
		}else{
			out.println("해당 id 가 존재하지 않습니다.");
		}
		
		out.println(sql);
	}catch(Exception ex){
		out.println(ex.getMessage());
		out.println(sql);
	}finally{
		if(rs != null)
			rs.close();
		if(stmt != null)
			stmt.close();
		if(conn != null)
			conn.close();
	}
%>	
	
</body>
</html>