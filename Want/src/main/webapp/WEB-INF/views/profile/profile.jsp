<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 내프로필</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/profile.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">


</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="profile" name="thisPage" />
	</jsp:include>
	
	<section id="profile" class="container">
		<div class="row">
			<div class="col-6">
				<h1><b>내 프로필</b></h1>
			</div>
		</div>
		
		<hr /><br />
		
		<div class="row">
			<div id="profile-img" class="section-title col-5">
				<img src="./upload/profile/default_profile.png" class="img-circle">
				<br />
				<div id="btns" class="row">
					<div class="col-2">&nbsp;</div>
					<div class="col-4">
						<button type="button" class="btn btn--blue-2 btn--radius-2">수정</button>
						<button type="button" class="btn btn--blue-2 btn--radius-2">삭제</button>
					</div>
					<div class="col-6">&nbsp;</div>
				</div>
			</div> <!-- profile-img 닫음 -->
			<div id="profile-info" class="col-7">
				<table>
					<tr>
						<th>이름</th>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>정현수</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>WANT</td>
					</tr>
					<tr>
						<th>메일</th>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>want@want.com</td>
					</tr>
					<tr>
						<th>가입일</th>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>2021-03-28 17:50:52</td>
					</tr>
					<tr>
						<th>인사말</th>		
					</tr>
				</table>
				<br />
				<div id="greeting">
					<p id="greet">&nbsp;인사말</p>
				</div>
				<div id="btn-modify" class="col-12">
					<button type="button" class="btn btn--blue-2 btn--radius-2">수정하기</button>
				</div>
			</div>	<!-- profile info 닫음 -->
		</div>	<!-- row 닫음 -->
	</section>

	<section id="my-feed" class="container">
		<div class="row">
			<div class="col-6">
				<h1><b>내 피드</b></h1>
			</div>
			<div id="btn-modify" class="col-6">
			<br />
				<button type="button" class="btn btn--blue-2 btn--radius-2">더보기</button>
			</div>
			<hr /><br />
			<!-- card -->
			<div class="card">
				<img src="./upload/lanTrip_apply/spain.jpg" class="card-img-top">
				<div class="card-body">
					<h3 class="card-title"><b>스페인</b></h3>
					<p class="card-text">스페인좋아여</p>
					<div id="view">
						<a href="#" class="btn btn--blue-1 btn--radius-2">글 보기</a>
					</div>
				</div>
			</div>
			<div class="card">
				<img src="./upload/lanTrip_apply/spain.jpg" class="card-img-top">
				<div class="card-body">
					<h3 class="card-title"><b>스페인</b></h3>
					<p class="card-text">스페인좋아여</p>
					<div id="view">
						<a href="#" class="btn btn--blue-1 btn--radius-2">글 보기</a>
					</div>
				</div>
			</div>
			<div class="card">
				<img src="./upload/lanTrip_apply/spain.jpg" class="card-img-top">
				<div class="card-body">
					<h3 class="card-title"><b>스페인</b></h3>
					<p class="card-text">스페인좋아여</p>
					<div id="view">
						<a href="#" class="btn btn--blue-1 btn--radius-2">글 보기</a>
					</div>
				</div>
			</div>
			<div class="card">
				<img src="./upload/lanTrip_apply/spain.jpg" class="card-img-top">
				<div class="card-body">
					<h3 class="card-title"><b>스페인</b></h3>
					<p class="card-text">스페인좋아여</p>
					<div id="view">
						<a href="#" class="btn btn--blue-1 btn--radius-2">글 보기</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<section id="my-feed" class="container">
		<div class="row">
			<div class="col-6">
				<h1><b>내 즐겨찾기</b></h1>
			</div>
			<div id="btn-modify" class="col-6">
			<br />
				<button type="button" class="btn btn--blue-2 btn--radius-2">더보기</button>
			</div>
			<hr /><br />
			<!-- card -->
			<div class="card">
				<img src="./upload/lanTrip_apply/Czech Republic.jpg" class="card-img-top">
				<div class="card-body">
					<h3 class="card-title"><b>체코</b></h3>
					<p class="card-text">체코좋아여</p>
					<div id="view">
						<a href="#" class="btn btn--blue-1 btn--radius-2">글 보기</a>
					</div>
				</div>
			</div>
			<div class="card">
				<img src="./upload/lanTrip_apply/Czech Republic.jpg" class="card-img-top">
				<div class="card-body">
					<h3 class="card-title"><b>체코</b></h3>
					<p class="card-text">체코</p>
					<div id="view">
						<a href="#" class="btn btn--blue-1 btn--radius-2">글 보기</a>
					</div>
				</div>
			</div>
			<div class="card">
				<img src="./upload/lanTrip_apply/Czech Republic.jpg" class="card-img-top">
				<div class="card-body">
					<h3 class="card-title"><b>체코</b></h3>
					<p class="card-text">체코</p>
					<div id="view">
						<a href="#" class="btn btn--blue-1 btn--radius-2">글 보기</a>
					</div>
				</div>
			</div>
			<div class="card">
				<img src="./upload/lanTrip_apply/Czech Republic.jpg" class="card-img-top">
				<div class="card-body">
					<h3 class="card-title"><b>체코</b></h3>
					<p class="card-text">체코</p>
					<div id="view">
						<a href="#" class="btn btn--blue-1 btn--radius-2">글 보기</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<br /><br /><br /><br />
</body>
</html>