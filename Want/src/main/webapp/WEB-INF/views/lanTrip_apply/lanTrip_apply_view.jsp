<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="com.exam.model1.lantripApply.LanTripApplyTO"%>
<%@ page import="com.exam.model1.lantripApply.LanTripApplyDAO"%>

<%@page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding("utf-8");
String cpage = request.getParameter("cpage");

LanTripApplyTO to = (LanTripApplyTO) request.getAttribute("to");

String no = to.getNo();
String subject = to.getSubject();
String content = to.getContent().replaceAll("\n", "<br />");
String writer = to.getWriter();
String wdate = to.getWdate();
String hit = to.getHit();
String location = to.getLocation();
String picture = to.getPicture();
String reply = to.getReply();

/* ArrayList<CommentTO> lists = (ArrayList)request.getAttribute( "lists" );
StringBuffer sbHtml = new StringBuffer();

for( CommentTO commentTo : lists ) {
	sbHtml.append( "<table>" );
	sbHtml.append( "	<tr>" );
	sbHtml.append( "	<td class='coment_re' width='20%'>" );
	sbHtml.append( "		<strong>"+ commentTo.getWriter() +"</strong> ("+ commentTo.getWdate() +")" );
	sbHtml.append( "		<div class='coment_re_txt'>" );
	sbHtml.append( "			"+ commentTo.getContent() +"" );
	sbHtml.append( "		</div>" );
	sbHtml.append( "	</td>" );
	sbHtml.append( "</tr>" );
	sbHtml.append( "</table>" ); 
} */
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, intial-scale=1.0">
<title><%=subject%></title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/lanTrip_apply_view.css?1"
	rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">
<style type="text/css">
</style>
</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_apply_list" name="thisPage" />
	</jsp:include>

	<br />
	<br />
	<br />

	<section id="info" class="container" style="margin-top: 100px;">
		<table class="table table-hover" id='board_list'>
			<thead>
				<div id="lanTrip_apply_header" class="align-middle">
					<br />
					<div id="header-title" class="fs-1 d-block">
						<b>랜선여행 신청하기</b>
					</div>
					<span id="header-sub" class="fs-6">원하는 랜선여행을 신청하세요!</span>
				</div>
				<tr>
					<td id="location" class="text-left d-none d-md-table-cell">
						<b>[<%=location%>]</b>
					</td>
				</tr>
				<tr>
					<td id="no" class="text-center d-none d-sm-table-cell"><%=no%></td>
					<td id="subject" class="text-center"><b><%=subject%></b></td>
					<td id="writer" class="text-center d-none d-md-table-cell"><%=writer%></td>
					<td id="wdate" class="text-center d-none d-md-table-cell"><%=wdate%></td>
					<td id="hit" class="text-center d-none d-md-table-cell"><%=hit%></td>
				</tr>
			</thead>
		</table>
	</section>
	<section id="content" class="container">
		<div class="form-group" style="margin-top: 20px;">
			<div id="board_content" name="board_content" class="form-control"
				rows="5" style="resize: none" disabled="disabled"><%=content%></div>
		</div>
	</section>
	<section id="section-picture" class="container">
		<div class="picture">
			<img src="./upload/lanTrip_apply/<%=picture%>" width="600px"></img>
		</div>
	</section>
<!-- 본문 끝 -->

