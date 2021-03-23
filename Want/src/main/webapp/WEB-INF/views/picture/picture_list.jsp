<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 사진자랑하기</title>

<jsp:include page="../include/index.jsp"></jsp:include>


<!-- CSS File -->
<link href="./resources/css/picture_list.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">
<script type="text/javascript">
	$(document).ready(function() {
		
		
		// view modal창 띄우는 함수입니다.
		const viewServer = function(no) {
			$.ajax({
				url : 'picture_view.do',
				type : 'get',
				data : {
					no : no
				},
				success : function(to) {
					let hit = to.hit;
					
					$('#m_hit'+no).text(hit);
					$('#hit'+no).text(hit);
					
				},
				error : function() {
					alert('서버 에러');
				}
			});
		};
		
		// 게시물 이미지를 클릭했을 때 실행된다
		// 해당 게시물을 hit+1하는 함수를 호출한다.
		$(document).on('click', '.card-img', function() {
			// 게시물 번호(no)를 idx로 전달받아 저장합니다.
			let no = $(this).attr('idx');
			
			console.log(no +"에 hit + 1을 함");
			
			// hit+1하기 위한 함수
			viewServer(no);
		});
		
		
		
		// 로그인 한 상태에서 하트를 클릭했을 때 (로그인한 상태인 하트의 <a></a> class명: heart-click)
		$(".heart-click ").click(function() {
			let no = $(this).attr('idx');
			
			// 빈하트를 눌렀을때
			if($(this).children('svg').attr('class') == "bi bi-suit-heart"){
				console.log("빈하트 클릭" + no);
				
				$.ajax({
					url : 'saveHeart.do',
					type : 'get',
					data : {
						no : no,
					},
					success : function(pto) {
						//페이지 새로고침
						//document.location.reload(true);
						
						let heart = pto.heart;
						$('#m_heart'+no).text(heart);
						$('#heart'+no).text(heart);
						
						console.log("하트추가 성공");
					},
					error : function() {
						alert('서버 에러');
					}
				});
				$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16"><path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/></svg>');
			
			// 꽉찬 하트를 눌렀을 때
			}else{
				console.log("꽉찬하트 클릭" + no);
				
				$.ajax({
					url : 'removeHeart.do',
					type : 'get',
					data : {
						no : no,
					},
					success : function(pto) {
						//페이지 새로고침
						//document.location.reload(true);
						
						let heart = pto.heart;
						$('#m_heart'+no).text(heart);
						$('#heart'+no).text(heart);
						
						console.log("하트삭제 성공");
					},
					error : function() {
						alert('서버 에러');
					}
				});
				$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
			}
		});
		
		
		// 로그인 안한 상태에서 하트를 클릭하면 로그인해야한다는 알림창이 뜹니다.
		// (로그인한 상태인 하트의 <a></a> class명: heart-notlogin)
		$(".heart-notlogin ").click(function() {
			alert('로그인 하셔야 하트를 누를수 있습니다!');
		});
		
		// view modal의 닫기 버튼(x)을 누르면 현재 스크롤 위치에서 페이지를 새로고침합니다.
		$(".btn-close").click(function(){
			
			// 현재 스크롤 위치에서 페이지를 새로고침하는 코드입니다.
			// 원래 페이지 새로고침 하는 코드 -> document.location.reload();
			// 문제발생 -> 닫기버튼 말고 modal창 밖을 클릭해서 닫을땐 발생하지 않는다.
			// ------ 해결 ------
			//data-bs-backdrop="static" -> modal창 밖을 클릭해서 닫히지 않게 한다.
			//data-bs-keyboard="false" -> esc 로 창이 닫기지 않게 한다.
			
			//document.location.reload(true);
		});

	});
	
</script>


