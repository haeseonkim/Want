<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want Home</title>
<jsp:include page="./include/index.jsp"></jsp:include>

	
<!-- CSS File -->
<link href="./resources/css/home.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

</head>
<body>

	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="./include/navbar.jsp">
		<jsp:param value="home" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />
	
	  <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex justify-content-center align-items-center">
    <div class="container position-relative" data-aos="zoom-in" data-aos-delay="100">
		<div class="want">
			<h1>여행을</h1>
			<h1>WANT 하다</h1>
		</div>  
      <h2>What A Nice Trip !</h2>
      <a href="./lanTrip_list.do" class="btn-get-started">랜선여행 시작</a>
    </div>
  </section><!-- End Hero -->

  <main id="main">

    <!-- ======= About Section ======= -->
    <section id="about" class="about">
      <div class="container" data-aos="fade-up">

        <div class="row">
          <div class="col-lg-6 order-1 order-lg-2" data-aos="fade-left" data-aos-delay="100">
            <img src="assets/img/about.jpg" class="img-fluid" alt="">
          </div>
          <div class="col-lg-6 pt-4 pt-lg-0 order-2 order-lg-1 content">
            <h3>Voluptatem dignissimos provident quasi corporis voluptates sit assumenda.</h3>
            <p class="font-italic">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
              magna aliqua.
            </p>
            <ul>
              <li><i class="bi bi-check-circle"></i> Ullamco laboris nisi ut aliquip ex ea commodo consequat.</li>
              <li><i class="bi bi-check-circle"></i> Duis aute irure dolor in reprehenderit in voluptate velit.</li>
              <li><i class="bi bi-check-circle"></i> Ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate trideta storacalaperda mastiro dolore eu fugiat nulla pariatur.</li>
            </ul>
            <p>
              Ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
            </p>

          </div>
        </div>

      </div>
    </section><!-- End About Section -->

    <!-- ======= Counts Section ======= -->
    <section id="counts" class="counts section-bg">
      <div class="container">

        <div class="row counters">

          <div class="col-lg-4 col-6 text-center">
            <span data-purecounter-start="0" data-purecounter-end="${visit }" data-purecounter-duration="1" class="purecounter"></span>
            <p>오늘 방문자수</p>
          </div>

          <div class="col-lg-4 col-6 text-center">
            <span data-purecounter-start="0" data-purecounter-end="${member }" data-purecounter-duration="1" class="purecounter"></span>
            <p>회원수</p>
          </div>

          <div class="col-lg-4 col-6 text-center">
            <span data-purecounter-start="0" data-purecounter-end="${boards_contents }" data-purecounter-duration="1" class="purecounter"></span>
            <p>게시물수</p>
          </div>


        </div>

      </div>
    </section><!-- End Counts Section -->

    <!-- ======= Why Us Section ======= -->
    <section id="why-us" class="why-us">
      <div class="container" data-aos="fade-up">

        <div class="row">
          <div class="col-lg-4 d-flex align-items-stretch">
            <div class="content">
              <h3>왜 Want여야 할까요?</h3>
              <p>
                Want는 일반 사용자부터 가이드까지 다양한 회원층을 기반으로 다양한 여행정보 제공, 랜선여행 서비스를 지원합니다. 저희의 비전은 다음과 같습니다.
              </p>
              <div class="text-center">
                <a href="about.html" class="more-btn">Learn More <i class="bx bx-chevron-right"></i></a>
              </div>
            </div>
          </div>
          <div class="col-lg-8 d-flex align-items-stretch" data-aos="zoom-in" data-aos-delay="100">
            <div class="icon-boxes d-flex flex-column justify-content-center">
              <div class="row">
                <div class="col-xl-4 d-flex align-items-stretch">
                  <div class="icon-box mt-4 mt-xl-0">
                    <i class="bx bx-receipt"></i>
                    <h4>Corporis voluptates sit</h4>
                    <p>Consequuntur sunt aut quasi enim aliquam quae harum pariatur laboris nisi ut aliquip</p>
                  </div>
                </div>
                <div class="col-xl-4 d-flex align-items-stretch">
                  <div class="icon-box mt-4 mt-xl-0">
                    <i class="bx bx-cube-alt"></i>
                    <h4>Ullamco laboris ladore pan</h4>
                    <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt</p>
                  </div>
                </div>
                <div class="col-xl-4 d-flex align-items-stretch">
                  <div class="icon-box mt-4 mt-xl-0">
                    <i class="bx bx-images"></i>
                    <h4>Labore consequatur</h4>
                    <p>Aut suscipit aut cum nemo deleniti aut omnis. Doloribus ut maiores omnis facere</p>
                  </div>
                </div>
              </div>
            </div><!-- End .content-->
          </div>
        </div>

      </div>
    </section><!-- End Why Us Section -->

    <!-- ======= 랜선여행 BEST ======= -->
    <section id="popular-courses" class="courses">
      <div class="container" data-aos="fade-up">

        <div class="row section-title">
          <h2>랜선여행</h2>
          <div class="col-10">
          	<p>BEST3</p>
          </div>
          <div class="col-2 btnclass">
          	<button class="btn" onclick="location.href='./lanTrip_list.do'">보러가기<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/>
