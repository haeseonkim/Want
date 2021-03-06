<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want aboutUS</title>
	
<jsp:include page="./include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/aboutUs.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="./include/navbar.jsp">
		<jsp:param value="aboutUs" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />
	

		<!-- ======= Our Team Section ======= -->
		<section id="team" class="team section-bg">
			<div class="container">
				<div class="section-title" data-aos="fade-up">
					<h2>
						WANT <strong>about us</strong>
					</h2>
					<p>안녕하세요! 우린 WANT 제작팀 KICKIC 입니다.
					   Want는 What a nice trip의 줄임말로 "정말 nice한 여행을 원한다!" 의 의미를 품고있습니다.</p>
				</div>

				<div class="row">

					<div class="col-lg-3 col-md-6 d-flex align-items-stretch">
						<div class="member" data-aos="fade-up">
							<div class="member-img">
								<img src="./upload/aboutUs/haeseon.jpeg" class="img-fluid" alt="">
							</div>
							<div class="member-info">
								<h4>김해선</h4>
								<span>그저 빛. 팀장.</span>
							</div>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 d-flex align-items-stretch">
						<div class="member" data-aos="fade-up" data-aos-delay="100">
							<div class="member-img">
								<img src="./upload/aboutUs/jihoon.jpeg" class="img-fluid" alt="">
							</div>
							<div class="member-info">
								<h4>이지훈</h4>
								<span>틀틀. 틀니압수예</span>
							</div>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 d-flex align-items-stretch">
						<div class="member" data-aos="fade-up" data-aos-delay="200">
							<div class="member-img">
								<img src="./upload/aboutUs/hyeonsoo.jpeg" class="img-fluid" alt="">
							</div>
							<div class="member-info">
								<h4>정현수</h4>
								<span>저년수. hunsoochung</span>
							</div>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 d-flex align-items-stretch">
						<div class="member" data-aos="fade-up" data-aos-delay="300">
							<div class="member-img">
								<img src="./upload/aboutUs/hyukjun.jpeg" class="img-fluid" alt="">
							</div>
							<div class="member-info">
								<h4>박혁준</h4>
								<span>커피셔틀</span>
							</div>
						</div>
					</div>

				</div>

			</div>
		</section>
		<!-- End Our Team Section -->

	</main>
	<!-- End #main -->

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script src="assets/vendor/aos/aos.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="assets/vendor/php-email-form/validate.js"></script>
	<script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="assets/vendor/waypoints/noframework.waypoints.js"></script>

	<!-- Template Main JS File -->
	<script src="assets/js/main.js"></script>
</body>
</html>