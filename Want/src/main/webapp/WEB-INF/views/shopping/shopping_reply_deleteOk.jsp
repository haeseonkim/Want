<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String cpage = (String)request.getAttribute( "cpage" );
	String no = (String)request.getAttribute( "no" );
	int flag = (Integer)request.getAttribute( "flag" );
	
	out.println( " <script type='text/javascript'> " );
	if( flag == 0 ) {
		out.println( " alert('댓글삭제에 성공했습니다.'); " );
		out.println( " location.href='./shopping_view.do?cpage=" + cpage + "&no="+ no +"'" );
	} else {
		out.println( " alert('댓글삭제에 실패했습니다.'); " );
		out.println( " history.back(); " );
	}
	out.println( " </script> " );

%>