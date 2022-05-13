<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<HTML>
<HEAD><TITLE>게시판</TITLE>
<link href="freeboard.css" rel="stylesheet" type="text/css">
<SCRIPT language="javascript">
 function check(){
  with(document.msgsearch){
   if(sval.value.length == 0){
    alert("검색어를 입력해 주세요!!");
    sval.focus();
    return false;
   }	
   document.msgsearch.submit();
  }
 }
 function rimgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/arrow.gif";
  }

 function imgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/close.gif";
 }
</SCRIPT>
</HEAD>
<BODY>
<%@ include file = "dbconn_oracle.jsp" %>
<P>
<P align=center><FONT color=#0000ff face=굴림 size=3><STRONG>자유 게시판</STRONG></FONT></P> 
<P>
<CENTER>
 <TABLE border=0 width=600 cellpadding=4 cellspacing=0>
  <tr align="center"> 
   <td colspan="5" height="1" bgcolor="#1F4F8F"></td>
  </tr>
  <tr align="center" bgcolor="#87E8FF"> 
   <td width="42" bgcolor="#DFEDFF"><font size="2">번호</font></td>
   <td width="340" bgcolor="#DFEDFF"><font size="2">제목</font></td>
   <td width="84" bgcolor="#DFEDFF"><font size="2">등록자</font></td>
   <td width="78" bgcolor="#DFEDFF"><font size="2">날짜</font></td>
   <td width="49" bgcolor="#DFEDFF"><font size="2">조회</font></td>
  </tr>
  <tr align="center"> 
   <td colspan="5" bgcolor="#1F4F8F" height="1"></td>
  </tr>
 <%   // Vector : 멀티스레드 환경에서 사용, 모든 메소드가 동기화 처리되어 있음. 
 
  Vector name=new Vector();			// DB의 Name 값만 저장하는 벡터
  Vector inputdate=new Vector();
  Vector email=new Vector();
  Vector subject=new Vector();
  Vector rcount=new Vector();
  
  Vector step=new Vector();
  Vector keyid=new Vector();
  
  // 페이징 처리 시작 부분 
  
  int where=1;

  int totalgroup=0;					// 출력할 페이징의 그룹핑의 최대 갯수
  int maxpages=5;					// 최대 페이지 갯수 ()
  int startpage=1;					// 페이지 그룹의 시작 페이지
  int endpage=startpage+maxpages-1;	// 페이지 그룹의 마지막 페이지
  int wheregroup=1;					// 현재 위치하는 그룹

	//go : 해당 페이지 번호로 이동
	//gogroup : 출력할 페이지의 그룹핑
	//freeboard_list.jsp?go=3
	//freeboard_list.jsp?gogroup=2 (maxpage가 5일때 6, 7, 8, 9, 10)
	
	//go 변수 (페이지 번호) 를 넘겨받아서 wheregroup, startpage, endpage 의 값 구하기
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
  int maxrows=5;			//출력할 레코드 수 
  int totalrows=0;
  int totalpages=0;
  
  /*
  out.println("================maxpage : 3 일때 ==========="+"<p>");
  out.println("현재 페이지 : " + where+"<p>");
  out.println("현재 페이지 그룹 : " + wheregroup+"<p>");
  out.println("시작 페이지 : " + startpage+"<p>");
  out.println("끝 페이지 : " + endpage+"<p>");
  */
  
  // 페이징 처리 마지막 부분 
  
  

  int id=0;

  String em=null;
  //Connection con= null;
  Statement st =null;
  ResultSet rs =null;


 try {
  st = conn.createStatement();
  String sql = "select * from freeboard order by" ;
  sql = sql + " masterid desc, replaynum, step, id" ;
  rs = st.executeQuery(sql);
  
  // out.println (sql); 
  // if (true) return;    //프로그램 종료

  if (!(rs.next()))  {
   out.println("게시판에 올린 글이 없습니다");
  } else {
   do {
	// rs 의 id 컬럼의 값을 가져와서 Vector 에 저장
	// ??... keyid, name, email 등의 변수는 어디에서 선언된 거임?
    keyid.addElement(new Integer(rs.getInt("id")));
	
    name.addElement(rs.getString("name"));
    email.addElement(rs.getString("email"));
    
    // inputdate 값을 가져온뒤 원하는 형식으로 수정하여 저장
    // 22-05-12 12:12 오전 -> 22-05-22
    String idate = rs.getString("inputdate");
    idate = idate.substring(0,8);
    inputdate.addElement(idate);
    
    subject.addElement(rs.getString("subject"));
    rcount.addElement(new Integer(rs.getInt("readcount")));
    step.addElement(new Integer(rs.getInt("step")));
    
   }while(rs.next());
   totalrows = name.size();	// name Vector에 저장된 인덱스 갯수 = 총 레코드 수
   totalpages = (totalrows-1)/maxrows +1;
   startrow = (where-1) * maxrows;
   endrow = startrow + maxrows-1  ;
   
   /*
   out.println("========== maxrow : 3 일때 ============="+ "<p>");
   out.println("총 레코드 수 : " + totalrows + "<p>");
   out.println("현재 페이지 : " + where + "<p>");
   out.println("시작 레코드 : " + startrow + "<p>");
   out.println("마지막 레코드 : " + endrow + "<p>");
   */
   
   if (endrow >= totalrows)
    endrow=totalrows-1;
   
   totalgroup = (totalpages-1)/maxpages +1;	// 페이지의 그룹핑
   
   out.println("토탈 페이지 그룹 : "+totalgroup +"<p>");
   
   if (endpage > totalpages) 
    endpage=totalpages;

   
   // for 시작
   // 현재 페이지에서 시작 레코드, 마지막 레코드 까지 순환하면서 출력
   for(int j=startrow;j<=endrow;j++) {
    // .elementAt(1); : 1번 item 을 가져온다.
	String temp=(String)email.elementAt(j);
    if ((temp == null) || (temp.equals("")) ) // 메일 주소가 비었을 때
     em= (String)name.elementAt(j); 
    else
     em = "<A href=mailto:" + temp + ">" + name.elementAt(j) + "</A>";

    id= totalrows-j;
    if(j%2 == 0){
     out.println("<TR bgcolor='#FFFFFF' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor=''\">");	
    } else {
     out.println("<TR bgcolor='#F4F4F4' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor='#F4F4F4'\">");
    } 
    out.println("<TD align=center>");
    out.println(id+"</TD>");
    out.println("<TD>");
    int stepi= ((Integer)step.elementAt(j)).intValue();
    int imgcount = j-startrow; 
    if (stepi > 0 ) {
     for(int count=0; count < stepi; count++)
      out.print("&nbsp;&nbsp;");
     out.println("<IMG name=icon"+imgcount+ " src=image/arrow.gif>");
     out.print("<A href=freeboard_read.jsp?id=");
     out.print(keyid.elementAt(j) + "&page=" + where );
     out.print(" onmouseover=\"rimgchg(" + imgcount + ",1)\"");
     out.print(" onmouseout=\"rimgchg(" + imgcount + ",2)\">");
    } else {
     out.println("<IMG name=icon"+imgcount+ " src=image/close.gif>");
     out.print("<A href=freeboard_read.jsp?id=");
     out.print(keyid.elementAt(j) + "&page=" + where );
     out.print(" onmouseover=\"imgchg(" + imgcount + ",1)\"");
     out.print(" onmouseout=\"imgchg(" + imgcount + ",2)\">");
    }
    out.println(subject.elementAt(j) + "</TD>");
    out.println("<TD align=center>");
    out.println(em+ "</TD>");
    out.println("<TD align=center>");
    out.println(inputdate.elementAt(j)+ "</TD>");
    out.println("<TD align=center>");
    out.println(rcount.elementAt(j)+ "</TD>");
    out.println("</TR>"); 
   /* 
    out.println("J :"+ j +"<p>");
    out.println("ID"+ keyid.elementAt(j)+"<p>");
    out.println("subject : "+ subject +"<p>");
    out.println("em : "+ em +"<p>");
    if(true) return;
    */
   }
   // for 끝
   
   rs.close();
  }
  out.println("</TABLE>");
  st.close();
  conn.close();
 } catch (java.sql.SQLException e) {
  out.println(e);
 } 

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
<!--<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right valign=bottom>
   <A href="freeboard_write.htm"><img src="image/write.gif" width="66" height="21" border="0"></A>
   </TD>
  </TR>
 </TABLE>-->


<!--  검색창  -->
<FORM method="post" name="msgsearch" action="freeboard_search.jsp">
<!--  option 으로 고른 value 값과 input 에 넣은 sval 값이 넘어감 -->
<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right width="241"> 
   <SELECT name=stype >
    <OPTION value=1 >이름
    <OPTION value=2 >제목
    <OPTION value=3 >내용
    <OPTION value=4 >이름+제목
    <OPTION value=5 >이름+내용
    <OPTION value=6 >제목+내용
    <OPTION value=7 >이름+제목+내용
   </SELECT>
  </TD>
  <TD width="127" align="center">
   <INPUT type=text size="17" name="sval" >
  </TD>
  <TD width="115">&nbsp;<a href="#" onClick="check();"><img src="image/serach.gif" border="0" align='absmiddle'></A></TD>
  <TD align=right valign=bottom width="117"><A href="freeboard_write.htm"><img src="image/write.gif" border="0"></TD>
 </TR>
</TABLE>
</FORM>
</BODY>
</HTML>