<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 동행구해요</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/with_list.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">

		<jsp:param value="with_list" name="thisPage" />

	</jsp:include>
	
	<br /><br /><br />
	with_list.jsp
</body>
</html>