<%@page import="com.exam.model1.accom.AccomListTO"%>
<%@page import="com.exam.model1.accom.AccomTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("utf-8");
	request.getParameter( "utf-8" );
	String sa = request.getParameter( "sa" );
	String nick = (String)session.getAttribute( "nick" );
	
	//국가 이름별 주요 도시 미리 저장
	String location = request.getParameter( "location" );
	ArrayList<String> citys = new ArrayList<String>();
	if( location.equals("프랑스") ) {
		citys.add( "Paris" );
		citys.add( "Marseille" );
		citys.add( "Lyon" );
		citys.add( "Toulouse" );
	} else if( location.equals( "그리스" ) ) {
		citys.add( "Athens" );
		citys.add( "Thessaloniki" );
		citys.add( "Larissa" );
		citys.add( "Paros" );
	} else if( location.equals( "이탈리아" ) ) {
		citys.add( "Rome" );
		citys.add( "Milan" );
		citys.add( "Venice" );
		citys.add( "Genoa" );
	} else if( location.equals( "스페인" ) ) {
		citys.add( "Madrid" );
		citys.add( "Barcelona" );
		citys.add( "Valencia" );
		citys.add( "Seville" );
	} else if( location.equals( "체코" ) ) {
		citys.add( "Prague" );
		citys.add( "Brno" );
		citys.add( "Ostrava" );
		citys.add( "Zlin" );
	} else if( location.equals( "영국" ) ) {
		citys.add( "London" );
		citys.add( "Oxford" );
		citys.add( "Cambridge" );
		citys.add( "Manchester" );
	} else if( location.equals( "스위스" ) ) {
		citys.add( "Zurich" );
		citys.add( "Basel" );
		citys.add( "Geneva" );
		citys.add( "Interlaken" );
	} else if( location.equals( "포르투갈" ) ) {
		citys.add( "Lisbon" );
		citys.add( "Porto" );
		citys.add( "Coimbra" );
		citys.add( "Sintra" );
	} else if( location.equals( "헝가리" ) ) {
		citys.add( "Budapest" );
		citys.add( "Debrecen" );
		citys.add( "Szeged" );
		citys.add( "Miskolc" );
	} else if( location.equals( "오스트리아" ) ) {
		citys.add( "Vienna" );
		citys.add( "Salzburg" );
		citys.add( "Innsbruck" );
		citys.add( "Hallstatt" );
	} else if( location.equals( "스웨덴" ) ) {
		citys.add( "Stockholm" );
		citys.add( "Gothenburg" );
		citys.add( "Uppsala" );
		citys.add( "Malmo" );
	} else if( location.equals( "핀란드" ) ) {
		citys.add( "Helsinki" );
		citys.add( "Turku" );
		citys.add( "Tampere" );
		citys.add( "Rovaniemi" );
	} else if( location.equals( "폴란드" ) ) {
		citys.add( "Warsaw" );
		citys.add( "Krakow" );
		citys.add( "Wroclaw" );
		citys.add( "Gdansk" );
	}
	
	//날씨 데이터 가져오기 위한 API Key설정
	String apiKey = "55544d62c597faf009f8444b02d3a8ca";
	
	ArrayList<AccomTO> list = (ArrayList<AccomTO>)request.getAttribute( "list" );
	
	StringBuffer sbHtml = new StringBuffer();
	
	for ( AccomTO to : list ) {
		sbHtml.append( " <div class='col-xl-3 col-lg-4 col-md-6 mb-4'>" );
		sbHtml.append( " 	<div class='bg-white rounded shadow-sm'>" );
		sbHtml.append( " 		<a href='./accom_view.do?no="+to.getNo()+"&location="+ location +"' class='text-dark'>" );
		sbHtml.append( " 		<img src='./upload/accom/" + to.getPicture() + "' alt='' class='img-fluid card-img-top'>" );
		sbHtml.append( " 		<div class='p-4'>" );
		sbHtml.append( " 			<h5><a href='./accom_view.do?no="+to.getNo()+"&location="+ location +"' class='text-dark'>" + to.getSubject() + "</a></h5>" );
		sbHtml.append( " 			<img id='profileImage' src='./upload/profile/"+ to.getProfile() +"' />&nbsp;&nbsp;<span class='small text-muted mb-0'>"+ to.getWriter()+" | "+ to.getWdate() +"</span>" );
		sbHtml.append( " 			<div class='d-flex align-items-center justify-content-between rounded-pill bg-light px-3 py-2 mt-4 boardItem'>" );
		if( nick == null ) {
			sbHtml.append( "		<svg class='heart3' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>" );
			sbHtml.append( "		  	<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />" );
			sbHtml.append( "		</svg>" );
		} else { 		//로그인 상태에서 빈 하트일때 
			if( to.getHno() == null ) {
			sbHtml.append( "        <a idx='"+to.getNo()+"' href='javascript:' class='heart-click heart_icon"+to.getNo()+"'>" );
			sbHtml.append( "			<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>" );
			sbHtml.append( "				<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />" );
			sbHtml.append( "			</svg>" );
			sbHtml.append( "        </a>" );
			} else {	//로그인 상태에서 꽉찬 하트일때 
			sbHtml.append( "        <a idx='"+to.getNo()+"' href='javascript:' class='heart-click heart_icon"+to.getNo()+"'>" );
			sbHtml.append( "			<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'>" );
			sbHtml.append( "				<path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/>" );
			sbHtml.append( "			</svg>" );
			sbHtml.append( "        </a>" );
			}
		}
		sbHtml.append( "      		<span id='m_heart"+ to.getNo() +"'> "+ to.getHeart() +"</span>" );
		sbHtml.append( "			<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat-dots' viewBox='0 0 16 16'>" );
		sbHtml.append( "				<path d='M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z' />" );
		sbHtml.append( "				<path d='M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z' />" );
		sbHtml.append( "			</svg>" );
		sbHtml.append( "			"+ to.getReply() +"&nbsp;" );
		sbHtml.append( "			<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye' viewBox='0 0 16 16'>" );
		sbHtml.append( "				<path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z' />" );
		sbHtml.append( "				<path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z' />" );
		sbHtml.append( "			</svg>" );
		sbHtml.append( "			"+ to.getHit()+ "" );
		sbHtml.append( " 			</div>" );
		sbHtml.append( " 		</div>" );
		sbHtml.append( " 	</div>" );
		sbHtml.append( " </div>" );
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 숙소정보</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/accom_list.css?sd" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">

//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
let currentPage=1;
//현재 페이지가 로딩중인지 여부를 저장할 변수이다.
let isLoading=false;


//웹브라우저의 창을 스크롤 할 때 마다 호출되는 함수 등록
$(window).on("scroll",function(){
	//위로 스크롤된 길이
	let scrollTop=$(window).scrollTop();
	//웹브라우저의 창의 높이
	let windowHeight=$(window).height();
	//문서 전체의 높이
	let documentHeight=$(document).height();
	//바닥까지 스크롤 되었는 지 여부를 알아낸다.
	let isBottom=scrollTop+windowHeight + 10 >= documentHeight;
	
	console.log( scrollTop, windowHeight, documentHeight, isBottom );
	
	if(isBottom){
		//만일 현재 마지막 페이지라면
		if( currentPage == ${totalPageCount} || isLoading ) {
			return; //함수를 여기서 끝낸다.
		}
		//현재 로딩 중이라고 표시한다.
		isLoading=true;
		//로딩바를 띄우고
		$(".back-drop").show();
		//요청할 페이지 번호를 1 증가시킨다.
		currentPage++;
		//추가로 받아올 페이지를 서버에 ajax 요청을 하고
		$.ajax({
			url:"./accom_ajax_page.do",
			method:"GET",
			//검색기능이 있는 경우 condition과 keyword를 함께 넘겨줘야한다. 안그러면 검색결과만 나와야하는데 다른것들이 덧붙여져 나온다.
			data:"pageNum="+currentPage+"&condition=${condition}&keyword=${keyword}&location=<%=location%>",
			//ajax_page.jsp의 내용이 data로 들어온다.
			success:function(data){
				console.log(data);
				//응답된 문자열은 html 형식이다.(shopping/shop_ajax_page.jsp에 응답내용이 있다.)
				//해당 문자열을 .card-list-container  div에 html로 해석하라고 추가한다.
				$(".card-list-container").append(data);
				//로딩바를 숨긴다.
				$(".back-drop").hide();
				//로딩중이 아니라고 표시한다.
				isLoading=false;
				
				// 로그인 한 상태에서 하트를 클릭했을 때 (로그인한 상태인 하트의 <a></a> class명: heart-click)
				$(".heart-click").unbind('click');
				$(".heart-click").click(function() {
					// 게시물 번호(no)를 idx로 전달받아 저장합니다.
					let no = $(this).attr('idx');
					
					// 빈하트를 눌렀을때
					if($(this).children('svg').attr('class') == "bi bi-suit-heart"){
						console.log("빈하트 클릭" + no);
						
						$.ajax({
							url : 'accom_saveHeart.do',
							type : 'get',
							data : {
								no : no,
							},
							success : function(sto) {
								
								let heart = sto.heart;
								
								// 페이지 하트수 갱신
								$('#m_heart'+no).text(heart);
								
								console.log("하트추가 성공");
							},
							error : function() {
								alert('서버 에러');
							}
						});
						
						// 꽉찬하트로 바꾸기
						$(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
						$('.heart_icon'+no).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
						
					// 꽉찬 하트를 눌렀을 때
					}else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill"){
						console.log("꽉찬하트 클릭" + no);
						
						$.ajax({
							url : 'accom_removeHeart.do',
							type : 'get',
							data : {
								no : no,
							},
							success : function(sto) {
								
								let heart = sto.heart;
								// 페이지 하트수 갱신
								$('#m_heart'+no).text(heart);
								
								console.log("하트삭제 성공");
							},
							error : function() {
								alert('서버 에러');
							}
						});
						// 빈하트로 바꾸기
						$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
						$('.heart_icon'+no).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
					}
				});
				
			}
			
		});
	}; 
});




$(document).ready( function() {
	
	// 로그인 한 상태에서 하트를 클릭했을 때 (로그인한 상태인 하트의 <a></a> class명: heart-click)
	$(".heart-click").unbind('click');
	$(".heart-click").click(function() {
		// 게시물 번호(no)를 idx로 전달받아 저장합니다.
		let no = $(this).attr('idx');
		
		// 빈하트를 눌렀을때
		if($(this).children('svg').attr('class') == "bi bi-suit-heart"){
			console.log("빈하트 클릭" + no);
			
			$.ajax({
				url : 'accom_saveHeart.do',
				type : 'get',
				data : {
					no : no,
				},
				success : function(sto) {
					
					let heart = sto.heart;
					
					// 페이지 하트수 갱신
					$('#m_heart'+no).text(heart);
					
					console.log("하트추가 성공");
				},
				error : function() {
					alert('서버 에러');
				}
			});
			
			// 꽉찬하트로 바꾸기
			$(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
			$('.heart_icon'+no).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
			
		// 꽉찬 하트를 눌렀을 때
		}else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill"){
			console.log("꽉찬하트 클릭" + no);
			
			$.ajax({
				url : 'accom_removeHeart.do',
				type : 'get',
				data : {
					no : no,
				},
				success : function(sto) {
					
					let heart = sto.heart;
					// 페이지 하트수 갱신
					$('#m_heart'+no).text(heart);
					
					console.log("하트삭제 성공");
				},
				error : function() {
					alert('서버 에러');
				}
			});
			// 빈하트로 바꾸기
			$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
			$('.heart_icon'+no).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
		}
	});
	
	//날씨 데이터 가져오는 ajax함수. city와 apikey는 위 jsp에서 미리 설정
	var citys = [];
	<%
	for( int i=0; i<citys.size(); i++ ) {
	%>
		citys.push( "<%= citys.get(i) %>" );
	<% 
	}
	%>
	for( var i=0; i<4; i++ ) {
		var apiUri = "http://api.openweathermap.org/data/2.5/weather?q="+citys[i]+"&appid=<%=apiKey%>";
		$.ajax({
			url: apiUri,
			dataType: "json",
			type: "GET",
			async: false,
			success: function( resp ) {
				console.log( "날씨 이미지 : " + resp.weather[0].icon );
				var imgUrl = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
				var status = resp.weather[0].description;
				switch( status ) {
				case "clear sky":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-sunny' );
					break;
				case "few clouds":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-cloudy' );
					break;
				case "scattered clouds":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-cloudy-windy' );
					break;
				case "overcast clouds":
					$('#weather_img'+i).attr( 'class', 'wi wi wi-day-cloudy' );
					break;
				case "broken clouds":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-sunny-overcast' );
					break;
				case "shower rain":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-showers' );
					break;
				case "light rain":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-showers' );
					break;
				case "drizzle":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-showers' );
					break;
				case "light intensity drizzle":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-showers' );
					break;
				case "rain":
					$('#weather_img'+i).attr( 'class', 'wi .wi-day-rain' );
					break;
				case "thunderstorm":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-thunderstorm' );
					break;
				case "snow":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-snow' );
					break;
				case "light snow":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-snow' );
					break;
				case "mist":
					$('#weather_img'+i).attr( 'class', 'wi wi-day-fog' );
					break;
				}
				$('#weather_temp'+i).text( (resp.main.temp-273.15).toFixed(2)+' ℃' );
				$('#weather_name'+i).text( citys[i] );
				$('#weather_status'+i).text( resp.weather[0].description );
				$('#weather_wind'+i).text( resp.wind.speed );
				$('#weather_humidity'+i).text( resp.main.humidity+'%' );
				$('#weather_clouds'+i).text( resp.clouds.all+'%' );
				
				console.log(resp);
	            console.log("현재온도 : "+ (resp.main.temp- 273.15) );
	            console.log("현재습도 : "+ resp.main.humidity);
	            console.log("날씨 : "+ resp.weather[0].main );
	            console.log("상세날씨설명 : "+ resp.weather[0].description );
	            console.log("도시이름  : "+ resp.name );
			}
		})
	}
	
})
</script>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="accom_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />
	<div class="container-fluid">
		<div class="px-lg-5">

			<!-- For demo purpose -->
			<div class="row py-5">
				<div class="col-lg-12 mx-auto">
					<div class="text-white p-5 shadow-sm rounded banner">
						<div class="row">
							<div class="col-4">
								<h1 class="display-4"><%= location %> 숙소 정보</h1><br/><br/>
							</div>
							<div class="col-8">
								<!-- 날씨 데이터 표현하는 div -->
								<c:forEach var="i" begin="0" end="3">
								<div class="weather_div1">
									<table class="weather_table" >
										<colgroup>
											<col width="33%" />
											<col width="33%" />
											<col width="33%" />
										</colgroup>
										<tr class="weather_tr1">
											<th class="weather_i" rowspan="3" colspan="2" align=center><i id="weather_img${i}"></i></th>
											<td align=center class="weather_name"><p id="weather_name${i}"></p></td>
										</tr>
										<tr class="weather_tr1">
											<td align=center><p id="weather_temp${i}"></p></td>
										</tr>
										<tr class="weather_tr1">
											<td align=center height="90px"><p id="weather_status${i}"></p></td>
										</tr>
										<tr class="weather_tr2">
											<td class="weather_bottom">
												<p>풍속</p>
												<p id="weather_wind${i}"></p>
											</td>
											<td class="weather_bottom">
												<p>습도</p>
												<p id="weather_humidity${i}"></p>
											</td>
											<td class="weather_bottom">
												<p>흐림정도</p>
												<p id="weather_clouds${i}"></p>
											</td>
										</tr>
									</table>									
								</div>
								</c:forEach>
							</div>
						</div>
						
						
						<div class="align_right">
						<c:choose>
							<c:when test="${empty sessionScope.nick }">
								<button type="button" class="btn btn-primary"
									onclick="javascript:alert('로그인을 하셔야합니다.')">글쓰기</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-primary"
									onclick="location.href='./accom_write.do?location=<%=location%>'">글쓰기</button>
							</c:otherwise>
						</c:choose>
						</div>
					</div>
				</div>
			</div>
			<!-- End -->

			<br/>
			<!-- 검색 버튼과 form -->
			<div id="card-search" class="card-search" >
			<form action="./accom_list.do" method="get">
				<input type="hidden" name="location" value="<%= location %>" />
				<div class="row justify-content-md-center" id="search">
					<div class="form-row col-2">
						<div class="value">
							<select id="condition" name="condition" class="form-select">
								<option value="subject" ${condition eq 'subject' ? 'selected' : '' }>제목</option>
								<option value="content" ${condition eq 'content' ? 'selected' : '' }>내용</option>
								<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
							</select>
						</div>
					</div>
					<div class="col-md-6">
						<input value="${keyword }" type="text" name="keyword" placeholder="검색어를 입력해주세요" class="form-control">
						
					</div>
					<div class="col-md-1">
						<button class="btn btn-success" type="submit">검색</button>
					</div>
					
				</div>
			</form>
			</div>
		
			<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
			<c:if test="${not empty keyword }">
				<div class="alert text-center">
					<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
				</div>
			</c:if>
			<!-- 검색기능 끝 -->
			<br/>

			<!--게시판-->
			<div class="row card-list-container">
			<!-- Gallery item -->
			<%= sbHtml %>
			<!-- End -->
			</div>
			<!-- 게시판 끝 -->
			
			<!-- 로딩중 이미지 -->
			<div class="back-drop">
				<!-- cpath/ 에서 '/'는 webapp을 의미한다. 웹앱 폴더의 svg폴더 안에 spinner-solid.svg가 들어있다.  -->
				<img src="./svg/spinner-solid.svg"/> 
			</div>
			<!-- 로딩중 이미지 끝 -->
		</div>
	</div>
	

</body>
</html>