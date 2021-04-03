<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.model1.shopping.ShoppingTO"%>
<%@page import="com.exam.model1.shoppingComment.ShoppingCommentTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("utf-8");
	String sa = request.getParameter( "sa" );
	String location = request.getParameter( "location" );
	String cpage = request.getParameter( "cpage" );
	String no = request.getParameter( "no" );
	
	String nick = (String)session.getAttribute( "nick" );
	
	ShoppingTO to = (ShoppingTO)request.getAttribute( "to" );
	
	String subject = to.getSubject();
	String content = to.getContent();
	String writer = to.getWriter();
	String wdate = to.getWdate();
	String hit = to.getHit();
	location = to.getLocation();
	String picture = to.getPicture();
	String reply = to.getReply();
	String heart = to.getHeart();
	String hno = to.getHno();
	
	ArrayList<ShoppingCommentTO> lists = (ArrayList)request.getAttribute( "lists" );
	StringBuffer sbHtml = new StringBuffer();
	
	for( ShoppingCommentTO commentTo : lists ) {
		sbHtml.append( "<form method='post' name='ccontent_reply"+commentTo.getNo()+"' >" );
		sbHtml.append( "<input type='hidden' name='no' value='"+commentTo.getNo()+"' />" );
		sbHtml.append( "<input type='hidden' name='bno' value='"+no+"' />" );
		sbHtml.append( "<input type='hidden' name='writer' value='"+nick+"' />" );
		sbHtml.append( "<input type='hidden' name='cpage' value='"+cpage+"' />" );
		sbHtml.append( "<input type='hidden' name='grp' value='"+commentTo.getGrp()+"' />" );
		
		sbHtml.append( "<table class='table table-bordered table_reply_view'> " );
		sbHtml.append( "<tr> " );
		sbHtml.append( "	<td class='coment_re' width='90%'>" );
		if ( commentTo.getGrpl() != 0 ) {
			sbHtml.append( "&nbsp;" + "<img src='./resources/img/icon_re.gif' />" );
		}
		sbHtml.append( "		<strong>"+ commentTo.getWriter() +"</strong> ("+ commentTo.getWdate() +") " );
		sbHtml.append( "		<div class='reply_comment"+commentTo.getNo()+"'> " );
		sbHtml.append( "			"+ commentTo.getContent()+"" );
		sbHtml.append( "		</div> " );
		sbHtml.append( "		<div class='reply_comment_textarea"+commentTo.getNo()+"' style='display: none;' > " );
		sbHtml.append( "		<table> ");
		sbHtml.append( "		<tr> ");
		sbHtml.append( "			<td width='100%'><textarea id='ccontent_modify"+commentTo.getNo()+"' name='ccontent_modify' class='form-control ccontent_modify'>"+commentTo.getContent()+"</textarea></td>" );
		sbHtml.append( "			<td><input type='button' id='ccontent_reply"+commentTo.getNo()+"m"+commentTo.getWriter()+"' value='댓글수정' class='btn btn-success' onclick='reply_modifyOk(this.id)' /></td>" );
		sbHtml.append( "		</tr> ");
		sbHtml.append( "		</table> ");
		sbHtml.append( "		</div> " );
		sbHtml.append( "	</td> " );
		sbHtml.append( "	<td align=center>" );
		sbHtml.append( "	<div class='reply_delete' id='ccontent_reply"+commentTo.getNo()+"d"+commentTo.getWriter()+"' onclick='reply_deleteOk(this.id);'> " );
		sbHtml.append( "		<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-x-square' viewBox='0 0 16 16' >" );
		sbHtml.append( "	  		<path d='M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z'/>" );
		sbHtml.append( "	  		<path d='M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z'/>" );
		sbHtml.append( "		</svg>" );
		sbHtml.append( "		<div class='tooltip_delete'> " );
		sbHtml.append( "			댓글삭제 " );
		sbHtml.append( "		</div> " );
		sbHtml.append( "	</div> " );
		sbHtml.append( "	</td> " );
		sbHtml.append( "	<td align=center>" );
		sbHtml.append( "	<div class='reply_delete'> " );
		sbHtml.append( "		<svg class='reply_modify' idx='"+commentTo.getNo()+"' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'>" );
		sbHtml.append( "			<path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/>" );
		sbHtml.append( "			<path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z'/>" );
		sbHtml.append( "		</svg>" );
		sbHtml.append( "		<div class='tooltip_delete'> " );
		sbHtml.append( "			댓글수정 " );
		sbHtml.append( "		</div> " );
		sbHtml.append( "	</div> " );
		sbHtml.append( "	</td> " );
		if ( commentTo.getGrpl() == 0 ) {
			sbHtml.append( "	<td align=center>" );
			sbHtml.append( "	<div class='reply_delete'> " );
			sbHtml.append( "	<svg class='reply_rereply' idx='"+commentTo.getNo()+"' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat-dots' viewBox='0 0 16 16'> " );
			sbHtml.append( "	  <path d='M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z'/> " );
			sbHtml.append( "	  <path d='M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z'/> " );
			sbHtml.append( "	</svg> " );
			sbHtml.append( "		<div class='tooltip_delete'> " );
			sbHtml.append( "			답글달기 " );
			sbHtml.append( "		</div> " );
			sbHtml.append( "	</div> " );
			sbHtml.append( "	</td> " );
		}
		sbHtml.append( "</tr> " );
		sbHtml.append( "</table> " );
		sbHtml.append( "<div class='reply_div"+commentTo.getNo()+"' style='display: none;'>" );
		sbHtml.append( "<table>" );
		sbHtml.append( "	<tr>" );
		sbHtml.append( "		<td width='94%' align='left' class='rereply_td'>" );
		sbHtml.append( "&nbsp;" + "<img src='./resources/img/icon_re.gif' />" );
		sbHtml.append( "			<strong>답글작성 </strong> " );
		sbHtml.append( "		</td>" );
		sbHtml.append( "		<td width='6%' class='bg01'></td>" );
		sbHtml.append( "	</tr>" );
		sbHtml.append( "	<tr>" );
		sbHtml.append( "		<td class='bg01' align=center>" );
		sbHtml.append( "			<textarea id='ccontent_reply"+commentTo.getNo()+"' name='ccontent_reply' cols='' rows='' class='form-control ccontent_reply' ></textarea>" );
		sbHtml.append( "		</td>" );
		sbHtml.append( "		<td align='right' class='bg01'>" );
		sbHtml.append( "			<input type='button' id='ccontent_reply"+commentTo.getNo()+"' value='답글등록' class='btn btn-success' onclick='reply_commentOk(this.id)' />" );
		sbHtml.append( "		</td>" );
		sbHtml.append( "</tr>" );
		sbHtml.append( "</table>" );
		sbHtml.append( "</div>" );
		sbHtml.append( "</form>" );
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 쇼핑 정보</title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/shopping_view.css?z" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">

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


$(document).ready( function() {
	
	// 로그인 후 하트 추가를 위한 함수
	const saveHeart = function(no) {
		$.ajax({
			url : 'shop_saveHeart.do',
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
		$(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
	};
	
	// 로그인 후 하트 해제를 위한 함수
	const removeHeart = function(no) {
		$.ajax({
			url : 'shop_removeHeart.do',
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
		$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
	};
	
	// 로그인 한 상태에서 빈하트를 클릭했을 때 입니다.
	$("svg.heart1").click(function() {
		let no = $(this).attr('idx');
		console.log("빈하트 클릭" + no);
		saveHeart(no);
	});
	
	// 로그인 한 상태에서 꽉찬하트를 클릭했을 때 입니다.
	$("svg.heart2 ").click(function() {
		let no = $(this).attr('idx');
		console.log("꽉찬하트 클릭" + no);
		removeHeart(no);
	});
	
	//답글 달기 버튼 눌렀을 때
	$('svg.reply_rereply').click( function() {
		let re_no = $(this).attr('idx');
		if( $('.reply_div'+re_no).attr('id') == 'h' || $('.reply_div'+re_no).attr('id') == null ) {
			$('.reply_div'+re_no).css("display", "block")
			$('.reply_div'+re_no).attr('id', 'b');
		} else {
			$('.reply_div'+re_no).css("display", "none")
			$('.reply_div'+re_no).attr('id', 'h');
		}
	})
	
	//댓글 수정 버튼 눌렀을 때
	$( 'svg.reply_modify' ).click( function() {
		let re_no = $(this).attr('idx');
		if( $( '.reply_comment'+re_no ).attr('id') == 'b' || $( '.reply_comment'+re_no ).attr('id') == null ) {
			$( '.reply_comment'+re_no ).css( "display", "none" );
			$( '.reply_comment'+re_no ).attr('id', 'h' );
			$( '.reply_comment_textarea'+re_no ).css( "display", "block" );
			$( '.reply_comment_textarea'+re_no ).attr('id', 'b' );
		} else {
			$( '.reply_comment'+re_no ).css( "display", "block" );
			$( '.reply_comment'+re_no ).attr('id', 'b' );
			$( '.reply_comment_textarea'+re_no ).css( "display", "none" );
			$( '.reply_comment_textarea'+re_no ).attr('id', 'h' );
		}
	})
	
})

	const commentOk = function() {
		if( document.cfrm.cwriter.value.trim() == '' ) {
			alert( '로그인을 해주세요' );
			return false;
		}
		if( document.cfrm.ccontent.value.trim() == '' ) {
			alert( '댓글내용을 입력해주세요' );
			return false;
		}
		document.cfrm.submit();
	}	
	
	//글쓴이 일치여부 확인 후 글삭제
	const deleteOk = function() {
		let writer = "<%= writer %>";
		let nick = "<%= nick %>";
		if( writer != nick ) {
			alert( '글쓴이만 삭제가 가능합니다.' )
			return false;
		}
		if (confirm("해당 게시글을 삭제하시겠습니까?") == true){    //확인
			document.shop_frm.action = "./shopping_delete_ok.do";
			document.shop_frm.submit();
		}else{   //취소
		    return false;
		}
	}
	
	//글쓴이 일치여부 확인 후 글수정
	const modifyOk = function() {
		let writer = "<%= writer %>";
		let nick = "<%= nick %>";
		if( writer != nick ) {
			alert( '글쓴이만 수정이 가능합니다.' )
			return false;
		}
		document.shop_frm.action = "./shopping_modify.do";
		document.shop_frm.submit();
		
	}
	
	//글쓴이 일치여부 확인 후 댓글 삭제
	const reply_deleteOk = function(clicked_id) {
		let nick = "<%= nick %>";
		list = clicked_id.split('d');
		
		let frm_id = list[0];
		let re_writer = list[1];
		
		if( re_writer != nick ) {
			alert( '글쓴이만 삭제가 가능합니다.' )
			return false;
		}	
		if (confirm("해당 댓글을 삭제하시겠습니까?") == true){    //확인
			
			document.forms[frm_id].action = "./shopping_reply_deleteOk.do";
			document.forms[frm_id].submit();
		}else{   //취소
		    return false;
		}
	}
	
	//글쓴이 일치여부 확인 후 댓글 수정
	const reply_modifyOk = function(clicked_id) {
		let nick = "<%= nick %>";
		list = clicked_id.split('m');
		
		let frm_id = list[0];
		let re_writer = list[1];
		
		if( re_writer != nick ) {
			alert( '글쓴이만 수정이 가능합니다.' )
			return false;
		}
		document.forms[frm_id].action = "./shopping_reply_modifyOk.do";
		document.forms[frm_id].submit();
	}
	
	//답글 쓰기
	const reply_commentOk = function(clicked_id) {
		let nick = "<%= nick %>";
		console.log( $( '#'+clicked_id ).text() );
		if( nick == "null" ) {
			alert( '로그인을 해주세요.' );
			return false;
		}
		if( $('#'+clicked_id ).val() == '' ) {
			alert( '답글 내용을 입력해주세요.' )
			return false;
		}
		document.forms[clicked_id].action = "./shopping_rereplyOk.do";
		document.forms[clicked_id].submit();
	}
		
</script>

</head>
<body>

<!-- 네비게이션바  -->
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="shopping_view" name="thisPage" />
</jsp:include>

<br /><br /><br />

<!-- 전체 div  -->
<div class="view1">
	<!-- 첫 번째 div : 페이지제목  -->
	<br />
	<div class="select-form">
		<div class="col-8 offset-3">
			<h3><%= location %> 쇼핑 정보</h3>
		</div>	
	</div>
	
	<!-- 두 번째 div : view보일 내용  -->
	<div class="view2">
		<div class="view3">
			<!-- 실제 글 내용 보이는 곳  -->
			<table class="table table_view" id='board_list'>
			<thead class="thead_view">
				<tr>
					<td class="text-center d-none d-md-table-cell"><%=no %></td>
					<td class="text-center d-none d-md-table-cell"><%=location %></td>
					<td class="text-center"><%=subject %></td>
					<td class="text-center d-none d-md-table-cell"><%=writer %></td>
					<td class="text-center d-none d-md-table-cell"><%=wdate %></td>
					<td class="text-center d-none d-md-table-cell"><%=hit %></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="6" >
							<img src="./upload/shopping/<%=picture %>" width="900" onerror="" /><br />
							<%= content %>
					</td>
				</tr>
			</tbody>
			</table>
			

			
			<!-- 댓글 리스트 출력  -->
			<%= sbHtml %>
			
			
			<!-- 댓글 div  -->
			<div class="view4">
				<form action="./shopping_view_comment_ok.do" method="post" name="cfrm">
					<input type="hidden" name="no" value="<%=no %>" />
					<input type="hidden" name="cpage" value="<%=cpage %>" />
					<table class="table table-bordered table_reply">
					<tr>
						<td width="94%">
							<strong>Comments | <%= reply %></strong> <input type="hidden" name="cwriter" class="coment_input" value="<%= nick %>" />&nbsp;&nbsp;
						</td>
						<td width="6%" class="bg01"></td>
					</tr>
					<tr>
						<td class="bg01">
							<textarea name="ccontent" cols="" rows="" class="form-control"></textarea>
						</td>
						<td align="right" class="bg01">
							<input type="button" id="submit_reply" value="댓글등록" class="btn btn-success" onclick="commentOk()" />
						</td>
						
					</tr>
					</table>
				</form>
			</div>
			
			<!-- 밑에 버튼 영역  -->
			<table class="table table-bordered table_reply_view">
			<tr>
				<td class="like">
				좋아요
				<c:choose>	<%-- 로그인 안되어 있는 경우 좋아요 표시 없음--%>
					<c:when test="${empty sessionScope.nick }" >
						<svg class='heart3' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>
							<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />
						</svg>
					</c:when>
					<c:when test="${ empty to.getHno() }" > <%--현재 사용자가 좋아요 안눌렀을 때 빈하트  --%> 
						<svg idx='<%= no %>' class='heart1' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>
							<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />
						</svg>
					</c:when>
					<c:otherwise>	<%--현재 사용자가 좋아요 눌렀을 때 꽉 찬 하트 --%>
						<svg idx='<%= no %>' class='heart2' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'>
							<path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/>
						</svg>
					</c:otherwise>
				</c:choose>
				<%= heart %>
				</td>
			</tr>
			<tr>
				<td class="coment_re" width="20%">
					<div class="btn_list">
						<input type="button" id="submit_list" value="목록" class="btn btn-success btn_list" onclick="location.href='./shopping_list.do?cpage=<%=cpage %>&location=<%=location%>'" />
					</div>
					<div class="btn_dm">
					<c:choose>		
						<c:when test="${empty sessionScope.nick}">
							<input type="button" id="submit_delete" value="삭제" class="btn btn-success" onclick="javascript:alert('로그인을 하셔야합니다.')" />
							<input type="button" id="submit_modify" value="수정" class="btn btn-success" onclick="javascript:alert('로그인을 하셔야합니다.')" />
						</c:when>
						<c:otherwise>
							<form name="shop_frm" method="post" >
								<input type="hidden" name="no" value="<%=no %>"/>
								<input type="hidden" name="location" value="<%= location %>" />
								<input type="hidden" name="subject" value="<%= subject %>" />
								<input type="hidden" name="cpage" value="<%= cpage %>" />
								<input type="hidden" name="writer" value="<%= writer %>" />
								<input type="hidden" name="content" value="<%= content %>" />
								<input type="hidden" name="picture" value="<%= picture %>" />
								<input type="button" id="submit_delete" value="삭제" class="btn btn-success" onclick="deleteOk()" />
								<input type="button" id="submit_modify" value="수정" class="btn btn-success" onclick="modifyOk()" />
							</form>
								
						</c:otherwise>
					</c:choose>	
						
					</div>
				</td>
			</tr>
			</table>
		</div>
		
	</div>
	

	
	
</div>


</body>
</html>