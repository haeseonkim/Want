<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WANT 다른 프로필</title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/other_profile.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<!-- 메세지 전송 아이콘(종이비행기) 때문에 필요 -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
	type="text/css" rel="stylesheet" />

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
	<br />

	<div class="container bootstrap snippet">
		<div class="row">

			<div class="col-sm-3">
			
				<!--left col-->
				<div class="nick-div">
	               <h5><b><span style="color:#5fcf80;">${to.nick }</span>님의 프로필</b></h5>
	            </div>
				<div class="text-center center row">
					<div class="col-1"></div>
					<div class="col-10">
						<div class="box">
							<img src="./upload/profile/${to.profile }"
								class="avatar img-circle img-profile" alt="avatar">
						</div>
						<div class="messagesend-btn">
							<!-- 메세지 보내기 버튼 -->
							<button type="button" class="msg_send_btn_profile"
								data-bs-toggle="modal" data-bs-target="#exampleModal"
								onclick="javascript:MessageContentList('${to.nick}')">
								<i class='fa fa-paper-plane-o'></i>&nbsp;메세지 보내기
							</button>
						</div>
						<!-- 메세지 보내기 모달창 -->
						<!-- Modal -->
						<div class="modal fade" id="exampleModal" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-scrollable">
								<div class="modal-content">
									<div class="modal-header">
										<span id="m_writer_profile">
											<div class="message-box">
												<img id="messageProfileImage"
													src='./upload/profile/${to.profile }' />
											</div>
										</span>
										<h5 class="modal-title" id="exampleModalLabel">${to.nick }</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<!-- 메세지 내용 영역 -->
										<div class="mesgs">
											<!-- 메세지 내용 목록 -->
											<div class="msg_history" name="contentList">
												<!-- 메세지 내용이 올 자리 -->
											</div>
											<div class="send_message"></div>
											<!-- 메세지 입력란이 올자리 -->
											<div class='type_msg'>
												<div class='input_msg_write row'>
													<div class='col-11'>
														<input type='text' class='write_msg form-control'
															placeholder='메세지를 입력...' />
													</div>
													<div class='col-1'>
														<button class='msg_send_btn' type='button'
															onclick="javascript:SendMessage('${to.nick}')">
															<i class='fa fa-paper-plane-o' aria-hidden='true'></i>
														</button>
													</div>
												</div>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-1"></div>
				</div>
				<br>

				<ul class="list-group">
					<li class="list-group-item text-muted">PROFILE&nbsp;&nbsp;</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>ID&nbsp;&nbsp;</strong></span>
						<p>${to.id }</p></li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Eamil&nbsp;&nbsp;</strong></span>
						<p>${to.mail }</p></li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>BirthDay&nbsp;&nbsp;</strong></span>
						<p>${to.birth }</p></li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Introduction&nbsp;&nbsp;</strong></span>
						<p>${to.greet }</p></li>
				</ul>
				
			</div>

			<!--/col-3-->
			<div class="col-sm-9">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="lantrip-tab"
							data-bs-toggle="tab" data-bs-target="#lantrip" type="button"
							role="tab" aria-controls="home" aria-selected="true">랜선여행</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="picture-tab" data-bs-toggle="tab"
							data-bs-target="#picture" type="button" role="tab"
							aria-controls="profile" aria-selected="false">사진자랑</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="shopping-tab" data-bs-toggle="tab"
							data-bs-target="#shopping" type="button" role="tab"
							aria-controls="shopping" aria-selected="false">쇼핑정보</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="accom-tab" data-bs-toggle="tab"
							data-bs-target="#accom" type="button" role="tab"
							aria-controls="accom" aria-selected="false">숙소정보</button>
					</li>
				</ul>


				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="lantrip" role="tabpanel"
						aria-labelledby="lantrip-tab"></div>
					<div class="tab-pane fade" id="picture" role="tabpanel"
						aria-labelledby="picture-tab"></div>
					<div class="tab-pane fade" id="shopping" role="tabpanel"
						aria-labelledby="shopping-tab"></div>
					<div class="tab-pane fade" id="accom" role="tabpanel"
						aria-labelledby="accom-tab"></div>
				</div>

			</div>
			<!--/col-9-->
		</div>
		<!--/row-->
		

	</div>

	<script>
		// 현재 세팅된 tab이 뭔지 구분하기 위한 변수이다. 디폴트는 lantrip이다.
		let currentTab = "lantrip";
		//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
		let currentPage=1;
		//현재 페이지가 로딩중인지 여부를 저장할 변수이다.
		let isLoading=false;
		// 현재 프로필의 nick을 담는다.
		let otherNick = '${to.nick}';
		
		let heartTab = "";
		
		//페이지가 뒤로가기 하면 하트버튼과 하트수 갱신이 안된다. 이때 하트를 누르면 디비에 중복으로 값이 들어가진다.
		//방지하기 위해 페이지가 뒤로가기 할때마다 css로 클릭을 막고 새로고침을 통해 갱신된 하트버튼과 하트수가 나오도록 한다.
		$(window).bind("pageshow", function (event) {
		   //파이어폭스와 사파리에서는 persisted를 통해서 뒤로가기 감지가 가능하지만 익스와 크롬에서는 불가  ||뒤의 코드를 추가한다. 
		   if (event.originalEvent.persisted || (window.performance && window.performance.navigation.type == 2)) {
		      console.log('BFCahe로부터 복원됨');
		      $(".heart-click").css("pointer-events","none");
		      location.reload();//새로고침 
		   }
		   else {
		      console.log('새로 열린 페이지');
		   }
		});

		
		
		// 메세지 내역을 가져온다.
	    const MessageContentList = function(other_nick) {
			console.log(other_nick);

			$.ajax({
				url : "message_content_list_inprofile.do",
				method : "GET",
				data : {
					other_nick : other_nick,
				},
				success : function(data) {
					console.log("메세지 내용 가져오기 성공");
					console.log(data);

					// 메세지 내용을 html에 넣는다
					$('.msg_history').html(data);

					// 이 함수로 메세지 내용을 가져올때마다 스크롤를 맨아래로 가게 한다.
					$(".msg_history").scrollTop($(".msg_history")[0].scrollHeight);

				},
				error : function() {
					alert('서버 에러');
				}
			})
		};

		// 메세지를 전송하는 함수
		const SendMessage = function(other_nick) {
	
			let content = $('.write_msg').val();
			console.log(content);
	
			content = content.trim();
	
			if (content == "") {
				alert("메세지를 입력하세요!");
			} else {
				$.ajax({
					url : "message_send_inlist_inprofile.do",
					method : "GET",
					data : {
						other_nick : other_nick,
		                content : content
					},
					success : function(data) {
						console.log("메세지 전송 성공");
	
						// 메세지 입력칸 비우기
		                $('.write_msg').val("");
	
		                // 메세지 내용  리로드
		                MessageContentList(other_nick);
	
					},
					error : function() {
						alert('서버 에러');
					}
				});
			}
		};
		
		

		// 게시물 리스트를 가져오는 함수
		const GetList = function(currentPage){
			// 전역변수 초기화
			console.log("CurrentTab: " + currentTab);
			console.log("currentPage: "+ currentPage);
			console.log("otherNick: "+ otherNick);
			
			
			// 무한 스크롤
			$.ajax({
				url : "other_ajax_"+currentTab+"_page.do",
				method : "GET",
				//검색기능이 있는 경우 condition과 keyword를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른것들이 덧붙여져 나온다.
				data : {
					pageNum: currentPage,
					other_nick: otherNick
				},
				//ajax_page.jsp의 내용이 data로 들어온다.
				success:function(data){
					//console.log(data);
					//응답된 문자열은 html 형식이다.(picture/ajax_page.jsp에 응답내용이 있다.)
					//해당 문자열을 .card-list-container  div에 html로 해석하라고 추가한다.
					$("#"+currentTab).append(data);
					//로딩바를 숨긴다.
					$(".back-drop").hide();
					//로딩중이 아니라고 표시한다.
					isLoading=false;
					console.log("ajax");
					
					$('.list-video').mouseover(function(){
					    $(this).get(0).play();
					}).mouseout(function(){
					    $(this).get(0).pause();
					});
					
					
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
								url : heartTab+'saveHeart.do',
								type : 'get',
								data : {
									no : no,
								},
								success : function(to) {
									//페이지 새로고침
									//document.location.reload(true);
									
									let heart = to.heart;
									
									console.log("heart는? " + heart);
									
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
							//$('.heart_icon'+no).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
							
						// 꽉찬 하트를 눌렀을 때
						}else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill"){
							console.log("꽉찬하트 클릭" + no);
							
							$.ajax({
								url : heartTab+'removeHeart.do',
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
							
							//$('.heart_icon'+no).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
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
						
						console.log("no: " + no);
						//책갈피
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
								url : 'other_'+currentTab+'_write_reply.do',
								type : 'get',
								data : {
									no : no,
									content: content
								},
								success : function(to) {
									
									let reply = to.reply;
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
				} // success 끝
				
			});	// ajax 끝
		}
		
		// [댓글]
		// 게시물의 댓글 목록을 불러오는 함수입니다.
		const ReplyList = function(no) {
			$.ajax({
				url : 'other_'+currentTab+'_replyList.do',
				type : 'get',
				data : {
					no : no
				},
				success : function(data) {
					
					console.log("댓글 리스트 가져오기 성공");
					
					// 댓글 목록을 html로 담기
					let listHtml = "";
					for(const i in data){
						let no = data[i].no;
						let bno = data[i].bno;
						let grp = data[i].grp;
						let grps = data[i].grps;
						let grpl = data[i].grpl;
						let writer = data[i].writer;
						let content = data[i].content;
						let wdate = data[i].wdate;
						let wgap = data[i].wgap;
						let profile = data[i].profile;
						
						console.log(grpl);	// 모댓글일땐 0, 답글일땐 1
						
						listHtml += "<div class='row replyrow reply" + no + "'>";
						
						if(content == ""){		// 삭제된 댓글일때
							listHtml += "	<div>";
							listHtml += "		(삭제된 댓글입니다)";
							listHtml += "	</div>";
						}else{
							if(grpl == 0){	// 모댓글일때
								listHtml += "	<div class='col-1'>";
								listHtml += "		<img class='reply_list_profileImage' src='./upload/profile/"+ profile +"'/>";
								listHtml += "	</div>";
								listHtml += "	<div class='rereply-content col-8'>";
								listHtml += "		<div>";
								listHtml += "			<span>";
								listHtml += "				<b>"+ writer +"</b>";
								listHtml += "			</span>";
								listHtml += "			<span>";
								listHtml += 				content;
								listHtml += "			</span>";
								listHtml += "		</div>";
								// 현재 로그인 상태일때 답글작성 버튼이 나온다.
								if("${nick}" != ""){
									listHtml += "		<div>";
									// 함수에 게시글번호(bno), 모댓글번호(no), 모댓글 작성자(writer)를 인자로 담아서 넘긴다.
									// 이때 모댓글 작성자 writer는 string인데 string을 인자에 넣기 위해선''나""로 감싸줘야한다.
									// 여기선 ''와 ""가 이미 둘다 쓰이고 있는데  href를 감싸고 있는 ''와 겹치지 않는 ""를 \" 처리해서 넣어줬다.
									listHtml += "			<a href='#' class='write_reply_start' data-bs-toggle='collapse' data-bs-target='#re_reply"+ no +"' aria-expanded='false' aria-controls='collapseExample'>답글&nbsp;달기</a>";
									listHtml += "		</div>";
								}
								listHtml += "	</div>";
							
							}else{	// 답글일때
								listHtml += "	<div class='col-1'>"
								listHtml += "	</div>"
								listHtml += "	<div class='col-1'>";
								listHtml += "		<img class='reply_list_profileImage' src='./upload/profile/"+ profile +"'/>";
								listHtml += "	</div>";
								listHtml += "	<div class='rereply-content"+ no +" col-7'>";
								listHtml += "		<div>";
								listHtml += "			<span>";
								listHtml += "				<b>"+ writer +"</b>";
								listHtml += "			</span>";
								listHtml += "			<span>";
								listHtml += 				content;
								listHtml += "			</span>";
								listHtml += "		</div>";
								
								listHtml += "	</div>";
							}
							
							listHtml += "	<div class='col-3 reply-right'>";
							listHtml += "		<div>";
							listHtml += 			wdate;
							listHtml += "		</div>";
							// 책갈피
							// 현재 로그인 상태이고..
							if("${nick}" != ""){
								
								//현재 사용자가 이 댓글의 작성자일때 삭제 버튼이 나온다.
								if("${nick}" == writer){
									listHtml += "		<div>";
									// 수정할 댓글의 no를 grpl과 함께 넘긴다. 
									// 모댓글 수정칸과 답글 수정칸을 화면에 다르게 나타내야하기 때문에 모댓글과 답글을 구분하는 grpl을 함께 넘겨주어야한다.
									//listHtml += "			<a href='javascript:' no='"+ no +"' grpl='"+ grpl +"' class='reply_modify'>수정</a>";
									//listHtml += "			&nbsp;|&nbsp;";
									// 삭제는 no만 넘겨주면 된다.
									listHtml += "			<a href='javascript:' no='"+ no +"' grpl='"+ grpl + "' bno='"+ bno +"' grp='"+ grp +"' class='reply_delete'>삭제</a>";
									listHtml += "		</div>";
								}
							}

							listHtml += "	</div>";
							// 댓글에 답글달기를 누르면 답글입력란이 나온다.
							// ---- 답글입력란
							listHtml += "	<div class='collapse row rereply_write' id='re_reply"+ no +"'>";
							listHtml += "		<div class='col-1'>"
							listHtml += "		</div>"
							listHtml += "		<div class='col-1'>"
							listHtml += "			<img id='write_reply_profileImage' src='./upload/profile/${profile}'/>"
							listHtml += "		</div>"
							listHtml += "		<div class='col-7'>"
							listHtml +=  "  		<input class='w-100 input_rereply_div form-control' id='input_rereply"+ no +"' type='text' placeholder='댓글입력...'>"
							listHtml += "		</div>"
							listHtml += "		<div class='col-3'>"
							// 답글달기 버튼이 눌리면 모댓글 번호(no)와 게시물번호(bno)를 함수에 전달한다.
							
							// 동적으로 넣은 html태그에서 발생하는 이벤트는 동적으로 처리해줘야한다 !!!!!
							// 예를들어, 동적으로 넣은 html태그에서 발생하는 click 이벤트는 html태그 안에서 onclick으로 처리하면 안되고, jquery에서 클래스명이나 id값으로 받아서 처리하도록 해야한다.
							// 아래코드를 보자~~~~
							// listHtml += "			<button onclick='javascript:WriteReReply("+ no +","+ bno +")' type='button' class='btn btn-success mb-1 write_rereply' >답글&nbsp;달기</button>"
							// 위 코드는 클릭되어도 값이 넘겨지지 않는다. 값이 undefined가 된다.
							// 아래코드처럼 짜야한다. click이벤트를 처리하지 않고 데이터(no, bno)만 속성으로 넘겨주도록 작성한다.
							listHtml += "			<button type='button' class='btn btn-success mb-1 write_rereply' no='" + no + "' bno='" + bno + "'>답글&nbsp;달기</button>"
							listHtml += "		</div>";
							listHtml += "	</div>";
							// ---- 답글입력란 끝
						}
						
						listHtml += "</div>";
			
						
					};
					
					///////////// 동적으로 넣어준 html에 대한 이벤트 처리는 같은 함수내에서 다 해줘야한다.
					///////////// $(document).ready(function(){}); 안에 써주면 안된다.
					
					// 댓글 리스트 부분에 받아온 댓글 리스트를 넣기
					$(".reply-list"+no).html(listHtml);
					
					// 답글에서 답글달기를 누르면 input란에 "@답글작성자"가 들어간다.
					//$('.write_re_reply_start').on('click', function(){
					//	$('#input_rereply'+ $(this).attr('no')).val("@"+$(this).attr('writer')+" ");
					//});
					
					//답글을 작성한 후 답글달기 버튼을 눌렀을 때 그 click event를 아래처럼 jquery로 처리한다.
					$('button.btn.btn-success.mb-1.write_rereply').on( 'click', function() {
						console.log( 'no', $(this).attr('no') );
						console.log( 'bno', $(this).attr('bno') );
						
						// 답글을 DB에 저장하는 함수를 호출한다. bno와 no를 같이 넘겨주어야한다.
						WriteReReply($(this).attr('bno'), $(this).attr('no') );
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
		const WriteReReply = function(bno,no) {
			
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
					url : 'other_'+currentTab+'_write_rereply.do',
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
						ReplyList(bno);
					},
					error : function() {
						alert('서버 에러');
					}
				});
				
			};
		};
		
		// 모댓글 삭제일때
		const DeleteReply = function(no, bno){
			// grp이 no인 댓글이 있는 경우 content에 null을 넣고 없으면 삭제한다.
			$.ajax({
				url : 'other_'+currentTab+'_delete_reply.do',
				type : 'get',
				data : {
					no : no,
					bno : bno
				},
				success : function(to) {
					
					let reply = to.reply;
					
					// 페이지, 모달창에 댓글수 갱신
					$('#m_reply'+bno).text(reply);
					$('#reply'+bno).text(reply);
					
					console.log("모댓글 삭제 성공");
					
					// 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
					ReplyList(bno);
				},
				error : function() {
					alert('서버 에러');
				}
			});
		};
		
		// 답글 삭제일때
		const DeleteReReply = function(no, bno, grp){
			
			//console.log("grp : " + grp);
			
			// 답글을 삭제한다.
			$.ajax({
				url : 'other_'+currentTab+'_delete_rereply.do',
				type : 'get',
				data : {
					no : no,
					bno : bno,
					grp : grp
				},
				success : function(to) {
					
					let reply = to.reply;
					
					// 페이지, 모달창에 댓글수 갱신
					$('#m_reply'+bno).text(reply);
					$('#reply'+bno).text(reply);
					
					console.log("답글 삭제 성공");
					
					// 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
					ReplyList(bno);
				},
				error : function() {
					alert('서버 에러');
				}
			});
			
		};
		
		
		$(document).ready(function(){
			GetList(currentPage);
		});
		

		// 창 크기가 변할 때마다 가로세로 길이를 맞춰준다.
		$(window).resize(function(){
			$('.box').each(function(){
				$(this).height($(this).width());
			});
			$('.video-box').each(function(){
				$(this).height($(this).width());
			});
			$('.message-box').each(function(){
				$(this).height($(this).width());
			});
		}).resize();
		
		//웹브라우저의 창을 스크롤 할 때 마다 호출되는 함수 등록
		$(window).on("scroll",function(){
			
			console.log("scroll 함수 안에서 currentPage: " + currentPage);
			
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
				if(currentPage == '${totalPageCount}' || isLoading){
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
		
		
		
		$("#lantrip-tab").on('click', function() {
			$("#lantrip").empty();
			$("#picture").empty();
			$("#shopping").empty();
			$("#accom").empty();
			currentTab = "lantrip";
			currentPage = 1;
			heartTab = "lanTrip_";
			GetList(currentPage);
			//alert("lantrip-tab 클릭" );
		})

		$("#picture-tab").on('click', function() {
			$("#lantrip").empty();
			$("#picture").empty();
			$("#shopping").empty();
			$("#accom").empty();
			currentTab = "picture";
			currentPage = 1;
			GetList(currentPage);
			//alert("picture-tab 클릭");
		})

		$("#shopping-tab").on('click', function() {
			$("#lantrip").empty();
			$("#picture").empty();
			$("#shopping").empty();
			$("#accom").empty();
			currentTab = "shopping";
			currentPage = 1;
			heartTab="shop_";
			GetList(currentPage);
			//alert("shopping-tab 클릭");
		})

		$("#accom-tab").on('click', function() {
			$("#lantrip").empty();
			$("#picture").empty();
			$("#shopping").empty();
			$("#accom").empty();
			currentTab = "accom";
			currentPage = 1;
			heartTab = "accom_";
			GetList(currentPage);
			//alert("accom-tab 클릭");
		})
	</script>

</body>
</html>