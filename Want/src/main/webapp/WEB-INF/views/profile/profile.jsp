<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 내프로필</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/profile.css?dDDd" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">


</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="profile" name="thisPage" />
	</jsp:include>
	
	<section id="profile" class="container">
		<div class="row">
			<div class="col-6">
				<h1><b>내 프로필</b></h1>
			</div>
			<div class="col-6 div_modify_profile">
				<button type="button" class="btn btn--blue-2 btn--radius-2 btn_modify_profile">내 프로필 수정</button>
			</div>
		</div>
		
		<hr /><br />
		
		<div class="row">
			<div id="profile-img" class="section-title col-5">
				<img src="./upload/profile/${ uto.profile }" class="img-circle">
				<br />
			</div> <!-- profile-img 닫음 -->
			<div id="profile-info" class="col-7">
				<table>
					<tr>
						<th>이름</th>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>${ uto.name }</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>${ uto.nick }</td>
					</tr>
					<tr>
						<th>메일</th>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>${ uto.mail }</td>
					</tr>
					<tr>
						<th>가입일</th>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>${ uto.rdate }</td>
					</tr>
					<tr>
						<th>인사말</th>		
					</tr>
				</table>
				<br />
				<div id="greeting">
					<p id="greet">&nbsp;${ uto.greet }</p>
				</div>
			</div>	<!-- profile info 닫음 -->
		</div>	<!-- row 닫음 -->
	</section>
	
	

	<!-- 내 피드 섹션 -->
	<section id="my-feed" class="container">
		<div class="row">
			<div class="col-6">
				<h1><b>내 피드</b></h1>
			</div>
			<br />
			<div class="col-12">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="lan" data-bs-toggle="tab"
							data-bs-target="#lantrip" type="button" role="tab"
							aria-controls="home" aria-selected="true">랜선여행</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="pic" data-bs-toggle="tab"
							data-bs-target="#picture" type="button" role="tab"
							aria-controls="profile" aria-selected="false">사진자랑</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="sho" data-bs-toggle="tab"
							data-bs-target="#shop" type="button" role="tab"
							aria-controls="contact" aria-selected="false">쇼핑정보</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="acc" data-bs-toggle="tab"
							data-bs-target="#accom" type="button" role="tab"
							aria-controls="contact" aria-selected="false">숙소정보</button>
					</li>
				</ul>
			</div>
			<div class="tab-content" id="myTabContent">
				<div class="tab-pane fade show active" id="lantrip" role="tabpanel" aria-labelledby="home-tab">
				</div>
				<div class="tab-pane fade" id="picture" role="tabpanel" aria-labelledby="profile-tab">
				</div>
				<div class="tab-pane fade" id="shop" role="tabpanel" aria-labelledby="contact-tab">
				</div>
				<div class="tab-pane fade" id="accom" role="tabpanel" aria-labelledby="contact-tab">
				</div>
			</div>
		</div>

		

			
		
	</section>
	<!-- 내 피드 섹션 끝 -->	
	
