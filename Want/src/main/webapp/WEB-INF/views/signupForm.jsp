<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
<jsp:include page="./include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/signupForm.css" rel="stylesheet"/>
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
	

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
    <form action="#" method="post" class="form-horizontal">
      	<div class="row">
        	<div class="col-8 signuptitle">
				<h2>회원가입</h2>
			</div>	
      	</div>			
        <div class="form-group row">
			<label class="col-form-label col-4">아이디</label>
			<div class="col-8">
                <input type="text" class="form-control" name="id" required="required">
            </div>        	
        </div>

		<div class="form-group row">
			<label class="col-form-label col-4">비밀번호</label>
			<div class="col-8">
                <input type="password" class="form-control" name="password" required="required">
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
                <input type="email" class="form-control" name="email" required="required">
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
                <input type="file" class="form-control" name="upload" value="" class="board_view_input" />
            </div>        	
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">소개글</label>
			<div class="col-8">
                <textarea name="content" class="form-control"></textarea>
            </div>        	
        </div>
        
		<div class="form-group row">
			<div class="col-8 offset-4">
				<%-- 동의 사항 내용은 modal창으로 클릭하면 뜨게 만들기 --%>
				<p><label class="form-check-label"><input type="checkbox" required="required"> <a href="#">개인정보취급방침</a>에 동의하십니까?</label></p>
				<button type="submit" class="btn btn-primary btn-lg">회원가입</button>
			</div>  
		</div>		      
    </form>
	<div class="text-center">이미 회원이십니까? <a href="./loginForm.do">로그인 하러 가기</a></div>
</div>
</body>
</html>
