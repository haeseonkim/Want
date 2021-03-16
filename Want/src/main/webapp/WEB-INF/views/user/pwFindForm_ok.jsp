<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute( "flag" );
	
	out.println( " <script type='text/javascript'> " );
	if( flag == 0 ) {	// 아이디, 메일 일치
		
		out.println( " alert('메일로 임시 비밀번호가 전송되었습니다.'); " );
		out.println( " location.href='./lanTrip_list.do'" );
	} else if( flag == 1 ) {	//메일 틀림
		out.println( " alert('메일을 다시 확인해주세요.'); " );
		out.println( " history.back(); " );
	} else if( flag == 2 ) {	//회원정보없음
		out.println( " alert('회원정보가 없습니다. 회원가입해주세요.'); " );
		out.println( " history.back(); " );
	} else {					//기타 에러났을 때
		out.println( " alert('다시 입력해주세요.'); " );
		out.println( " history.back(); " );
	}
	out.println( " </script> " );

%>