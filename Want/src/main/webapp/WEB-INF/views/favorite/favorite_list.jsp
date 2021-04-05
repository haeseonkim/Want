<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("utf-8");
	String nick = (String)session.getAttribute( "nick" );

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 즐겨찾기</title>


<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/favorite_list.css?daa" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">

//===================사진자랑하기 관련함수 =========================
//[댓글]
// 게시물의 댓글 목록을 불러오는 함수입니다.
const ReplyList = function(no) {
	$.ajax({
		url : 'picture_replyList.do',
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
					listHtml += "			<img id='profileImage' src='./upload/profile/${profile}'/>"
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
			url : 'picture_write_rereply.do',
			type : 'get',
			data : {
				no : no,
				bno : bno,
				content: content
			},
			success : function(pto) {
				
				let reply = pto.reply;
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
		url : 'picture_delete_reply.do',
		type : 'get',
		data : {
			no : no,
			bno : bno
		},
		success : function(pto) {
			
			let reply = pto.reply;
			
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
		url : 'picture_delete_rereply.do',
		type : 'get',
		data : {
			no : no,
			bno : bno,
			grp : grp
		},
		success : function(pto) {
			
			let reply = pto.reply;
			
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
//========================= 사진자랑하기 관련 함수 끝 =================================



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



$(document).ready(function() { 
	
	//======= 메뉴버튼 글목록 가져오기관련 =========
	//btn_munu1_1이란 버튼을 누르면 해당 버튼의(this) id값을 받아오고 그 id값은 컨트롤러의 매핑값이다.
	//그 매핑값을 ajax url로 사용한다.
	//ajax를 통해서 새로운 페이지가 만들어지고 menu_content에 있는 태그들은 모두 remove된 다음 
	//ajax를 통해서 받아온 페이지 내용을 append시켜준다.
	$('.btn_menu1_1').on('click', function(e) { 
		var userName = '<%= nick %>';
		var doName = this.id;
		
		//클릭안된 버튼들의 뒷 배경은 흰색
		$('.btn_menu1_1').css( 'background-color', 'white' );
		
		currentPage = 1;
		isLoading = false;
		
		//컨트롤러의 어떤 매핑값과 매치시킬지 조건문으로 나눠준다.
		if( doName == './f_lantrip_list.do' ) {
			//input hidden으로 되어있는 menu_name의 id값을 바꿔준다.
			//이 값은 나중에 좋아요 추가,삭제할 때 쓰인다.
			$( '.menu_name' ).attr( 'id', 'lanTrip_' );
			
			//현재 클릭된 버튼의 색깔만 바꿔준다.
			$(this).css( 'background-color', '#C8FAC8' );
			
			
			$.ajax({
				url: doName,
				method:"GET",
				data: "nick="+userName,
				success: function(html) {
					//console.log( html );
					$('.menu_content').empty();	//div_menu의 내부요소들만 삭제
					$('.menu_content').append(html);
					FuncHeart();
				}
			})
		} else if( doName == './f_picture_list.do' ) {
			$( '.menu_name' ).attr( 'id', '' );
			
			//현재 클릭된 버튼의 색깔만 바꿔준다.
			$(this).css( 'background-color', '#C8FAC8' );
			
			$.ajax({
				url: doName,
				method:"GET",
				data: "nick="+userName,
				success: function(html) {
					//console.log( html );
					$('.menu_content').empty();	//div_menu의 내부요소들만 삭제
					$('.menu_content').append(html);
					FuncHeart();
				}
			})
		} else if( doName == './f_shop_list.do' ) {
			$( '.menu_name' ).attr( 'id', 'shop_' );
			
			//현재 클릭된 버튼의 색깔만 바꿔준다.
			$(this).css( 'background-color', '#C8FAC8' );
			
			$.ajax({
				url: doName,
				method:"GET",
				data: "nick="+userName,
				success: function(html) {
					//console.log( html );
					$('.menu_content').empty();	//div_menu의 내부요소들만 삭제
					$('.menu_content').append(html);
					FuncHeart();
				}
			})
		} else if( doName == './f_accom_list.do' ) {
			$( '.menu_name' ).attr( 'id', 'accom_' );
			
			//현재 클릭된 버튼의 색깔만 바꿔준다.
			$(this).css( 'background-color', '#C8FAC8' );
			
			$.ajax({
				url: doName,
				method:"GET",
				data: "nick="+userName,
				success: function(html) {
					//console.log( html );
					$('.menu_content').empty();	//div_menu의 내부요소들만 삭제
					$('.menu_content').append(html);
					FuncHeart();
				}
			})
		}
		
		
	});
	
	
	
	
	//======= 좋아요 관련 =========
	// 하트 클릭했을 때
	let FuncHeart = function() {
		$(".heart-click").unbind('click');
		$(".heart-click").click(function() {
			
			if( $(this).children('svg').attr('class') == 'bi bi-suit-heart' ) {
				//빈하트 클릭시
				let no = $(this).attr('idx');
				let menuName = $('.menu_name').attr('id');
				let doName = menuName + 'saveHeart.do';
				console.log("빈하트 클릭" + no + " / 메뉴이름" + menuName + " / do이름 " + doName );
				
				//꽉찬하트로 만들기 전에 DB 하트테이블에 로우 추가
				$.ajax({
					url : doName,
					type : 'get',
					data : {
						no : no,
					},
					success : function(lto) {
						console.log("하트추가 성공");
						
						$('#heart'+no).text( lto.heart );
						
					},
					error : function() {
						alert('서버 에러');
					}
				});
				$(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
				
			} else if( $(this).children('svg').attr('class') == 'bi bi-suit-heart-fill' ) {
				//꽉찬하트 클릭시
				let no = $(this).attr('idx');
				console.log("꽉찬하트 클릭" + no);
				let menuName = $('.menu_name').attr('id');
				let doName = menuName + 'removeHeart.do';
				console.log("빈하트 클릭" + no + " / 메뉴이름" + menuName + " / do이름 " + doName );
				
				//빈하트로 만들기 전에 DB 하트테이블에 로우 삭제
				$.ajax({
					url : doName,
					type : 'get',
					data : {
						no : no,
					},
					success : function(lto) {
						console.log("하트삭제 성공");
						
						$('#heart'+no).text( lto.heart );
					},
					error : function() {
						alert('서버 에러');
					}
				});
				$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
			}
		});
	}
	FuncHeart();
	
	
	// 게시물 이미지를 클릭했을 때 실행된다
	// 해당 게시물을 hit+1하는 함수를 호출한다.
	$(document).on('click', '.card-img', function() {
		// 게시물 번호(no)를 idx로 전달받아 저장합니다.
		let no = $(this).attr('idx');
		
		console.log(no +"에 hit + 1을 함");
		
		// hit+1하고 그 값을 불러온다.
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
	});
	
	
	
	//======= 사진자랑하기 댓글관련 jquery =========
	// 댓글아이콘을 클릭했을때 댓글 리스트 함수를 호출
	$(".open_reply_list").unbind('click');
	$(".open_reply_list").click(function(){
		console.log( '댓글리스트 가져와라')
		let no = $(this).attr('idx');
		// 게시물에 no에 해당하는 댓글 리스트를 가져오는 함수	
		ReplyList(no);
	});
	
	// 댓글 달기 버튼 클릭시  실행
	$(".write_reply").unbind('click');
	$(".write_reply").click(function(){
		// 게시물 번호
		let no = $(this).attr('idx');
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

});
//jquery document ready끝

let currentPage=1;
let isLoading=false;

//======= 무한스크롤 관련 =======
//웹브라우저의 창을 스크롤 할 때 마다 호출되는 함수 등록
$(window).on("scroll",function(){
	
	//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
	//let currentPage = $('.currentPage').val();
	//현재 페이지가 로딩중인지 여부를 저장할 변수이다.
	//let isLoading = $('.isLoading').val();
	
	//위로 스크롤된 길이
	let scrollTop=$(window).scrollTop();
	//웹브라우저의 창의 높이
	let windowHeight=$(window).height();
	//문서 전체의 높이
	let documentHeight=$(document).height();
	//바닥까지 스크롤 되었는 지 여부를 알아낸다.
	let isBottom=scrollTop+windowHeight + 10 >= documentHeight;
	
	console.log( scrollTop, windowHeight, documentHeight, isBottom );
	
	
	console.log( $( '.menu_name' ).attr( 'id' ) );
	//무한스크롤 컨트롤러에서 매핑할 이름 설정
	let ajaxDoName = '';
	let mName = $( '.menu_name' ).attr( 'id' );
	if( mName == 'lanTrip_' ) {
		ajaxDoName = './f_lantrip_list.do';
	} else if( mName == '' ) {
		ajaxDoName = './f_picture_list.do';
	} else if( mName == 'shop_' ) {
		ajaxDoName = './f_shop_list.do';
	} else if( mName == 'accom_' ) {
		ajaxDoName = './f_accom_list.do';
	}
	console.log( 'ajaxDoName: ' + ajaxDoName );
	
	if(isBottom){
		//만일 현재 마지막 페이지라면
		if( currentPage == ${ totalPageCount } || isLoading ) {
			return; //함수를 여기서 끝낸다.
		}
		//현재 로딩 중이라고 표시한다.
		isLoading=true;
		//로딩바를 띄우고
		$(".back-drop").show();
		//요청할 페이지 번호를 1 증가시킨다.
		currentPage++;
		//currentPage = $('.currentPage').val( currentPage++ );
		
		
		//추가로 받아올 페이지를 서버에 ajax 요청을 하고
		$.ajax({
			url: ajaxDoName,
			method:"GET",
			//검색기능이 있는 경우 condition과 keyword를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른것들이 덧붙여져 나온다.
			data:"pageNum="+currentPage,
			//ajax_page.jsp의 내용이 data로 들어온다.
			success:function(data){
				//console.log(data);

				//해당 문자열을 .menu_content div에 html로 해석하라고 추가한다.
				$(".menu_content").append(data);
				//로딩바를 숨긴다.
				$(".back-drop").hide();
				//로딩중이 아니라고 표시한다.
				isLoading=false;
				
				//======= 좋아요 관련 =========
				// 하트 클릭했을 때
				$(".heart-click").unbind('click');
				$(".heart-click").click(function() {
					
					if( $(this).children('svg').attr('class') == 'bi bi-suit-heart' ) {
						//빈하트 클릭시
						let no = $(this).attr('idx');
						let menuName = $('.menu_name').attr('id');
						let doName = menuName + 'saveHeart.do';
						console.log("빈하트 클릭" + no + " / 메뉴이름" + menuName + " / do이름 " + doName );
						
						//꽉찬하트로 만들기 전에 DB 하트테이블에 로우 추가
						$.ajax({
							url : doName,
							type : 'get',
							data : {
								no : no,
							},
							success : function(lto) {
								console.log("하트추가 성공");
								
								$('#heart'+no).text( lto.heart );
								
							},
							error : function() {
								alert('서버 에러');
							}
						});
						$(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
						
					} else if( $(this).children('svg').attr('class') == 'bi bi-suit-heart-fill' ) {
						//꽉찬하트 클릭시
						let no = $(this).attr('idx');
						console.log("꽉찬하트 클릭" + no);
						let menuName = $('.menu_name').attr('id');
						let doName = menuName + 'removeHeart.do';
						console.log("빈하트 클릭" + no + " / 메뉴이름" + menuName + " / do이름 " + doName );
						
						//빈하트로 만들기 전에 DB 하트테이블에 로우 삭제
						$.ajax({
							url : doName,
							type : 'get',
							data : {
								no : no,
							},
							success : function(lto) {
								console.log("하트삭제 성공");
								
								$('#heart'+no).text( lto.heart );
							},
							error : function() {
								alert('서버 에러');
							}
						});
						$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
					}
				});
				
				//======= 사진자랑하기 댓글관련 jquery =========
				// 댓글
				// 댓글아이콘을 클릭했을때 댓글 리스트 함수를 호출
				$(".open_reply_list").unbind('click');
				$(".open_reply_list").click(function(){
					console.log( '댓글리스트 가져와라')
					let no = $(this).attr('idx');
					// 게시물에 no에 해당하는 댓글 리스트를 가져오는 함수	
					ReplyList(no);
				});
				
				// 댓글 달기 버튼 클릭시  실행
				$(".write_reply").unbind('click');
				$(".write_reply").click(function(){
					// 게시물 번호
					let no = $(this).attr('idx');
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
					
				}); //댓글관련 끝
				
			} //success 끝
			
		}); //ajax끝
		
	}; //if bottom 끝
	
}); // 스크롤 jquery 끝



</script>

</head>
<body>

<!-- 메뉴바 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="favorite_list" name="thisPage" />
</jsp:include>
<br /><br /><br />

<!-- 메인 div 시작 -->
<div class="div_main">
	<div class="div_subject">
		<div class="div_subject1">
			<div class="div_subject1_1">
				<p class="p_subject"><b>좋 아 요  목 록</b></p>
				<p class="p_subject_content"><%= nick %> 님의 좋아요 목록을 확인하세요!</p>
			</div>
		</div>
		<div class="div_menu1">
			<!-- 버튼안에 id값으로 컨트롤러에 ajax로 넘겨줄 매핑이름을 저장 -->
			<button type="button" id="./f_lantrip_list.do" class="btn btn-default btn_menu1_1" style="background-color: #C8FAC8;">랜선여행하기</button>
			<button type="button" id="./f_picture_list.do" class="btn btn-default btn_menu1_1">사진자랑하기</button>
			<button type="button" id="./f_shop_list.do" class="btn btn-default btn_menu1_1">쇼핑정보</button>
			<button type="button" id="./f_accom_list.do" class="btn btn-default btn_menu1_1">숙소정보</button>
			
			<input type="hidden" class="menu_name" id="lanTrip_" /> 
			<input type="hidden" class="currentPage" value="1" />
			<input type="hidden" class="isLoading" value="false" />
		</div>
	</div>
	
	<div class="div_menu">
		<!-- 카드들 담고있는 div -->
		<div class="div_menu_content" id="image-object">
			<div class="row menu_content">
				<!-- 카드 나타내는 div -->
				<c:forEach var="tmp" items="${ list }">
				
				<div class="col-xl-3 col-lg-3 col-md-6 mb-4 div_card">
					<div class="bg-white rounded shadow-sm">
						<a href='./lanTrip_view.do?no=${ tmp.no }'><video src='./upload/lanTrip/${ tmp.video }' class='card-img-top' controls></video></a>
						<div class="p-4">
							<h5>
								<a href="./lanTrip_view.do?no=${ tmp.no }" class="text-dark">${ tmp.subject }</a>
							</h5>
							<img id='profileImage' src='./upload/profile/${ tmp.profile }' />&nbsp;&nbsp;<span class="small text-muted mb-0">${ tmp.writer } | ${ tmp.wdate }</span>
							<%-- 좋아요, 댓글, 조회수 표시하는 div 시작 --%>
							<div class="d-flex align-items-center justify-content-between rounded-pill bg-light px-3 py-2 mt-4">
								<c:choose>
								<%-- 로그인 상태일때 - 하트 클릭 되게 --%>
								<c:when test="${not empty sessionScope.nick}">
									<c:choose>
										<c:when test="${empty tmp.hno}">
											<%-- 빈 하트일때 --%>
											<span>
												<a idx="${tmp.no }" href="javascript:" class="heart-click heart_icon${tmp.no }">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
					  							  		<path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
													</svg>
												</a>
											</span>
										</c:when>
										<c:otherwise>
											<%-- 꽉찬 하트일때 --%>
											<span>
												<a idx="${tmp.no }" href="javascript:" class="heart-click heart_icon${tmp.no }">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
											 			<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/>
													</svg>
												</a>
											</span>
										</c:otherwise>
									</c:choose>
								</c:when>
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
							<%-- 좋아요, 댓글, 조회수 표시하는 div 끝 --%>
						</div>
					</div>
				</div>
				
				</c:forEach>
				<!-- 카드 나타내는 div 끝 -->

			</div>
		</div>
		<!-- 카드 담고있는 애니메이션 div 끝 -->
		
		<!-- 로딩중 이미지 -->
		<div class="back-drop">
			<!-- cpath/ 에서 '/'는 webapp을 의미한다. 웹앱 폴더의 svg폴더 안에 spinner-solid.svg가 들어있다.  -->
			<img src="./svg/spinner-solid.svg"/> 
		</div>
		<!-- 로딩중 이미지 끝 -->
	</div>
</div>
<!-- 메인 div 끝 -->

<script type="text/javascript">



</script>

</body>
</html>