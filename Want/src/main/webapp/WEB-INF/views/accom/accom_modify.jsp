<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.exam.model1.accom.AccomTO"%>

<%
	request.setCharacterEncoding("utf-8");

	AccomTO to = (AccomTO)request.getAttribute( "to" );
	
	String no = to.getNo();
	String writer = to.getWriter();
	String subject = to.getSubject();
	String location = to.getLocation();
	String picture = to.getPicture();
	String content = to.getContent();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 숙소 글수정</title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- Summernote -->
<script src="./summernote/summernote-lite.js"></script>
<script src="./summernote/lang/summernote-ko-KR.js"></script>

<!-- Summernote CSS File -->
<link rel="stylesheet" href="./summernote/summernote-lite.css">

<!-- CSS File -->
<link href="./resources/css/shopping_modify.css?asa" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">


<script type="text/javascript">
	window.onload = function() {
		// 파일을 선택하면 파일명이 뜨도록 함
		var file_input_container = $('.js-input-file');
		if (file_input_container[0]) {
			file_input_container.each(function() {

				var that = $(this);

				var fileInput = that.find(".input-file");
				var info = that.find(".input-file__info");

				fileInput.on("change", function() {

					var fileName;
					fileName = $(this).val();

					if (fileName.substring(3, 11) == 'fakepath') {
						fileName = fileName.substring(12);
					}

					if (fileName == "") {
						info.text( "<%=picture%>" );
					} else {
						info.text(fileName);
					}

				})

			});
		}
		
		// Summernote 설정
		var toolbar = [
		    // 글꼴 설정
		    ['fontname', ['fontname']],
		    // 글자 크기 설정
		    ['fontsize', ['fontsize']],
		    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    // 글자색
		    ['color', ['forecolor','color']],
		    // 표만들기
		    ['table', ['table']],
		    // 글머리 기호, 번호매기기, 문단정렬
		    ['para', ['ul', 'ol', 'paragraph']],
		    // 줄간격
		    ['height', ['height']],
		    // 그림첨부, 링크만들기, 동영상첨부
		    //['insert',['picture','link','video']],
		    //['insert',['link']],
		    // 코드보기, 확대해서보기, 도움말
		    ['view', ['codeview','fullscreen', 'help']]
		  ];
		
		let setting = {
				height: 300,                 // 에디터 높이
				  minHeight: null,             // 최소 높이
				  maxHeight: null,             // 최대 높이
				  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
				  lang: "ko-KR",					// 한글 설정
				  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
		}
		$('.summernote').summernote(setting);
		
		
		document.getElementById( 'submit1' ).onclick = function() {
			if ( document.wfrm.subject.value.trim() == '' ) {
				alert( '제목을 입력해주세요' );
				return false;
			}
			if ( document.wfrm.content.value.trim() == '' ) {
				alert( '내용을 입력해주세요' );
				return false;
			}
			if ( !document.wfrm.picture.value.trim() == '' ) {
				var fileValue = document.wfrm.picture.value.trim().split('\\');
				var filename = fileValue[fileValue.length-1];
				var fileEname = filename.substring(filename.length-4, filename.length);
				if ( fileEname == '.jpg' || fileEname == '.png' || fileEname == '.gif' || fileEname == '.GIF' || fileEname == '.PNG' || fileEname == '.JPG' ) {} 
				else {
					alert( '사진파일만 첨부해주세요.(jpg, png, gif)' );
					document.wfrm.picture_name.value = '';
					return false;
				}
			} 
			document.wfrm.submit();
		}
		
	};
	

</script>


</head>
<body>


	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="accom_modify" name="thisPage" />
	</jsp:include>

	<br />
	<div class="page-wrapper bg-light p-t-100 p-b-50">
		<div class="wrapper wrapper--w900">
			<div class="card card-6">

				<div class="card-heading">
					<h2 class="title">숙소 정보 수정</h2>
				</div>
				<div class="card-body">
					<form action="./accom_modify_ok.do" method="post" name="wfrm" enctype="multipart/form-data">
						<input type="hidden" name="no" value="<%=no %>" />
						
						<div class="form-row">
							<div class="name">글쓴이</div>
							<div class="value">
								<input class="input--style-6" type="text" name="writer" value="<%= writer %>" readonly>
							</div>
						</div>
						<div class="form-row">
							<div class="name">제목</div>
							<div class="value">
								<input class="input--style-6" type="text" name="subject" value="<%= subject %>">
							</div>
						</div>
						<div class="form-row">
							<div class="name">위치</div>
							<div class="value">
								<input class="input--style-6" type="text" name="location" value="<%= location %>" readonly>
							</div>
						</div>
						<div class="form-row">
							<div class="name">파일 업로드</div>
							<div class="value">
								<div class="input-group js-input-file">
									<input type="hidden" name="ex-picture" value=<%= picture %> />
									<input class="input-file" type="file" name="picture" id="file">
									<label class="label--file" for="file">파일 선택</label> 
									<span class="input-file__info" id="picture_name"><%= picture %></span>
								</div>
								<div class="label--desc">숙소 사진을 업로드하세요.</div>
							</div>
						</div>
						
						<div class="form-row">
							<div class="name">내용</div>
							<div class="value">
								<div class="summernote-group">
									<textarea class="summernote" name="content" id="content"><%= content %></textarea>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="card-footer">
					<button class="btn btn--radius-2 btn--blue-2" type="submit" id="submit1" >수정하기</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>