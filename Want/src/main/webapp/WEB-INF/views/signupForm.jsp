<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 정현수 수정 -->
<title>Want 회원가입</title>
<!-- 정현수 수정 끝 -->
	
<jsp:include page="./include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/signupForm.css" rel="stylesheet"/>
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
window.onload = function() {
    document.getElementById('submit1').onclick = function() {
       if(document.sfrm.info.checked == false) {
          alert('동의를 하셔야 합니다.');
          return false;
       }
       document.sfrm.submit();
    };
 };

</script>
</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="./include/navbar.jsp">
		<jsp:param value="signupForm" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />

<div class="signup-form">
    <form action="./signup_ok.do" method="post" name="sfrm" class="form-horizontal" enctype="multipart/form-data">
      	<div class="row">
        	<div class="col-8 signuptitle">
				<h2>회원가입</h2>
			</div>	
      	</div>			
      	<!-- 현수 수정 -->
        <div class="form-group row">
			<label class="col-form-label col-4">아이디</label>
			<div class="col-8">
                <input type="text" class="form-control" name="id" required="required">
            </div>        	
        </div>

		<div class="form-group row">
			<label class="col-form-label col-4">비밀번호</label>
			<div class="col-8">
                <input type="password" class="form-control" name="pwd" required="required">
            </div>        	
        </div>
		<div class="form-group row">
			<label class="col-form-label col-4">비밀번호 확인</label>
			<div class="col-8">
                <input type="password" class="form-control" name="confirm_password" required="required">
            </div>        	
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">이름</label>
			<div class="col-8">
                <input type="text" class="form-control" name="name" required="required">
            </div>        	
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">생년월일</label>
			<div class="col-8">
                <input type="text" class="form-control" name="birth" place-holder="YYMMDD" required="required">
            </div>        	
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">이메일</label>
			<div class="col-8">
                <input type="email" class="form-control" name="mail" required="required">
            </div>        	
        </div>
        <div class="form-group row">
			<label class="col-form-label col-4">전화번호</label>
			<div class="col-8">
                <input type="email" class="form-control" name="phone" required="required">
            </div>        	
        </div>
        <div class="form-group row">
			<label class="col-form-label col-4">닉네임</label>
			<div class="col-8">
                <input type="text" class="form-control" name="nick"  required="required">
            </div>        	
        </div>
        <div class="form-group row">
			<label class="col-form-label col-4">프로필 사진</label>
			<div class="col-8">
                <input type="file" class="form-control" name="profile" value="" class="board_view_input" />
            </div>        	
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">소개글</label>
			<div class="col-8">
                <textarea name="greet" class="form-control"></textarea>
            </div>        	
        </div>
        <!-- 현수 수정 끝 -->
		<div class="form-group row">
			<div class="col-8 offset-4">
				<%-- 동의 사항 내용은 modal창으로 클릭하면 뜨게 만들기 --%>
				<p><label class="form-check-label"><input type="checkbox" name="info" required="required"> <a href="signup_ok.do">개인정보취급방침</a>에 동의하십니까?</label></p>
				<button type="submit" id="submit1" class="btn btn-primary btn-lg">회원가입</button>
			</div>  
		</div>		      
    </form>
	<div class="text-center">이미 회원이십니까? <a href="./loginForm.do">로그인 하러 가기</a></div>
</div>
</body>
</html>