<!-- 댓글 시작 -->
	<section class="container" style="margin-top: 10px;">
		<form id="commentForm" name="commentForm" method="post">
			<br /> <br /> <br />
			<div>
				<div class="cmt">
					<span><strong>댓글 <span id="count_reply" style="color: #5fcf80;"><%=reply %></span></strong></span>
				</div>
				<div class='reply-list'>
					<!-- ajax로 list 불러오기 -->
				</div>
				<div>
					<table class="table">
						<tr>
							<td><textarea style="width: 86%" rows="3" cols="50"
									id="comment" name="comment" placeholder="&nbsp;댓글을 입력하세요"></textarea>
								<div class="row">
									<div class="col-11"></div>
									<div id="btn_comment" class="col-1">
									<c:choose>
										<c:when test="${empty sessionScope.nick }">
											<button type='button' 
												class='btn btn--radius-2 btn--blue-2 btn-md false' 
												onclick="javascrip:alert('로그인을 하셔야합니다.')">댓글등록</button>
										</c:when>
										<c:otherwise>
											<button type='button' 
												class='btn btn--radius-2 btn--blue-2 btn-md write_reply' 
												no="<%=no %>">댓글등록</button>
										</c:otherwise>
									</c:choose>

									</div>
									<!-- form태그로 배꿔야됨 -->
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
		

		<div id="btn_buttons">
			<span>
				<button class="btn btn--radius-2 btn-sm btn--silver" type="button"
					onclick="location.href='./lanTrip_apply_list.do'">목록</button> <!-- 로그인이 되어있고 작성자가 같을 때만 수정과 삭제버튼이 보이게 한다. -->
				<c:if test="${to.writer eq sessionScope.nick }">
					<button class="btn btn--radius-2 btn--silver btn-sm" type="button"
						data-bs-toggle="modal" data-bs-target=".bs-modify-modal-sm">수정</button>
					<button class="btn btn--radius-2 btn--silver btn-sm" type="button"
						data-bs-toggle="modal" data-bs-target=".bs-delete-modal-sm">삭제</button>
				</c:if> 
				<span> 
					<c:choose>
						<c:when test="${empty sessionScope.nick}">
							<button type="button"
								class="btn btn--radius-2 btn--blue-2 btn-md"
								onclick="javascript:alert('로그인을 하셔야합니다.')">신청하기</button>
						</c:when>
						<c:otherwise>
							<button type="button"
								class="btn btn--radius-2 btn--blue-2 btn-md"
								onclick="location.href='./lanTrip_apply_write.do?cpage=<%=cpage%>'">신청하기</button>
						</c:otherwise>
					</c:choose>
			</span>
			</span>
		</div>

		<div class="modal fade bs-delete-modal-sm" tabindex="-1" role="dialog"
			aria-labelledby="mySmallModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm">


				<div class="modal-content">
					<br />
					<div style="height: 60px;">&nbsp;&nbsp;정말 삭제하시겠습니까?</div>

					<div class="modal-footer">
						<button type="button" class="btn btn--silver"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn--blue-2"
							onclick="location.href='./lanTrip_apply_delete_ok.do?no=<%=request.getParameter("no")%>'">삭제</button>
					</div>
				</div>

			</div>
		</div>

		<div class="modal fade bs-modify-modal-sm" tabindex="-1" role="dialog"
			aria-labelledby="mySmallModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm">


				<div class="modal-content">
					<br />
					<div style="height: 60px;">&nbsp;&nbsp;정말 수정하시겠습니까?</div>
					<div class="modal-footer">
						<button type="button" class="btn btn--silver"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn--blue-2"
							onclick="location.href='./lanTrip_apply_modify.do?no=<%=request.getParameter("no")%>'">수정</button>
					</div>
				</div>

			</div>
		</div>

	</section>

	<!-- 댓글 시작 -->
