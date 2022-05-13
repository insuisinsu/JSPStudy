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
  int maxrows=5;			//출력할 레코드 수 
  int totalrows=0;
  int totalpages=0;

// DB 에서 각 컬럼의 값들을 Vector 에 불러와서 저장
  String em=null;
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
		
	    name.addElement(rs.getString("name"));
	    email.addElement(rs.getString("email"));
	    
	    // inputdate 값을 가져온뒤 원하는 형식으로 수정하여 저장
	    // 22-05-12 12:12 오전 -> 22-05-22
	    String idate = rs.getString("inputdate");
	    idate = idate.substring(0,8);
	    inputdate.addElement(idate);
	    
	    subject.addElement(rs.getString("subject"));
	    cont.addElement("content");
	    
	   }while(rs.next());
	   totalrows = name.size();	// name Vector에 저장된 인덱스 갯수 = 총 레코드 수
	   totalpages = (totalrows-1)/maxrows +1;
	   startrow = (where-1) * maxrows;
	   endrow = startrow + maxrows-1  ;
	   
	   if (endrow >= totalrows)
	    endrow=totalrows-1;
	   
	   totalgroup = (totalpages-1)/maxpages +1;	// 페이지의 그룹핑
	   
	   out.println("토탈 페이지 그룹 : "+totalgroup +"<p>");
	   
	   if (endpage > totalpages) 
	    endpage=totalpages;

	// read 형식으로 값들을 불러와야 함 for 사용?	   
	   // for 시작
	   // 현재 페이지에서 시작 레코드, 마지막 레코드 까지 순환하면서 출력
	   for(int j=startrow;j<=endrow;j++) {
	    // .elementAt(1); : 1번 item 을 가져온다.
		String temp=(String)email.elementAt(j);
	    if ((temp == null) || (temp.equals("")) ) // 메일 주소가 비었을 때
	     em= (String)name.elementAt(j); 
	    else
	     em = "<A href=mailto:" + temp + ">" + name.elementAt(j) + "</A>";
/*
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

<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right valign=bottom width="117"><A href="dbgb_write.htm"><img src="image/write.gif" border="0"></TD>
 </TR>
</TABLE>

</body>
</html>