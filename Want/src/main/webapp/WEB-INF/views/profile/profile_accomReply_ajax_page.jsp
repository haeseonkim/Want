<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach var="tmp" items="${ rlist }">
<div class='row replyrow reply${ tmp.no }'>
	<%-- 1. 삭제된 댓글일때 --%>
	<c:choose>
	<c:when test="${ tmp.content eq '' }"> 
		<div>
			(삭제된 댓글입니다)
		</div>
	</c:when>
	<c:otherwise>
		<%--2. 모댓글 일때 --%>
		<c:choose>
			<c:when test="${ tmp.grpl eq 0 }"> 
			<div class='col-1'>
				<a href="other_profile.do?other_nick=${tmp.writer }">
					<img class='reply_list_profileImage' src='./upload/profile/${ tmp.profile }'/>
				</a>
			</div>
			<div class='rereply-content col-8'>
				<div>
					<span>
						<b>${ tmp.writer }</b>
					</span>
					<span>
						${ tmp.content }
					</span>
				</div>
				<%--3.1 현재 로그인 상태일때 답글작성 버튼이 나온다. --%>
				<c:choose>
					<c:when test="${ not empty sessionScope.nick }">
						<div>
							<a href='#' idx='${ tmp.no }' class='write_reply_start' data-bs-toggle='collapse' data-bs-target='#re_reply${ tmp.no }' aria-expanded='false' aria-controls='collapseExample'>답글&nbsp;달기</a>
						</div>
					</c:when>
				</c:choose>
				<%--3.1 끝 --%>			
			</div>
			<div class='col-3 reply-right'>
				<div>
					${ tmp.wdate }
				</div>
				<%--3.2 시작 --%>
				<c:choose>
					<c:when test="${ sessionScope.nick eq tmp.writer }"> 
						<div>
							<%-- 수정할 댓글의 no를 grpl과 함께 넘긴다. 
							모댓글 수정칸과 답글 수정칸을 화면에 다르게 나타내야하기 때문에 모댓글과 답글을 구분하는 grpl을 함께 넘겨주어야한다. --%>
							<%-- 삭제는 no만 넘겨주면 된다.--%> 
							<a href='javascript:' no='${ tmp.no }' grpl='${ tmp.grpl }' bno='${ tmp.bno }' grp='${ tmp.grp }' class='reply_delete'>삭제</a>
						</div>
					</c:when>
				</c:choose>
				<%--3.2 끝 --%>
			</div>
			</c:when>
			<%--2. 끝--%>
			<%--2. 대댓글일 때 --%>
			<c:otherwise> 
				<div class='col-1'>
				</div>
				<div class='col-1'>
					<a href="other_profile.do?other_nick=${tmp.writer }">
						<img class='reply_list_profileImage' src='./upload/profile/${ tmp.profile }'/>
					</a>
				</div>
				<div class='rereply-content${ tmp.no } col-7'>
					<div>
						<span>
							<b>${ tmp.writer }</b>
						</span>
						<span>
							${ tmp.content }
						</span>
					</div>
				</div>
				<div class='col-3 reply-right'>
					<div>${ tmp.wdate }</div>
					<c:choose>
					<c:when test="${ sessionScope.nick eq tmp.writer }"> 
						<div>
							<%-- 수정할 댓글의 no를 grpl과 함께 넘긴다. 
							모댓글 수정칸과 답글 수정칸을 화면에 다르게 나타내야하기 때문에 모댓글과 답글을 구분하는 grpl을 함께 넘겨주어야한다. --%>
							<%-- 삭제는 no만 넘겨주면 된다.--%> 
							<a href='javascript:' no='${ tmp.no }' grpl='${ tmp.grpl }' bno='${ tmp.bno }' grp='${ tmp.grp }' class='reply_delete'>삭제</a>
						</div>
					</c:when>
				</c:choose>
				</div>
			</c:otherwise>
		</c:choose>
		<%--2.끝 --%>

		<%-- 댓글에 답글달기를 누르면 답글입력란이 나온다.
		---- 답글입력란 --%>
		<div class='collapse row rereply_write' id='re_reply${ tmp.no }'>
			<div class='col-1'>
			</div>
			<div class='col-1'>
				<img id='write_reply_profileImage' src='./upload/profile/${profile}'/>
			</div>
			<div class='col-7'>
				<input class='w-100 input_rereply_div form-control' id='input_rereply${ tmp.no }' type='text' placeholder='댓글입력...'>
			</div>
			<div class='col-3'>
				<%-- 답글달기 버튼이 눌리면 모댓글 번호(no)와 게시물번호(bno)를 함수에 전달한다.
				// 동적으로 넣은 html태그에서 발생하는 이벤트는 동적으로 처리해줘야한다 !!!!!
				// 예를들어, 동적으로 넣은 html태그에서 발생하는 click 이벤트는 html태그 안에서 onclick으로 처리하면 안되고, jquery에서 클래스명이나 id값으로 받아서 처리하도록 해야한다.
				// 아래코드를 보자~~~~
				// 위 코드는 클릭되어도 값이 넘겨지지 않는다. 값이 undefined가 된다.
				// 아래코드처럼 짜야한다. click이벤트를 처리하지 않고 데이터(no, bno)만 속성으로 넘겨주도록 작성한다.
				 --%>
				<button type='button' class='btn btn-success mb-1 write_rereply' no='${ tmp.no }' bno='${ tmp.bno }'>답글&nbsp;달기</button>
			</div>
		</div>
			
		
	</c:otherwise>
	</c:choose>
</div>
</c:forEach>