</svg></button>
          	
          </div>
        </div>

        <div class="row" data-aos="zoom-in" data-aos-delay="100">
        <% int best1 = 0; %>
		<c:forEach var="tmp" items="${lanList }" >
			<% best1++; %>
          <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
          
            <div class="course-item">
	          <div class="box1">
	              <video src="./upload/lanTrip/${tmp.video }" class="img-fluid" autoplay loop muted></video>
              </div>
              <div class="course-content">
                <div class="d-flex justify-content-between align-items-center mb-3">
                  <h4>best <%=best1 %></h4>
                </div>

                <h3><a href="course-details.html">${tmp.subject }</a></h3>
                <p>${tmp.content }</p>
                <div class="trainer d-flex justify-content-between align-items-center">
                  <div class="trainer-profile d-flex align-items-center">
                  	<div class="box">
                    	<img src="./upload/profile/${tmp.profile }" class="img-fluid" alt="">
                    </div>
                    <span>${tmp.writer }</span>
                  </div>
                  <div class="trainer-rank d-flex align-items-center">
                    <i class="bx bx-user"></i>&nbsp;${tmp.hit }
                    &nbsp;&nbsp;
                    <i class="bx bx-heart"></i>&nbsp;${tmp.heart }
                  </div>
                </div>
              </div>
            </div>
          </div> 

        </c:forEach>
        
        </div>

      </div>
    </section><!-- 랜선여행 BEST 끝 -->
    
    
    <!-- ======= 사진자랑 BEST ======= -->
    <section id="popular-courses1" class="courses">
      <div class="container" data-aos="fade-up">

        <div class="row section-title">
          <h2>사진자랑</h2>
          <div class="col-10">
          	<p>BEST3</p>
          </div>
          <div class="col-2 btnclass">
          	<button class="btn" onclick="location.href='./picture_list.do'">보러가기<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/>
</svg></button>
          	
          </div>
        </div>

        <div class="row" data-aos="zoom-in" data-aos-delay="100">
        <% int best2 = 0; %>
		<c:forEach var="tmp" items="${picList }" >
			<% best2++; %>
          <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
          
            <div class="course-item">
              <div class="box1">
              	<img src="./upload/picture/${tmp.media }" class="img-fluid">
              </div>
              <div class="course-content">
                <div class="d-flex justify-content-between align-items-center mb-3">
                  <h4>best <%=best2 %></h4>
                </div>

                <h3><a href="course-details.html">${tmp.subject }</a></h3>
                <p>${tmp.content }</p>
                <div class="trainer d-flex justify-content-between align-items-center">
                  <div class="trainer-profile d-flex align-items-center">
                  	<div class="box">
                    	<img src="./upload/profile/${tmp.profile }" class="img-fluid" alt="">
                    </div>
                    <span>${tmp.writer }</span>
                  </div>
                  <div class="trainer-rank d-flex align-items-center">
                    <i class="bx bx-user"></i>&nbsp;${tmp.hit }
                    &nbsp;&nbsp;
                    <i class="bx bx-heart"></i>&nbsp;${tmp.heart }
                  </div>
                </div>
              </div>
            </div>
          </div> 

        </c:forEach>
        
        </div>

      </div>
    </section><!-- 사진자랑  BEST 끝-->

    <!-- ======= 쇼핑 BEST ======= -->
    <section id="popular-courses1" class="courses">
      <div class="container" data-aos="fade-up">

        <div class="row section-title">
          <h2>쇼핑</h2>
          <div class="col-10">
          	<p>BEST3</p>
          </div>
          <div class="col-2 btnclass">
          	<button class="btn" onclick="location.href='./select_shop_accom.do'">보러가기<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/>
