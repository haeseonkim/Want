<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
   if( request.getAttribute( "flag" ) != null && !request.getAttribute( "flag" ).equals( "" ) ) {
      int flag = (Integer)request.getAttribute( "flag" );
      
      out.println( " <script type='text/javascript'> " );
      if( flag == 0 ) {   //로그인성공
         session.setAttribute( "id", request.getAttribute( "id" ) );
         out.println( " alert('로그인에 성공했습니다.'); " );
         out.println( " location.href='./lanTrip_list.do'" );
      } else if( flag == 1 ) {   //비번틀림
         out.println( " alert('비밀번호가 틀립니다.'); " );
         out.println( " location.href='./loginForm.do' " );
      } else if( flag == 2 ) {   //회원정보없음
         out.println( " alert('회원정보가 없습니다. 회원가입해주세요.'); " );
         out.println( " location.href='./loginForm.do' " );
      } else {               //기타 에러났을 때 또는 맨처음 시작
         out.println( " location.href='./loginForm.do' " );
      }
      out.println( " </script> " );
   }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 로그인</title>
   
<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/loginForm.css" rel="stylesheet"/>
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
   window.onload = function() {
      document.getElementById('login_submit').onclick = function() {
         document.login_frm.submit();
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
    <form method="post" class="form-horizontal" name="login_frm">
       <input type="hidden" name="login_ok" value="1"/>  <!-- form넘어갈때 얘도 같이넘어가서 회원정보비교함   -->
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
         <button type="submit" id="login_submit" class="btn btn-primary btn-lg">로그인</button>
      </div>      
      
      <div class="form-group row">
         <div class="or-seperator"><b>or</b></div>
      </div>
      
      <div class="form-group row">
         <button type="submit" class="kakaobtn btn-primary btn-lg">카카오톡으로 로그인</button>
      </div>   
           
    </form>
   <div class="text-center">비밀번호가 기억나지 않습니까? <a href="#">비밀번호 찾기</a></div>
   <div class="text-center">아직 회원이 아니십니까? <a href="./signupForm.do">회원가입</a></div>
</div>
</body>
</html>