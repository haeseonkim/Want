<%@ page import="java.util.ArrayList"%>
<%@ page import="com.exam.model1.lantripApply.LanTripApplyListTO"%>
<%@ page import="com.exam.model1.lantripApply.LanTripApplyTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	LanTripApplyListTO listTO = (LanTripApplyListTO) request.getAttribute("listTO");
	int cpage = listTO.getCpage();
	if(request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals( "" ) ) {
		cpage = Integer.parseInt( request.getParameter( "cpage" ) );
	}
	int recordPerPage = listTO.getRecordPerPage();
	int totalRecord = listTO.getTotalRecord();
	int totalPage = listTO.getTotalPage();
	int blockPerPage = listTO.getBlockPerPage();
	int startBlock = listTO.getStartBlock();
	int endBlock = listTO.getEndBlock();
	ArrayList<LanTripApplyTO> boardLists = listTO.getBoardLists();
	
	StringBuffer sbHtml = new StringBuffer();
	for (LanTripApplyTO to : boardLists) {
		String no = to.getNo();
		String subject = to.getSubject();
		String writer = to.getWriter();
		String wdate = to.getWdate();
		String hit = to.getHit();
		String location = to.getLocation();
		String reply = to.getReply();
			
		sbHtml.append("<tr class='fonted-table'>");
		sbHtml.append("   <td>&nbsp;</td>");
		sbHtml.append("   <td id='no'>" + no + "</td>");
		sbHtml.append("	 <th>&nbsp;</th>");
		sbHtml.append("   <td id='loc'>" + location + "</td>");
		sbHtml.append("	 <th>&nbsp;</th>");
		sbHtml.append("   <td>");
		sbHtml.append("      <a href='./lanTrip_apply_view.do?cpage="+cpage+"&no=" + no + "'>" + subject + "</a>&nbsp;");
		
		if(Integer.parseInt(reply)==0){
			sbHtml.append("");
		} else {
			sbHtml.append("<span style='color:#5fcf80;'>["+reply+"]</span>");
		}
		
		sbHtml.append("   </td>");
		sbHtml.append("   <td id='writer'>" + writer + "</td>");
		sbHtml.append("   <td id='wdate'>" + wdate + "</td>");
		sbHtml.append("   <td id='hit'>" + hit + "</td>");
		sbHtml.append("   <td>&nbsp;</td>");
		sbHtml.append("</tr>");
	}	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Want ??????????????????</title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/lanTrip_apply_list.css?12sdf"
	rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
		
		window.onload = function() {
			
			// ??????????????? ????????? ??? ???????????? ?????? ??????
			document.getElementById('submit').onclick = function() {
				if (document.frm.keyword.value.trim() == "") {
					alert('?????? ????????? ??????????????? ?????????.');
					return false;
				}
				
				console.log(document.frm.keyword.value.trim());
				//console.log(document.frm.condition.isSelected);
				
				document.frm.submit();
			};
		}
		
	</script>


</head>
<body>
	<!-- ????????? 
		 ??????????????? ?????? param.thisPage??? ????????? navbar.jsp???  ?????? -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_apply_list" name="thisPage" />
	</jsp:include>

	<br />
	<br />
	<br />

	<section id="la-header">
		<br />
		<div class="la-header-container">
			<h1> ???????????? ????????????</h1>
			<p>????????? ??????????????? ???????????????!</p>
		</div>
	</section>
	<br />
	<div id="card-search" class="card-search" >
		<!-- ?????? ????????? form -->
		<form action="./la_ajax_page.do" name="frm" method="get">
			<div class="row justify-content-md-center" id="search">
				<div class="form-row col-1"></div>
				<div class="col-1">
					<div class="value">
						<select id="condition" name="condition" class="form-select">
							<option value="subject" ${condition eq 'subject' ? 'selected' : '' }>??????</option>
							<option value="content" ${condition eq 'content' ? 'selected' : '' }>??????</option>
							<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>?????????</option>
							<option value="location" ${condition eq 'location' ? 'selected' : '' }>??????</option>
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<input value="${keyword }" type="text" name="keyword" id="keyword" placeholder="???????????? ??????????????????" class="form-control">
				</div>
				<div class="col-md-1" style="padding-left:0; vertical-align:middle;">
					<button id="submit" class="btn btn--blue-2 btn--radius-2" type="submit">??????</button>
				</div>
				<div class="col-1"></div>
			</div>
		</form>
	</div>
	
	<!-- ?????? -->

	<%-- ?????? ?????? ???????????? ??????????????? ????????? ?????? ?????? ???????????? ????????????. --%>
	<c:if test="${not empty keyword }">
		<div class="alert text-center">
			<span style="color:#5fcf80;"><strong>${totalRow }</strong> </span>?????? ????????? ?????????????????????.
		</div>
	</c:if>
	<!-- ???????????? -->
	<div class="search-result">
	
	</div>
			<!--?????????-->
			<div class="board">
			<hr />
				<table>
					<tr>
						<th width="3%" class="latable">&nbsp;</th>
						<th width="5%" id="no" class="latable">??????</th>
						<th width="3%">&nbsp;</th>
						<th width="5%" id="loc" class="latable">??????</th>
						<th width="3%">&nbsp;</th>
						<th id="subject" class="latable">??????</th>
						<th width="10%" id="writer" class="latable">?????????</th>
						<th width="17%" id="wdate" class="latable">?????????</th>
						<th width="5%" id="hit" class="latable">??????</th>
						<th width="3%">&nbsp;</th>
					</tr>
					<!-- ??? ?????? -->
					<%=sbHtml%>
					
					<!-- ??? ??? -->
				</table>
			</div>
			<div class="card-footer">
			<c:choose>      
				<c:when test="${empty sessionScope.nick}">
					<button type="button" class="btn btn--radius-2 btn--blue-2 btn-md" onclick="javascript:alert('???????????? ??????????????????.')">????????????</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn--radius-2 btn--blue-2 btn-md" onclick="location.href='./lanTrip_apply_write.do?cpage=<%=cpage%>'">????????????</button>	
				</c:otherwise>
			</c:choose>   
			</div>
	<div class="align-center paging">
<%
	if(startBlock == 1) {
        out.println("&lt;&lt;&nbsp;&nbsp;");
	} else {
		out.println("<a href='lanTrip_apply_list.do?cpage=" + (startBlock - blockPerPage) + "'>&lt;&lt;</a>");
	}
	
	if(cpage == 1) {
		out.println("&lt;&nbsp;&nbsp;");    
	} else {
		out.println("<a href='lanTrip_apply_list.do?cpage=" + (cpage - 1)   + "'>&lt;</a>");
	}
	for(int i=startBlock ; i<=endBlock ; i++) {
		if (cpage == i) {
            out.println("<a href='#' style='color: red'>[ " + i + " ]</a>");
       } else {
			out.println("<a href='lanTrip_apply_list.do?cpage=" + i + "'>[ " + i + " ]</a>");
       }
	}
	
	if(cpage == totalPage) {
		out.println("&nbsp;&nbsp;&gt;&nbsp;&nbsp;");    
	} else {
		out.println("<a href='lanTrip_apply_list.do?cpage=" + (cpage + 1)   + "'>&gt;</a>");
	}
	
    if(endBlock == totalPage) {
        out.println("&gt;&gt;&nbsp;");
	} else {
		out.println("<a href='lanTrip_apply_list.do?cpage=" + (startBlock + blockPerPage) + "'>&gt;&gt;</a>");
	}
%>
	</div>

	

</body>
</html>
