<!-- 현수 생성 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int flag = (Integer)request.getAttribute("flag");
	String cityName = (String)request.getAttribute( "cityName" );
	
	out.println("<script type='text/javascript'>");
	if(flag == 0){
	   out.println("alert('쇼핑 글쓰기에 성공했습니다.');");
	   out.println("location.href='./shopping_list.do?cityName="+ cityName +"';");
	}else{
	   out.println("alert('쇼핑 글쓰기에 실패했습니다.');");
	   out.println("history.back();");
	}
	out.println("</script>");
%>