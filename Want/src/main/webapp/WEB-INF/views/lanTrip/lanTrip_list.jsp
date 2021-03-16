<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 랜선여행하기</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/lanTrip_list.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">


<!-- 캐러셀 -->

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">

.carousel-container {
	padding: 15px;
	margin-top : 100px;
}
.carousel {
   	display : block;
   	margin-left : auto;
   	margin-right : auto;
   	margin-top : auto;   		
   	width: 40%;
}
.carousel-inner img {
   	width: 100%;
   	height: auto;
}

.card-container {
	padding: 30px;
	margin-top : 10px;
}
</style>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />

	<section id=carousel>
		<div class="carousel-container">
			<div id="myCarousel" class="carousel slide" data-ride="carousel">				
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
					<span class="glyphicon glyphicon-chevron-left"></span> 
					<span class="sr-only">Previous</span>
				</a> 
				<a class="right carousel-control" href="#myCarousel" data-slide="next"> 
					<span class="glyphicon glyphicon-chevron-right"></span> 
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
	</section>
	
	<%-- card --%>
	<section id="card">
		<div class="card-container">
			<div class="row">
				<div class="col-sm">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">김해선</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col-sm">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">정현수</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col-sm">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">이지훈</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col-sm">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">박혁준</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col-sm">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">윤동희</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
			</div>
			<div class="row mt-5">
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">이형석</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">이형진</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">이승원</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">지명현</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">문기태</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
			</div>
			<div class="row mt-5">
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">박준용</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">유우상</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">박영인</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
    						<h3 class="card-title">우현지</h3>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    						<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
				<div class="col">
					<div class="card" style="width: 30rem;">
  						<video src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4" controls></video>
  						<div class="card-body">
   		 					<h3 class="card-title">원혜련</h3>
  		  					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
   		 					<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
  						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	

</body>
</html>