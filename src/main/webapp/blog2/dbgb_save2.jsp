<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %>

<% request.setCharacterEncoding("EUC-KR"); %>
<%@ include file = "dbconn_oracle.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DataBase저장</title>
</head>
<body>
	<%
		// 폼에서 받은 변수를 저장
		String na = request.getParameter("name");
		String em = request.getParameter("email");
		String sub = request.getParameter("subject");
		String cont = request.getParameter("content");
	
		int pos = 0;		
		if(cont.length() == 1) {
			cont = cont + " ";
		}
		
		//textarea ' 처리
		while ( (pos = cont.indexOf("\'" , pos) ) != -1) {
			String left = cont.substring(0,pos);
			String right = cont.substring(pos, cont.length());
			pos += 2;
		}
		
		// 오늘의 날짜 처리
		java.util.Date yymmdd = new java.util.Date();
		SimpleDateFormat myformat = new SimpleDateFormat ("yy-MM-dd a h:mm:ss");
		String ymd = myformat.format(yymmdd);
		
		// 저장하기
		String sql = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;	// insert 잘 되었는지 확인
		
		try{
			sql = "Insert into guestboard (name, email, inputdate, subject, content)";
			sql = sql + " values(?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, na);
			pstmt.setString(2, em);
			pstmt.setString(3, ymd);
			pstmt.setString(4, sub);
			pstmt.setString(5, cont);
			
			cnt = pstmt.executeUpdate();
			
			if(cnt > 0) {
				out.println("데이터가 성공적으로 입력 되었습니다.");
			}else {
				out.println("데이터가 입력되지 않았습니다.");
			}
			
		} catch (Exception e) {
			out.print(e.getMessage());
		}finally{
			if( rs != null)
				rs.close();
			if ( pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
	%>
	
<jsp:forward page = "dbgb_show5.jsp"/>	

</body>
</html>