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
// read �������� ������ �ҷ��;� ��


// DB ���� �� �÷��� ������ Vector �� �ҷ����� ���� ��ü ����
  Vector name=new Vector();			// DB�� Name ���� �����ϴ� ����
  Vector email=new Vector();
  Vector inputdate=new Vector();
  Vector subject=new Vector();
  Vector cont=new Vector();

// ����¡ ó��
  int where=1;

  int totalgroup=0;					// ����� ����¡�� �׷����� �ִ� ����
  int maxpages=5;					// �ִ� ������ ���� ()
  int startpage=1;					// ������ �׷��� ���� ������
  int endpage=startpage+maxpages-1;	// ������ �׷��� ������ ������
  int wheregroup=1;					// ���� ��ġ�ϴ� �׷�
  
  if (request.getParameter("go") != null) {
	   where = Integer.parseInt(request.getParameter("go"));
	   wheregroup = (where-1)/maxpages + 1;
	   startpage=(wheregroup-1) * maxpages+1;  
	   endpage=startpage+maxpages-1; 
	   //gogroup ������ �Ѱܹ޾Ƽ� startpage, endpage, where �� �� ����
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
  int maxrows=2;			//����� ���ڵ� �� 
  int totalrows=0;
  int totalpages=0;

// DB ���� �� �÷��� ������ Vector �� �ҷ��ͼ� ����


  String em=null;
  //Connection con= null;
  Statement st =null;
  ResultSet rs =null;

 try {
  st = conn.createStatement();
  String sql = "select * from guestboard order by inputdate desc" ;
  rs = st.executeQuery(sql);

  if (!(rs.next()))  {
   out.println("�����Ͱ� �����ϴ�.");
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
   
   totalrows = name.size();					// name vector �� ����� ���� ���� , �� ���ڵ� �� 
   
   totalpages = (totalrows-1)/maxrows +1;
   startrow = (where-1) * maxrows;			// ���� ���������� ���� ���ڵ� ��ȣ	
   endrow = startrow+maxrows-1  ;			// ���� ���������� ������ ���ڵ� ��ȣ

   if (endrow >= totalrows)		
    endrow=totalrows-1;
  
   totalgroup = (totalpages-1)/maxpages +1;		// �������� �׷��� 
   
   if (endpage > totalpages) 
    endpage=totalpages;
   
	// ���� ���������� ���� ���ڵ�, ������ ���ڵ� ���� ��ȯ�ϸ鼭 ���
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
	   out.println("<td width='51%' height='7'>�۾��� : "+ name.elementAt(j) +"</td>");
	   out.println("<td width='51%' height='7'>e-mail : "+ email.elementAt(j) +"</td>");
	   out.println("<td width='25%' height='7'></td>");
	   out.println("<td width='11%' height='7'></td>");
	   out.println("</tr>");
	   out.println("<tr bgcolor='#F4F4F4'>");
	   out.println("<td width='13%'></td>");
	   out.println("<td width='51%'>�ۼ��� : " + inputdate.elementAt(j) + "</td>");
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


// ������ �׷���
 if (wheregroup > 1) {	// ���� ���� �׷��� 1 �ʰ��� ��
  out.println("[<A href=freeboard_list.jsp?gogroup=1>ó��</A>]"); 
  out.println("[<A href=freeboard_list.jsp?gogroup="+priorgroup +">����</A>]");
 } else {	// ���� ���� �׷��� 1 ������ ��
  out.println("[ó��]") ;
  out.println("[����]") ;
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
   out.println("[<A href=freeboard_list.jsp?gogroup="+ nextgroup+ ">����</A>]");
   out.println("[<A href=freeboard_list.jsp?gogroup="+ totalgroup + ">������</A>]");
  } else {
   out.println("[����]");
   out.println("[������]");
  }
  out.println ("��ü �ۼ� :"+totalrows); 

  %>




<TABLE border=0 width=600 cellpadding=0 cellspacing=0 align='center'>>
 <TR>
  <TD align=right valign=bottom width="117"><A href="dbgb_write.htm"><img src="image/write.gif" border="0"></TD>
 </TR>
</TABLE>

</body>
</html>