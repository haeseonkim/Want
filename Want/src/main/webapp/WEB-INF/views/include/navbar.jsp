<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="org.apache.ibatis.annotations.Param"%>


<header id="header" class="fixed-top">
	<div class="container d-flex align-items-center">

		<h1 class="logo me-auto">
			<a href="./home.do">Want</a>
		</h1>
		<!-- <a href="index.html" class="logo me-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

		<nav id="navbar" class="navbar order-last order-lg-0">
			<ul>
				<li><a
					class="${param.thisPage eq 'home' ? 'active':''}"
					href="./home.do">Home</a></li>
				<li class="dropdown"><a href="./lanTrip_list.do"><span>랜선여행</span>
						<i class="bi bi-chevron-down"></i></a>
					<ul>
						<%--thisPage에 저장된 값이 "my_report"이면 active시켜라 포커싱된다. --%>
						<li><a
							class="${param.thisPage eq 'lanTrip_list' ? 'active':''}"
							href="./lanTrip_list.do">랜선여행 하기</a></li>
						<li><a
							class="${param.thisPage eq 'lanTrip_apply_list' ? 'active':''}"
							href="./lanTrip_apply_list.do">랜선여행 신청</a></li>
					</ul></li>
				<li><a
					class="${param.thisPage eq 'picture_list' ? 'active':''}"
					href="./picture_list.do">사진 자랑</a></li>
				<li class="dropdown"><a href="./select_city.do?sa=s"><span>여행지
							정보</span> <i class="bi bi-chevron-down"></i></a>
					<ul>
						<li><a
							class="${param.thisPage eq 'shopping_list' ? 'active':''}"
							href="./select_city.do?sa=s">쇼핑</a></li>
						<li><a
							class="${param.thisPage eq 'accom_list' ? 'active':''}"
							href="./select_city.do?sa=a">숙소</a></li>
						<li><a class="${param.thisPage eq 'with_list' ? 'active':''}"
							href="./with_list.do">동행 구해요</a></li>
					</ul></li>
				<li><a class="${param.thisPage eq 'aboutUs' ? 'active':''}"
					href="./aboutUs.do">About us</a></li>

				<%-- 로그인 상태 일때만 '마이페이지'가 보인다. --%>
				<c:if test="${!empty sessionScope.id or !empty sessionScope.kakaoid}">
					<li class="dropdown"><a href="./my_list.do"><span>마이페이지</span>
							<i class="bi bi-chevron-down"></i></a>
						<ul>
							<li><a class="${param.thisPage eq 'profile' ? 'active':''}"
								href="./profile.do">내 프로필</a></li>
							<li><a
								class="${param.thisPage eq 'favorite_list' ? 'active':''}"
								href="./favorite_list.do">좋아요한 목록</a></li>
						</ul></li>
				</c:if>
			</ul>
			<i class="bi bi-list mobile-nav-toggle"></i>
		</nav>
		<!-- .navbar -->

		<%-- 로그인일때와 아닐때를 구분하기 위함이다. --%>
		<c:choose>
			<%--session scope에 로그인 된 아이디가 있는지 찾아본다.--%>
			<%-- 로그인 상태가 아닐 때 --%>
			<c:when test="${empty sessionScope.nick}">
				<a href="./loginForm.do" class="get-started-btn">로그인</a>
				<a href="./signupForm.do" class="get-started-btn">회원가입</a>
			</c:when>
			<%-- 로그인 상태일 때 --%>
			<c:otherwise>
				<span class="navbar-text">
					<a href="./logout.do" class="get-started-btn">로그아웃</a>
				</span>
				<span class="message">
				<a href="./message_list.do"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
  					<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2zm13 2.383-4.758 2.855L15 11.114v-5.73zm-.034 6.878L9.271 8.82 8 9.583 6.728 8.82l-5.694 3.44A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.739zM1 11.114l4.758-2.876L1 5.383v5.73z"/>
					</svg></a></span>
			</c:otherwise>
		</c:choose>

	</div>

</header>
<!-- End Header -->
