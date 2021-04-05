<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	if( request.getAttribute( "flag" ) != null && !request.getAttribute( "flag" ).equals( "" ) ) {
		int flag = (Integer)request.getAttribute( "flag" );
		
		out.println( " <script type='text/javascript'> " );
		if( flag == 0 ) {	//로그인성공
			out.println( " alert('로그인에 성공했습니다.'); " );
			out.println( " location.href='./lanTrip_list.do'" );
		} else if( flag == 1 ) {	//비번틀림
			out.println( " alert('없는 메일주소입니다.'); " );
			out.println( " location.href='./loginForm.do' " );
		} else if( flag == 2 ) {	//회원정보없음
			out.println( " alert('회원정보가 없습니다. 회원가입해주세요.'); " );
			out.println( " location.href='./loginForm.do' " );
		} else {					//기타 에러났을 때 또는 맨처음 시작
			out.println( " location.href='./loginForm.do' " );
		}
		out.println( " </script> " );
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/loginForm.css" rel="stylesheet"/>
<link href="./resources/css/navbar.css" rel="stylesheet">


<script>
	
	window.onload = function() {
		document.getElementById('submit').onclick = function() {
			
			if ( document.wfrm.id.value.trim() == '' ) {
				alert( 'ID를 입력해주세요' );
				return false;
			}
			if ( document.wfrm.mail.value.trim() == '' ) {
				alert( '메일을 입력해주세요' );
				return false;
			}
			document.pwFind_frm.submit();
		}
	}
</script>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="loginForm" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br /><br />

<div class="login-form">
    <form action="pwFindForm_ok.do" method="post" class="form-horizontal">
      	<div class="row">
        	<div align="center">
				<h2>비밀번호 찾기</h2>
			</div>	
      	</div>			
        <div class="form-group row">
			<label class="col-form-label col-4">아이디</label>
			<div class="col-8">
                <input type="text" class="form-control" name="id" placeholder="아이디를 입력하세요." required="required">
            </div>        	
        </div>

		<div class="form-group row">
			<label class="col-form-label col-4">이메일</label>
			<div class="col-8">
                <input type="text" class="form-control" name="mail" placeholder="메일을 입력하세요." required="required">
            </div>        	
        </div>
		<div class="form-group row">
			<button type="submit" id="submit" class="btn btn-primary btn-lg">비밀번호 찾기</button>
		</div>		

    </form>

</div>
</body>
</html>
		