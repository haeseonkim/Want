<%@page import="com.exam.model1.AccomListTO"%>
<%@page import="com.exam.model1.AccomTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.getParameter( "utf-8" );
	String sa = request.getParameter( "sa" );
	String cityName = request.getParameter( "cityName" );

	AccomListTO listTO = (AccomListTO)request.getAttribute( "listTO" );
	int cpage = (Integer)request.getAttribute( "cpage" );
	
	int recordPerPage = listTO.getRecordPerPage();
	int totalRecord = listTO.getTotalRecord();
	int totalPage = listTO.getTotalPage();
	int blockPerPage = listTO.getBlockPerPage();
	int blockRecord = listTO.getBlockRecord();
	int startBlock = listTO.getStartBlock();
	int endBlock = listTO.getEndBlock();

	StringBuffer sbHtml = new StringBuffer();
	
	for ( AccomTO to : listTO.getAccomLists()) {
		blockRecord++;
		if( blockRecord == 1 || blockRecord == 6 ) {
			sbHtml.append( "<tr>" );
		}
		sbHtml.append( " <td width='20%' class='last2'> ");
		sbHtml.append( " 	<div class='board'> " );
		sbHtml.append( " 		<table class='table table-bordered'> " );
		sbHtml.append( " 		<tr> " );
		sbHtml.append( " 			<td class='boardThumbWrap'> " );
		sbHtml.append( " 				<div class='card' style='width: 18rem;'> " );
		sbHtml.append( " 					<a href='./accom_view.do?cpage="+ cpage +"&no="+to.getNo()+"&cityName="+ cityName +"'><img class='card-img-top' src='./upload/accom/" + to.getPicture() + "' border='0' width='100%'/></a>" );
		sbHtml.append( " 				</div> " );														
		sbHtml.append( " 			</td> " );
		sbHtml.append( " 		</tr> " );
		sbHtml.append( " 		<tr> " );
		sbHtml.append( " 			<td> " );
		sbHtml.append( " 				<div class='card-body'>	 " );
		sbHtml.append( " 					<strong class='card-text'>" + to.getSubject() + "</strong> " );
		sbHtml.append( " 					<span class='coment_number'><img src='./resources/img/icon_comment.png' alt='commnet'>"+ to.getReply() +"</span>" );
		if( to.getWgap() == 0 ) {
			sbHtml.append( "		<img src='./resources/img/icon_new.gif' alt='NEW'> ");
		}
		sbHtml.append( " 				</div> " );
		sbHtml.append( " 			</td> " );
		sbHtml.append( " 		</tr> " );
		sbHtml.append( " 		<tr> " );
		sbHtml.append( " 			<td><div class='boardItem'><span class='bold_blue'>" + to.getWriter() + "</span></div></td> " );
		sbHtml.append( " 		</tr> " );
		sbHtml.append( " 		<tr> " );
		sbHtml.append( " 			<td><div class='boardItem'>" + to.getWdate() + " <font>|</font> Hit " + to.getHit()+ "</div></td> " );
		sbHtml.append( " 		</tr> " );
		sbHtml.append( " 		</table> " );
		sbHtml.append( " 	</div> " );
		sbHtml.append( " </td> " );
		if( blockRecord == 5 ) {
			sbHtml.append( "</tr>" );
		}
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want 숙박정보</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>
	
<!-- CSS File -->
<link href="./resources/css/accom_list.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">


</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="accom_list" name="thisPage" />
	</jsp:include>
	<br /><br /><br />
	
	<div class="select-form">
		<div class="col-8 offset-3">
			<h3>숙소 정보</h3>
		</div>	
	</div>
<div class="contents1"> 
	<div class="contents_sub">	
		<div class="board_top">
			<div class="bold">
				<p class="total">총 <span class="txt_orange"><%= blockRecord %></span>건</p>
			</div>
		</div>	
		
		<!--게시판-->
		<table class="board_list">
			<%= sbHtml %>
			</tr>
		</table>
		<!--//게시판-->	
		
		<div class="align_right">		
			<button type="button" class="btn btn-primary" onclick="location.href='./accom_write.do?cityName=<%=cityName%>&cpage=<%=cpage%>'">글쓰기</button>
		</div>
		
		<!--페이지넘버-->
		<div class="paginate_regular">
			<div class="board_pagetab">
			<%	
				if ( startBlock == 1 ) {
					out.println(" <span class='off'><a>&lt;&lt;</a></span> ");
				} else {
					out.println(" <span class='off'><a href='./accom_list.do?cityName="+cityName+"&cpage="+ (startBlock-blockPerPage) +"'>&lt;&lt;</a></span> ");
				}
				out.println(" &nbsp; ");
				
				if ( cpage == 1 ) {
					out.println(" <span class='off'><a>&lt;</a></span> ");
				} else {
					out.println(" <span class='off'><a href='./accom_list.do?cityName="+cityName+"&cpage="+ (cpage-1) +"'>&lt;</a></span> ");
				}
				out.println(" &nbsp;&nbsp; ");
				
				for ( int i=startBlock; i<=endBlock; i++ ) {
					if ( cpage == i ) { 
						out.println(" <span class='off'>[" + i + "]</span> ");
					} else {
						out.println(" <span class='off'><a href='./accom_list.do?cityName="+cityName+"&cpage=" + i + "'>" + i + "</a></span> ");
					}
				}
				out.println(" &nbsp;&nbsp; ");
				
				if ( cpage == totalPage ) {
					out.println(" <span class='off'><a>&gt;</a></span> ");
				} else {
					out.println(" <span class='off'><a href='./accom_list.do?cityName="+cityName+"&cpage="+ (cpage+1) +"'>&gt;</a></span> ");
				}
				out.println(" &nbsp; ");
				
				if ( endBlock == totalPage ) {
					out.println(" <span class='off'><a>&gt;&gt;</a></span> ");
				} else {
					out.println(" <span class='off'><a href='./accom_list.do?cityName="+cityName+"&cpage="+ (startBlock+blockPerPage) +"'>&gt;&gt;</a></span> ");
				}
				out.println(" &nbsp; ");
			%>
			<!-- 
				<span class="off"><a href="#">&lt;&lt;</a>&nbsp;&nbsp;</span>
				<span class="off"><a href="#">&lt;</a>&nbsp;&nbsp;</span>
				<span class="off"><a href="#">[ 1 ]</a></span>
				<span class="on"><a href="#">[ 2 ]</a></span>
				<span class="off"><a href="#">[ 3 ]</a></span>
				<span class="off">&nbsp;&nbsp;<a href="#">&gt;</a></span>
				<span class="off">&nbsp;&nbsp;<a href="#">&gt;&gt;</a></span>
				 -->
			</div>
		</div>
		<!--//페이지넘버-->	
  	</div>
</div>
	
</body>
</html>