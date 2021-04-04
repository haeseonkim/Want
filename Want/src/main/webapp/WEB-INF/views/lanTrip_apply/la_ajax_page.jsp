<%@page import="com.exam.model1.lantripApply.LanTripApplyListTO"%>
<%@page import="com.exam.model1.lantripApply.LanTripApplyTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String nick = (String)session.getAttribute( "nick" );
	
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
			
		sbHtml.append("<tr>");
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
		};
		
		sbHtml.append("   </td>");
		sbHtml.append("   <td id='writer'>" + writer + "</td>");
		sbHtml.append("   <td id='wdate'>" + wdate + "</td>");
		sbHtml.append("   <td id='hit'>" + hit + "</td>");
		sbHtml.append("   <td>&nbsp;</td>");
		sbHtml.append("</tr>");
	}	
%>


<%= sbHtml %>