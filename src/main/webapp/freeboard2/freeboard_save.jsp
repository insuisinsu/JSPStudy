<%@ page contentType="text/html; charset=EUC-KR" %>  
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %> 
<% request.setCharacterEncoding("EUC-KR"); %>

<%@ include file = "dbconn_oracle.jsp" %>

<%
 String na = request.getParameter("name");
 String em = request.getParameter("email");
 String sub = request.getParameter("subject"); 
 String cont = request.getParameter("content");
 String pw = request.getParameter("password");
 int id =1;
 int pos=0;
 
 if (cont.length()==1) 
  cont = cont+" "  ;

 while ((pos=cont.indexOf("\'", pos)) != -1) {
  String left=cont.substring(0, pos);
  String right=cont.substring(pos, cont.length());
  cont = left + "\'" + right;
  pos += 2;
 }

// out.println (pos);
// out.println (cont.length());
// if (true) return;
 
 java.util.Date yymmdd = new java.util.Date() ;
 SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
 String ymd=myformat.format(yymmdd);

 String sql=null;
 //Connection con=null;
 Statement st=null; 
 ResultSet rs=null;  
 int cnt=0; 



 try {

  st = conn.createStatement();
  sql = "select max(id) from  freeboard";	 //최신글의 번호를 가져온다. 
  rs = st.executeQuery(sql);
  if (!(rs.next())) 		//글이 존재하지 않는 경우  
   id=1;
  else {
   id= rs.getInt(1) + 1 ;  //글이존재하는 경우 최대값에 + 1	
  
  }       
  sql= "insert into freeboard(id,name,password,email,subject," ;
  sql= sql + "content,inputdate,masterid,readcount,replaynum,step)" ; 
  sql= sql + " values(" +id + ", '" +  na + "','" + pw + "','"+ em  ;
  sql= sql + "','" + sub + "','" + cont + "','" + ymd + "'," +id+"," ;
  sql= sql + "0,0,0)";

  cnt = st.executeUpdate(sql); 
  
if (cnt >0) 
 out.println("데이터가 성공적으로 입력되었습니다.");
 else  
  out.println("데이터가 입력되지 않았습니다. ");
  
 
 } catch (SQLException e) {
  out.println(e);
 }finally {
	 if (rs != null)
		 rs.close(); 
	 if (st != null)
		 st.close(); 
	 if (conn != null)
		 conn.close();
 }
 
%>

<jsp:forward page ="freeboard_list.jsp" />   
