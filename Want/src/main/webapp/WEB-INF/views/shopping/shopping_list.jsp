<%@page import="com.exam.model1.shopping.ShoppingListTO"%>
<%@page import="com.exam.model1.shopping.ShoppingTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("utf-8");
	String sa = request.getParameter( "sa" );
	String location = request.getParameter( "location" );
	
	String nick = (String)session.getAttribute( "nick" );
	
	ShoppingListTO listTO = (ShoppingListTO)request.getAttribute( "listTO" );
	int cpage = (Integer)request.getAttribute( "cpage" );
	
	int recordPerPage = listTO.getRecordPerPage();
	int totalRecord = listTO.getTotalRecord();
	int totalPage = listTO.getTotalPage();
	int blockPerPage = listTO.getBlockPerPage();
	int blockRecord = listTO.getBlockRecord();
	int startBlock = listTO.getStartBlock();
	int endBlock = listTO.getEndBlock();
	
	StringBuffer sbHtml = new StringBuffer();
	
	for ( ShoppingTO to : listTO.getShopLists()) {
		blockRecord++;
		if( blockRecord == 1 || blockRecord == 6 ) {	//tr 테이블 행 나누기
			sbHtml.append( "<tr align='center'>" );
		}
		sbHtml.append( " <td width='20%' class='last2'> ");
		sbHtml.append( " 	<div class='board'> " );
		sbHtml.append( " 		<table> " );
		sbHtml.append( " 		<tr> " );
		sbHtml.append( " 			<td class='boardThumbWrap'> " );
		sbHtml.append( " 				<div class='card' style='width: 18rem;'> " );
		sbHtml.append( " 					<div class='card-img-div'> " );
		sbHtml.append( " 						<a href='./shopping_view.do?cpage="+ cpage +"&no="+to.getNo()+"&location="+ location +"'><img class='card-img-top' src='./upload/shopping/" + to.getPicture() + "' border='0' width='100%'/></a>" );
		sbHtml.append( " 					</div> " );		
		sbHtml.append( " 				</div> " );														
		sbHtml.append( " 			</td> " );
		
		sbHtml.append( " 		</tr> " );
		sbHtml.append( " 		<tr> " );
		sbHtml.append( " 			<td> " );
		sbHtml.append( " 				<div class='card-body'>	 " );
		sbHtml.append( " 					<strong class='card-text'>" + to.getSubject() + "</strong> " );
		if( to.getWgap() == 0 ) {
			sbHtml.append( "		<img src='./resources/img/icon_new.gif' alt='NEW'> ");
		}
		sbHtml.append( " 				</div> " );
		sbHtml.append( " 			</td> " );
		sbHtml.append( " 		</tr> " );
		sbHtml.append( " 		<tr> " );
		sbHtml.append( " 			<td><div class='boardItem'><span class='bold_blue'>" + to.getWriter() + "</span></div></td> " );
		sbHtml.append( " 		</tr> " );
		sbHtml.append( " 		<tr> " );
		sbHtml.append( " 			<td><div class='boardItem'>" + to.getWdate() );
		// 로그인 상태아닐 때 하트 클릭안됨
		if( nick == null ) {
			sbHtml.append( "			<svg class='heart3' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>" );
			sbHtml.append( "		  		<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />" );
			sbHtml.append( "			</svg>" );
		} else { 		//로그인 상태에서 빈 하트일때 
			if( to.getHno() == null ) {
				sbHtml.append( "				<svg idx='"+ to.getNo()+"' id='"+to.getWriter()+"' class='heart1' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>" );
				sbHtml.append( "				  	<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />" );
				sbHtml.append( "				</svg>" );
			} else {	//로그인 상태에서 꽉찬 하트일때 
				sbHtml.append( "				<svg idx='"+ to.getNo()+"' id='"+to.getWriter()+"' class='heart2' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'>" );
				sbHtml.append( "			  		<path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/>" );
				sbHtml.append( "				</svg>" );
			}
		}
		sbHtml.append( "		"+ to.getHeart() +"&nbsp;" );
		sbHtml.append( "				<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat-dots' viewBox='0 0 16 16'>" );
		sbHtml.append( "					<path d='M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z' />" );
		sbHtml.append( "					<path d='M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z' />" );
		sbHtml.append( "				</svg>" );
		sbHtml.append( "				"+ to.getReply() +"&nbsp;" );
		sbHtml.append( "				<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye' viewBox='0 0 16 16'>" );
		sbHtml.append( "					<path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z' />" );
		sbHtml.append( "					<path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z' />" );
		sbHtml.append( "				</svg>" );
		sbHtml.append( "				"+ to.getHit()+ "" );
		sbHtml.append( " 		</tr> " );
		sbHtml.append( " 		</table> " );
		sbHtml.append( " 	</div> " );
		sbHtml.append( " </td> " );
		if( blockRecord == 5 ) {
			sbHtml.append( "</tr>" );
		}
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 쇼핑정보</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/shopping_list.css?q" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
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
	$(".boardItem > svg.heart1 ").click(function() {
		let no = $(this).attr('idx');
		console.log("빈하트 클릭" + no);
		saveHeart(no);
	});
	
	// 로그인 한 상태에서 꽉찬하트를 클릭했을 때 입니다.
	$(".boardItem > svg.heart2 ").click(function() {
		let no = $(this).attr('idx');
		console.log("꽉찬하트 클릭" + no);
		removeHeart(no);
	});
})
</script>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="shopping_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />
	<div class="select-form">
		<div class="col-8 offset-3">
			<h3><%= location %> 쇼핑 정보</h3>
		</div>	
	</div>
