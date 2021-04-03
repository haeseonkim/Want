<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 보기</title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/other_profile.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">


</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="other_profile" name="thisPage" />
	</jsp:include>

	<br />
	<br />
	<br />
	<br />

	<div class="container bootstrap snippet">
		<div class="row">
			
			<div class="col-sm-3">
				<!--left col-->


				<div class="text-center">
					<div class="box">
						<img src="./upload/profile/${to.profile }" class="avatar img-circle img-profile" alt="avatar">
					</div>
					<h4>${to.nick }</h4>
				</div>
				<br>

				<ul class="list-group">
					<li class="list-group-item text-muted">PROFILE <i
						class="fa fa-dashboard fa-1x"></i></li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>ID</strong></span>
						${to.id }</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Eamil</strong></span>
						${to.mail }</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>BirthDay</strong></span>
						${to.birth }</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Introduction</strong></span>
						${to.greet }</li>
				</ul>

			</div>
			<!--/col-3-->
			<div class="col-sm-9">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
							data-bs-target="#lantrip" type="button" role="tab"
							aria-controls="home" aria-selected="true">랜선여행</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
							data-bs-target="#picture" type="button" role="tab"
							aria-controls="profile" aria-selected="false">사진자랑</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#shopping" type="button" role="tab"
							aria-controls="contact" aria-selected="false">쇼핑정보</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#accom" type="button" role="tab"
							aria-controls="contact" aria-selected="false">숙소정보</button>
					</li>
				</ul>


				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="lantrip" role="tabpanel" aria-labelledby="home-tab">
					</div>
					<div class="tab-pane fade" id="picture" role="tabpanel" aria-labelledby="profile-tab">
					</div>
					<div class="tab-pane fade" id="shopping" role="tabpanel" aria-labelledby="contact-tab">
					</div>
					<div class="tab-pane fade" id="accom" role="tabpanel" aria-labelledby="contact-tab">
					</div>
				</div>

			</div>
			<!--/col-9-->
		</div>
		<!--/row-->

	</div>
	
	<script>
	
	//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
	let currentPage=1;
	//현재 페이지가 로딩중인지 여부를 저장할 변수이다.
	let isLoading=false;
	
	const GetList = function(currentPage){
		console.log("inGetList"+currentPage);
		
		$.ajax({
			url:"lanTrip_ajax_page.do",
			method:"GET",
			//검색기능이 있는 경우 condition과 keyword를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른것들이 덧붙여져 나온다.
			data:"pageNum="+currentPage+"&condition=${condition}&keyword=${keyword}",
			//ajax_page.jsp의 내용이 data로 들어온다.
			success:function(data){
				console.log(data);
				//응답된 문자열은 html 형식이다.(picture/ajax_page.jsp에 응답내용이 있다.)
				//해당 문자열을 .card-list-container  div에 html로 해석하라고 추가한다.
				$(".card-list-container").append(data);
				//로딩바를 숨긴다.
				$(".back-drop").hide();
				//로딩중이 아니라고 표시한다.
				isLoading=false;
				console.log("ajax");
				
				$(".heart-click").unbind('click');
				// 로그인 한 상태에서 하트를 클릭했을 때 (로그인한 상태인 하트의 <a></a> class명: heart-click)
				$(".heart-click").click(function() {
				
					// 게시물 번호(no)를 idx로 전달받아 저장합니다.
					let no = $(this).attr('idx');
					console.log("heart-click");
					
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
								
								// 페이지, 모달창에 하트수 갱신
								$('#m_heart'+no).text(heart);
								$('#heart'+no).text(heart);
								
								console.log("하트추가 성공");
							},
							error : function() {
								alert('서버 에러');
							}
						});
						console.log("꽉찬하트로 바껴라!");
						
						// 꽉찬하트로 바꾸기
						$(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
						$('.heart_icon'+no).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
						
					// 꽉찬 하트를 눌렀을 때
					}else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill"){
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
								// 페이지, 모달창에 하트수 갱신
								$('#m_heart'+no).text(heart);
								$('#heart'+no).text(heart);
								
								console.log("하트삭제 성공");
							},
							error : function() {
								alert('서버 에러');
							}
						});
						console.log("빈하트로 바껴라!");
						
						// 빈하트로 바꾸기
						$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
						
						$('.heart_icon'+no).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
					}
					
					

				});
				
				
				// 로그인 안한 상태에서 하트를 클릭하면 로그인해야한다는 알림창이 뜹니다.
				// (로그인한 상태인 하트의 <a></a> class명: heart-notlogin)
				$(".heart-notlogin").unbind('click');
				$(".heart-notlogin ").click(function() {
					alert('로그인 하셔야 하트를 누를수 있습니다!');
				});
				
				
				// 댓글아이콘을 클릭했을때 댓글 리스트 함수를 호출
				$(".open_reply_list").unbind('click');
				$(".open_reply_list").click(function(){
					let no = $(this).attr('idx');
					// 게시물에 no에 해당하는 댓글 리스트를 가져오는 함수	
					ReplyList(no);
				});
				
				// 댓글 달기 버튼 클릭시  실행
				$(".write_reply").unbind('click');
				$(".write_reply").click(function(){
					// 게시물 번호
					let no = $(this).attr('idx');
					
					// 댓글 입력란의 내용을 가져온다.
					let content = $("#input_reply" + no).val();
					
					// 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
					content = content.trim();
					
					console.log(content);
					
					if(content == ""){	// 입력된게 없을때
						alert("글을 입력하세요!");
					}else{	
						// 입력란 비우기
						$("#input_reply" + no).val("");
						
						// reply+1 하고 그 값을 가져옴
						$.ajax({
							url : 'picture_write_reply.do',
							type : 'get',
							data : {
								no : no,
								content: content
							},
							success : function(pto) {
								
								let reply = pto.reply;
								// 페이지, 모달창에 댓글수 갱신
								$('#m_reply'+no).text(reply);
								$('#reply'+no).text(reply);
								
								console.log("댓글 작성 성공");
								
								// 댓글리스트를 새로 받아오기
								ReplyList(no);
							},
							error : function() {
								alert('서버 에러');
							}
						});
						
					}
					
				});
			}
			
		});
	}

	
	//웹브라우저의 창을 스크롤 할 때 마다 호출되는 함수 등록
	$(window).on("scroll",function(){
		//위로 스크롤된 길이
		let scrollTop=$(window).scrollTop();
		//웹브라우저의 창의 높이
		let windowHeight=$(window).height();
		//문서 전체의 높이
		let documentHeight=$(document).height();
		//바닥까지 스크롤 되었는 지 여부를 알아낸다.
		let isBottom=scrollTop+windowHeight + 10 >= documentHeight;
		
		if(isBottom){
			//만일 현재 마지막 페이지라면
			if(currentPage == ${totalPageCount} || isLoading){
				return; //함수를 여기서 끝낸다.
			}
			//현재 로딩 중이라고 표시한다.
			isLoading=true;
			//로딩바를 띄우고
			$(".back-drop").show();
			//요청할 페이지 번호를 1 증가시킨다.
			currentPage++;
			//추가로 받아올 페이지를 서버에 ajax 요청을 하고
			console.log("inscroll"+currentPage);
			GetList(currentPage);
			
		}; 
	});
	
	
	$(document).ready(function(){
		LanTripList();
	});

	
	</script>

</body>
</html>