<!-- 프로필수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   int flag = (Integer)request.getAttribute("flag");

   out.println("<script type='text/javascript'>");
   if(flag == 0){
      out.println("alert('수정 성공!');");
      out.println("location.href='./profile.do';");
   }else{
      out.println("alert('수정 실패!');");
      out.println("history.back();");
   }
   out.println("</script>");
%>