</head>
<body>


	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="picture_list" name="thisPage" />
	</jsp:include>

	<br />
	<br />
	<br />

	<!-- best5 캐러샐 -->
	<%-- 
	<section id="carousel-container" class="carousel-container" style="background:url('./resources/img/slide-1.jpg');">
	--%>
	<section id="carousel-container" class="carousel-container" >
		<div class="row row-carousel">
			<div class="section-title col-md-4">
				<h2>Best5</h2>
				<p>인기게시물을 확인하세요!</p>
			</div>
			<div id="carouselExampleIndicators" class="carousel slide col-md-8" data-bs-ride="carousel">
				<div class="carousel-indicators">
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
				 </div>
				<div class="carousel-inner">
					<c:forEach var="tmp" items="${bestList }">
						<c:choose>
							<c:when test="${tmp eq bestList[0] }">
								<div class="carousel-item active">
									<img class="d-block w-100 carousel-img" src="./upload/picture/${tmp.media }"
										alt="...">
								</div>
							</c:when>
							<c:otherwise>
								<div class="carousel-item">
									<img class="d-block w-100 carousel-img" src="./upload/picture/${tmp.media }"
										alt="...">
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
	
	
				<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"  data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"  data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
			</div>
		</div>
	</section>
	<!-- best5 캐러샐 끝 -->
	
	
	<!-- ======= card Section ======= -->
	<section id="card-list" class="card-list">
		<div class="container">

			<div class="row card-list-container" data-aos="fade-up">

				<c:forEach var="tmp" items="${listTO.boardLists }">

					<div class="col-lg-4 col-md-6 card" style="width: 18rem;" >
						<div class="card-img" type="button" idx="${tmp.no }" data-bs-toggle="modal" data-bs-target="#viewModal${tmp.no }">
							<img src="./upload/picture/${tmp.media }" class="card-img-top" alt="..." >
						</div>
						<div class="card-body">
							<div class="row">
								<div class="col-xsm card-title"> ${tmp.writer }</div>
								<div class="col-sm card-heart" id="card-heart">
									<c:choose>
										<%-- 로그인 상태일때 - 하트 클릭 되게 --%>
										<c:when test="${not empty sessionScope.nick}">
											<c:choose>
												<c:when test="${empty tmp.hno}">
													<%-- 빈 하트일때 --%>
													<span>
													<a idx="${tmp.no }" href="javascript:" class="heart-click"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
						  							  <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
													</svg></a>
													</span>
												</c:when>
												<c:otherwise>
													<%-- 꽉찬 하트일때 --%>
													<span>
													<a idx="${tmp.no }" href="javascript:" class="heart-click"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
													  <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/>
													</svg></a>
													</span>
												</c:otherwise>
											</c:choose>
										</c:when>
										<%-- 로그인 상태가 아닐때  - 하트클릭 안되게 --%>
										<c:otherwise>
											<span>
											<a href="javascript:" class="heart-notlogin">
											<svg class="heart3" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
						  					  <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
											</svg></a>
											</span>
										</c:otherwise>
									</c:choose>
									<span id="heart${tmp.no }">${tmp.heart }</span>
									
									<%-- 댓글 아이콘 --%>
									<span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
										<path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" />
										<path d="M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z" />
									</svg>
									</span>
									<span id="reply${tmp.no }">${tmp.reply }</span>
									
									<%-- 눈깔 아이콘 --%>
									<span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
										<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
										<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
									</svg>
									</span>
									<span id="hit${tmp.no }">${tmp.hit }</span>
								</div>
							</div>
						</div>
					</div>
					
					<!-- view Modal -->
					<div class="modal fade" id="viewModal${tmp.no }" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" role="dialog" data-bs-backdrop="static" data-bs-keyboard="false">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
						    	<div class="modal-header">
								    <h5 class="modal-title" id="m_subject">[${tmp.location}]&nbsp;${tmp.subject }</h5>
								    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<section class="modal-section">
										<div>
											<span id="m_writer_profile" >
												<img id="profileImage" src='./upload/profile/${tmp.profile }' />
											</span>&nbsp;&nbsp;<span id="m_writer">${tmp.writer }</span>
											
										</div>
									</section>
									<section class="modal-section-media">
										<div class="container" id="m_media">
											<img class="w-100" id="media-image" src='./upload/picture/${tmp.media }' />
										</div>
									</section>
									<section class="modal-section">
										<div id="m_heart_reply_hit">
											<span id="m_heart_icon">
											<c:choose>
											<%-- 로그인 상태일때 - 하트 클릭 되게 --%>
											<c:when test="${not empty sessionScope.nick}">
												<c:choose>
													<c:when test="${empty tmp.hno}">
														<%-- 빈 하트일때 --%>
														<a idx="${tmp.no}" href="javascript:" class="heart-click"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
							  							  <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
														</svg></a>
														
													</c:when>
													<c:otherwise>
														<%-- 꽉찬 하트일때 --%>
														<a idx="${tmp.no}" href="javascript:" class="heart-click"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
														  <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/>
														</svg></a>
													</c:otherwise>
												</c:choose>
											</c:when>
											<%-- 로그인 상태가 아닐때  - 하트클릭 안되게 --%>
											<c:otherwise>
												<a href="javascript:" class="heart-notlogin">
												<svg class="heart3" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
							  					  <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
												</svg></a>
											</c:otherwise>
											</c:choose>
											</span>
											<span id="m_heart${tmp.no }">${tmp.heart }</span>
											
											<%-- 댓글 --%>
											<span>
												<a href="javascript:" class="open_reply_list" data-bs-toggle="collapse" data-bs-target="#reply_list" aria-expanded="false" aria-controls="collapseExample">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
													<path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" />
													<path d="M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z" />
												</svg>
												</a>
											</span>
											<span id="m_reply${tmp.no }">${tmp.reply }</span>
											
											<%-- 조회수 --%>
											<span>
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
													<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
													<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
												</svg>
											</span>
											<span id="m_hit${tmp.no }">${tmp.hit }</span>
										</div>
									</section>
									<section class="modal-section">
										<div id="m_content">
											${tmp.content }
										</div>
									</section>
								</div>
								
								<div>
									<!-- 댓글  -->
									<div class="collapse" id="reply_list">
									  <div class="card card-body">
									    Some placeholder content for the collapse component. This panel is hidden by default but revealed when the user activates the relevant trigger.
									  </div>
									</div>
								</div>
								<div id="modify_delete">
									<%-- 수정/삭제버튼 --%>
									<c:if test="${not empty nick and tmp.writer eq sessionScope.nick}">
										<div class='modal-footer'>
											<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modifyModal${tmp.no}">수정</button>
											<button type="button" class="btn btn-dark"  data-bs-toggle="modal" data-bs-target="#deleteModal${tmp.no}">삭제</button>
										</div>
									</c:if>
								</div>
						    </div>
						</div>
					</div>
					<%-- view Modal 끝 --%>
						
					<!-- modify Modal -->
					<div class="modal fade" id="modifyModal${tmp.no}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">modify confirm</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					       	수정페이지로 이동 하시겠습니까?
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요</button>
					        <button type="button" class="btn btn-primary" onclick="location.href='./picture_modify.do?no=${tmp.no}'">네</button>
					      </div>
					    </div>
					  </div>
					</div>
					<!-- modify Modal 끝 -->
						
					<!-- delete Modal -->
					<div class="modal fade" id="deleteModal${tmp.no}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">delete confirm</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					       	정말 삭제하시겠습니까?!!
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요</button>
					        <button type="button" class="btn btn-primary" onclick="location.href='./picture_delete.do?no=${tmp.no}'">네</button>
					      </div>
					    </div>
					  </div>
					</div>
					<!-- delete Modal 끝 -->
					
				</c:forEach>


			</div>
		</div>
		
	

	</section>
	<!-- ======= card Section 끝 ======= -->


	<c:choose>
		<c:when test="${empty sessionScope.nick}">
			<button type="button" class="btn btn-primary"
				onclick="javascript:alert('로그인을 하셔야합니다.')">글쓰기</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="btn btn-primary"
				onclick="location.href='./picture_write.do'">글쓰기</button>
		</c:otherwise>
	</c:choose>

</body>
</html>