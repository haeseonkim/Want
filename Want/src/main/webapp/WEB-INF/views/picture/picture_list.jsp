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
		let no;
		let subject;
		let writer;
		let media;
		let content;
		let heart;
		let reply;
		let hit;
		
		let hno;
		let fno;
		let profile;
		let id;
		
		// view modal창 띄우는 함수입니다.
		const viewServer = function(no) {
			$.ajax({
				url : 'picture_view.do',
				type : 'get',
				data : {
					no : no
				},
				success : function(to) {
					/*
					let no = to.no;
					let subject = to.subject;
					let writer = to.writer;
					let media = to.media;
					let content = to.content;
					let heart = to.heart;
					let reply = to.reply;
					let hit = to.hit;
					
					let hno = to.hno;
					let fno = to.fno;
					let profile = to.profile;
					let id = to.id;
					*/
					
					no = to.no;
					subject = to.subject;
					writer = to.writer;
					media = to.media;
					content = to.content;
					heart = to.heart;
					reply = to.reply;
					hit = to.hit;
					
					hno = to.hno;
					fno = to.fno;
					profile = to.profile;
					id = to.id;

					console.log(hno);
					console.log(fno);
					console.log(profile);

					$('#m_subject').text(subject);
					$('#m_writer').text(writer);
					$('#m_media').html("<img class='w-100' src='./upload/picture/"+ media +"' />");
					if(id != null){
						if(hno == null){
							$('#m_heart').append("<svg class='m-heart1' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'><path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' /></svg>");
						}else{
							$('#m_heart').append("<svg class='m-heart2' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z' /></svg>")
						}
					}else{
						$('#m_heart').append("<svg class='heart3' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'><path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' /></svg>");
					}
					//$('#m_heart').append(heart + text('&npsp;'));
					$('#m_heart').append('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16"><path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" /><path d="M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z" /></svg>');
					
					$('#m_content').html(content);
					$('#m_reply').text(reply);
					$('#m_hit').text(hit);
					
					
				},
				error : function() {
					alert('서버 에러');
				}
			});
		};
		
		// 로그인 후 하트 추가를 위한 함수
		const saveHeart = function(no) {
			$.ajax({
				url : 'saveHeart.do',
				type : 'get',
				data : {
					no : no,
				},
				success : function(flag) {
					console.log(flag);
					console.log("하트추가 성공");
					
					//페이지 새로고침
					document.location.reload(true);
				},
				error : function() {
					alert('서버 에러');
				}
			});
		};
		
		// 로그인 후 하트 해제를 위한 함수
		const removeHeart = function(no) {
			$.ajax({
				url : 'removeHeart.do',
				type : 'get',
				data : {
					no : no,
				},
				success : function(flag) {
					console.log(flag);
					console.log("하트삭제 성공");
					
					//페이지 새로고침
					document.location.reload(true);
				},
				error : function() {
					alert('서버 에러');
				}
			});
		};
		
		// 이미지를 클릭햇을 때 실행되며 view modal창을 띄우기 위해 함수를 호출하는 부분입니다.
		$(document).on('click', '.card-img', function() {
			// 게시물 번호(no)를 idx로 전달받아 저장합니다.
			let no = $(this).attr('idx');
			console.log(no);
			
			// view modal창을 띄우기 위한 함수를 호출합니다.
			viewServer(no);
		});
		
		$(document).on('click', '#m_heart > svg.m-heart1', function() {
			let no = $(this).attr('idx');
			console.log('모달창 클릭됨 ' + no);
			alert('모달창 하트 클릭');
		});
		
		// 로그인 한 상태에서 빈하트를 클릭했을 때 입니다.
		$(".card-heart > svg.heart1 ").click(function() {
			let no = $(this).attr('idx');
			console.log("빈하트 클릭" + no);
			saveHeart(no);
		});
		
		// 로그인 한 상태에서 꽉찬하트를 클릭했을 때 입니다.
		$(".card-heart > svg.heart2 ").click(function() {
			let no = $(this).attr('idx');
			console.log("꽉찬하트 클릭" + no);
			removeHeart(no);
		});
		
		// 로그인 안한 상태에서 하트를 클릭하면 로그인해야한다는 알림창이 뜹니다.
		$(".card-heart > svg.heart3 ").click(function() {
			alert('로그인 하셔야 하트를 누를수 있습니다!');
			
		});
		
		// view modal의 닫기 버튼(x)을 누르면 현재 스크롤 위치에서 페이지를 새로고침합니다.
		$(".btn-close").click(function(){
			
			// 현재 스크롤 위치에서 페이지를 새로고침하는 코드입니다.
			// 원래 페이지 새로고침 하는 코드 -> document.location.reload();
			document.location.reload(true);
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
	<section id="carousel-container" class="carousel-container">
		<div class="row">
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

	<!-- ======= Section ======= -->
	<section id="card-list" class="card-list">
		<div class="container">

			<div class="row card-list-container" data-aos="fade-up">

				<c:forEach var="tmp" items="${listTO.boardLists }">

					<div class="col-lg-4 col-md-6 card" id="myModal" style="width: 18rem;" >
						<div class="card-img" type="button" idx="${tmp.no }" data-bs-toggle="modal" data-bs-target="#viewModal">
							<img src="./upload/picture/${tmp.media }" class="card-img-top" alt="..." >
						</div>
						<div class="card-body">
							<div class="row">
								<div class="col-xsm card-title"> ${tmp.writer }</div>
								<div class="col-sm card-heart">
									<c:choose>
										<%-- 로그인 상태일때 - 하트 클릭 되게 --%>
										<c:when test="${not empty sessionScope.nick}">
											<c:choose>
												<c:when test="${empty tmp.hno}">
													<%-- 빈 하트일때 --%>
													<svg idx="${tmp.no }" class="heart1" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
						  							  <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
													</svg>
													
												</c:when>
												<c:otherwise>
													<%-- 꽉찬 하트일때 --%>
													<svg idx="${tmp.no }" class="heart2" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
													  <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/>
													</svg>
												</c:otherwise>
											</c:choose>
										</c:when>
										<%-- 로그인 상태가 아닐때  - 하트클릭 안되게 --%>
										<c:otherwise>
											<svg class="heart3" href="./picture_write.do" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
						  					  <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
											</svg>
										</c:otherwise>
									</c:choose>
									${tmp.heart }&nbsp;
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
										<path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" />
										<path d="M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z" />
									</svg>
									${tmp.reply }&nbsp;
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
										<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
										<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
									</svg>
									${tmp.hit }
								</div>
							</div>
						</div>
					</div>
					
					
					
				</c:forEach>


			</div>
		</div>
		
	<!-- Modal -->
	<div class="modal fade" id="viewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
	    	<div class="modal-header">
			    <h5 class="modal-title" id="m_subject"></h5>
			    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div>
					<span id="m_writer_profile" ></span><span id="m_writer"></span>
				</div>
				<div class="container" id="m_media">
				</div>
				<div id="m_heart">
				</div>
				<div id="m_content">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modifyModal">수정</button>
				<button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제</button>
			</div>
		    </div>
		</div>
	</div>


	</section>
	<!-- End Portfolio Section -->


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