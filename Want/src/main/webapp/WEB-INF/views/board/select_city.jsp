<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
	request.getParameter( "utf-8" );
	String sa = request.getParameter( "sa" );
	String pageName = "";
	if( sa.equals( "s" ) ) {
		pageName = "./shopping_list.do";
	} else {
		pageName = "./accom_list.do";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 도시선택</title>


<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/select_city.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
window.onload = function() {
	$('#paris').on('click', (event) => {
		document.cfrm.cityName.value = "paris";
		document.cfrm.submit();
	});
	$('#athens').on('click', (event) => {
		document.cfrm.cityName.value = "athens";
		document.cfrm.submit();
	});
	$('#rome').on('click', (event) => {
		document.cfrm.cityName.value = "rome";
		document.cfrm.submit();
	});
	$('#budapest').on('click', (event) => {
		document.cfrm.cityName.value = "budapest";
		document.cfrm.submit();
	});
	$('#prague').on('click', (event) => {
		document.cfrm.cityName.value = "prague";
		document.cfrm.submit();
	});
	$('#london').on('click', (event) => {
		document.cfrm.cityName.value = "london";
		document.cfrm.submit();
	});
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
	<div class="select-form">
		<div class="col-8 offset-3">
			<h3>도시를 선택해주세요!</h3>
		</div>	
	</div>
<form action="<%= pageName %>" method="post" name="cfrm">
<input type="hidden" name="sa" value="<%= sa %>"/>
<input type="hidden" name="cityName" value="" />
<section class="container">
    
    <div class="row active-with-click">
        <div class="col-md-4 col-sm-6 col-xs-12">
            <article id="paris" class="material-card Red">
                <h2>
                    <span>프랑스</span>
                    <strong>
                        <i class="fa fa-fw fa-star"></i>
                        파리
                    </strong>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/파리.jpg">
                    </div>
                </div>
            </article>
        </div>
        <div class="col-md-4 col-sm-6 col-xs-12">
            <article id="athens" class="material-card Pink">
                <h2>
                    <span>그리스</span>
                    <strong>
                        <i class="fa fa-fw fa-star"></i>
                        아테네
                    </strong>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/아테네.jpg">
                    </div>
                </div>
            </article>
        </div>
        <div class="col-md-4 col-sm-6 col-xs-12">
            <article id="rome" class="material-card Purple">
                <h2>
                    <span>이탈리아</span>
                    <strong>
                        <i class="fa fa-fw fa-star"></i>
                       	로마
                    </strong>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/로마.jpg">
                    </div>
                </div>
            </article>
        </div>
        <div class="col-md-4 col-sm-6 col-xs-12">
            <article id="budapest" class="material-card Deep-Purple">
                <h2>
                    <span>스페인</span>
                    <strong>
                        <i class="fa fa-fw fa-star"></i>
                        부다페스트
                    </strong>
                </h2>
                <div class="mc-content">
                    <div class="img-container">                    	
                        <img class="img-responsive" src="./resources/img/부다페스트.jpg">
                    </div>
                </div>
            </article>
        </div>
        <div class="col-md-4 col-sm-6 col-xs-12">
            <article id="prague" class="material-card Indigo">
                <h2>
                    <span>체코</span>
                    <strong>
                        <i class="fa fa-fw fa-star"></i>
                        프라하
                    </strong>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/프라하.jpg">
                    </div>
                </div>
            </article>
        </div>
        <div class="col-md-4 col-sm-6 col-xs-12">
            <article id="london" class="material-card Blue">
                <h2>
                    <span>영국</span>
                    <strong>
                        <i class="fa fa-fw fa-star"></i>
                        런던
                    </strong>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/런던.jpg">
                    </div>
                </div>
            </article>
        </div>
    </div>
</section>
</form>

			
						

</body>
</html>