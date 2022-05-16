<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ include file = "dbconn_oracle.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link href = "filegb.css" rel = "systlesheet" type = "text/css">
<title>글 삭제 - DB 에서 삭제</title>
</head>
<body>
[ <a href = "freeboard_list.jsp?page=<%= request.getParameter("page")%>"> 게시판 목록으로 이동 </a>]
<p><p>
<%
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int cnt = 0;		//Delete 가 되었는지 확인하는 변수
	
	int id = Integer.parseInt(request.getParameter("id"));
	
	try{
		//DB 의 비밀번호와 form 으로 받은 비밀번호 비교
		sql = "select * from freeboard where id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		rs = pstmt.executeQuery();
		
		if(!(rs.next())){
			out.println("해당 내용은 존재하지 않습니다.");
		}else{
			// Password 확인 후 일치하면 삭제
			String pwd = rs.getString("password");
			if(pwd.equals(request.getParameter("password"))){
				sql = "delete freeboard where id = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, id);
				cnt = pstmt.executeUpdate();
				
				if(cnt>0){
					out.println("삭제 되었습니다.");
				}else{
					out.println("삭제되지 않았습니다.");
				}
			}else{
				out.println("비밀번호가 일치하지 않습니다.");
			}
		}
		
	}catch(Exception ex){
		out.println(ex.getMessage());
	}finally{
		if(rs != null)
			rs.close();
		if(pstmt != null)
			pstmt.close();
		if(conn != null)
			conn.close();
	}
	
%>

</body>
</html>