<!-- 내 피드 관련 자바스크립트 -->
<script>
	
	//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
	let currentPage=1;
	//현재 페이지가 로딩중인지 여부를 저장할 변수이다.
	let isLoading=false;
	
	//currentPage는 무한스크롤에 필요한 현재 페이지
	//doName은 클릭한 게시판의 컨트롤러명
	//divName은 ajax로 받은 데이터를 append시킬 div명
	const GetList = function( currentPage, doName, divName ){
		console.log("inGetList의 페이지번호 : "+currentPage);
		//console.log( 'doName : ' + doName );
		//console.log( 'divName : ' + divName );
		
		//하트 컨트롤러 이름 만들어주기
		let heartUrl = 'lantrip';
		if( divName = 'lantrip' ) {
			break;
		} else if( divName = 'picture' ) {
			heartUrl = '';
		} else if( divName = 'shop' ) {
			heartUrl = 'shop_';
		} else if( divName = 'accom' ) {
			heartUrl = 'accom_';
		}
		
		$.ajax({
			url: doName,
			method:"GET",
			data:"pageNum="+currentPage,
			//ajax_page.jsp의 내용이 jspPage로 들어온다.
			success:function( jspPage ){
				//console.log(jspPage);
				//console.log( divName );
				//console.log( $('#'+divName ).attr('class')  );
				//응답된 문자열은 jsp 형식이다.(profile/게시판명_ajax_page.jsp에 응답내용이 있다.)
				//해당 문자열을 특정div 태그에 붙여준다.
				$( '#'+divName ).append(jspPage);
				//로딩바를 숨긴다.
				$(".back-drop").hide();
				//로딩중이 아니라고 표시한다.
				isLoading=false;
				console.log("ajax");
				
				// 로그인 한 상태에서 하트를 클릭했을 때 (로그인한 상태인 하트의 <a></a> class명: heart-click)
				$(".heart-click").unbind('click');
				$(".heart-click").click(function() {
				
					// 게시물 번호(no)를 idx로 전달받아 저장합니다.
					let no = $(this).attr('idx');
					console.log("heart-click");
					
					// 빈하트를 눌렀을때
					if($(this).children('svg').attr('class') == "bi bi-suit-heart"){
						console.log("빈하트 클릭" + no);
						
						$.ajax({
							url : heartUrl+'saveHeart.do',
							type : 'get',
							data : {
								no : no,
							},
							success : function(to) {
								//페이지 새로고침
								//document.location.reload(true);
								
								let heart = to.heart;
								
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
					} else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill"){
						console.log("꽉찬하트 클릭" + no);
						
						$.ajax({
							url : heartUrl+'removeHeart.do',
							type : 'get',
							data : {
								no : no,
							},
							success : function(to) {
								//페이지 새로고침
								//document.location.reload(true);
								
								let heart = to.heart;
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
					ReplyList( no, divName );
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
								ReplyList(no, divName);
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
	
	//맨처음 페이지 입장시 실행
	$(document).ready(function(){
		//현재페이지번호, 컨트롤러명, ajax결과 붙일 div태그명 넘겨준다.
		GetList( currentPage, "profile_lanTrip_ajax_page.do", "lantrip" );
	});
	
	// [댓글]
	// 게시물의 댓글 목록을 불러오는 함수입니다.
	const ReplyList = function( no, divName ) {
		
		$.ajax({
			url : divName+'_replyList.do',
			type : 'get',
			data : {
				no : no
			},
			success : function( jspPage ) {
				
				console.log("댓글 리스트 가져오기 성공");
				
				
				
				///////////// 동적으로 넣어준 html에 대한 이벤트 처리는 같은 함수내에서 다 해줘야한다.
				///////////// $(document).ready(function(){}); 안에 써주면 안된다.
				
				// 댓글 리스트 부분에 받아온 댓글 리스트를 넣기
				$(".reply-list"+no).html( jspPage );
				
				// 답글에서 답글달기를 누르면 input란에 "@답글작성자"가 들어간다.
				//$('.write_re_reply_start').on('click', function(){
				//	$('#input_rereply'+ $(this).attr('no')).val("@"+$(this).attr('writer')+" ");
				//});
				
				//답글을 작성한 후 답글달기 버튼을 눌렀을 때 그 click event를 아래처럼 jquery로 처리한다.
				$('button.btn.btn-success.mb-1.write_rereply').on( 'click', function() {
					console.log( 'no', $(this).attr('no') );
					console.log( 'bno', $(this).attr('bno') );
					let bno = $(this).attr('bno');
					let no = $(this).attr('no');
					
					
					// 답글을 DB에 저장하는 함수를 호출한다. bno와 no를 같이 넘겨주어야한다.
					WriteReReply( bno, no, divName );
				});
				
				// 삭제버튼을 클릭했을 때
				$('.reply_delete').on('click', function(){
					// 모댓글 삭제일때
					if($(this).attr('grpl') == 0){	
						DeleteReply($(this).attr('no'), $(this).attr('bno'));
					
					// 답글 삭제일때
					}else{
						DeleteReReply($(this).attr('no'), $(this).attr('bno'), $(this).attr('grp'));
					}
					
				})
				
				
			},
			error : function() {
				alert('서버 에러');
			}
		});
	};
	
	// 답글 달기 버튼 클릭시  실행 - 답글 저장, 댓글 갯수 가져오기
	const WriteReReply = function( bno, no, divName ) {
		
		console.log(bno);
		console.log(no);
		
		console.log($("#input_rereply" + no).val());
		
		// 댓글 입력란의 내용을 가져온다. 
		// ||"" 를 붙인 이유  => 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
		let content = $("#input_rereply" + no).val();
		content = content.trim();
		
		
		if(content == ""){	// 입력된게 없을때
			alert("글을 입력하세요!");
		}else{	
			// 입력란 비우기
			$("#input_rereply" + no).val("");
	
			// reply+1 하고 그 값을 가져옴
			$.ajax({
				url : divName+'_write_rereply.do',
				type : 'get',
				data : {
					no : no,
					bno : bno,
					content: content
				},
				success : function(to) {
					
					let reply = to.reply;
					// 페이지, 모달창에 댓글수 갱신
					$('#m_reply'+bno).text(reply);//
					$('#reply'+bno).text(reply);
					
					console.log("답글 작성 성공");
					
					// 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
					ReplyList( bno, divName );
				},
				error : function() {
					alert('서버 에러');
				}
			});
			
		};
	};
	
	
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
		
		//GetList 함수에 매개변수를 위해 active된 id값을 받아와서 매개변수를 지정해준다.
		let divName = $( '.tab-content' ).children( '.active' ).attr( 'id' );
		
		
		let ajaxDoName = '';
		switch( divName ) {
		case 'lantrip':
			ajaxDoName = 'profile_lanTrip_ajax_page.do';
			break;
		case 'picture':
			ajaxDoName = 'profile_picture_ajax_page.do';
			break;
		case 'shop':
			ajaxDoName = 'profile_shop_ajax_page.do';
			break;
		case 'accom':
			ajaxDoName = 'profile_accom_ajax_page.do';
			break;
		}
		
		if(isBottom) {
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
			
			
			//추가로 불러올 글목록 가져오기
			GetList( currentPage, ajaxDoName, divName );
			
		}; 
	});

	


</script>
	
	
	<br /><br /><br /><br />
</body>
</html>