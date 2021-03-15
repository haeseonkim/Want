<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/lanTrip_list.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />

	<div class="container">
		<div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-bs-target="#myCarousel" data-bs-slide-to="0" class="active"></li>
				<li data-bs-target="#myCarousel" data-bs-slide-to="1"></li>
				<li data-bs-target="#myCarousel" data-bs-slide-to="2"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner">

				<div class="item active">
					<img src="./upload/lanTrip/img1.jpg" alt="Paris" class="img-responsive">
					<div class="carousel-caption">
						<h3>Paris</h3>						
					</div>
				</div>

				<div class="item">
					<img src="./upload/lanTrip/img3.jpg" alt="Positano" class="img-responsive">
					<div class="carousel-caption">
						<h3>Positano</h3>
					</div>
				</div>

				<div class="item">
					<img src="./upload/lanTrip/img4.jpg" alt="London" class="img-responsive">
					<div class="carousel-caption">
						<h3>London</h3>
					</div>
				</div>

			</div>

			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span> <span
				class="sr-only">Next</span>
			</a>
		</div>
	</div>

</body>
</html>