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

	<div class="container bootstrap snippet">
		<div class="row">

			<div class="col-sm-3">
				<!--left col-->

				<div class="text-center">
					<div class="box">
						<img src="./upload/profile/${to.profile }"
							class="avatar img-circle img-profile" alt="avatar">
					</div>
					<h4>${to.nick }</h4>
					<div>
						<!-- 메세지 보내기 버튼 -->
						<button type="button" class="msg_send_btn_profile" data-bs-toggle="modal"
							data-bs-target="#exampleModal" onclick="javascript:MessageContentList('${to.nick}')">
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
											<img id="messageProfileImage" src='./upload/profile/${to.profile }' />
										</div>
									</span>
									<h5 class="modal-title" id="exampleModalLabel">${to.nick }</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
													<input type='text' class='write_msg form-control' placeholder='메세지를 입력...' />
												</div>
												<div class='col-1'>
													<button class='msg_send_btn' type='button' onclick="javascript:SendMessage('${to.nick}')"><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>
												</div>
											</div>
										</div>
			          
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<br>

				<ul class="list-group">
					<li class="list-group-item text-muted">PROFILE&nbsp;&nbsp;</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>ID&nbsp;&nbsp;</strong></span>
						${to.id }</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Eamil&nbsp;&nbsp;</strong></span>
						${to.mail }</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>BirthDay&nbsp;&nbsp;</strong></span>
						${to.birth }</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Introduction&nbsp;&nbsp;</strong></span>
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
					<div class="tab-pane fade show active" id="lantrip" role="tabpanel"
						aria-labelledby="home-tab"></div>
					<div class="tab-pane fade" id="picture" role="tabpanel"
						aria-labelledby="profile-tab"></div>
					<div class="tab-pane fade" id="shopping" role="tabpanel"
						aria-labelledby="contact-tab"></div>
					<div class="tab-pane fade" id="accom" role="tabpanel"
						aria-labelledby="contact-tab"></div>
				</div>

			</div>
			<!--/col-9-->
		</div>
		<!--/row-->

	</div>

	<script>
		// 읽지 않은 메세지들을 읽음으로 바꾼다.
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
					$(".msg_history").scrollTop(
							$(".msg_history")[0].scrollHeight);

				},
				error : function() {
					alert('서버 에러');
				}
			})
		};
		
		// 메세지를 전송하는 함수
		const SendMessage = function(other_nick){
			
			let content = $('.write_msg').val();
			console.log(content);
			
			content = content.trim();
			
			if(content == ""){
				alert("메세지를 입력하세요!");
			}else{
				$.ajax({
					url:"message_send_inlist_inprofile.do",
					method:"GET",
					data:{
						other_nick: other_nick,
						content: content
					},
					success:function(data){
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
		
		
	</script>

</body>
</html>