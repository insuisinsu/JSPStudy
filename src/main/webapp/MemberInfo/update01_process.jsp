<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update 를 통한 데이터 수정</title>
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
	
	//폼에서 넘겨받은 id/passwd를 DB 에서 가져온 id/passwd 가 같으면 update!
	
	try{
		//Form 에서 받은 id 를 조건으로 DB 의 값을 Select 하는 구문
		sql = "select id, pass from mbTbl where id = '"+id+"'";
		
		//conn 의 createStatement() 를 사용하여 stmt 객체를 활성화
		stmt = conn.createStatement();	
		rs = stmt.executeQuery(sql);
		
		if(rs.next()) {		//DB에 Form 에서 넘긴 id 가 존재하면 true, -> pw 일치 여부 확인해야 함
//			out.println(id + " :   ID 가 DB에 존재합니다.");
		
			//DB 에서 값을 가지고 온 ID 와 Pass 를 변수에 할당 // 여기서의 id 와 pass 는 테이블의 컬럼명
			String rId = rs.getString("id");
			String rPasswd = rs.getString("pass");
		
			//rId 와 rPasswd 가 DB 에 존재하는지 확인
			if(id.equals(rId) && passwd.equals(rPasswd)){
				//DB에서 가져온 rPasswd 와 form 에서 넘긴 passwd 가 같다면 Update
				sql = "update mbTbl set name = '"+name+"', email = '"+email+"' where id = '"+id+"'";
				stmt = conn.createStatement();
				stmt.executeUpdate(sql);
				out.println("테이블의 내용이 잘 수정되었습니다.");
			}else{
				out.println("패스워드가 일치하지 않습니다.");
			}
			
		}else{		//DB에 Form 에서 넘긴 id 가 존재하지 않으면 false
			out.println(id+" :   ID 가 DB 에 존재하지 않습니다.");
		}	
//		out.println(sql);
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