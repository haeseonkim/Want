<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="com.exam.model1.lantrip.LanTripTO" %>
<%@ page import="com.exam.model1.lantripReply.LanTripReplyTO" %>
<%@ page import="com.exam.model1.lantrip.LanTripDAO" %>
<%@ page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding( "utf-8" );
	String cpage = request.getParameter( "cpage" );
	String nick = (String)session.getAttribute("nick");
	
	LanTripTO to = (LanTripTO)request.getAttribute("to");
	
	String no = to.getNo();
	String subject = to.getSubject();
	//String content = to.getContent().replaceAll("\n","<br />");
	String content = to.getContent();
	String writer = to.getWriter();
	String wdate = to.getWdate();
	String hit = to.getHit();
	String location = to.getLocation();
	String video = to.getVideo();
	String reply = to.getReply();
	String heart = to.getHeart();
	String hno = to.getHno();
	
	ArrayList<LanTripReplyTO> rLists = (ArrayList)request.getAttribute( "rLists" );
	StringBuffer sbHtml = new StringBuffer();
	
	for( LanTripReplyTO replyTo : rLists ) {
		if( replyTo.getGrpl() == 1 ) {
			sbHtml.append( "<form method='post' class='rereply' name='reply_content"+replyTo.getNo()+"' >" );
		} else {
			sbHtml.append( "<form method='post' class='reply' name='reply_content"+replyTo.getNo()+"' >" );
		}
		sbHtml.append( "<input type='hidden' name='no' value='"+replyTo.getNo()+"' />" );
		sbHtml.append( "<input type='hidden' name='bno' value='"+no+"' />" );
		sbHtml.append( "<input type='hidden' name='writer' value='"+nick+"' />" );
		sbHtml.append( "<input type='hidden' name='cpage' value='"+cpage+"' />" );
		sbHtml.append( "<input type='hidden' name='grp' value='"+replyTo.getGrp()+"' />" );
       	sbHtml.append( "<div class='row'> " );
		sbHtml.append( "<div class='col-1 profile_img'> ");
		sbHtml.append( "	<img class='cmt_profile img-circle' src='./upload/profile/" + replyTo.getProfile() + "'> ");
		sbHtml.append( "</div> ");
		sbHtml.append( "<div class='col-10'> ");
		sbHtml.append( "	<h6><b>" + replyTo.getWriter() + "</b></h6>");
		sbHtml.append( "<div>" + replyTo.getContent() + "</div> ");
		sbHtml.append( "	<div class='rereply_box'> ");
		sbHtml.append( "		<span class='cdate'>" + replyTo.getWdate() + "</span> &nbsp;&nbsp;");
        sbHtml.append( "		<span><button type='button' class='btn_rereply' idx='"+replyTo.getNo()+"'>????????????</button></span> ");
      	sbHtml.append( "		| ");
       	sbHtml.append( "		<span><button type='button' class='btn_rdelete' id='reply_content"+ replyTo.getNo()+"d"+replyTo.getWriter()+"' onclick='reply_deleteOk(this.id)'>??????</button></span> ");
   		sbHtml.append( " 	</div> ");
 		sbHtml.append( "</div> ");
 		sbHtml.append( "<div> " );
		sbHtml.append( "<div class='row reply_div" + replyTo.getNo() + "' style='display: none;'> ");
    	sbHtml.append( "		<div> ");
    	sbHtml.append( "			<textarea style='width: 1100px' rows='3' cols='50' id='reply_content"+replyTo.getNo()+"' name='r_ccontent' placeholder='&nbsp;????????? ???????????????'></textarea> ");
        sbHtml.append( "			<span><button id='reply_content" + replyTo.getNo() + "' type='button' class='btn_rereply' onclick='reply_commentOk(this.id)'>????????????</button></span> ");
		sbHtml.append( "     	</div> ");
    	sbHtml.append( "	</div> ");
 		sbHtml.append( "</div> ");
		sbHtml.append( "</div> ");
		sbHtml.append( "</form>");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<title>WANT ??????????????????</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/lanTrip_view.css?1111" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">

<script type="text/javascript">

$(document).ready( function() {
   
   // ????????? ??? ???????????? ???????????? ???????????? ??? ?????????.
   $(".div_heart").click(function() {
      let heartName = $(this).attr('id');
      console.log( heartName );
      
      let no = '';
      if( heartName == 'heart1' ) {   //????????? -> ????????????
         let no = $(this).children( '.heart1').attr( 'idx' );
      
         $.ajax({
            url : 'lanTrip_saveHeart.do',
            type : 'get',
            data : {
               no : no,
            },
            success : function(flag) {
               console.log(flag);
               console.log("???????????? ??????");
               
               //????????? ????????????
               //document.location.reload(true);
               $( '.heartCount' ).html( flag.heart );
               
            },
            error : function() {
               alert('????????? ?????? ??????');
            }
         });
         $('.div_heart').html("<svg idx='"+no+"' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill heart2' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
         $('.div_heart').attr( 'id', 'heart2' );
         
      } else {   //???????????? -> ?????????
         let no = $(this).children( '.heart2').attr( 'idx' );
         console.log("?????????????????? no????????? : "+ no );   
      
         $.ajax({
            url : 'lanTrip_removeHeart.do',
            type : 'get',
            data : {
               no : no,
            },
            success : function(flag) {
               console.log(flag);
               console.log("???????????? ??????");
               
               //????????? ????????????
               //document.location.reload(true);
               $( '.heartCount' ).html( flag.heart );
               
            },
            error : function() {
               alert('????????? ?????? ??????');
            }
         });
         $('.div_heart').html("<svg idx='"+no+"' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart heart1' viewBox='0 0 16 16'><path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' /></svg>");
         $('.div_heart').attr( 'id', 'heart1' );
      
      }
      console.log("???????????? ??????" );

   });
	
	
	//?????? ?????? ?????? ????????? ???
	$('.btn_rereply').click( function() {
		let re_no = $(this).attr('idx');
		if( $('.reply_div'+re_no).attr('id') == 'h' || $('.reply_div'+re_no).attr('id') == null ) {
			$('.reply_div'+re_no).css("display", "block")
			$('.reply_div'+re_no).attr('id', 'b');
		} else {
			$('.reply_div'+re_no).css("display", "none")
			$('.reply_div'+re_no).attr('id', 'h');
		}
	})
	
	//?????? ?????? ?????? ????????? ???
	$( 'svg.reply_modify' ).click( function() {
		let re_no = $(this).attr('idx');
		if( $( '.reply_comment'+re_no ).attr('id') == 'b' || $( '.reply_comment'+re_no ).attr('id') == null ) {
			$( '.reply_comment'+re_no ).css( "display", "none" );
			$( '.reply_comment'+re_no ).attr('id', 'h' );
			$( '.reply_comment_textarea'+re_no ).css( "display", "block" );
			$( '.reply_comment_textarea'+re_no ).attr('id', 'b' );
		} else {
			$( '.reply_comment'+re_no ).css( "display", "block" );
			$( '.reply_comment'+re_no ).attr('id', 'b' );
			$( '.reply_comment_textarea'+re_no ).css( "display", "none" );
			$( '.reply_comment_textarea'+re_no ).attr('id', 'h' );
		}
	})
	
})

	const replyOk = function() {
		if( document.cfrm.cwriter.value.trim() == '' ) {
			alert( '???????????? ????????????' );
			return false;
		}
		if( document.cfrm.ccontent.value.trim() == '' ) {
			alert( '??????????????? ??????????????????' );
			return false;
		}
		
		document.cfrm.submit();
	}	
	
	
	//????????? ???????????? ?????? ??? ?????? ??????
	const reply_deleteOk = function(clicked_id) {
		let nick = "<%= nick %>";
		list = clicked_id.split('d');
		
		let frm_id = list[0];
		let re_writer = list[1];
		
		if( re_writer != nick ) {
			alert( '???????????? ????????? ???????????????.' )
			return false;
		}	
		if (confirm("?????? ????????? ?????????????????????????") == true){    //??????
			
			document.forms[frm_id].action = "./lanTrip_reply_deleteOk.do";
			document.forms[frm_id].submit();
		}else{   //??????
		    return false;
		}
	}
	
	//????????? ???????????? ?????? ??? ?????? ??????
	const reply_modifyOk = function(clicked_id) {
		let nick = "<%= nick %>";
		list = clicked_id.split('m');
		
		let frm_id = list[0];
		let re_writer = list[1];
		
		if( re_writer != nick ) {
			alert( '???????????? ????????? ???????????????.' )
			return false;
		}
		document.forms[frm_id].action = "./lanTrip_reply_modifyOk.do";
		document.forms[frm_id].submit();
	}
	
	//?????? ??????
	const reply_commentOk = function(clicked_id) {
		let nick = "<%= nick %>";
		console.log( $( '#'+clicked_id ).text() );
		console.log( clicked_id );
		if( nick == "null" ) {
			alert( '???????????? ????????????.' );
			return false;
		}
		if( $('#'+clicked_id ).val() == '' ) {
			alert( '?????? ????????? ??????????????????.' )
			return false;
		}
		document.forms[clicked_id].action = "./lanTrip_rereply_ok.do";
		document.forms[clicked_id].submit();
	}
	
			
</script>
</head>
<body>
	<!-- ????????? 
		 ??????????????? ?????? param.thisPage??? ????????? navbar.jsp???  ?????? -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />	
	
	<section id="info" class="container" style="margin-top:100px;">
		<table class="table table-hover" id='board_list'>
			<thead>
				<tr>
					<td class="text-center d-none d-md-table-cell"><%=no %></td>
					<td class="text-center d-none d-md-table-cell"><%=location %></td>
					<td class="text-center"><%=subject %></td>
					<td class="text-center d-none d-md-table-cell"><%=writer %></td>
					<td class="text-center d-none d-md-table-cell"><%=wdate %></td>
					<td class="text-center d-none d-md-table-cell"><%=hit %></td>
				</tr>
			</thead>
		</table>
	</section>
	<section id="player" class="container">
		<div class="video">
			<video src="./upload/lanTrip/<%=video %>" width="600px" controls></video>
		</div>
	</section>
	<section id="content" class="container">
		<div class="form-group" style="border: 1px; color: solid; margin-top:20px;">
			<div id="board_content" name="board_content" class="form-control" rows="10" style="resize: none" disabled="disabled"><%=content %> </div>
		</div>
	</section>
	
	<!-- ?????? -->
	<section class="container" style="margin-top:10px;">
		    
		    <%=sbHtml %>
		    
            <div class="cmt">
               <span><strong>?????? | <%=reply %></strong></span>
            </div>
   <section id="heartview" class="container">
	   <table class="table table-bordered table_reply_view">
	         <tr>
	            <td class="like">
	            ?????????
	            <c:choose>   <%-- ????????? ????????? ?????? ?????? ????????? ?????? ??????--%>
	               <c:when test="${empty sessionScope.nick }" >
	                  <span class="div_heart">
	                     <svg class='heart3' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>
	                        <path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />
	                     </svg>
	                  </span>
	               </c:when>
	               <c:when test="${ empty to.getHno() }" > <%--?????? ???????????? ????????? ???????????? ??? ?????????  --%>
	                  <span id="heart1" class="div_heart"> 
	                     <svg idx='<%= no %>' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart heart1' viewBox='0 0 16 16'>
	                        <path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />
	                     </svg>
	                  </span>
	               </c:when>
	               <c:otherwise>   <%--?????? ???????????? ????????? ????????? ??? ??? ??? ?????? --%>
	                  <span id="heart2" class="div_heart"> 
	                     <svg idx='<%= no %>' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill heart2' viewBox='0 0 16 16'>
	                        <path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/>
	                     </svg>
	                  </span>
	               </c:otherwise>
	            </c:choose>
	            <span class='heartCount'><%= heart %></span> 
	            </td>
	         </tr>
	         </table>
	   </section>
            <form action="./lanTrip_view_reply_ok.do" method="post" name="cfrm">
            <input type="hidden" name="cwriter" value="<%= nick %>" />
            <input type="hidden" name="bno" value="<%=no %>" />
	        	<table class="table">                    
	        	    <tr>
	                	<td>
	            	        <textarea style="width: 1100px" rows="3" cols="50" id="comment" name="ccontent" placeholder="&nbsp;????????? ???????????????"></textarea>
	                        	<div id="btn_comment">
	                                <button type="button" onClick="replyOk()" class="btn btn--radius-2 btn--blue-2 btn-md">????????????</button>
	                            </div>
	                    </td>
	                 </tr>
	           	</table>
	           	 </form>
	        </div>
         </div>
     
	        
	    <div id="btn_buttons">
			<span>
				<button class="btn btn--radius-2 btn-sm btn--silver"  type="button"
				onclick="location.href='./lanTrip_list.do'"> ?????? </button>
				<!-- ???????????? ???????????? ???????????? ?????? ?????? ????????? ??????????????? ????????? ??????. -->
				<c:if test="${to.writer eq sessionScope.nick }">
					<button class="btn btn--radius-2 btn--silver btn-sm" type="button" data-bs-toggle="modal" data-bs-target=".bs-modify-modal-sm">??????</button>
					<button class="btn btn--radius-2 btn--silver btn-sm" type="button" data-bs-toggle="modal" data-bs-target=".bs-delete-modal-sm">??????</button>
				</c:if>
			</span>
		</div>
		
		<div class="modal fade bs-delete-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  			<div class="modal-dialog modal-sm">
  		
  		
    			<div class="modal-content" >
    				<br />
      				<div style="height:60px;">&nbsp;&nbsp;?????? ?????????????????????????</div>
      		
      				<div class="modal-footer">
        				<button type="button" class="btn btn--silver" data-bs-dismiss="modal" >??????</button>
        				<button type="button" class="btn btn--blue-2" onclick="location.href='./lanTrip_delete_ok.do?no=<%=no %>'">??????</button>
      				</div>
    			</div>
    		
  			</div>
		</div>
		
		<div class="modal fade bs-modify-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  			<div class="modal-dialog modal-sm">
  		
  		
    			<div class="modal-content">
      			<br />
      			<div style="height:60px;">&nbsp;&nbsp;?????? ?????????????????????????</div>
      				<div class="modal-footer">
        				<button type="button" class="btn btn--silver" data-bs-dismiss="modal" >??????</button>
        				<button type="button" class="btn btn--blue-2" onclick="location.href='./lanTrip_modify.do?no=<%=no %>'">??????</button>
      				</div>
    			</div>
    		
  			</div>
		</div>
	</section>
	
</body>
</html>	