<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="org.apache.ibatis.annotations.Param"%>

<%
	String cpage = request.getParameter("cpage");
%>

<header id="header" class="fixed-top">
	<div class="container d-flex align-items-center">

		<h1 class="logo me-auto">
			<a href="./lanTrip_list.do">Want</a>
		</h1>
		<div id="writebox">
		<c:if test="${!empty sessionScope.nick}">
			<c:choose>
				<c:when test="${empty sessionScope.nick}">
					<button type="button" class="btn btn--radius-2 btn--blue-2 btn-md" onclick="javascript:alert('로그인을 하셔야합니다.')">등록하기</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn--radius-2 btn--blue-2 btn-md" onclick="location.href='./lanTrip_write.do?cpage=<%=cpage%>'">등록하기</button>	
				</c:otherwise>
			</c:choose>
			</c:if>
		</div>
		
		<!-- <a href="index.html" class="logo me-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

		<nav id="navbar" class="navbar order-last order-lg-0">
			<ul>
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
				<li class="dropdown"><a href="./select_shop_accom.do"><span>여행지
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
							<li><a class="${param.thisPage eq 'my_list' ? 'active':''}"
								href="./my_list.do">내 피드</a></li>
							<li><a class="${param.thisPage eq 'profile' ? 'active':''}"
								href="./profile.do">내 프로필</a></li>
							<li><a
								class="${param.thisPage eq 'favorite_list' ? 'active':''}"
								href="./favorite_list.do">즐겨찾기 목록</a></li>
							<li><a
								class="${param.thisPage eq 'follow_list' ? 'active':''}"
								href="./fallow_list">팔로우</a></li>
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
			<c:when test="${empty sessionScope.id && empty sessionScope.kakaoid}">
				<a href="./loginForm.do" class="get-started-btn">로그인</a>
				<a href="./signupForm.do" class="get-started-btn">회원가입</a>
			</c:when>
			<%-- 로그인 상태일 때 --%>
			<c:otherwise>
				<span class="navbar-text">
					<a href="./logout.do" class="get-started-btn">로그아웃</a>
				</span>
			</c:otherwise>
		</c:choose>

	</div>
</header>
<!-- End Header -->
