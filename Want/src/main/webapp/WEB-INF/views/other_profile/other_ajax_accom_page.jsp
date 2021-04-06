<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setCharacterEncoding("utf-8"); %>


<div class="row">
<c:forEach var="tmp" items="${list }">
	
	<div class="col-3 card-inner">
		<div class="thumb">
			<div class="card-img" type="button" idx="${tmp.no }"
				data-bs-toggle="modal" data-bs-target="#viewModal${tmp.no }">
				<div class="video-box">
					<img src="./upload/accom/${tmp.picture }" class="card-img-top img-wrapper" alt="...">
				</div>
			</div>
			<!-- 마우스 오버시 보여지는 부분 --> 
			<div class="links" style="text-align:center;" type="button" idx="${ tmp.no }"
				data-bs-toggle="modal" data-bs-target="#viewModal${tmp.no }"> ${ tmp.subject }<br> 
				<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>" );
					<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />" );
				</svg> ${ tmp.heart } 
				<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat-dots' viewBox='0 0 16 16'>" );
					<path d='M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z' />" );
					<path d='M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z' />" );
				</svg> ${ tmp.reply } 
			</div>
		</div>
	</div>

	<!-- view Modal -->
	<div class="modal fade" id="viewModal${tmp.no }" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="m_subject">[${tmp.location}]&nbsp;${tmp.subject }</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<section class="modal-section">
						<!-- 글쓴이 프로필 사진이 원형으로 나오는 부분 -->
						<div class="row">
							<div class="col-1">
								<span id="m_writer_profile"> 
									<div class="message-box">
										<img id="profileImage" src='./upload/profile/${tmp.profile }' />
									</div>
								</span>
							</div>
							<div class="col-9">
								<span id="m_writer">${tmp.writer }</span>
							</div>
							<div class="col-2">${tmp.wdate }</div>
						</div>
					</section>
					<section class="modal-section-media">
						<div class="container" id="m_media">
							<img src="./upload/accom/${ tmp.picture }" class="w-100" />
						</div>
					</section>

					<section class="modal-section">
						<div id="m_heart_reply_hit">
							<span id="m_heart_icon"> <c:choose>
									<%-- 로그인 상태일때 - 하트 클릭 되게 --%>
									<c:when test="${not empty sessionScope.nick}">
										<c:choose>
											<c:when test="${empty tmp.hno}">
												<%-- 빈 하트일때 --%>
												<a idx="${tmp.no}" href="javascript:"
													class="heart-click heart_icon${tmp.no }"><svg
														xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-suit-heart"
														viewBox="0 0 16 16">
							  							  <path
															d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
														</svg></a>

											</c:when>
											<c:otherwise>
												<%-- 꽉찬 하트일때 --%>
												<a idx="${tmp.no}" href="javascript:"
													class="heart-click heart_icon${tmp.no }"><svg
														xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-suit-heart-fill"
														viewBox="0 0 16 16">
														  <path
															d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" />
														</svg></a>
											</c:otherwise>
										</c:choose>
									</c:when>
									<%-- 로그인 상태가 아닐때  - 하트클릭 안되게 --%>
									<c:otherwise>
										<a href="javascript:" class="heart-notlogin"> <svg
												class="heart3" xmlns="http://www.w3.org/2000/svg" width="16"
												height="16" fill="currentColor" class="bi bi-suit-heart"
												viewBox="0 0 16 16">
							  					  <path
													d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
												</svg></a>
									</c:otherwise>
								</c:choose>
							</span> <span id="m_heart${tmp.no }">${tmp.heart }</span>

							<%-- 댓글 수 --%>
							<span> <a idx="${tmp.no}" href="javascript:"
								class="open_reply_list" data-bs-toggle="collapse"
								data-bs-target="#reply_card${tmp.no }" aria-expanded="false"
								aria-controls="collapseExample"> <svg
										xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-chat-dots"
										viewBox="0 0 16 16">
													<path
											d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" />
													<path
											d="M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z" />
												</svg>
							</a>
							</span> <span id="m_reply${tmp.no }">${tmp.reply }</span>

							<%-- 조회수 --%>
							<span> <svg xmlns="http://www.w3.org/2000/svg" width="16"
									height="16" fill="currentColor" class="bi bi-eye"
									viewBox="0 0 16 16">
													<path
										d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
													<path
										d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
												</svg>
							</span> <span id="m_hit${tmp.no }">${tmp.hit }</span>
						</div>
					</section>
					<section class="modal-section">
						<div id="m_content">${tmp.content }</div>
					</section>
				</div>

				<div>
					<!-- 댓글  -->
					<div class="collapse" id="reply_card${tmp.no }">
						<section class="modal-section">
							<div class="card card-body">
								<!-- 댓글 목록 -->
								<div class="reply-list reply-list${tmp.no }">
									<!-- 댓글이 목록이 들어가는 곳 -->
								</div>
								<!-- 댓글 작성 => 로그인한 상태여야만 댓글작성 칸이 나온다. -->
								<c:if test="${not empty sessionScope.nick }">
									<div class="row reply_write">
										<div class="col-1">
											<img id="write_reply_profileImage"
												src="./upload/profile/${sessionScope.profile }" />
										</div>
										<div class="col-8" class="input_reply_div">
											<input class="w-100 form-control" id="input_reply${tmp.no}"
												type="text" placeholder="댓글입력...">
										</div>
										<div class="col-3 ">
											<button type="button" idx="${tmp.no }"
												class="btn btn-success mb-1 write_reply">댓글&nbsp;달기</button>
										</div>
									</div>
								</c:if>
							</div>
						</section>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%-- view Modal 끝 --%>

</c:forEach>
</div>
