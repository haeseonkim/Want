<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/picture_write.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">




<script type="text/javascript">
	window.onload = function() {
		document.getElementById('submit1').onclick = function() {
			if(document.wfrm.subject.value.trim() == "") {
				alert('제목을 입력하셔야 합니다.');
				return false;				
			}
			
			if(document.wfrm.country.value.trim() == "(선택 안함)") {
				alert('위치를 입력하셔야 합니다.');
				return false;				
			}
			
			if(document.wfrm.content.value.trim() == "") {
				alert('내용을 입력하셔야 합니다.');
				return false;				
			}
			
			// 파일 업로드 확인 메세지
			if(document.wfrm.media.value.trim() == "") {
				alert('파일을 입력하셔야 합니다.');
				return false;
			} else {
				const extension = document.wfrm.media.value.split('.').pop();
				if(extension != 'png' && extension != 'jpg' && extension != 'gif'&& extension != 'mp4') {
					alert('이미지나 동영상 파일을 입력하셔야 합니다.');	
					return false;
				}
			}
			document.wfrm.submit();
		};
	};
	
	
	// 파일을 선택하면 파일명이 뜨도록 함
	$(document).ready(function(){
		var file_input_container = $('.js-input-file');
	    
        if (file_input_container[0]) {
    
            file_input_container.each(function () {
    
                var that = $(this);
    
                var fileInput = that.find(".input-file");
                var info = that.find(".input-file__info");
    
                fileInput.on("change", function () {
    
                    var fileName;
                    fileName = $(this).val();
    
                    if (fileName.substring(3,11) == 'fakepath') {
                        fileName = fileName.substring(12);
                    }
    
                    if(fileName == "") {
                        info.text("No file chosen");
                    } else {
                        info.text(fileName);
                    }
    
                })
    
            });
        }
	})
</script>


</head>
<body>


	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="picture_write" name="thisPage" />
	</jsp:include>

	<br />
	<div class="page-wrapper bg-light p-t-100 p-b-50">
		<div class="wrapper wrapper--w900">
			<div class="card card-6">
			
				<div class="card-heading">
					<h2 class="title">여행한 곳을 자랑하세요!</h2>
				</div>
				<div class="card-body">
					<form action="./picture_write_ok.do" method="post" name="wfrm" enctype="multipart/form-data">
						<div class="form-row">
							<div class="name">제목</div>
							<div class="value">
								<input class="input--style-6" type="text" name="subject">
							</div>
						</div>
						<div class="form-row">
							<div class="name">위치</div>
							<div class="value">
								<label for="country">국가</label>
								<select id="country" name="country" class="form-select">
									<option>(선택 안함)</option>
									<option>영국</option>
									<option>프랑스</option>
									<option>독일</option>
									<option>이탈리아</option>
									<option>스위스</option>
									<option>그리스</option>
									<option>스페인</option>
									<option>포르투갈</option>
									<option>체코</option>
									<option>헝가리</option>
									<option>오스트리아</option>
									<option>스웨덴</option>
									<option>핀란드</option>
									<option>폴란드</option>
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="name">파일 업로드</div>
							<div class="value">
								<div class="input-group js-input-file">
									<input class="input-file" type="file" name="media" id="file">
									<label class="label--file" for="file">파일 선택</label> <span
										class="input-file__info">No file chosen</span>
								</div>
                                <div class="label--desc">여행 사진 or 동영상을 업로드하세요. 최대파일 크기는 00MB입니다.</div>
							</div>
						</div>
						<div class="form-row">
							<div class="name">내용</div>
							<div class="value">
								<div class="weditor-group">
									<textarea class="weditor" name="content" id="content"></textarea>
									
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="card-footer">
					<button class="btn btn--radius-2 btn--blue-2" type="submit" id="submit1">
						등록하기</button>
				</div>
			</div>
		</div>
	</div>

<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script type="text/javascript" src="./SmartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		 oAppRef: oEditors,
		 elPlaceHolder: "content",
		 sSkinURI: "./SmartEditor/SmartEditor2Skin.html",
		 fCreator: "createSEditor2"
	});
</script>



</body>
</html>