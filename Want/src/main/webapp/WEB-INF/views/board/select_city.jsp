<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
	request.setCharacterEncoding("utf-8");
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
<link href="./resources/css/select_city.css?qq" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
window.onload = function() {
	$('#france').on('click', (event) => {
		document.cfrm.location.value = "프랑스";
		document.cfrm.submit();
	});
	$('#greece').on('click', (event) => {
		document.cfrm.location.value = "그리스";
		document.cfrm.submit();
	});
	$('#italy').on('click', (event) => {
		document.cfrm.location.value = "이탈리아";
		document.cfrm.submit();
	});
	$('#spain').on('click', (event) => {
		document.cfrm.location.value = "스페인";
		document.cfrm.submit();
	});
	$('#czech').on('click', (event) => {
		document.cfrm.location.value = "체코";
		document.cfrm.submit();
	});
	$('#uk').on('click', (event) => {
		document.cfrm.location.value = "영국";
		document.cfrm.submit();
	});
	$('#swizerland').on('click', (event) => {
		document.cfrm.location.value = "스위스";
		document.cfrm.submit();
	});
	$('#portugal').on('click', (event) => {
		document.cfrm.location.value = "포르투갈";
		document.cfrm.submit();
	});
	$('#hungary').on('click', (event) => {
		document.cfrm.location.value = "헝가리";
		document.cfrm.submit();
	});
	$('#osterria').on('click', (event) => {
		document.cfrm.location.value = "오스트리아";
		document.cfrm.submit();
	});
	$('#sweden').on('click', (event) => {
		document.cfrm.location.value = "스웨덴";
		document.cfrm.submit();
	});
	$('#finland').on('click', (event) => {
		document.cfrm.location.value = "핀란드";
		document.cfrm.submit();
	});
	$('#poland').on('click', (event) => {
		document.cfrm.location.value = "폴란드";
		document.cfrm.submit();
	});
	
	
}

	
</script>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="select_city" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />
	<div class="select-form">
		<div class="col-8 offset-3">
			<h2>국가를 선택해주세요!</h2>
		</div>	
	</div>
<form action="<%= pageName %>" method="post" name="cfrm">
<input type="hidden" name="sa" value="<%= sa %>"/>
<input type="hidden" name="location" value="" />
<section class="container">
    
    <div class="row active-with-click">
    
        <div class="col-md-3 col-sm-6 col-xs-12">
			<article id="france" class="material-card Red">
				<h2>
					<span>프랑스</span>
				</h2>
				<div class="mc-content">
					<div class="img-container">
						<img class="img-responsive" src="./resources/img/파리.jpg">
					</div>
				</div>
			</article>
		</div>
        
        <div class="col-md-3 col-sm-6 col-xs-12">
            <article id="greece" class="material-card Pink">
                <h2>
                    <span>그리스</span>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/아테네.jpg">
                    </div>
                </div>
            </article>
        </div>
        
        <div class="col-md-3 col-sm-6 col-xs-12">
            <article id="italy" class="material-card Purple">
                <h2>
                    <span>이탈리아</span>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/로마.jpg">
                    </div>
                </div>
            </article>
        </div>
        
        <div class="col-md-3 col-sm-6 col-xs-12">
            <article id="spain" class="material-card Deep-Purple">
                <h2>
                    <span>스페인</span>
                </h2>
                <div class="mc-content">
                    <div class="img-container">                    	
                        <img class="img-responsive" src="./resources/img/부다페스트.jpg">
                    </div>
                </div>
            </article>
        </div>
        
        <div class="col-md-3 col-sm-6 col-xs-12">
            <article id="czech" class="material-card Indigo">
                <h2>
                    <span>체코</span>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/프라하.jpg">
                    </div>
                </div>
            </article>
        </div>
        
        <div class="col-md-3 col-sm-6 col-xs-12">
            <article id="uk" class="material-card Blue">
                <h2>
                    <span>영국</span>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/런던.jpg">
                    </div>
                </div>
            </article>
        </div>
        
        <div class="col-md-3 col-sm-6 col-xs-12">
            <article id="swizerland" class="material-card Green">
                <h2>
                    <span>스위스</span>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/스위스.jpg">
                    </div>
                </div>
            </article>
        </div>
        
        <div class="col-md-3 col-sm-6 col-xs-12">
            <article id="portugal" class="material-card portugal">
                <h2>
                    <span>포르투갈</span>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/포르투갈.jpg">
                    </div>
                </div>
            </article>
        </div>
        
        <div class="col-md-3 col-sm-6 col-xs-12">
            <article id="hungary" class="material-card hungary">
                <h2>
                    <span>헝가리</span>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/헝가리.jpg">
                    </div>
                </div>
            </article>
        </div>

    
    	<div class="col-md-3 col-sm-6 col-xs-12">
            <article id="osterria" class="material-card osterria">
                <h2>
                    <span>오스트리아</span>
                </h2>
                <div class="mc-content">
                    <div class="img-container">
                        <img class="img-responsive" src="./resources/img/오스트리아.jpg">
                    </div>
                </div>
            </article>
        </div>

		<div class="col-md-3 col-sm-6 col-xs-12">
			<article id="sweden" class="material-card sweden">
				<h2>
					<span>스웨덴</span>
				</h2>
				<div class="mc-content">
					<div class="img-container">
						<img class="img-responsive" src="./resources/img/스웨덴.jpg">
					</div>
				</div>
			</article>
		</div>
		
		<div class="col-md-3 col-sm-6 col-xs-12">
			<article id="finland" class="material-card finland">
				<h2>
					<span>핀란드</span>
				</h2>
				<div class="mc-content">
					<div class="img-container">
						<img class="img-responsive" src="./resources/img/핀란드.jpg">
					</div>
				</div>
			</article>
		</div>
		
		<div class="col-md-3 col-sm-6 col-xs-12">
			<article id="poland" class="material-card poland">
				<h2>
					<span>폴란드</span>
				</h2>
				<div class="mc-content">
					<div class="img-container">
						<img class="img-responsive" src="./resources/img/폴란드.jpg">
					</div>
				</div>
			</article>
		</div>

	</div>
    <!-- 전체 div 끝 -->
</section>
</form>

			
						

</body>
</html>