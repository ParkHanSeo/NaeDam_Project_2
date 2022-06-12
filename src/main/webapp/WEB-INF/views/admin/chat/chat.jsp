<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org" xmlns:sec="http://www.thymeleaf.org/extras/spring-security">
<head>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js" integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY=" crossorigin="anonymous"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath }/resources/js/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath }/resources/js/adminlte.min.js"></script>
<!-- Sparkline -->
<script src="${pageContext.request.contextPath }/resources/js/jquery.sparkline.min.js"></script>
<!-- jvectormap  -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-jvectormap-1.2.2.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll -->
<script src="${pageContext.request.contextPath }/resources/js/jquery.slimscroll.min.js"></script>
<!-- ChartJS -->
<script src="${pageContext.request.contextPath }/resources/js/Chart.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath }/resources/js/demo.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/common.js" type="text/javascript" charset="utf-8"></script>
<style type="text/css">
	button,button:hover{border:none;color:#fff;padding:10px}.chat__messages,.chat__sidebar ul{list-style-type:none}*{box-sizing:border-box;margin:0;padding:0;font-family:HelveticaNeue-Light,"Helvetica Neue Light","Helvetica Neue",Helvetica,Arial,"Lucida Grande",sans-serif;font-weight:300;font-size:.95rem}li,ul{list-style-position:inside}h3{font-weight:600;text-align:center;font-size:1.5rem}button{background:#265f82;cursor:pointer;transition:background .3s ease}button:hover{background:#1F4C69}button:disabled{cursor:default;background:#698ea5}.centered-form{display:flex;align-items:center;height:100vh;width:100vw;justify-content:center;background:-moz-linear-gradient(125deg,rgba(255 255 255) 0,rgba(0 191 255) 100%);background:-webkit-gradient(linear,left top,right bottom,color-stop(0,rgba(49,84,129,1)),color-stop(100%,rgba(39,107,130,1)));background:-webkit-linear-gradient(125deg,rgba(255 255 255) 0,rgba(0 191 255) 100%);background:-o-linear-gradient(125deg,rgba(255 255 255) 0,rgba(0 191 255) 100%);background:-ms-linear-gradient(125deg,rgba(255 255 255) 0,rgba(0 191 255) 100%);background:linear-gradient(325deg,rgba(255 255 255) 0,rgba(0 191 255) 100%)}.centered-form__form{background:rgba(250,250,250,.9);border:1px solid #e1e1e1;border-radius:5px;padding:0 20px;margin:20px;width:230px}.form-field{margin:20px 0}.form-field>*{width:100%}.form-field label{display:block;margin-bottom:7px}.form-field input,.form-field select{border:1px solid #e1e1e1;padding:10px}.chat{display:flex}.chat__sidebar{overflow-y:scroll;width:260px;height:100vh;background:-moz-linear-gradient(125deg,rgba(255 255 255) 0,rgba(0 191 255) 100%);background:-webkit-gradient(linear,left top,right bottom,color-stop(0,rgba(49,84,129,1)),color-stop(100%,rgba(39,107,130,1)));background:-webkit-linear-gradient(125deg,rgba(255 255 255) 0,rgba(0 191 255) 100%);background:-o-linear-gradient(125deg,rgba(255 255 255) 0,rgba(0 191 255) 100%);background:-ms-linear-gradient(125deg,rgba(255 255 255) 0,rgba(0 191 255) 100%);background:linear-gradient(325deg,rgba(255 255 255) 0,rgba(0 191 255) 100%)}.chat__footer,.chat__sidebar li{background:#e6eaee;padding:10px}.chat__sidebar h3{color:#e6eaee;margin:10px 20px;text-align:left}.chat__sidebar li{border:1px solid #e1e1e1;border-radius:5px;margin:10px}.chat__main{display:flex;flex-direction:column;height:100vh;width:100%}.chat__messages{flex-grow:1;overflow-y:scroll;-webkit-overflow-scrolling:touch;padding:10px}.chat__footer{display:flex;flex-shrink:0}.chat__footer form{flex-grow:1;display:flex}.chat__footer form *{margin-right:10px}.chat__footer input{border:none;padding:10px;flex-grow:1}.message__title{display:flex;margin-bottom:5px}.message__title h4{font-weight:600;margin-right:10px}.message__title span{color:#999}@media (max-width:600px){*{font-size:1rem}.chat__sidebar{display:none}.chat__footer{flex-direction:column}.chat__footer form{margin-bottom:10px}.chat__footer button{margin-right:0}}
	#msgArea{background-color: rgb(0 191 255);}.chat__footer{background-color: yellow;}
	.message1{padding:10px;border-radius:15px;background-color:white;margin-top: 5px;margin-bottom: 5px;width:300px;margin-left:auto;}
	.message2{padding:10px;border-radius:15px;background-color:white;margin-top: 5px;margin-bottom: 5px;width:300px;}
	#submit-btn{background-color: black;}
</style>
<script type="text/javascript">
	//전송 버튼 누르는 이벤트
	
	function chatStart(){
		sendMessage();
		$('#msg').val('')
	}
	
	var sock = new SockJS('/ws/admin/chat/chat', null, {transports: ["websocket", "xhr-streaming", "xhr-polling"]});
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onopen = onOpen;
	
	function scrollToBottom() {
		let messages = document.querySelector('#messages').lastElementChild;
		messages.scrollIntoView();
	}
	
	function sendMessage() {
		sock.send($("#msg").val());
	}
	//서버에서 메시지를 받았을 때
	function onMessage(msg) {
		console.log(msg);
		var data = msg.data;
		var sessionId = null; //데이터를 보낸 사람
		var message = null;
		var memberId = $("input[name='memberId']").val();
		
		var arr = data.split(":");
		
		for(var i=0; i<arr.length; i++){
			console.log('arr[' + i + ']: ' + arr[i]);
		}
		
		var cur_session = '${userid}'; //현재 세션에 로그인 한 사람
		console.log("cur_session : " + cur_session);
		
		sessionId = arr[0];
		message = arr[1];

	    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
		if(sessionId == memberId){
			const html = 
		  	'<li class="message1"><div class="message__title"><h4>'
		  	+"나"+
		  	'</h4></div><div class="message__body"><p>'
		  	+message+
		  	'</p></div></li>';

			
			$("#msgArea").append(html);
		}
		else{
			const html = 
		  	'<li class="message2"><div class="message__title"><h4>'
		  	+sessionId+
		  	'</h4></div><div class="message__body"><p>'
		  	+message+
		  	'</p></div></li>';
			
			$("#msgArea").append(html);
		}
		
	}
	//채팅창에서 나갔을 때
	function onClose(evt) {

		var user = '${userid}';
		var str = user + " 님이 퇴장하셨습니다.";
		
		$("#msgArea").append(str);
	}
	//채팅창에 들어왔을 때
	function onOpen(evt) {
		
		var user = '${userid}';
		var str = user + "님이 입장하셨습니다.";
		
		$("#msgArea").append(str);
	}
	
	function enterkey() {
		if (window.event.keyCode == 13) {
			chatStart();
	    }
	}

	
</script>
</head>
	<body class="chat">
	    <div class="chat__sidebar">
	      <h3 style="color:black; font-weight:bold">채팅</h3>
	      <div id="users"></div>
	      <input type="hidden" name="memberId" value="<sec:authentication property='principal.id'/>">
	    </div>
		<div class="chat__main">
				<ol id="msgArea" class="chat__messages" style="font-weight:bold"></ol>
	      <div class="chat__footer">
	          <input type="text" id="msg" name="message" onkeyup="enterkey()"  placeholder="Message"/>
	          <button id="submit-btn" onclick="chatStart()">전송</button>
	      </div>			
		</div>
	</body>
</html>