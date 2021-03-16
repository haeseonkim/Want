<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ page import="com.exam.model1.lanTripApplyTO" %>
<%@ page import="com.exam.model1.CommentTO" %>

<%@ page import="java.util.ArrayList" %>

<%
   String cpage = request.getParameter("cpage");

   BoardTO to = (BoardTO)request.getAttribute("to");
   
   // 하나만 가져오니까 if문 사용
   String seq = to.getSeq();
   String subject = to.getSubject();
   String writer = to.getWriter();
   String mail = to.getMail();
   String wip = to.getWip();
   String wdate = to.getWdate();
   String hit = to.getHit();
   String content = to.getContent().replaceAll("\n","<br />");
   String filename = to.getFilename();
   String longitude = to.getLongitude();
   String latitude = to.getLatitude();
   int cmt = to.getCmt();
   
   ArrayList<CommentTO> clist = (ArrayList)request.getAttribute("clist");   
   StringBuffer sbHtml = new StringBuffer();
   for(CommentTO cto : clist){
      sbHtml.append("<tr>");
      sbHtml.append("<td class='coment_re' width='20%'>");
      sbHtml.append("<strong>"+ cto.getWriter() +"</strong> ("+ cto.getWdate() +")");
      sbHtml.append("<div class='coment_re_txt'>");
      sbHtml.append(cto.getContent());
      sbHtml.append("</div>");
      sbHtml.append("</td>");
      sbHtml.append("</tr>");
      
   }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./css/board_view.css">
<script type="text/javascript">
   window.onload = function(){
      document.getElementById( 'submit1' ).onclick = function(){
         if(document.cfrm.ccontent.value.trim() == ''){
            alert('댓글을 입력하세요.');
            return false;
         }
         if(document.cfrm.cwriter.value.trim() == ''){
            alert('글쓴이를 입력하세요.');
            return false;
         }
         if(document.cfrm.cpassword.value.trim() == ''){
            alert('비밀번호를 입력하세요.');
            return false;
         }
         document.cfrm.submit();
      };
   };
</script>
</head>

<body>
<!-- 상단 디자인 -->
<div class="contents1"> 
   <div class="con_title"> 
      <p style="margin: 0px; text-align: right">
         <img style="vertical-align: middle" alt="" src="./images/home_icon.gif" /> &gt; 커뮤니티 &gt; <strong>여행지리뷰</strong>
      </p>
   </div>

   <div class="contents_sub">   
   <!--게시판-->
      <div class="board_view">
         <table>
         <tr>
            <th width="10%">제목</th>
            <td width="60%"><%=subject %>(<%=wip %>)</td>
            <th width="10%">등록일</th>
            <td width="20%"><%=wdate %></td>
         </tr>
         <tr>
            <th>글쓴이</th>
            <td><%=writer %></td>
            <th>조회</th>
            <td><%=hit %></td>
         </tr>
         <tr>
            <th>위치정보</th>
            <td>
               위도 : (<%=latitude %>) / 경도 : (<%=longitude %>)
            </td>
            <th></th>
            <td></td>
         </tr>
         <tr>
            <td colspan="4" height="200" valign="top" style="padding:20px; line-height:160%">
               <div id="bbs_file_wrap">
                  <div>
                     <img src="./upload/<%=filename %>" width="900" onerror="" /><br />
                  </div>
               </div>
               <%=content %>
            </td>
         </tr>         
         </table>
         
         <table>
         <%=sbHtml %>
         </table>

         <form action="view_ok.do?cpage=<%=cpage %>&seq=<%=seq %>" method="post" name="cfrm">
         <table>
         <tr>
            <td width="94%" class="coment_re">
               글쓴이 <input type="text" name="cwriter" maxlength="5" class="coment_input" />&nbsp;&nbsp;
               비밀번호 <input type="password" name="cpassword" class="coment_input pR10" />&nbsp;&nbsp;
            </td>
            <td width="6%" class="bg01"></td>
         </tr>
         <tr>
            <td class="bg01">
               <textarea name="ccontent" cols="" rows="" class="coment_input_text"></textarea>
            </td>
            <td align="right" class="bg01">
               <input type="button" id="submit1" value="댓글등록" class="btn_re btn_txt01" />
            </td>
         </tr>
         </table>
         </form>
      </div>
      <div class="btn_area">
         <div class="align_left">         
            <input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='list.do?cpage=<%=cpage %>'" />
         </div>
         <div class="align_right">
            <input type="button" value="수정" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='modify.do?cpage=<%=cpage %>&seq=<%=seq %>'" />
            <input type="button" value="삭제" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='delete.do?cpage=<%=cpage %>&seq=<%=seq %>'" />
            <input type="button" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='write.do?cpage=<%=cpage %>'" />
         </div>
      </div>
      <!--//게시판-->
   </div>
<!-- 하단 디자인 -->
</div>

</body>
</html> --%>