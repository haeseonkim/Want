<%@page import="com.exam.model1.LanTripApplyListTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.model1.LanTripApplyTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	LanTripApplyListTO listTO = ( LanTripApplyListTO )request.getAttribute( "listTO" );
   
int cpage = listTO.getCpage();
int recordPerPage = listTO.getRecordPerPage();
int totalRecord = listTO.getTotalRecord();
int totalPage = listTO.getTotalPage();
int blockPerPage = listTO.getBlockPerPage();
   
int startBlock = listTO.getStartBlock();
int endBlock = listTO.getEndBlock();

   ArrayList<LanTripApplyTO> boardLists= listTO.getBoardLists();
   
   StringBuffer sbHtml = new StringBuffer();
   for( LanTripApplyTO to : boardLists ) {
      String no = to.getNo();
      String subject = to.getSubject();
      String writer = to.getWriter();
      String wdate = to.getWdate();
      String hit = to.getHit();
      int wgap = to.getWgap();
         
      sbHtml.append( "<tr>" );
      sbHtml.append( "   <td>&nbsp;</td>" );
      sbHtml.append( "   <td>" + no + "</td>" );
      sbHtml.append( "   <td class='=center'>" );
      sbHtml.append( "      <a href='./view.spring?seq=" + no + "'>" + subject + "</a>&nbsp;" );
/*       if( wgap == 0 ) {
         sbHtml.append( "      <img src='./images/icon_hot.gif' alt='HOT'>" );
      } */
      sbHtml.append( "   </td>" );
      sbHtml.append( "   <td>" + writer + "</td>" );
      sbHtml.append( "   <td>" + wdate + "</td>" );
      sbHtml.append( "   <td>" + hit + "</td>" );
      sbHtml.append( "   <td>&nbsp;</td>" );
      sbHtml.append( "</tr>" );
   }   
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>랜선여행 신청하기</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/lanTrip_apply_list.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_apply_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />
<div class="con_txt">
	<div class="contents_sub">
		<div class="board_top">
			<div class="bold">총 <span id="totalRecord"><%=totalRecord %></span>건</div>
		</div>

		<!--게시판-->
		<div class="board">
			<table>
			<tr>
				<th width="3%">&nbsp;</th>
				<th width="5%">번호</th>
				<th id="subject">제목</th>
				<th width="10%">글쓴이</th>
				<th width="17%">등록일</th>
				<th width="5%">조회</th>
				<th width="3%">&nbsp;</th>
			</tr>
			<!-- 행 시작 -->
			<%= sbHtml %>
			
			
			<!-- 행 끝 -->
			</table>
		</div>	


		<div class="align_right">
			<input type="button" value="신청하기" class="btn_write btn_txt01" style="cursor: pointer;" 
			onclick="location.href='./lanTrip_apply/lanTrip_apply_write.do'" />
		</div>
	</div>
</div>

</body>
</html>