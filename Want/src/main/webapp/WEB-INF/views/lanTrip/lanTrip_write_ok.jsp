<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
<%@ page import="com.exam.board02.model1.BoardTO" %>
<%@ page import="com.exam.board02.model1.BoardDAO" %>

<%@page import="java.util.ArrayList"%>

<%
	String cpage = (String)request.getAttribute("cpage");
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if(flag == 0){
		out.println("alert('글쓰기에 성공했습니다.');");
		out.println("location.href='list.do';");
	}else{
		out.println("alert('글쓰기에 실패했습니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
%> --%>