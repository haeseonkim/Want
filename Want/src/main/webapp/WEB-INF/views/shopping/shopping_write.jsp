<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String writer = (String)session.getAttribute( "id" );
	String cityName = request.getParameter( "cityName" );
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 쇼핑 글쓰기</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/shopping_write.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Song+Myung&display=swap" rel="stylesheet">	

<script type="text/javascript">
window.onload = function() {
	document.getElementById( 'submit1' ).onclick = function() {
		if ( document.s_wfrm.writer.value.trim() == '' ) {
			alert( '글쓴이를 입력해주세요' );
			return false;
		}
		if ( document.s_wfrm.subject.value.trim() == '' ) {
			alert( '제목을 입력해주세요' );
			return false;
		}
		if ( document.s_wfrm.content.value.trim() == '' ) {
			alert( '내용을 입력해주세요' );
			return false;
		}
		if ( !document.s_wfrm.picture.value.trim() == '' ) {
			var fileValue = document.s_wfrm.picture.value.trim().split('\\');
			var filename = fileValue[fileValue.length-1];
			var fileEname = filename.substring(filename.length-4, filename.length);
			if ( fileEname == '.jpg' || fileEname == '.png' || fileEname == '.gif' || fileEname == '.GIF' || fileEname == '.PNG' || fileEname == '.JPG' ) {} 
			else {
				alert( '사진파일만 첨부해주세요.(jpg, png, gif)' );
				document.s_wfrm.picture.value = '';
				return false;
			}
		} 
		document.s_wfrm.submit();
	}
}
</script>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="shopping_write" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />
<div class="contents1"> 
	<div class="select-form">
		<div class="col-8 offset-3">
			<h3>쇼핑 정보 등록</h3>
		</div>	
	</div>
	
	<form action="./shopping_write_ok.do" method="post" name="s_wfrm" enctype="multipart/form-data">
		<input type="hidden" name="cpage" value="" />
		<div class="contents_sub">
		<!--게시판-->
			<div class="board_write">
				<table>
				<tr>
					<th class="top">글쓴이</th>
					<td class="top" colspan="3"><input type="text" name="writer" value="<%= writer %>" class="board_view_input_mail" maxlength="5" readonly /></td>
				</tr>
				<tr>
					<th>도시이름</th>
					<td colspan="3"><input type="text" name="city" value="<%= cityName %>" class="board_view_input" readonly /></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" name="subject" value="" class="board_view_input" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<textarea name="content" class="board_editor_area"></textarea>
					</td>
				</tr>
				<tr>
					<th>사진</th>
					<td colspan="3">
						<input type="file" name="picture" value="" class="board_view_input" /><br /><br />
					</td>
				</tr>
				</table>
				
				<table>	
				</table>
			</div>

			<div class="btn_area">
				<div class="align_left">			
					<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='./shopping_list.do?cityName=<%=cityName %>'" />
				</div>
				<div class="align_right">			
					<input type="button" value="쓰기" id="submit1" class="btn_write btn_txt01" style="cursor: pointer;" />					
				</div>	
			</div>	
			<!--//게시판-->
		</div>
	</form>
</div>
</body>
</html>