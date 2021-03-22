<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.exam.model1.lantrip.LanTripTO" %>
<%@ page import="com.exam.model1.lantrip.LanTripDAO" %>

<%
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if(flag == 0){
		out.println("alert('글수정에 성공했습니다.');");
		out.println("location.href='lanTrip_view.do?no="+request.getParameter("no")+"';");
	}else{
		out.println("alert('글수정에 실패했습니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
	
%>
