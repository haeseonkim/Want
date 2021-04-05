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

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, intial-scale=1.0">
<title><%=subject%></title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/lanTrip_apply_view.css?1231231"
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
	
	<section id="la-header">
		<br />
		<div class="la-header-container">
			<h1> 랜선여행 신청하기</h1>
			<p>원하는 랜선여행을 신청하세요!</p>
		</div>
	</section>

	<section id="info" class="container">
		<table class="table table-hover" id='board_list'>
			<thead>
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
		<c:choose>
			<c:when test="${empty to.picture }">
				<div></div>
			</c:when>
			<c:otherwise>
				<section id="section-picture" class="container">
					<div class="picture">
						<img src="./upload/lanTrip_apply/<%=picture%>" width="600px"></img>
					</div>
				</section>
			</c:otherwise>
		</c:choose>
<!-- 본문 끝 -->

<!-- 댓글 시작 -->
	<section class="container" style="margin-top: 10px;">
		<form id="commentForm" name="commentForm" method="post">
			<br /> <br /> <br />
			<div>
				<div class="cmt">
					<span><strong>댓글 <span id="count_reply" style="color: #5fcf80;"><%=reply %></span></strong></span>
				</div>
				<hr />
				<br />
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
					onclick="location.href='./lanTrip_apply_list.do'">목록</button>
				<!-- 로그인이 되어있고 작성자가 같을 때만 수정과 삭제버튼이 보이게 한다. -->
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


