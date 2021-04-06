<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/edit_profile.css" rel="stylesheet"/>
<link href="./resources/css/navbar.css" rel="stylesheet">

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/ui-darkness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	//id와pw 적합여부 검사(4~12자리, 영어대소문자, 숫자만 가능)
	let val = /^[a-zA-Z0-9]{4,15}$/		
	
	//생년월일 적합여부 검사
	let birth_val = /([0-9]{2}(0[1-9]{1}|1[0-2]{1})(0[1-9]{1}|[1,2]{1}[0-9]{1}|3[0,1]{1}))/g
	
	//이메일형식 적합여부 검사
	let mail_val = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i
	
	//폰번호 적합여부 검사
	let phone_val = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/
	
	//형식검사하는 메서드
	function check( val, target ) {
		if( val.test( target ) ) {
			return true;
		}
	}
	
	
	//닉네임 중복 검사
	$( "#nick_id" ).blur( function() {
		var user_nick = $( "#nick_id" ).val();
		
		if( user_nick != '' ) {
			
			if( check( val, user_nick ) ) {
				$.ajax({
					url: './usingNick_chk.do?user_nick='+user_nick,
					type: 'GET',
					success: function( data ) {
						
						if( data == "0" ) {
							$( "#usingNick_chk" ).text( "사용할 수 있는 닉네임입니다." );
							$( "#usingNick_chk" ).css( "margin-left", "155px" );
							$( "#usingNick_chk" ).css( "color", "blue" );
							$( "#submit1" ).attr( "disabled", false );
						} else if( data == "1"  ) {
							$( "#usingNick_chk" ).text( "사용중인 닉네임입니다." );
							$( "#usingNick_chk" ).css( "margin-left", "155px" );
							$( "#usingNick_chk" ).css( "color", "red" );
							$( "#submit1" ).attr( "disabled", true );
						}
					},
					error: function() {
						console.log( "signupForm의 ajax 에러" )
					}
				})
			} else {
				$( "#usingNick_chk" ).text( "닉네임이 형식에 맞지않습니다." );
				$( "#usingNick_chk" ).css( "margin-left", "155px" );
				$( "#usingNick_chk" ).css( "color", "red" );
				$( "#user_nick" ).val( "" );
				$( "#submit1" ).attr( "disabled", true );
			}
			
		} else {
			$( "#usingNick_chk" ).text( "닉네임이 형식에 맞지않습니다." );
			$( "#usingNick_chk" ).css( "margin-left", "155px" );
			$( "#usingNick_chk" ).css( "color", "red" );
			$( "#user_nick" ).val( "" );
			$( "#submit1" ).attr( "disabled", true );
			$( "#usingNick_chk" ).text( "" );
		}
	})

	
	//생년월일 유효성검사
	$( "#user_birth" ).blur( function() {
		var user_birth = $( '#user_birth' ).val();
		
		if( user_birth.length != 6 || !check( birth_val, user_birth ) ) {
			$( "#birth_chk" ).text( "생년월일이 형식에 맞지않습니다." );
			$( "#birth_chk" ).css( "margin-left", "155px" );
			$( "#birth_chk" ).css( "color", "red" );
			$( '#user_birth' ).val( "" );
			$( "#submit1" ).attr( "disabled", true );
		} else {
			$( "#birth_chk" ).text( "" );
			$( "#submit1" ).attr( "disabled", false );
		}
	})
	
	//이메일 유효성검사
	$( "#user_mail" ).blur( function() {
		var user_mail = $( "#user_mail" ).val();
		
		if( !check( mail_val, user_mail ) ) {
			$( "#mail_chk" ).text( "메일이 형식에 맞지않습니다." );
			$( "#mail_chk" ).css( "margin-left", "155px" );
			$( "#mail_chk" ).css( "color", "red" );
			$( '#user_mail' ).val( "" );
			$( "#submit1" ).attr( "disabled", true );
		} else {
			$( "#mail_chk" ).text( "" );
			$( "#submit1" ).attr( "disabled", false );
		}
	})
	
	//전화번호 유효성검사
	$( '#user_phone' ).blur( function() {
		var user_phone = $( '#user_phone' ).val();
		
		if( !check( phone_val, user_phone ) ) {
			$( "#phone_chk" ).text( "휴대폰번호가 형식에 맞지않습니다." );
			$( "#phone_chk" ).css( "margin-left", "155px" );
			$( "#phone_chk" ).css( "color", "red" );
			$( '#user_phone' ).val( "" );
			$( "#submit1" ).attr( "disabled", true );
		} else {
			$( "#phone_chk" ).text( "" );
			$( "#submit1" ).attr( "disabled", false );
		}
	})
	
	$('#submit1').on('click',function() {
		document.sfrm.submit();
	});
});

</script>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="editProfile" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />

<div class="signup-form">
    <form action="./edit_profile_ok.do" method="post" name="sfrm" class="form-horizontal">
      	<div class="row">
        	<div class="col-10 signuptitle">
				<h2>회원정보 수정</h2>
			</div>	
      	</div>			
        <div class="form-group row">
			<label class="col-form-label col-4">아이디</label>
			<div class="col-8">
                <input type="text" class="form-control" id="user_id" name="id" value="${uto.id }" required="required" readonly>
            </div>            
            <div id="usingId_chk"></div>
        </div>

        <div class="form-group row">
			<label class="col-form-label col-4">이름</label>
			<div class="col-8">
                <input type="text" class="form-control" name="name" value="${uto.name }" readonly>
            </div>        	
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">생년월일</label>
			<div class="col-8">
                <input type="text" class="form-control" id="user_birth" name="birth" placeholder="YYMMDD" value="${uto.birth }">
            </div>        	
            <div id="birth_chk"></div>
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">이메일</label>
			<div class="col-8">
                <input type="email" class="form-control" id="user_mail" name="mail" placeholder="want@want.com" value="${uto.mail }">
            </div>        	 
            <div id="mail_chk"></div>
        </div>
        <div class="form-group row">
			<label class="col-form-label col-4">전화번호</label>
			<div class="col-8">
                <input type="tel" class="form-control" id="user_phone" name="phone" placeholder="010-1234-5678" value="${uto.phone }">
            </div>   
            <div id="phone_chk"></div>     	
        </div>
        <div class="form-group row">
			<label class="col-form-label col-4">닉네임</label>
			<div class="col-8">
                <input type="text" class="form-control" id="nick_id" name="nick" placeholder="4~12, 영어대소문자, 숫자가능" value="${uto.nick }">
            </div>        	
            <div id="usingNick_chk"></div>
        </div>

        <div class="form-group row">
			<label class="col-form-label col-4">소개글</label>
			<div class="col-8">
                <textarea name="greet" class="form-control" style="resize:none; height:100pt;">${uto.greet }</textarea>
            </div>
        </div>
		<div class="form-group row">
			<div class="col-8 offset-4">
				<button type="submit" id="submit1" class="btn btn-primary btn-lg">수정하기</button>
			</div>  
			
		</div>		      
    </form>
</div>


</body>
</html>
