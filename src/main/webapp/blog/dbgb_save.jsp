<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ include  file = "dbconn_oracle.jsp"%>

<%

String name = request.getParameter("name");
String email = request.getParameter("email");
String subject = request.getParameter("subject");
String cont = request.getParameter("content");

java.util.Date yymmdd = new java.util.Date() ;
SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
String ymd =myformat.format(yymmdd);

/* /*
int pos=0;

if (cont.length()==1) 
 cont = cont+" "  ;

// 본문에 입력한 ' 가 쿼리에 영향을 줌 // insert, update 할때
while ((pos=cont.indexOf("\'", pos)) != -1) {
 String left=cont.substring(0, pos);
 	out.println("pos : " + pos + "<p>");
 	out.println("left : " + left + "<p>");
 
 String right=cont.substring(pos, cont.length());
 	out.println("pos : " + pos + "<p>");
 	out.println("right : " + right + "<p>");
 	
 cont = left + "\'" + right;
 pos += 2;
}
*/


 
 String sql=null;
 //Connection con=null;
 PreparedStatement pst = null; 
 ResultSet rs=null;  
 int cnt=0; 


 try {
  sql= "insert into guestboard(name, email, inputdate, subject, content)" ; 
  sql += " values(?, ?, ?, ?, ?)";
  pst = conn.prepareStatement(sql);
  pst.setString(1, name);
  pst.setString(2, email);
  pst.setString(3, ymd);
  pst.setString(4, subject);
  pst.setString(5, cont);
  rs = pst.executeQuery();

  cnt = pst.executeUpdate(sql); 
  
if (cnt >0) 
 out.println("데이터가 성공적으로 입력되었습니다.");
 else  
  out.println("데이터가 입력되지 않았습니다. ");
  
 
 } catch (SQLException e) {
  out.println(e);
 }finally {
	 if (rs != null)
		 rs.close(); 
	 if (pst != null)
		 pst.close(); 
	 if (conn != null)
		 conn.close();
 }
 
%>

<!-- <jsp:forward page ="dbgb_show.jsp" /> -->
   


