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
<link href="./resources/css/loginForm.css" rel="stylesheet"/>
<link href="./resources/css/navbar.css" rel="stylesheet">


</head>
<body>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	//d2d78fe4b3e00dbdb6af02d56f8c765a
	window.Kakao.init("d2d78fe4b3e00dbdb6af02d56f8c765a");
	
	function kakaoLogin(){
		window.Kakao.Auth.login({
			scope:'profile,account_email,birthday',
			success: function(authObj){
				console.log(authObj);
				window.Kakao.API.request({
					url: '/v2/user/me',
					success: res => {
						alert(JSON.stringify(res))
					}
				});
				
			}
		});
	}
</script>

	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="loginForm" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br /><br />
	
<div class="login-form" data-aos="fade-up">
    <form action="loginForm_ok.do" method="post" class="form-horizontal">
      	<div class="row">
        	<div class="col-8 offset-4">
				<h2>로그인</h2>
			</div>	
      	</div>			
        <div class="form-group row">
			<label class="col-form-label col-4">아이디</label>
			<div class="col-8">
                <input type="text" class="form-control" name="id" placeholder="ID 입력..." required="required">
            </div>        	
        </div>

		<div class="form-group row">
			<label class="col-form-label col-4">비밀번호</label>
			<div class="col-8">
                <input type="password" class="form-control" name="password" placeholder="Password 입력..." required="required">
            </div>        	
        </div>
		<div class="form-group row">
			<div class="col-8 offset-2">
				<button type="submit" class="btn btn-primary btn-lg">로그인</button>
			</div>		
		</div>		
		
		<div class="form-group row">
			<div class="or-seperator"><b>or</b></div>
		</div>
		
		<div class="form-group row" id="kakaologin">
			<div class="col-8 offset-2">
				<a href="javascript:kakaoLogin();">
					<img src="./resources/img/kakao_login_medium_wide.png" />
				</a>
			</div>	
		</div>	
		     
    </form>
	<div class="text-center">비밀번호가 기억나지 않습니까? <a href="#">비밀번호 찾기</a></div>
	<div class="text-center">아직 회원이 아니십니까? <a href="./signupForm.do">회원가입</a></div>
</div>
</body>
</html>
