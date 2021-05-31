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
	
	//닉네임 유효성 검사
	let nick_val = /^[a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{4,15}$/	
	
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
			if( check( nick_val, user_nick ) ) {
				$.ajax({
					url: './usingNick_chk.do?user_nick='+user_nick,
					type: 'GET',
					success: function( data ) {
						
						if( data == "0" ) {
							$( "#usingNick_chk" ).text( "사용할 수 있는 닉네임입니다." );
							$( "#usingNick_chk" ).css( "margin-left", "155px" );
							$( "#usingNick_chk" ).css( "color", "blue" );
							$( "#user_nick" ).val( "" );
							$( "#submit1" ).attr( "disabled", false );
							
						} else if( data == "1"  ) {
							$( "#usingNick_chk" ).text( "사용중인 닉네임입니다." );
							$( "#usingNick_chk" ).css( "margin-left", "155px" );
							$( "#usingNick_chk" ).css( "color", "red" );
							$( "#user_nick" ).val( "" );
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
			$( "#usingNick_chk" ).text( "닉네임을 입력해주세요." );
			$( "#usingNick_chk" ).css( "margin-left", "155px" );
			$( "#usingNick_chk" ).css( "color", "red" );
			$( "#user_nick" ).val( "" );
			$( "#submit1" ).attr( "disabled", true );
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
	
};
	
	//개인정보방침보이는 modal창 설정
/* 	$( '#dialog' ).dialog({
		width: 450,
		height: 500,
		autoOpen: false,
		modal: true,
		resizable: false,
		buttons: {
			'확인': function() {
				$( this ).dialog( 'close' );
			}
		}
	}) 


//개인정보방침 modal창 띄우기
function agree() {
	$( '#dialog' ).dialog( 'open' );
}
 */

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
                <input type="text" class="form-control" id="nick_id" name="nick" placeholder="4~12, 한글, 영어대소문자, 숫자가능">
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
				<p>
					<label class="form-check-label">
						<input type="checkbox" name="info" required="required">
						<a id="agree" href="javascript:agree();" data-bs-toggle="modal" data-bs-target="#modal">개인정보취급방침</a>에 동의하십니까?
					</label>
				</p>
				<button type="submit" id="submit1" class="btn btn-primary btn-lg">회원가입</button>
			</div>  
			
			<!-- 개인정보방침 modal창 내용 -->
			<div class="modal fade" id="modal" tabindex="-1">
			<div class="modal-dialog modal-lg modal-dialog-scrollable modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title"><b>&lt;WANT&gt;</b>개인정보취급방침</h5>
					</div>
					<div class="modal-body">
						<div id="dialog" title="개인정보취급방침" class="modal-dialog">
						<p><b>&lt;Want&gt;</b>은(는) ｢개인정보 보호법｣ 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.</p>
							<ul>
								<li><b>제1조(개인정보의 처리목적)</b> &lt;WANT&gt;은(는) 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 ｢개인정보 보호법｣ 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
									<ol>
										<li>홈페이지 회원 가입 및 관리</li>
										회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별․인증, 회원자격 유지․관리, 서비스 부정이용 방지, 만 14세 미만 아동의 개인정보 처리 시 법정대리인의 동의여부 확인, 각종 고지․통지, 고충처리 목적으로 개인정보를 처리합니다. 
										<li>재화 또는 서비스 제공</li>
										물품배송, 서비스 제공, 계약서․청구서 발송, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증, 요금결제․정산, 채권추심을 목적으로 개인정보를 처리합니다. 
										<li>고충처리</li>
										민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락․통지, 처리결과 통보의 목적으로 개인정보를 처리합니다. 
										<li>WANT의 개인정보 처리 업무</li>
										&lt;개인정보 처리업무에 따른 처리목적&gt;으로 개인정보를 처리합니다. 
									</ol>
								</li> 
								<li><b>제2조(개인정보의 처리 및 보유기간)</b> ① &lt;WANT&gt;은(는) 법령에 따른 개인정보 보유․이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유․이용기간 내에서 개인정보를 처리․보유합니다.<br/>② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다. 
									<ol>
										<li>홈페이지 회원 가입 및 관리 : 사업자/단체 홈페이지 탈퇴 시까지<br />다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료 시까지
											<dl>
												<dd>1) 관계 법령 위반에 따른 수사․조사 등이 진행 중인 경우에는 해당 수사․조사 종료 시까지</dd>
												<dd>2) 홈페이지 이용에 따른 채권․채무관계 잔존 시에는 해당 채권․채무관계 정산 시까지</dd>
												<dd>3) &lt;예외 사유&gt; 시에는 &lt;보유기간&gt; 까지</dd>
											</dl>
										</li>
											
										<li>재화 또는 서비스 제공 : 재화․서비스 공급완료 및 요금결제․정산 완료시까지<br />  다만, 다음의 사유에 해당하는 경우에는 해당 기간 종료 시까지 
											<dl>
												<dd> 1) 「전자상거래 등에서의 소비자 보호에 관한 법률」에 따른 표시․광고, 계약내용 및 이행 등 거래에 관한 기록<br />
											        - 표시․광고에 관한 기록 : 6개월 <br />
											        - 계약 또는 청약철회, 대금결제, 재화 등의 공급기록 : 5년  <br />
											        - 소비자 불만 또는 분쟁처리에 관한 기록 : 3년 
        										</dd>
												<dd>2) 「통신비밀보호법」에 따른 통신사실확인자료 보관<br />
											       - 가입자 전기통신일시, 개시․종료시간, 상대방 가입자번호, 사용도수, 발신기지국 위치추적자료 : 1년 <br />
											       - 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월<br />
       											</dd>
												<dd>3) &lt;개인정보 보유기간 근거법령 및 조문&gt; : &lt;3개월&gt;</dd>
											</dl>
										</li>
										<li>&lt;개인정보 처리업무&gt; : &lt;3개월&gt;</li>
									</ol>
								</li>
								<li><b>기타 모든 사항은 개인정보 처리 방침을 따릅니다.</b></li>
							</ul>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
			</div>
		</div>		      
    </form>
	<div class="text-center">이미 회원이십니까? <a href="./loginForm.do">로그인 하러 가기</a></div>
</div>
</body>
</html>