<div class="contents1"> 
	<div class="contents_sub">	
		<div class="board_top">
			<div class="bold">
				<p class="total">총 <span class="txt_orange"><%= blockRecord %></span>건</p>
			</div>
		</div>	
		
		<!--게시판-->
		<table class="board_list">
			<%= sbHtml %>
		</tr>
		</table>
		
		<!--//게시판-->	
		
		<div class="align_right">
		<c:choose>		
		<c:when test="${empty sessionScope.nick }">
			<button type="button" class="btn btn-primary" onclick="javascript:alert('로그인을 하셔야합니다.')">글쓰기</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="btn btn-primary" onclick="location.href='./shopping_write.do?location=<%=location%>&cpage=<%=cpage%>'">글쓰기</button>
		</c:otherwise>
		</c:choose>	
		</div>
		
		<!--페이지넘버-->
		<div class="paginate_regular">
			<div class="board_pagetab">
			<%	
				if ( cpage == 1 ) {
					out.println(" <span class='off'><a>&lt;&lt;</a></span> ");
				} else {
					out.println(" <span class='off'><a href='./shopping_list.do?location="+location+"&cpage="+ startBlock +"'>&lt;&lt;</a></span> ");
				}
				out.println(" &nbsp; ");
				
				if ( cpage == 1 ) {
					out.println(" <span class='off'><a>&lt;</a></span> ");
				} else {
					out.println(" <span class='off'><a href='./shopping_list.do?location="+location+"&cpage="+ (cpage-1) +"'>&lt;</a></span> ");
				}
				out.println(" &nbsp;&nbsp; ");
				
				for ( int i=startBlock; i<=endBlock; i++ ) {
					if ( cpage == i ) { 
						out.println(" <span class='off'>[" + i + "]</span> ");
					} else {
						out.println(" <span class='off'><a href='./shopping_list.do?location="+location+"&cpage=" + i + "'>" + i + "</a></span> ");
					}
				}
				out.println(" &nbsp;&nbsp; ");
				
				if ( cpage == totalPage ) {
					out.println(" <span class='off'><a>&gt;</a></span> ");
				} else {
					out.println(" <span class='off'><a href='./shopping_list.do?location="+location+"&cpage="+ (cpage+1) +"'>&gt;</a></span> ");
				}
				out.println(" &nbsp; ");
				
				if ( cpage != totalPage ) {
					out.println(" <span class='off'><a href='./shopping_list.do?location="+location+"&cpage="+ endBlock +"'>&gt;&gt;</a></span> ");
				} else {
					out.println(" <span class='off'><a>&gt;&gt;</a></span> ");
				}
				out.println(" &nbsp; ");
			%>
			</div>
		</div>
		<!--//페이지넘버-->	
  	</div>
</div>
	

</body>
</html>