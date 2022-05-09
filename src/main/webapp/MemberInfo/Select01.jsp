<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB의 내용을 가져와서 출력하기</title>
</head>
<body>

<%@ include file = "dbconn_oracle.jsp" %>

<table width = "500" border = "1">

	<tr>
		<th> 아이디 </th>	
		<th> 비밀번호 </th>
		<th> 이름 </th>
		<th> email </th>
		<th> city </th>
		<th> phone </th>
	</tr>
	
	<%
		//ResultSet 객체는 DB 의 테이블을 Select 해서 나온 결과의 레코드셋을 담는 객체
		ResultSet rs = null;	
		Statement stmt = null;	//SQL 쿼리를 담아서 실행하는 객체
		
		try{
			String sql = "select * from mbTbl";
			stmt = conn.createStatement();	// connection 객체의 createStatement() 로 stmt 를 활성화
			rs = stmt.executeQuery(sql);
				// stmt.excuteQuery(sql)	: select 한 결과를 ResultSet 객체로 저장해야하
				//stmt.excuteUpdate(sql)	: insert, update, delete
			while(rs.next()){
					String id = rs.getString("id");
					String pw = rs.getString("pass");
					String name = rs.getString("name");
					String email = rs.getString("email");
					String city = rs.getString("city");
					String phone = rs.getString("phone");
		%>		
	
					
		<tr>
			<td> <%= id %> </td>	
			<td> <%= pw %> </td>
			<td> <%= name %> </td>
			<td> <%= email %> </td>
			<td> <%= city %> </td>
			<td> <%= phone %> </td>
		</tr>
	<%				
			}		
		}catch(Exception e){
			out.println("테이블 호출에 실패했습니다.");
			out.println(e.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();	
			if (conn != null)
				conn.close();
		}
		
		 %>

</table>


</body>
</html>