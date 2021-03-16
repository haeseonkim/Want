<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.getParameter( "utf-8" );
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 여행지정보</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/select_shop_accom.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
function shop_btn() {
	document.sa_frm.sa.value = "s";
	document.sa_frm.submit();
}
function accom_btn() {
	document.sa_frm.sa.value = "a";
	document.sa_frm.submit();
}
</script>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="shopping_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />
	<form action="./select_city.do" method="post" name="sa_frm">
	<input type="hidden" name="sa" value=""/>
	<div class="select-form">
      <div class="row">
        	<div class="col-8 offset-3">
				<h2>선택해주세요!</h2>
			</div>	
			<div class="s_div con-sm-e text-center btn-group" >
				<div id="div1" style="float:left;">
					<button class="btn btn-primary btn-block" type="button" onclick="shop_btn();">쇼핑 정보
					</button>
				</div>
				<div id="div2" style="float:right;">
					<button class="btn btn-primary btn-block" type="button" onclick="accom_btn();">숙소 정보
					</button>
				</div>
			</div>
      </div>			
	</div>
	</form>
	
</body>
</html>