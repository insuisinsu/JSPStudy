<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*,java.util.*" %> 
<html>
<head>
<title>Guest Board</title>
<link href = "freeboard.css" rel="stylesheet" type="texy/css">
<Script language = "javascript"></Script>
</head>
<body>
<%@ include file = "dbconn_oracle.jsp" %>
<%
// read 형식으로 값들을 불러와야 함


// DB 에서 각 컬럼의 값들을 Vector 로 불러오기 전에 객체 생성
  Vector name=new Vector();			// DB의 Name 값만 저장하는 벡터
  Vector email=new Vector();
  Vector inputdate=new Vector();
  Vector subject=new Vector();
  Vector cont=new Vector();

// 페이징 처리
  int where=1;

  int totalgroup=0;					// 출력할 페이징의 그룹핑의 최대 갯수
  int maxpages=5;					// 최대 페이지 갯수 ()
  int startpage=1;					// 페이지 그룹의 시작 페이지
  int endpage=startpage+maxpages-1;	// 페이지 그룹의 마지막 페이지
  int wheregroup=1;					// 현재 위치하는 그룹
  
  if (request.getParameter("go") != null) {
	   where = Integer.parseInt(request.getParameter("go"));
	   wheregroup = (where-1)/maxpages + 1;
	   startpage=(wheregroup-1) * maxpages+1;  
	   endpage=startpage+maxpages-1; 
	   //gogroup 변수를 넘겨받아서 startpage, endpage, where 의 값 구함
	  } else if (request.getParameter("gogroup") != null) {
	   wheregroup = Integer.parseInt(request.getParameter("gogroup"));
	   startpage=(wheregroup-1) * maxpages+1;  
	   where = startpage ; 
	   endpage=startpage+maxpages-1; 
	  }
  
  int nextgroup=wheregroup+1;
  int priorgroup= wheregroup-1;

  int nextpage=where+1;
  int priorpage = where-1;
  int startrow=0;
  int endrow=0;
  int maxrows=2;			//출력할 레코드 수 
  int totalrows=0;
  int totalpages=0;

// DB 에서 각 컬럼의 값들을 Vector 에 불러와서 저장


  String em=null;
  //Connection con= null;
  Statement st =null;
  ResultSet rs =null;

 try {
  st = conn.createStatement();
  String sql = "select * from guestboard order by inputdate desc" ;
  rs = st.executeQuery(sql);

  if (!(rs.next()))  {
   out.println("데이터가 없습니다.");
  } else {
   do {
    name.addElement(rs.getString("name"));
    email.addElement(rs.getString("email"));
    String idate = rs.getString("inputdate");
    idate = idate.substring(0,8);
    inputdate.addElement(idate);
    subject.addElement(rs.getString("subject"));
    cont.addElement(rs.getString("content"));
   }while(rs.next());
   
   totalrows = name.size();					// name vector 에 저장된 값의 개수 , 총 레코드 수 
   
   totalpages = (totalrows-1)/maxrows +1;
   startrow = (where-1) * maxrows;			// 현재 페이지에서 시작 레코드 번호	
   endrow = startrow+maxrows-1  ;			// 현재 페이지에서 마지막 레코드 번호

   if (endrow >= totalrows)		
    endrow=totalrows-1;
  
   totalgroup = (totalpages-1)/maxpages +1;		// 페이지의 그룹핑 
   
   if (endpage > totalpages) 
    endpage=totalpages;
   
	// 현재 페이지에서 시작 레코드, 마지막 레코드 까지 순환하면서 출력
   for(int j=startrow;j<=endrow;j++) {

	   out.println("<table width='600' cellspacing='0' cellpadding='2' align='center'>");
	   out.println("<tr>");
	   out.println("<td height='22'>&nbsp;</td></tr>");
	   out.println("<tr align='center'>");
	   out.println("<td height='1' bgcolor='#1F4F8F'></td>");
	   out.println("</tr>");
	   out.println("<tr align='center' bgcolor='#DFEDFF'>");
	   out.println("<td class='button' bgcolor='#DFEDFF'>"); 
	   out.println("<div align='left'><font size='2'>"+subject.elementAt(j) + "</div> </td>");
	   out.println("</tr>");
	   out.println("<tr align='center' bgcolor='#FFFFFF'>");
	   out.println("<td align='center' bgcolor='#F4F4F4'>"); 
	   out.println("<table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>");
	   out.println("<tr bgcolor='#F4F4F4'>");
	   out.println("<td width='13%' height='7'></td>");
	   out.println("<td width='51%' height='7'>글쓴이 : "+ name.elementAt(j) +"</td>");
	   out.println("<td width='51%' height='7'>e-mail : "+ email.elementAt(j) +"</td>");
	   out.println("<td width='25%' height='7'></td>");
	   out.println("<td width='11%' height='7'></td>");
	   out.println("</tr>");
	   out.println("<tr bgcolor='#F4F4F4'>");
	   out.println("<td width='13%'></td>");
	   out.println("<td width='51%'>작성일 : " + inputdate.elementAt(j) + "</td>");
	   out.println("<td width='11%'></td>");
	   out.println("</tr>");
	   out.println("</table>");
	   out.println("</td>");
	   out.println("</tr>");
	   out.println("<tr align='center'>");
	   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
	   out.println("</tr>");
	   out.println("<tr align='center'>");
	   out.println("<td style='padding:10 0 0 0'>");
	   out.println("<div align='left'><br>");
	   out.println("<font size='3' color='#333333'><PRE>"+cont.elementAt(j) + "</PRE></div>");
	   out.println("<br>");
	   out.println("</td>");
	   out.println("</tr>");
	   out.println("<tr align='center'>");
	   out.println("<td class='button' height='1'></td>");
	   out.println("</tr>");
	   out.println("<tr align='center'>");
	   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
	   out.println("</tr>");
	   out.println("</table>");
    
   }

   rs.close();
  }
  out.println("</TABLE>");
  st.close();
  conn.close();
 } catch (java.sql.SQLException e) {
  out.println(e);
 } 


// 페이지 그룹핑
 if (wheregroup > 1) {	// 현재 나의 그룹이 1 초과일 때
  out.println("[<A href=freeboard_list.jsp?gogroup=1>처음</A>]"); 
  out.println("[<A href=freeboard_list.jsp?gogroup="+priorgroup +">이전</A>]");
 } else {	// 현재 나의 그룹이 1 이하일 때
  out.println("[처음]") ;
  out.println("[이전]") ;
 }
 if (name.size() !=0) { 
  for(int jj=startpage; jj<=endpage; jj++) {
   if (jj==where) 
    out.println("["+jj+"]") ;
   else
    out.println("[<A href=freeboard_list.jsp?go="+jj+">" + jj + "</A>]") ;
   } 
  }
  if (wheregroup < totalgroup) {
   out.println("[<A href=freeboard_list.jsp?gogroup="+ nextgroup+ ">다음</A>]");
   out.println("[<A href=freeboard_list.jsp?gogroup="+ totalgroup + ">마지막</A>]");
  } else {
   out.println("[다음]");
   out.println("[마지막]");
  }
  out.println ("전체 글수 :"+totalrows); 

  %>




<TABLE border=0 width=600 cellpadding=0 cellspacing=0 align='center'>>
 <TR>
  <TD align=right valign=bottom width="117"><A href="dbgb_write.htm"><img src="image/write.gif" border="0"></TD>
 </TR>
</TABLE>

</body>
</html>