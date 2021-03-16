<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <%@ page import="com.exam.board02.model1.BoardTO" %>
<%@ page import="com.exam.board02.model1.BoardDAO" %>

<%@page import="java.util.ArrayList"%>

<%
	BoardTO to = (BoardTO)request.getAttribute("to");
	
	
	String seq = to.getSeq();
	String subject = to.getSubject();
	String writer = to.getWriter();
	String[] mail = null;
	if(to.getMail().equals("")){
		mail = new String[] {"",""};
	}else{
		mail = to.getMail().split("@");
	}
	String content = to.getContent();
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" type="text/css" href="resources/css/board_write.css">
<script type='text/javascript'>
	window.onload = function(){
		document.getElementById('submit1').onclick = function(){
			if(document.mfrm.subject.value.trim() == ''){
				alert('제목을 입력하셔야 합니다.');
				return false;
			}
			if(document.mfrm.password.value.trim() == ''){
				alert('비밀번호를 입력하셔야 합니다.');
				return false;
			}
			document.mfrm.submit();
		}
	}
</script> -->
</head>
<body>

</body>
</html>