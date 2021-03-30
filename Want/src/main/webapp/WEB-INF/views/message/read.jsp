<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	var ws = new WebSocket("ws://localhost:8080/replyEcho");
	//var ws = new WebSocket("ws://localhost:8080/replyEcho?bno=1234");
	
	// 커넥션이 연결 됐을 때 실행
	ws.onopen = function() {
		console.log('Info: connection opened.');
		setTimeout( function() {connect(); }, 1000); 
		
		ws.onmessage = function (event) {
			console.log(event.data+'\n');
		};
	};
	
	ws.onclose = function (event) {console.log('Info: connection closed.'); };
	ws.onerror = function (err) {console.log('Error:', err); };
	
	//$('#btnSend').on('click', function(evt){
	//	evt.preventDefault();
	//	if(socket.readyState !== 1) return;
	//	let msg = $('input#msg').val();
	//	ws.send(msg);
	//});

</script>
</head>
<body>
	<input type="text" id="msg" />
	<input type="button" id="btnSend" value="submit"/>
	<div id="messageArea"></div>
</body>
</html>