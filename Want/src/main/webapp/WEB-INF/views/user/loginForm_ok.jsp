<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute( "flag" );
	
	out.println( " <script type='text/javascript'> " );
	if( flag == 0 ) {	//로그인성공
		
		out.println( " alert('로그인에 성공했습니다.'); " );
		out.println( " location.href='./lanTrip_list.do'" );
	} else if( flag == 1 ) {	//비번틀림
		out.println( " alert('비밀번호가 틀립니다.'); " );
		out.println( " history.back(); " );
	} else if( flag == 2 ) {	//회원정보없음
		out.println( " alert('회원정보가 없습니다. 회원가입해주세요.'); " );
		out.println( " history.back(); " );
	} else {					//기타 에러났을 때
		out.println( " alert('다시 로그인해주세요.'); " );
		out.println( " history.back(); " );
	}
	out.println( " </script> " );

%>