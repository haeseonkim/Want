<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="com.exam.model1.lantripApply.LanTripApplyTO" %>
<%@ page import="com.exam.model1.lantripApply.LanTripApplyDAO" %>

<%@page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding( "utf-8" );
	String cpage = request.getParameter( "cpage" );
	
	LanTripApplyTO to = (LanTripApplyTO)request.getAttribute("to");
	
	String no = to.getNo();
	String subject = to.getSubject();
	String content = to.getContent().replaceAll("\n","<br />");
	String writer = to.getWriter();
	String wdate = to.getWdate();
	String hit = to.getHit();
	String location = to.getLocation();
	String picture = to.getPicture();
	String reply = to.getReply();
	
	/* ArrayList<CommentTO> lists = (ArrayList)request.getAttribute( "lists" );
	StringBuffer sbHtml = new StringBuffer();
	
	for( CommentTO commentTo : lists ) {
		sbHtml.append( "<table>" );
		sbHtml.append( "	<tr>" );
		sbHtml.append( "	<td class='coment_re' width='20%'>" );
		sbHtml.append( "		<strong>"+ commentTo.getWriter() +"</strong> ("+ commentTo.getWdate() +")" );
		sbHtml.append( "		<div class='coment_re_txt'>" );
		sbHtml.append( "			"+ commentTo.getContent() +"" );
		sbHtml.append( "		</div>" );
		sbHtml.append( "	</td>" );
		sbHtml.append( "</tr>" );
		sbHtml.append( "</table>" ); 
	}*/
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, intial-scale=1.0">
<title><%=subject %></title>
	
<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/lanTrip_apply_view.css?1232" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">
<style type="text/css">


</style>
</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_apply_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />	
	
	<section id="info" class="container" style="margin-top:100px;">
		<table class="table table-hover" id='board_list'>
			<thead>
				<tr>
					<td id="location" class="text-left d-none d-md-table-cell"><b>[<%=location %>]</b></td>
					<tr>
					<td id="no" class="text-center d-none d-sm-table-cell"><%=no %></td>
					<td id="subject" class="text-center"><b><%=subject %></b></td>
					<td id="writer" class="text-center d-none d-md-table-cell"><%=writer %></td>
					<td id="wdate" class="text-center d-none d-md-table-cell"><%=wdate %></td>
					<td id="hit" class="text-center d-none d-md-table-cell"><%=hit %></td>
					</tr>
				</tr>

			</thead>
		</table>
	</section>
	<section id="content" class="container" >
		<div class="form-group" style=" margin-top:20px;">
			<textarea id="board_content" name="board_content" class="form-control" rows="5" style="resize: none" disabled="disabled"><%=content %></textarea>
		</div>
	</section>
	<section id="section-picture" class="container">
		<div class="picture">
			<img src="./upload/lanTrip_apply/<%=picture %>" width="600px"></img>
		</div>
	</section>
	
	<section class="container" style="margin-top:10px;">
	    <form id="commentForm" name="commentForm" method="post">
	    <br/><br /><br />
	        <div>
	            <div>
	                <span><strong>Comments</strong></span> 
	                <span id="cCnt"></span>
	            </div>
	            <div>
	                <table class="table">                    
	                    <tr>
	                        <td>
	                            <textarea style="width: 1100px" rows="3" cols="50" id="comment" name="comment" placeholder="&nbsp;댓글을 입력하세요"></textarea>
	                            <div id="btn_write">
	                                <a href='#' onClick="fn_comment('${result.code }')" class="btn pull-right btn-success">등록</a>
	                            </div>
	                        </td>
	                    </tr>
	                </table>
	            </div>
	        </div>
	    </form>
	    <div>
			<div id="btn_list">
				<input type="button" value="목록" class="btn" onclick="location.href='lanTrip_apply_list.do'"/>
			</div>
			<div>
				<input id="btn_modify" type="button" value="수정" class="btn btn-default" style="cursor: pointer;" onclick="location.href='lanTrip_apply_modify.do?no=<%=request.getParameter("no") %>'" />
				<input id="btn_delete" type="button" value="삭제" class="btn" style="cursor: pointer;" onclick="location.href='lanTrip_apply_delete.do?no=<%=request.getParameter("no") %>'" />
				<input id="btn_write" type="button" value="신청하기" class="btn" style="cursor: pointer;" onclick="location.href='lanTrip_apply_write.do'" />
			</div>
		</div>
	</section>
	
</body>
</html>