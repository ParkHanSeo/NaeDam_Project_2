<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	
<html>
<head>
	<meta charset="UTF-8">
	<title>AdminLTE 2 | 회원탈퇴</title>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<!-- bootstrap js: jquery load 이후에 작성할것.-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	
	<!-- bootstrap css -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
	
	<!-- 사용자작성 css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
	
	<script>
	<!-- redirect Msg 처리 -->
	<c:if test="${not empty msg}">
			alert("${msg}");
			location.reload();
	</c:if>
	
	$(() => {
		$(loginModal)
			.modal()
			.on("hide.bs.modal", (e) => {
				location.href = '${empty header.referer ? pageContext.request.contextPath : header.referer}';
			});
	});
	</script>
</head>

<body>
	<!-- https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="loginModalLabel">회원 탈퇴</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<!-- 탈퇴 -->
				<!-- https://getbootstrap.com/docs/4.1/components/forms/#overview -->
				<form:form action="${pageContext.request.contextPath}/admin/member/memberWithdrawal.do" method="POST">
					<div class="modal-body">
						<!-- error가 존재한다면 -->
						<!-- jstl param 받기 -->
						<c:if test="${param.error != null}">
							<span class="text-danger">아이디 또는 비밀번호가 일치하지 않습니다.</span>
						</c:if>
						<span>아이디</span>
						<input type="text" class="form-control" name="id" id="id" value="<sec:authentication property="principal.username" />" required><br />
						<span>비밀번호</span>	 
						<input type="password" class="form-control" name="password" id="password" value="" required><br />
						<span>탈퇴 사유</span>
						<textarea class="form-control" name="reason" id="reason" rows="5"></textarea>
						<span class="info-text">회원탈퇴 하시면 기존 회원관련 정보가 모두 삭제됩니다.</span>
					</div>
					<div class="modal-footer jstify-content-centers">
						<div>
							<button type="submit" class="btn btn-outline-success">확인</button>
							<button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
						</div>
					</div>
				</form:form>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal fade -->
</body>
</html>
