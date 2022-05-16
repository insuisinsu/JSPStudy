<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
<% request.setCharacterEncoding("EUC-KR"); %>    <!--  한글 처리  -->

 <%@ include file = "dbconn_oracle.jsp" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>폼의 값을 받아서 DataBase에 값을 넣어주는 파일</title>
</head>
<body>
<%
	//폼에서 넘긴 변수를 받아서 저장. 
	String na = request.getParameter("name"); 
	String em = request.getParameter("email"); 
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content"); 
	String pw = request.getParameter("password"); 
	
	int id = 1; 		//DB에 id컬럼에 저장할 값
	
	int pos =0 ; 
	if (cont.length()==1) {
		cont = cont + " " ; 
	}
	
	//content (Text Area ) 에 엔터를 처리해 줘야 한다. Oracle DB 에 저장시에  
	while ((pos = cont.indexOf("\'", pos)) != -1){
		String left = cont.substring (0,pos); 
		String right = cont.substring (pos, cont.length()); 
		cont = left + "\'" + right; 
		pos += 2; 
	}
	
	//오늘의 날짜 처리 
	
	java.util.Date yymmdd = new java.util.Date(); 
	SimpleDateFormat myformat = new SimpleDateFormat ("yy-MM-d h:mm a"); 
	String ymd = myformat.format(yymmdd); 
	
	String sql = null; 
	Statement st = null ; 
	ResultSet rs = null ; 
	int cnt = 0 ; 			// -- Insert가 잘 되었는지 그렇지 않은지 확인 하는 변수 . 
			
	try {
		
		//값을 저장하기 전에 최신 글번호 (max(id))를 가져 와서 + 1 을 적용한다. 
		//conn (Connection) : Auto commit; 이 작동 된다. 
			//commit을 명시 하지 않아도 insert , update, delete , 자동 커밋이 된다. 
		
		st = conn.createStatement(); 
		sql = "select max (id) from freeboard"; 
		rs = st.executeQuery(sql);
		
		if ( !(rs.next())){  //rs의 값이 비어있을때 
			id = 1; 
		}else { 			// rs의 값이 존재 할때 
			id = rs.getInt(1) + 1 ;    // 최대값 + 1 	 
		}
		
		
		sql = "INSERT INTO freeboard (id, name, password, email, subject, " ; 
		sql = sql + "content, inputdate, masterid, readcount, replaynum, step)";
		sql = sql + " values (" + id + ",'" +  na +  "','" +  pw + "','" + em  ; 
		sql = sql + "','" + sub + "','" + cont + "','" + ymd + "'," + id + "," ; 
		sql = sql + "0,0,0)"; 
		
		//out.println (sql); 
		
		cnt =  st.executeUpdate(sql);    //cnt > 0 : Insert  성공,  
		
		if (cnt > 0){
			out.println ("데이터가 성공적으로 입력 되었습니다."); 
		}else {
			out.println ( "데이터가 입력되지 않았습니다. "); 
		}
			
	}catch (Exception ex) {
		out.println (ex.getMessage()); 
	}finally {
		if ( rs != null)
			rs.close(); 
		if ( st != null)
			st.close(); 
		if (conn != null)
			conn.close(); 
		
	}
	
%>

</body>
</html>