<script type="text/javascript">

	const ReplyList = function(no) {
		$.ajax({
			url : 'la_replyList.do',
			type : 'get',
			data: {
				no : no
			},
			success : function(data) {
				console.log("댓글리스트 가져오기 성공");
				
				let listHtml ="";
				for(const i in data){
					let no = data[i].no;			// 댓글번호
					let bno = data[i].bno;			// 게시물번호
					let grp = data[i].grp;			// 모댓글no
					let grps = data[i].grps;		// 같은 모댓글 내의 대댓글 순서 (0부터 시작)
					let grpl = data[i].grpl;		// 모댓글인지 대댓글인지
					let writer = data[i].writer;	
					let content = data[i].content;	
					let wdate = data[i].wdate;		
					let wgap = data[i].wgap;		
					let profile = data[i].profile;
					
					console.log(grpl); // 0 : 모댓글, 1 : 답글
					
					listHtml += "<div class='row reply"+no+"'>";
					
					if(content == ""){	// 삭제된 댓글일 때
						listHtml += "<div style='color:silver;'>";
						listHtml += "	(삭제된 댓글입니다.)";
						listHtml += "</div>";
					} else {
						if(grpl == 0 ){	// 모댓글일 때
							listHtml += "	<div class='col-1 profile_img'>";
							listHtml += "		<img class='cmt_profile img-circle' src='./upload/profile/"+profile+"'/>";
							listHtml += "	</div>";
							listHtml += "	<div class='col-10'>";
							listHtml += "		<h6>";
							listHtml += "			<b>"+writer+"</b>";
							listHtml += "		</h6>";
							listHtml += "		<div>";
							listHtml += 			content;
							listHtml += "		</div>";
							listHtml += "		<div class='rereply_box'>";	
							listHtml += "			<span class='cdate'>"+wdate+"</span>";
							

							// 로그인상태일 때 답글작성 버튼이 나온다.
							if("${nick}"!=""){
								listHtml += "&nbsp;&nbsp;";
								listHtml += "		<span>";
								listHtml += "			<button type='button' class='btn_rereply' data-bs-toggle='collapse' data-bs-target='#re_reply"+ no +"' aria-expanded='false' aria-controls='collapseExample'>답글쓰기</button>";
								listHtml += "		</span>";
							}
						}else {	// 답글일 때
							// row rereply 줄까말까 고민중
							listHtml += "	<div class='col-1 space'></div>";
							listHtml += "	<div class='col-1 profile_img'>";
							listHtml += "		<img class='cmt_profile img-circle' src='./upload/profile/"+profile+"'/>";
							listHtml += "	</div>";
							listHtml += "	<div class='col-10 rereply-content"+no+"'>";
							listHtml += "		<h6>";
							listHtml += "			<b>"+writer+"</b>";
							listHtml += "		</h6>";
							listHtml += "		<div>";
							listHtml += 			content;
							listHtml += "		</div>";
							listHtml += "		<div class='rereply_box'>";
							listHtml += "			<span class='cdate'>"+wdate+"</span>";
							listHtml += "		</div>";
						}
						// 현재 로그인 상태이고
						if("${nick}"!=""){
							// 사용자 = 작성자일 때
							if("${nick}"== writer ){
								listHtml += "|";
								listHtml += "		<span class='rereply_box'>";
								listHtml += "			<button type='button' no='"+no+"' grpl='"+grpl+"' bno='"+bno+"' grp='"+grp+"' class='btn_rdelete'>삭제</button>";
								listHtml += "		</span>";
//								listHtml += "	</div>";
								listHtml += "</div>";	// 168번 닫음
							}
						}
						listHtml += "	</div>";	//	153번 닫음
						// 답글달기 답글입력란
						listHtml += "	<div class='collapse' id='re_reply"+no+"'>";
						listHtml += "		<table class='table'>";
						listHtml += "			<tr>";
						listHtml += "				<td>";
						listHtml += "					<textarea style='width:86%' rows='3' cols='50' id='comment' placeholder='&nbsp;댓글을 입력하세요'></textarea>";
						listHtml += "					<div class='row'>";
						listHtml += "						<div class='col-11'></div>";
						listHtml += "						<div id='btn_comment' class='col-1'>";
						listHtml += "							<button type='button' class='btn btn--radius-2 btn--blue-2 btn-md write_rereply' no='"+no+"' bno='"+bno+"'>답글등록</button>";
						listHtml += "						</div>";
						listHtml += "					</div>";
						listHtml += "				</td>";
						listHtml += "			</tr>";
						listHtml += "		</table>";
						listHtml += "	</div>";
						// 답글입력란 끝
						}
						listHtml += "</div>";
					};
					
					// listHtml 출력
					$(".reply-list").html(listHtml);
					 
					$('button.btn.btn--radius-2.btn--blue-2.btn-md.write_rereply').on('click', function(){
						console.log('no', $(this).attr('no') );
						console.log('bno', $(this).attr('bno') );
						
						writeReReply($(this).attr('bno'), $(this).attr('no') );
					});
					
					$('.btn_rdelete').on('click', function(){
						// 모댓글 삭제
						if($(this).attr('grpl') == 0){
							DeleteReply($(this).attr('no'), $(this).attr('bno'));
						} else {
							DeleteReReply($(this).attr('no'), $(this).attr('bno'), $(this).attr('grp'));
						}
					})
			},
			error : function() {
				alert('서버에러');
			}
		});
	};
	
	const WriteReply = function(bno){
		
		let content = $('#comment').val();
		
		alert(content);
		
		$.ajax({
			url: 'la_write_reply.do',
			type: 'get',
			data: {
				bno : bno,
				content : content
			},
			success: function(lato){
				console.log("모댓글 작성 성공");
				
				$("#count_reply").text(lato.reply);
				
				$("#comment").val("");
				
				ReplyList(bno);
			},
			error: function() {
				alert('서버에러');
			}
		});
	}
	
	const WriteReReply = function(bno, no) {
		console.log(bno);
		console.log(no);
		
		console.log($("#commnet").val());
		
		let content = $("#comment").val();
		content = content.trim();
		
		if(content == ""){R
			alert("내용을 입력하세요!");
		} else {
			$("#comment").val("");
			
			$.ajax({
				url: 'la_write_rereply.do',
				type: 'get',
				data: {
					no : no,
					bno : bno,
					content : content
				},
				success : function(lato){
					console.log("답글 작성 성공");
					
					ReplyList(bno);
				},
				error: function() {
					alert('서버에러');
				}
			});
		};
	};
	
	// 모댓글 삭제
	const DeleteReply = function(no, bno){
		// grp가 no인 댓글이 있는 경우 content에 null을 넣고, 없으면 삭제
		$.ajax({
			url : 'la_delete_reply.do',
			type : 'get',
			data : {
				no: no,
				bno: bno
			},
			success : function(lato) {
				let reply = lato.reply;
				console.log("모댓글 삭제 성공");
				ReplyList(bno);
			},
			error : function() {
				alert('서버에러');
			}
		});
	};
	
	// 답글 삭제
	const DeleteReReply = function(no, bno, grp){
		
		$.ajax({
			url : 'la_delete_reply.do',
			type : 'get',
			data : {
				no: no,
				bno: bno,
				grp: grp
			},
			success : function(lato) {
				let reply = lato.reply;
				console.log("답글 삭제 성공");
				ReplyList(bno);
			},
			error : function() {
				alert('서버에러');
			}
		});
	};
	
	
	$('.write_reply').on('click', function(){
		let bno = $(this).attr("no");
		
		
		WriteReply(bno);
	});
	
	$(document).ready(function(){
		
		ReplyList(${to.no});
	});
	
</script>

</body>
</html>