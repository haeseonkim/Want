<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int flag = (Integer)request.getAttribute("flag");
	String location = (String)request.getAttribute( "location" );
	String cpage = (String)request.getAttribute( "cpage" );
	
	out.println("<script type='text/javascript'>");
	if(flag == 0){
	   out.println("alert('숙소 글수정에 성공했습니다.');");
	   out.println("location.href='./accom_list.do?cpage="+cpage+"&location="+ location +"';");
	}else{
	   out.println("alert('숙소 글수정에 실패했습니다.');");
	   out.println("history.back();");
	}
	out.println("</script>");
%>