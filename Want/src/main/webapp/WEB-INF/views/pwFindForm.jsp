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
<link href="./resources/css/loginForm.css" rel="stylesheet"/>
<link href="./resources/css/navbar.css" rel="stylesheet">

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="./include/navbar.jsp">
		<jsp:param value="loginForm" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br /><br />

<div class="login-form">
    <form action="pwFindForm_ok.do" method="post" class="form-horizontal">
      	<div class="row">
        	<div align="center">
				<h2>비밀번호 찾기</h2>
				<%-- <form action="${pageContext.request.contextPath)/mail/mailSending}" method="post">
				</form> --%>
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
			
			<button type="submit" class="btn btn-primary btn-lg">비밀번호 찾기</button>
		</div>		

    </form>

</div>
</body>
</html>
		