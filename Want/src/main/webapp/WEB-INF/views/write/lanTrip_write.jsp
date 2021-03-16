<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- <%
	request.getParameter( "utf-8" );
	String cpage = request.getParameter( "cpage" );
%>
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/lanTrip_list.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Song+Myung&display=swap" rel="stylesheet">	
<!-- <link rel="stylesheet" type="text/css" href="resources/css/board_write.css">
<script type="text/javascript">
	window.onload = function(){
		document.getElementById( 'submit1' ).onclick = function(){
			if(document.wfrm.info.checked == false){
				alert('동의를 하셔야 합니다.');
				return false;
			}
			
			if(document.wfrm.writer.value.trim() == ''){
				alert('글쓴이를 입력 하셔야 합니다.');
				return false;
			}
			
			if(document.wfrm.subject.value.trim() == ''){
				alert('제목을 입력 하셔야 합니다.');
				return false;
			}
			
			if(document.wfrm.password.value.trim() == ''){
				alert('비밀번호를 입력 하셔야 합니다.');
				return false;
			}
			document.wfrm.submit();
		};
	};
</script>
 -->
</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />
	lanTrip_write.jsp
</body>
</html>