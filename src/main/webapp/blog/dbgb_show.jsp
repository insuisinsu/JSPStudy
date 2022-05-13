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
  int maxrows=5;			//����� ���ڵ� �� 
  int totalrows=0;
  int totalpages=0;

// DB ���� �� �÷��� ������ Vector �� �ҷ��ͼ� ����
  String em=null;
  Statement st =null;
  ResultSet rs =null;

  try {
	  st = conn.createStatement();
	  String sql = "select * from freeboard order by" ;
	  sql = sql + " masterid desc, replaynum, step, id" ;
	  rs = st.executeQuery(sql);
	  
	  // out.println (sql); 
	  // if (true) return;    //���α׷� ����

	  if (!(rs.next()))  {
	   out.println("�Խ��ǿ� �ø� ���� �����ϴ�");
	  } else {
	   do {
		// rs �� id �÷��� ���� �����ͼ� Vector �� ����
		
	    name.addElement(rs.getString("name"));
	    email.addElement(rs.getString("email"));
	    
	    // inputdate ���� �����µ� ���ϴ� �������� �����Ͽ� ����
	    // 22-05-12 12:12 ���� -> 22-05-22
	    String idate = rs.getString("inputdate");
	    idate = idate.substring(0,8);
	    inputdate.addElement(idate);
	    
	    subject.addElement(rs.getString("subject"));
	    cont.addElement("content");
	    
	   }while(rs.next());
	   totalrows = name.size();	// name Vector�� ����� �ε��� ���� = �� ���ڵ� ��
	   totalpages = (totalrows-1)/maxrows +1;
	   startrow = (where-1) * maxrows;
	   endrow = startrow + maxrows-1  ;
	   
	   if (endrow >= totalrows)
	    endrow=totalrows-1;
	   
	   totalgroup = (totalpages-1)/maxpages +1;	// �������� �׷���
	   
	   out.println("��Ż ������ �׷� : "+totalgroup +"<p>");
	   
	   if (endpage > totalpages) 
	    endpage=totalpages;

	// read �������� ������ �ҷ��;� �� for ���?	   
	   // for ����
	   // ���� ���������� ���� ���ڵ�, ������ ���ڵ� ���� ��ȯ�ϸ鼭 ���
	   for(int j=startrow;j<=endrow;j++) {
	    // .elementAt(1); : 1�� item �� �����´�.
		String temp=(String)email.elementAt(j);
	    if ((temp == null) || (temp.equals("")) ) // ���� �ּҰ� ����� ��
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
	   // for ��
	   
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

<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right valign=bottom width="117"><A href="dbgb_write.htm"><img src="image/write.gif" border="0"></TD>
 </TR>
</TABLE>

</body>
</html>