// 모댓글 작성
	const WriteReply = function(bno){
		
		let content = $('#comment').val();
		
		content = content.trim();
		
			if(content == ""){
				alert("내용을 입력하세요!");
			} else {
			$.ajax({
				url: 'la_write_reply.do',
				type: 'get',
				data: {
					bno : bno,
					content : content
				},
				success: function(lato){
					console.log("댓글 작성 성공");
				
					$("#count_reply").text(lato.reply);
				
					$("#comment").val("");
				
					// 맞음
					ReplyList(bno);
				},
				error: function() {
					alert('서버에러');
				}
			});
		};
	}

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
					
					listHtml += "<div class='row reply"+no+"'>";	// div 1
					
					if(content == ""){	// 삭제된 댓글일 때
						listHtml += "<div style='color:silver;'>";	// div 2
						listHtml += "	(삭제된 댓글입니다.)";
						listHtml += "</div>";						// div 2 닫음
					} else {
						if(grpl == 0 ){	// 모댓글일 때
							listHtml += "	<div class='col-1 profile_img'>";	// div 3
							listHtml += "		<img class='cmt_profile img-circle' src='./upload/profile/"+profile+"'/>";
							listHtml += "	</div>";							// div 3 닫음
							listHtml += "	<div class='col-10'>";				// div 4
							listHtml += "		<h6>";
							listHtml += "			<b>"+writer+"</b>";
							listHtml += "		</h6>";
							listHtml += "		<div>";							// div 4-1
							listHtml += 			content;
							listHtml += "		</div>";						// div 4-1 닫음
							listHtml += "		<div class='rereply_box'>";		// div 4-2
							listHtml += "			<span class='cdate'>"+wdate+"&nbsp;</span>";
							
							// 로그인상태일 때 답글작성 버튼이 나온다.
							if("${nick}"!=""){
								listHtml += "&nbsp;&nbsp;";
								listHtml += "		<span>";
								listHtml += "			<button type='button' class='btn_rereply' data-bs-toggle='collapse' data-bs-target='#re_reply"+ no +"' aria-expanded='false' aria-controls='collapseExample'>답글쓰기</button>";
								listHtml += "		</span>";
								
							}
						}else {	// 답글일 때
							// row rereply 줄까말까 고민중
							listHtml += "	<div class='col-1 space'></div>";	// div 4-2-1 닫음
							listHtml += "	<div class='col-1 profile_img'>";	// div 4-2-2
							listHtml += "		<img class='cmt_profile img-circle' src='./upload/profile/"+profile+"'/>";
							listHtml += "	</div>";							// div 4-2-2 닫음
							listHtml += "	<div class='col-10 rereply-content"+no+"'>";	// div 4-2-3
							listHtml += "		<h6>";
							listHtml += "			<b>"+writer+"</b>";
							listHtml += "		</h6>";
							listHtml += "		<div>";										// div 4-2-3-1
							listHtml += 			content;
							listHtml += "		</div>";									// div 4-2-3-1 닫음
							listHtml += "		<div class='rereply_box'>";					// div 4-2-3-2
							listHtml += "			<span class='cdate'>"+wdate+"&nbsp;</span>";
							
							
							
						}
						// 현재 로그인 상태이고
						if("${nick}"!=""){
							// 사용자 = 작성자일 때 삭제버튼 출력
							if("${nick}"== writer ){
								listHtml += "|";
								listHtml += "			<span class='rereply_box'>";
								//listHtml += "				<button type='button' no='"+no+"' grpl='"+grpl+"' bno='"+bno+"' grp='"+grp+"' class='btn_rdelete'>삭제</button>";
								listHtml += "				<button type='button' class='btn_rdelete' no='"+no+"' grpl='"+grpl+"' bno='"+bno+"' grp='"+grp+"' data-bs-toggle='modal' data-bs-target='.bs-rdelete-modal-sm"+no+"'>삭제</button>";
								listHtml += "			</span>";
								listHtml += "		</div>";									// div 4-2-3-2 닫음
								listHtml += "	</div>";										// div 4-2-3 닫음
								listHtml += "	<br />";
								listHtml += "	<div class='modal bs-rdelete-modal-sm"+no+"'";//다른 댓글을 클릭해도 항상 가장 빠른 번호의 no가 넘어가지 않도록 no값 입력
								listHtml +=	"		aria-labelledby='mySmallModalLabel' aria-hidden='true'>";
								listHtml += "		<div class='modal-dialog modal-sm'>";
								listHtml += "		<div class='modal-content'>";
								listHtml += "			<br />";
								listHtml += "			<div style='height: 60px;'>&nbsp;&nbsp;정말 삭제하시겠습니까?</div>";

								listHtml += "			<div class='modal-footer'>";
								listHtml += "				<button type='button' class='btn btn--silver'";
								listHtml +=	"					data-bs-dismiss='modal'>취소</button>";
								listHtml += "				<button type='button' class='btn btn--blue-2 btn-rdelete-modal' no='"+no+"' grpl='"+grpl+"' bno='"+bno+"' grp='"+grp+"'>";
								listHtml +=	"					삭제</button>";
								listHtml += "			</div>";
								listHtml +=	"		</div>";
								listHtml += "		</div>";
								listHtml += "	</div>";
								
								
							}
							
						}
						listHtml += "	</div>";												// div 4-2 닫음
						
						listHtml += "	<br />";
						
						// 답글달기 답글입력란
						listHtml += "	<div class='collapse' id='re_reply"+no+"'>";			// div 4-3
						listHtml += "		<table class='table'>";
						listHtml += "			<tr>";
						listHtml += "				<td>";
						listHtml += "					<textarea style='width:86%' rows='3' cols='50' id='recomment"+no+"' class='re_comment' placeholder='&nbsp;댓글을 입력하세요'></textarea>";
						listHtml += "					<div class='row'>";
						listHtml += "						<div class='col-11'></div>";
						listHtml += "						<div id='btn_comment' class='col-1 btn_recomment'>";
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
						
				}
				//for 문 끝
				
				// listHtml 출력
				$(".reply-list").html(listHtml);
					
				$('button.btn.btn--radius-2.btn--blue-2.btn-md.write_rereply').unbind('click');
				$('button.btn.btn--radius-2.btn--blue-2.btn-md.write_rereply').on('click', function(){
					console.log('no', $(this).attr('no') );
					console.log('bno', $(this).attr('bno') );
					
					WriteReReply($(this).attr('bno'), $(this).attr('no') );
				});
				
				/* $('.btn_rdelete').unbind('click');
				$('.btn_rdelete').on('click', function(){ */
				/* $('.btn.btn--blue-2.btn-rdelete-modal').unbind('click'); */
				$('.btn.btn--blue-2.btn-rdelete-modal').on('click', function(){
					
					// 모댓글 삭제
					if($(this).attr('grpl') == 0){
						DeleteReply($(this).attr('no'), $(this).attr('bno'));
						
					} else {//대댓글삭제
						DeleteReReply($(this).attr('no'), $(this).attr('bno'), $(this).attr('grp'));
						
					}
					//	모달의 삭제버튼을 누르면 레이아웃이 사라지게 함 
					$('.modal-backdrop').remove();
				});
				
				
				// 댓글 작성 후 새로 불러온 댓글 리스트 html에 있는 댓글 입력창에 대한 댓글 작성 이벤트
				$('.write_reply').unbind('click');
				$('.write_reply').on('click', function(){
					let bno = $(this).attr("no");
					WriteReply(bno);
				});
					
			},
			error : function() {
				alert('서버에러');
			}
		});
	};
	

	// 대댓글 작성
	const WriteReReply = function(bno, no) {
		console.log("jsp/bno : " + bno);
		console.log("jsp/no : " + no);
		
		console.log($("#recomment" + no).val());
		
		let content = $("#recomment" + no).val();
		content = content.trim();
		
		if(content == ""){
			alert("내용을 입력하세요!");
		} else {
			$("#recomment"+no).val("");
			
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
					$("#count_reply").text(lato.reply);
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
				$("#count_reply").text(lato.reply);
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
			url : 'la_delete_rereply.do',
			type : 'get',
			data : {
				no: no,
				bno: bno,
				grp: grp
			},
			success : function(lato) {
				let reply = lato.reply;
				$("#count_reply").text(lato.reply);
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
		
		ReplyList(<%=no%>);
	});
	
</script>

</body>
</html>