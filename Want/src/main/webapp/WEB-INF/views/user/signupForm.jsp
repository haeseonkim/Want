<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 회원가입</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/signupForm.css" rel="stylesheet"/>
<link href="./resources/css/navbar.css" rel="stylesheet">

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/ui-darkness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">
window.onload = function() {
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
	
	//id 중복 검사
	$( "#user_id" ).blur( function() {
		var user_id = $( "#user_id" ).val();
		if( user_id != '' ) {
			if( check( val, user_id ) ) {
				$.ajax({
					url: './usingId_chk.do?user_id='+user_id,
					type: 'GET',
					success: function( data ) {
						
						if( data == "0" ) {
							$( "#usingId_chk" ).text( "사용할 수 있는 ID입니다." );
							$( "#usingId_chk" ).css( "margin-left", "155px" );
							$( "#usingId_chk" ).css( "color", "blue" );
							$( "#submit1" ).attr( "disabled", false );
						} else if( data == "1"  ) {
							$( "#usingId_chk" ).text( "사용중인 ID입니다." );
							$( "#usingId_chk" ).css( "margin-left", "155px" );
							$( "#usingId_chk" ).css( "color", "red" );
							$( "#submit1" ).attr( "disabled", true );
						}
					},
					error: function() {
						console.log( "signupForm의 ajax 에러" )
					}
				})
			} else {
				$( "#usingId_chk" ).text( "ID가 형식에 맞지않습니다." );
				$( "#usingId_chk" ).css( "margin-left", "155px" );
				$( "#usingId_chk" ).css( "color", "red" );
				$( "#user_id" ).val( "" );
				$( "#submit1" ).attr( "disabled", true );
			}	
		} else {
			$( "#usingId_chk" ).text( "" );
		}
	})
	
	//닉네임 중복 검사
	$( "#nick_id" ).blur( function() {
		var user_nick = $( "#nick_id" ).val();
		if( user_nick != '' ) {
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
			$( "#usingNick_chk" ).text( "" );
		}
	})
	//패스워드 유효성 검사
	$( "#user_pwd" ).blur( function() {
		var user_pwd = $( "#user_pwd" ).val();
		
		if( !check( val, user_pwd ) ) {
			$( "#pwd_chk" ).text( "패스워드가 형식에 맞지 않습니다." );
			$( "#pwd_chk" ).css( "margin-left", "155px" );
			$( "#pwd_chk" ).css( "color", "red" );
			$( "#user_pwd" ).val( "" );
			$( "#submit1" ).attr( "disabled", true );
		} else{
			$( "#pwd_chk" ).text( "" );
			//패스워드 똑같이 입력했는지 검사
			$( "#user_cpwd" ).blur( function() {
				var user_pwd = $( "#user_pwd" ).val();
				var user_cpwd = $( "#user_cpwd" ).val();
				
				if( user_pwd != '' && user_cpwd != '' ) {
					if( user_pwd == user_cpwd ) {
						$( "#cpwd_chk" ).text( "비밀번호가 같습니다." );
						$( "#cpwd_chk" ).css( "margin-left", "155px" );
						$( "#cpwd_chk" ).css( "color", "blue" );
						$( "#submit1" ).attr( "disabled", false );
					} else {
						$( "#cpwd_chk" ).text( "비밀번호가 틀립니다." );
						$( "#cpwd_chk" ).css( "margin-left", "155px" );
						$( "#cpwd_chk" ).css( "color", "red" );
						$( "#user_cpwd" ).val( "" );
						$( "#submit1" ).attr( "disabled", true );
					}
				} else {
					$( "#pwd_chk" ).text( "" );
					$( "#submit1" ).attr( "disabled", false );
				}
				
			})
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
	
	document.getElementById('submit1').onclick = function() {
		let id = document.sfrm.id.value.trim()
		let pwd = document.sfrm.pwd.value.trim()
		let mail = document.sfrm.mail.value.trim()
		let birth = document.sfrm.birth.value.trim()
		let phone = document.sfrm.phone.value.trim()
		
		if( id == '' ) {
			alert( 'ID를 입력하셔야 합니다.' )
			document.sfrm.id.focus()
			return false;
		} 
		if( pwd == '' ) {
			alert( '비밀번호를 입력하셔야 합니다.')
			return false;
		}
		if( document.sfrm.name.value.trim() == '' ) {
			alert( '이름을 입력하셔야 합니다.')
			return false;
		}
		if( birth == '' ) {
			alert( '생년월일을 입력하셔야 합니다.')
			return false;
		}
		if( mail == '' ) {
			alert( '이메일을 입력하셔야 합니다.')
			return false;
		}
		if( phone == '' ) {
			alert( '핸드폰 번호를 입력하셔야 합니다.')
			return false;
		}
		if( document.sfrm.nick.value.trim() == '' ) {
			alert( '닉네임을 입력하셔야 합니다.')
			return false;
		}
		if(document.sfrm.info.checked == false) {
			alert('동의를 하셔야 합니다.');
			return false;
		}
		//파일형식 검사(사진파일만 가능)
		if ( document.sfrm.profile.value.trim() != '' ) {
			var fileValue = document.sfrm.profile.value.trim().split('\\');
			var filename = fileValue[fileValue.length-1];
			var fileEname = filename.substring(filename.length-4, filename.length);
			if ( fileEname == '.jpg' || fileEname == '.png' || fileEname == '.gif' || fileEname == '.GIF' || fileEname == '.PNG' || fileEname == '.JPG' ) {} 
			else {
				alert( '사진파일만 첨부해주세요.(jpg, png, gif)' );
				document.sfrm.profile.value = '';
				return false;
			}
		}
		document.sfrm.submit();
	};
	
	//개인정보방침보이는 modal창 설정
	$( '#dialog' ).dialog({
		width: 700,
		height: 500,
		autoOpen: false,
		modal: true,
		resizable: false,
		buttons: {
			'확인': function() {
				$( this ).dialog( 'close' );
			}
		},
		show: {
			effect: 'blind',
			duration: 1000
		},
		hide: {
			effect: 'blind',
			duration: 1000
		}
	})
};

//개인정보방침 modal창 띄우기
function agree() {
	$( '#dialog' ).dialog( 'open' );
}


</script>
</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
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
        <div class="form-group row">
			<label class="col-form-label col-4">아이디</label>
			<div class="col-8">
                <input type="text" class="form-control" id="user_id" name="id" placeholder="4~12, 영어대소문자, 숫자가능" required="required">
            </div>            
            <div id="usingId_chk"></div>
        </div>

		<div class="form-group row">
			<label class="col-form-label col-4">비밀번호</label>
			<div class="col-8">
                <input type="password" class="form-control" id="user_pwd" name="pwd" placeholder="4~12, 영어대소문자, 숫자가능" required="required">
            </div>   	
            <div id="pwd_chk"></div>
        </div>
		<div class="form-group row">
			<label class="col-form-label col-4">비밀번호 확인</label>
			<div class="col-8">
                <input type="password" class="form-control" id="user_cpwd" name="confirm_pwd">
            </div>        	
            <div id="cpwd_chk"></div>
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">이름</label>
			<div class="col-8">
                <input type="text" class="form-control" name="name" >
            </div>        	
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">생년월일</label>
			<div class="col-8">
                <input type="text" class="form-control" id="user_birth" name="birth" placeholder="YYMMDD" >
            </div>        	
            <div id="birth_chk"></div>
        </div>
        
        <div class="form-group row">
			<label class="col-form-label col-4">이메일</label>
			<div class="col-8">
                <input type="email" class="form-control" id="user_mail" name="mail" placeholder="want@want.com" >
            </div>        	 
            <div id="mail_chk"></div>
        </div>
        <div class="form-group row">
			<label class="col-form-label col-4">전화번호</label>
			<div class="col-8">
                <input type="tel" class="form-control" id="user_phone" name="phone" placeholder="010-1234-5678" >
            </div>   
            <div id="phone_chk"></div>     	
        </div>
        <div class="form-group row">
			<label class="col-form-label col-4">닉네임</label>
			<div class="col-8">
                <input type="text" class="form-control" id="nick_id" name="nick" >
            </div>        	
            <div id="usingNick_chk"></div>
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
		<div class="form-group row">
			<div class="col-8 offset-4">
				<%-- 동의 사항 내용은 modal창으로 클릭하면 뜨게 만들기 --%>
				<p><label class="form-check-label"><input type="checkbox" name="info" required="required"><a id="agree" href="javascript:agree();">개인정보취급방침</a>에 동의하십니까?</label></p>
				<button type="submit" id="submit1" class="btn btn-primary btn-lg">회원가입</button>
			</div>  
			
			<!-- 개인정보방침 modal창 내용 -->  
			<div id="dialog" title="개인정보취급방침">
				<p>
				1. 수집 개인정보 항목 : 회사명, 담당자명, 메일 주소, 전화번호, 홈페이지 주소, 팩스번호, 주소 <br />
				2. 개인정보의 수집 및 이용목적 : 제휴신청에 따른 본인확인 및 원활한 의사소통 경로 확보 <br />
				3. 개인정보의 이용기간 : 모든 검토가 완료된 후 3개월간 이용자의 조회를 위하여 보관하며, 이후 해당정보를 지체 없이 파기합니다. <br />
				4. 그 밖의 사항은 개인정보취급방침을 준수합니다.
				</p>
			</div>
		</div>		      
    </form>
	<div class="text-center">이미 회원이십니까? <a href="./loginForm.do">로그인 하러 가기</a></div>
</div>
</body>
</html>
