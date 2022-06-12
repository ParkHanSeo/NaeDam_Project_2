<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>AdminLTE 2 | Log In</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<!-- Font Awesome -->
	<script src="https://kit.fontawesome.com/76afde4c0b.js" crossorigin="anonymous"></script>
	<!-- Ionicons -->
	<script src="https://unpkg.com/ionicons@4.4.1/dist/ionicons.js"></script>
	<!-- jvectormap -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.vector-map.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/AdminLTE.min.css">
	<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/_all-skins.min.css">
	<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css" />
	
	<!-- fullcalendar -->
	<link href="//mir9.co.kr/resource/css/bootstrap-colorselector.css" rel="stylesheet" />
	
	<link
		href="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/fullcalendar/dist/fullcalendar.min.css"
		rel="stylesheet" type="text/css" />
	<link
		href="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/fullcalendar/dist/fullcalendar.print.css"
		rel="stylesheet" type="text/css" media='print' />
	
	<!-- Google Font -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
	
	<style>
		#loginBody {
			min-height: 100vh;
			background: -webkit-gradient(linear, left bottom, right top, from(#92b5db),
				to(#1d466c));
			background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
			background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
			background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
			background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
		}
	</style>
</head>

<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>

<body id="loginBody" class="hold-transition login-page">
	<iframe name="iframe_process" width="0" height="0" frameborder="0"></iframe>
	<div align="center">
		<br> <br> <br> <br> <br> <br> <br>

		<div style="width: 400px;">
			<div class="box box-primary">
				<div class="box-body box-profile">
					<img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/neadam_logo.png" style="height: 50px; margin: 20px;">
					<h3 class="profile-username text-center">웹사이트 운영을 위한 관리자 모드입니다.</h3>
					<p class="text-muted text-center" style="padding: 10px;">아이디와 비밀번호 입력후 로그인해 주시기 바랍니다.</p>
					<form:form name="form" action="${pageContext.request.contextPath}/admin/member/memberLogin.do?${_csrf.parameterName}=${_csrf.token}" method="POST" style="padding: 20px;">
						<c:if test="${param.error != null}">
							<span class="text-danger" style="font-weight: bold; font-size: 120%;"> 아이디 또는 비밀번호가 일치하지 않습니다.</span>
						</c:if>
						<div class="form-group has-feedback">
							<input type="text" name="id" class="form-control" placeholder="ID" /> 
							<span class="glyphicon glyphicon-pencil form-control-feedback"></span>
						</div>
						<div class="form-group has-feedback">
							<input type="password" name="password" class="form-control" placeholder="PASSWORD" />
							<span class="glyphicon glyphicon-lock form-control-feedback"></span>
						</div>
						<a id="loginBtn" onclick="loginSubmit()" class="btn btn-primary btn-block"><b>로그인</b></a>&nbsp;
						<a href="#none" onclick="enrollSubmit()" class="btn btn-primary btn-block"><b>회원가입</b></a>
					</form:form>
				</div>
				<p class="text-muted text-center" style="padding: 10px;">&copy; NAEDAM </p>
			</div><!-- /.box box-primary -->
		</div>
	</div>

<script>
	$("input:checkbox[id='remember-me']").prop("checked", true);

	function loginSubmit() {		
		console.log("loginSubmit 도착했나요?");
		if (form.id.value == '') {
			alert('아이디가 입력되지 않았습니다.');
			form.id.focus();
			return false;
		}
		if (form.password.value == '') {
			alert('패스워드가 입력되지 않았습니다.');
			form.password.focus();
			return false;
		}
		form.submit();
	}
	
	function enrollSubmit() {
		console.log("enrollSubmti() 실행");
		location.href=`${pageContext.request.contextPath}/user/user/userEnroll.do`;
	}
</script>
</body>
</html>