<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.model1.ShoppingTO"%>
<%@page import="com.exam.model1.ShoppingCommentTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("utf-8");
	String sa = request.getParameter( "sa" );
	String location = request.getParameter( "location" );
	String cpage = request.getParameter( "cpage" );
	String no = request.getParameter( "no" );
	
	String id = "";
	if( session.getAttribute( "id" ) != null ) {
		id = (String)session.getAttribute( "id" );
	} else if( session.getAttribute( "kakaoid" ) != null ) {
		id = (String)session.getAttribute( "kakaoid" );
	} else {
		id = (String)session.getAttribute("id");
	}
	
	ShoppingTO to = (ShoppingTO)request.getAttribute( "to" );
	
	no = to.getNo();
	String subject = to.getSubject();
	String content = to.getContent();
	String writer = to.getWriter();
	String wdate = to.getWdate();
	String hit = to.getHit();
	location = to.getLocation();
	String picture = to.getPicture();
	String replay = to.getReply();
	String heart = to.getHeart();
	
	ArrayList<ShoppingCommentTO> lists = (ArrayList)request.getAttribute( "lists" );
	StringBuffer sbHtml = new StringBuffer();
	
	for( ShoppingCommentTO commentTo : lists ) {
		sbHtml.append( "<table class='table table-bordered table_reply_view'> " );
		sbHtml.append( "<tr> " );
		sbHtml.append( "	<td class='coment_re' width='20%'>" );
		sbHtml.append( "		<strong>"+ commentTo.getWriter() +"</strong> ("+ commentTo.getWdate() +") " );
		sbHtml.append( "		<div class='coment_re_txt'> " );
		sbHtml.append( "			"+ commentTo.getContent()+"" );
		sbHtml.append( "		</div> " );
		sbHtml.append( "	</td> " );
		sbHtml.append( "</tr> " );
		sbHtml.append( "</table> " );
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 쇼핑 정보</title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/shopping_view.css?wq" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
const commentOk = function() {
	if( document.cfrm.ccontent.value.trim() == '' ) {
		alert( '댓글 내용을 입력해주세요' );
		return false;
	}
	document.cfrm.submit();
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
			<table class="table table-bordered table_view">
			<tr>
				<th width="15%">제목</th>
				<td width="50%"><%= subject %></td>
				<th width="15%">등록일</th>
				<td width="20%"><%= wdate %></td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td><%= writer %></td>
				<th>조회수</th>
				<td><%= hit %></td>
			</tr>
			<tr>
				<td colspan="4" height="200" valign="top" style="padding:20px; line-height:160%">
					<div id="bbs_file_wrap">
						<div>
							<img src="./upload/shopping/<%=picture %>" width="900" onerror="" /><br />
							<%= content %>
						</div>
					</div>
				</td>
			</tr>			
			</table>
			
			<!-- 댓글 쓰는 곳  -->
			<%= sbHtml %>
			
			<!-- 댓글 div  -->
			<div class="view4">
				<form action="./shopping_view_comment_ok.do" method="post" name="cfrm">
					<input type="hidden" name="no" value="<%=no %>" />
					<input type="hidden" name="cpage" value="<%=cpage %>" />
					<table class="table table-bordered table_reply">
					<tr>
						<td width="94%">
							글쓴이 <input type="text" name="cwriter" maxlength="5" class="coment_input" value="<%= id %>" readonly/>&nbsp;&nbsp;
						</td>
						<td width="6%" class="bg01"></td>
					</tr>
					<tr>
						<td class="bg01">
							<textarea name="ccontent" cols="" rows="" class="coment_input_text"></textarea>
						</td>
						<td align="right" class="bg01">
							<input type="button" id="submit_reply" value="댓글등록" class="btn_re btn_txt01" onclick="commentOk()" />
						</td>
						
					</tr>
					</table>
				</form>
			</div>
			
			<!-- 밑에 버튼 영역  -->
			<table class="table table-bordered table_reply_view">
			<tr>
				<td class="coment_re" width="20%">
					<div class="btn_list">
						<input type="button" id="submit_list" value="목록" class="btn btn-success" onclick="location.href='./shopping_list.do?cpage=<%=cpage %>&location=<%=location%>'" />
					</div>
					<div class="btn_dm">
						<input type="button" id="submit_delete" value="삭제" class="btn btn-success" onclick="location.href='./shopping_list.do?cpage=<%=cpage %>&no=<%=no %>" />
						<input type="button" id="submit_modify" value="수정" class="btn btn-success" onclick="location.href='./shopping_list.do?cpage=<%=cpage %>&no=<%=no %>" />
					</div>
				</td>
			</tr>
			</table>
		</div>
		
	</div>
	

	
	
</div>


</body>
</html>