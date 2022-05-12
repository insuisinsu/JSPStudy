<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
<% request.setCharacterEncoding("UTF-8"); %>	<!--  한글 처리 -->
<%@ include file = "dbconn_oracle.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form 의 값을 받아서 DB 에 값을 넣어줌</title>
</head>
<body>
<%
	//폼에서 넘긴 변수를 받아서 저장
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
	
	int id = 1;		// DB의 id 컬럼에 저장할 값
	int pos = 0;
	if(cont.length() == 1){
		cont = cont + " "; 
	}
	
	//content(Text Area)의 엔터를 처리해 줘야 함 - Oracle DB에 저장할때
	while((pos = cont.indexOf("\'", pos)) != -1){
		String left = cont.substring(0,pos);
		String right = cont.substring(pos, cont.length());
		cont = left + "\'" + right;
		pos += 2;
	}
	
	//오늘의 날짜 처리
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-mm-d h:mm a");
	String ymd = myformat.format(yymmdd);
	
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	int cnt = 0;			//insert 가 잘 되었는지 확인하는 변수
	
	try{
		//값을 저장하기 전에 최신 글번호(max(id))를 가져와서 +1 을 적용한다.
		//conn(Connection) : Auto Commit; 이 작동됨
			// commit 을 명시하지 않아도 Insert, Update, Delete 후에 자동으로 커밋됨
		st = conn.createStatement();
		sql = "select max(id) from freeboard";
		rs = st.executeQuery(sql);
		
		if(!(rs.next())){	//!(rs.next()) .. rs.next() 가 false 라면 (비었다면)
			id = 1;
		}else{				//rs.next() 가 true 라면 (값이 있다면)
			id = rs.getInt(1) + 1;		//rs.getInt(1) -> max(id)
		}
		
		
		sql = "insert into freeboard (id, name, password, email, subject, ";
		sql += "content, inputdate, masterid, readcount, replaynum, step) ";
		sql += "values(" + id + ", '" + na +  "', '" + pw + "' , '" + em + "', ";
		sql += "'" + sub + "', '" + cont + "', '" + ymd + "', " + id + ", ";
		sql += "0, 0, 0)";
		
//		out.println(sql);

		cnt = st.executeUpdate(sql);		// cnt > 0 이면 insert 성공

		if(cnt > 0){
			out.println("데이터가 성공적으로 입력되었습니다.");
		}else{
			out.println("데이터가 입력되지 않았습니다.");
		}
		
	}catch(Exception ex){
		out.println(ex.getMessage());
	}finally{
		if(rs != null)
			rs.close();
		if(st != null)
			st.close();
		if(conn != null)
			conn.close();
	}
		
%>
	<jsp:forward page = "freeboard_list.jsp" />


</body>
</html>