</svg></button>
          	
          </div>
        </div>

        <div class="row" data-aos="zoom-in" data-aos-delay="100">
        <% int best3 = 0; %>
		<c:forEach var="tmp" items="${shopList }" >
			<% best3++; %>
          <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
          
            <div class="course-item">
              <div class="box1">
              	<img src="./upload/shopping/${tmp.picture }" class="img-fluid">
              </div>
              <div class="course-content">
                <div class="d-flex justify-content-between align-items-center mb-3">
                  <h4>best <%=best3 %></h4>
                </div>

                <h3><a href="course-details.html">${tmp.subject }</a></h3>
                <p>${tmp.content }</p>
                <div class="trainer d-flex justify-content-between align-items-center">
                  <div class="trainer-profile d-flex align-items-center">
                  	<div class="box">
                    	<img src="./upload/profile/${tmp.profile }" class="img-fluid" alt="">
                    </div>
                    <span>${tmp.writer }</span>
                  </div>
                  <div class="trainer-rank d-flex align-items-center">
                    <i class="bx bx-user"></i>&nbsp;${tmp.hit }
                    &nbsp;&nbsp;
                    <i class="bx bx-heart"></i>&nbsp;${tmp.heart }
                  </div>
                </div>
              </div>
            </div>
          </div> 

        </c:forEach>
        
        </div>

      </div>
    </section><!-- 쇼핑  BEST 끝-->
    

    <!-- ======= 숙소 BEST ======= -->
    <section id="popular-courses1" class="courses">
      <div class="container" data-aos="fade-up">

        <div class="row section-title">
          <h2>숙소</h2>
          <div class="col-10">
          	<p>BEST3</p>
          </div>
          <div class="col-2 btnclass">
          	<button class="btn" onclick="location.href='./select_shop_accom.do'">보러가기<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/>
</svg></button>
          	
          </div>
        </div>

        <div class="row" data-aos="zoom-in" data-aos-delay="100">
        <% int best4 = 0; %>
		<c:forEach var="tmp" items="${accomList }" >
			<% best4++; %>
          <div class="col-lg-4 col-md-6 d-flex align-items-stretch">
          
            <div class="course-item">
              <div class="box1">
              	<img src="./upload/accom/${tmp.picture }" class="img-fluid">
              </div>
              <div class="course-content">
                <div class="d-flex justify-content-between align-items-center mb-3">
                  <h4>best <%=best4 %></h4>
                </div>

                <h3><a href="course-details.html">${tmp.subject }</a></h3>
                <p>${tmp.content }</p>
                <div class="trainer d-flex justify-content-between align-items-center">
                  <div class="trainer-profile d-flex align-items-center">
                  	<div class="box">
                    	<img src="./upload/profile/${tmp.profile }" class="img-fluid" alt="">
                    </div>
                    <span>${tmp.writer }</span>
                  </div>
                  <div class="trainer-rank d-flex align-items-center">
                    <i class="bx bx-user"></i>&nbsp;${tmp.hit }
                    &nbsp;&nbsp;
                    <i class="bx bx-heart"></i>&nbsp;${tmp.heart }
                  </div>
                </div>
              </div>
            </div>
          </div> 

        </c:forEach>
        
        </div>

      </div>
    </section><!-- 숙소  BEST 끝-->


  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer">

    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-5 col-md-6 footer-contact">
            <h3>Want</h3>
            <p>
              	서울특별시 강남구 역삼동  <br>
             <br>
              <strong>Phone:</strong> 010-9217-6517<br>
              <strong>Email:</strong> kimhaeseon1@gmail.com<br>
            </p>
          </div>

          <div class="col-lg-4 col-md-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="./home.do">Home</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="./aboutUs.do">About us</a></li>
            </ul>
          </div>

          <div class="col-lg-3 col-md-6 footer-links">
            <h4>Our Services</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="./lanTrip_list.do">랜선여행 하기</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="./lanTrip_apply_list.do">랜선여행 신청</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="./picture_list.do">사진 자랑</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="./select_shop_accom.do">여행 정보</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="./with_list.do">동행구해요</a></li>
            </ul>
          </div>

        </div>
      </div>
    </div>

  </footer><!-- End Footer -->

  <div id="preloader"></div>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/vendor/purecounter/purecounter.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>
</html>