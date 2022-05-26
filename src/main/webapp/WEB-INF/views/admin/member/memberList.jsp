<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="회원 관리" name="title" />
</jsp:include>
<style>
.ui-menu {
	z-index: 9999;
	width: 400px;
}
</style>

<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			회원 관리 <small>member list</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>회원 관리</li>
			<li class="active">회원 리스트</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">
					<label id="countContainer" style="margin-top: 5px;">총 ${totalMemberListCount} 건</label>
						<div class="box-tools pull-right" style="margin-bottom: 5px;">
							<div class="has-feedback">
								<span> 
									<input type="text" name="keyword" id="keyword" value="" class="form-control input-sm" placeholder="검색" /> 
									<span class="glyphicon glyphicon-search form-control-feedback"> </span>
								</span>
							</div>
						</div>
						<div class="box-tools pull-right" style="margin-bottom: 5px;">
							<div class="has-feedback">
								<select name="type" class="form-control input-sm">
									<option value="last_name">성</option>
									<option value="first_name">이름</option>
									<option value="phone">휴대폰</option>
								</select>
							</div>
						</div>
					<form:form id="memberDeleteFrm" name="memberDeleteFrm" action="${pageContext.request.contextPath}/admin/member/memberDelete.do" method="POST">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<table class="table table-bordered table-hover checkbox-group">
							<thead>
								<tr>
									<td style="width: 30px;"><input type="checkbox" name="select_all" id="checkAll" /></td>
									<td style="width: 110px;">아이디</td>
									<td style="width: 110px;">이름</td>
									<td style="width: 110px;">휴대폰</td>
									<td>주소</td>
									<td style="width: 100px;">현재 적립금</td>
									<td style="width: 120px;">가입일</td>
									<td style="width: 50px;">상태</td>
									<td style="width: 80px;">적립금</td>
									<td style="width: 100px;">명령</td>
								</tr>
							</thead>
							<tbody id="tbody">
								<c:forEach items="${memberList}" var="memberEntity">
									<c:if test="${memberEntity.status eq 'Y'}">
										<tr>
											<td style="width: 30px;"><input type="checkbox" class="member-is-checked" name="list[]" value="${memberEntity.memberNo}" data-target="${memberEntity.memberNo}" /></td>
											<td style="width: 110px;">${memberEntity.id}</td>
											<td style="width: 110px;">${memberEntity.lastName}${memberEntity.firstName}</td>
											<td style="width: 110px;">${memberEntity.phone}</td>
											<td>${memberEntity.addressMain}${memberEntity.addressSub}</td>
											<td style="width: 100px;">${memberEntity.pointAmount}</td>
											<td style="width: 120px;"><fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${memberEntity.regDate}" /></td>
											<td><span class="label label-success" style="font-size:12px;">보임</span></td>
											<td>
												<button type="button" id="btn_${memberEntity.memberNo}" value="${memberEntity.memberNo}" class="btn btn-primary btn-xs">내역보기</button>
											</td>
											<td>
												<button type="button" value="${memberEntity.memberNo}" class="btn btn-primary btn-xs detailBtn">상세보기</button>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</form:form>
					<br>
					<button type="button" id="memberListDeleteBtn" class="btn btn-danger">
						<i class="fa fa-minus-square"></i> 선택삭제
					</button>
					<button type="button" onclick="onclickInsert();" class="btn btn-primary">
						<i class="fa fa-plus-square"></i> 등록
					</button>
					<button type="button" onclick="onclickPoint();" class="btn btn-warning" style="margin-left: 20px;">
						<i class="fa fa-won"></i> 적립금 지급
					</button>
					<button type="button" onclick="onclickCoupon();" class="btn btn-warning">
						<i class="fa fa-credit-card"></i> 쿠폰 지급
					</button>
					<button type="button" onclick="downloadExcel();" class="btn btn-warning">
						<i class="fa" aria-hidden="true"></i> Excel 다운로드
					</button>
					<form name="form_download" method="post" action="${pageContext.request.contextPath }/excel/download.do?${_csrf.parameterName}=${_csrf.token}">
						<input type="hidden" name="mode" value="downloadExcel"> <input type="hidden" name="search_data"> <input type="hidden" name="download_type" value="memberList">
					</form>
					<div id="pagebarContainer" style="text-align: right;">
						${pagebar}
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
		</div>
		<!-- /.col-xs-12 -->
	</div>
	<!-- /.row --> 
	</section>

   <!-- 회원 등록 폼 -->
   <div class="modal fade" id="modalRegister" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
      <div class="modal-dialog" style="width: 620px;">
         <div class="modal-content">
            <input type="hidden" id="addressNo" name="addressNo" value="" />
            <input type="hidden" id="memberNo" name="memberNo" value="" />
            <form name="memberInsertModalFrm" id="memberInsertModalFrm" method="POST" action="${pageContext.request.contextPath}/admin/member/memberInsertModalFrm.do">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <h4 class="modal-title" id="myModalLabel">회원 등록</h4>
               </div>
               <div class="modal-body">
                  <h4>
                     <p class="text-light-blue">
                        <i class="fa fa-fw fa-info-circle"></i> 회원정보
                     </p>
                  </h4>
                  <table class="table table-bordered">
                     <tr>
                        <td class="menu">아이디</td>
                        <td align="left"><input type="text" id="id" name="id" value="" class="form-control input-sm" style="width: 30%; float: left;" />  &nbsp;
                           <button type="button" id="btnCheckId" name="btnCheckId" class="btn btn-sm btn-default" onclick="onclickCheckId()">아이디 중복확인</button> 4~12자로 입력하세요.</td>
                     </tr>
                     <tr>
                        <td class="menu">비밀번호</td>
                        <td align="left"><input type="password" id="password" name="password" class="form-control input-sm" style="width: 30%; float: left;" /> 대소문자와 숫자 포함 8~15자로 입력하세요</td>
                     </tr>
                     <tr>
                        <td class="menu">비밀번호 확인</td>
                        <td align="left"><input type="password" id="passwordCheck" name="passwordCheck" class="form-control input-sm" style="width: 30%;" /></td>
                     </tr>
                     <tr>
                        <td class="menu">이름</td>
                        <td align="left"><input type="text" name="firstName" id="firstName" class="form-control input-sm" style="width: 30%; float: left;" placeholder="이름" /> <input type="text" name="lastName" id="lastName" class="form-control input-sm" style="width: 30%;" placeholder="성" /></td>
                     </tr>
                     <tr>
                        <td class="menu">휴대폰</td>
                        <td align="left"><select name="mobile1" id="mobile1" class="form-control input-sm" style="width: 15%; float: left;">
                              <option value="010">010</option>
                              <option value="011">011</option>
                              <option value="016">016</option>
                              <option value="017">017</option>
                              <option value="018">018</option>
                              <option value="019">019</option>
                        </select> <span style="float: left;">-</span> <input type="text" name="mobile2" id="mobile2" class="form-control input-sm" style="width: 15%; float: left;" maxlength="4" /> <span style="float: left;">-</span> <input type="text" name="mobile3" id="mobile3" class="form-control input-sm" style="width: 15%; float: left;" maxlength="4" /></td>
                     </tr>
                     <tr>
                        <td class="menu">이메일</td>
                        <td align="left"><input type="text" name="email" id="email" class="form-control input-sm" style="width: 60%;" /></td>
                     </tr>
                     <tr>
                        <td class="menu">주소</td>
                        <td align="left">
                           <input type="text" id="address_zipcode" name="addressZipcode" readonly class="form-control input-sm" style="width: 15%; background-color: #dddddd; float: left;" /> 
                           &nbsp;
                           <button type="button" onclick="callAddress()" class="btn btn-sm btn-default">주소입력</button> 
                           <br> 
                           <input type="text" id="address_main" name="addressMain" readonly class="form-control input-sm" style="margin: 5px 0; width: 100%; background-color: #dddddd;" /> 
                           <input type="text" id="address_sub" name="addressSub" placeholder="상세주소" class="form-control input-sm" style="width: 100%;" />
                        </td>
                     </tr>
                     <tr>
                        <td class="menu">메모</td>
                        <td align="left"><textarea name="memberMemoContent" id="memberMemoContent" rows="4" class="form-control input-sm" style="width: 100%;"></textarea></td>
                     </tr>
                     <tr>
                        <td class="menu">현재 포인트</td>
                        <td align="left"><span id="current_point"> </span></td>
                     </tr>
                     <tr id="display_level">
                        <td class="menu">등급 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                        <td>
                           <select name="authority" id="memberGradeChk" class="form-control input-sm" style="width: 120px;">
                              <c:forEach items="${memberGradeList}" var="memberGrade">
                                 <option value="${memberGrade.authority}">${memberGrade.memberGradeName}</option>
                              </c:forEach>
                           </select>
                        </td>
                     </tr>
                     <tr id="display_status">
                        <td class="menu">상태 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                        <td>
                           <select name="status" id="status" class="form-control input-sm" style="width: 120px;">
                              <option value="Y">정상</option>
                              <option value="N">대기</option>
                           </select>
                        </td>
                     </tr>
                     <tr id="display_last_login_date">
                        <td class="menu">최근 접속일</td>
                        <td align="left"><span id="last_login_date"></span></td>
                     </tr>
                     <tr id="display_update_date">
                        <td class="menu">수정일자</td>
                        <td align="left"><span id="update_date"></span></td>
                     </tr>
                     <tr id="display_reg_date">
                        <td class="menu">등록일자</td>
                        <td align="left"><span id="reg_date"></span></td>
                     </tr>
                  </table>
                 </div>
               <div class="modal-footer">
                  <button type="button" id="btnRegister" onclick="register()" class="btn btn-primary">저장</button>
                  <button type="button" id="btnUpdate" onclick="update()" class="btn btn-primary">저장</button>
               </div>                  
            </form>
         </div>
      </div>
   </div>
	
	<!-- // 적립금 지급 폼 -->
	<div class="modal fade" id="modalPoint" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog" style="width: 500px;">
			<div class="modal-content">
<<<<<<< HEAD
				<form name="formPoint" method="post" onsubmit="return false;">
					<input type="hidden" name="mode" value="point"> 
					<input type="hidden" name="member_code">
=======
				<input type="hidden" id="addressNo" name="addressNo" value="" />
				<input type="hidden" id="memberNo" name="memberNo" value="" />
				<form name="memberInsertModalFrm" id="memberInsertModalFrm" method="POST" action="${pageContext.request.contextPath}/admin/member/memberInsertModalFrm.do">
>>>>>>> branch 'master' of https://github.com/dawnduck07/mir9.git
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabelPortfolio">적립금 지급</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered">
							<tr>
								<td class="menu">대상 회원</td>
								<td align="left"><span id="sendCount"></span> 명</td>
							</tr>
							<tr>
								<td class="menu">지급 형태</td>
								<td align="left">
									<select name="plus_minus_type" class="form-control input-sm" style="width: 120px;">
										<option value="+">지급</option>
										<option value="-">차감</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="menu">적립금</td>
								<td align="left"><input type="text" name="point" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="width: 120px;" /></td>
							</tr>
							<tr>
								<td class="menu">메모</td>
								<td align="left"><input type="text" name="content" class="form-control input-sm" /></td>
							</tr>
							<tr>
								<td class="menu">알림 설정</td>
								<td align="left">
									<input type="checkbox" name="pointSms" value="y" /> SMS 알림 (설정된 SMS 발송)<br> 
									<input type="checkbox" name="pointEmail" value="y" /> 메일 알림 (설정된 메일 발송)<br>
								</td>
							</tr>
						</table>
<<<<<<< HEAD
					</div>
=======
					  </div>
					<div class="modal-footer">
						<button type="button" id="btnRegister" onclick="register()" class="btn btn-primary">저장</button>
						<button type="button" id="btnUpdate" onclick="update()" class="btn btn-primary">저장</button>
					</div>						
				</form>
			</div>
		</div>
	</div>


<!-- // 적립금 지급 폼 -->
<div class="modal fade" id="modalPoint" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	<div class="modal-dialog" style="width: 500px;">
		<div class="modal-content">
			<form name="formPoint" method="post" onsubmit="return false;">
				<input type="hidden" name="mode" value="point"> 
				<input type="hidden" name="member_code">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabelPortfolio">적립금 지급</h4>
				</div>
				<div class="modal-body">
					<table class="table table-bordered">
						<tr>
							<td class="menu">대상 회원</td>
							<td align="left"><span id="sendCount"></span> 명</td>
						</tr>
						<tr>
							<td class="menu">지급 형태</td>
							<td align="left">
								<select name="plus_minus_type" class="form-control input-sm" style="width: 120px;">
									<option value="+">지급</option>
									<option value="-">차감</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="menu">적립금</td>
							<td align="left"><input type="text" name="point" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="width: 120px;" /></td>
						</tr>
						<tr>
							<td class="menu">메모</td>
							<td align="left"><input type="text" name="content" class="form-control input-sm" /></td>
						</tr>
						<tr>
							<td class="menu">알림 설정</td>
							<td align="left">
								<input type="checkbox" name="pointSms" value="y" /> SMS 알림 (설정된 SMS 발송)<br> 
								<input type="checkbox" name="pointEmail" value="y" /> 메일 알림 (설정된 메일 발송)<br>
							</td>
						</tr>
					</table>
				</div>
>>>>>>> branch 'master' of https://github.com/dawnduck07/mir9.git
					<div class="modal-footer">
						<button type="button" onclick="registerPoint();" class="btn btn-primary">지급하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- // 쿠폰 지급 폼 -->
	<div class="modal fade" id="modalCoupon" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog" style="width: 500px;">
			<div class="modal-content">
				<form name="formCoupon" method="post" onsubmit="return false;" >
					<input type="hidden" name="mode" value="coupon"> 
					<input type="hidden" name="member_code">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabelPortfolio">쿠폰 지급</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered">
							<tr>
								<td class="menu">대상 회원</td>
								<td align="left"><span id="sendCountCoupon"></span> 명</td>
							</tr>
							<tr>
								<td class="menu">쿠폰 선택</td>
								<td align="left">
									<select name="coupon_code" class="form-control input-sm">
										<option value="">선택</option>
										<c:forEach var="coupon" items="${couponList }">
											<option value="${coupon.couponNo }">${coupon.couponName }</option>
										</c:forEach>
									</select> ※ 쿠폰은 회원당 한번씩만 발급 할수 있습니다.
								</td>
							</tr>
							<tr>
								<td class="menu">알림 설정</td>
								<td align="left">
									<input type="checkbox" name="couponSms" value="y" /> SMS 알림 (설정된 SMS 발송)<br> 
									<input type="checkbox" name="couponEmail" value="y" /> 메일 알림 (설정된 메일 발송)<br>
								</td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" onclick="registerCoupon();" class="btn btn-primary">지급하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>	
</div>
<<<<<<< HEAD
=======
</div>
>>>>>>> branch 'master' of https://github.com/dawnduck07/mir9.git
<!-- /.content-wrapper -->



<!-- 다음 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
//Excel 다운로드
function downloadExcel() {  
    form_download.target = 'iframe_process';
    form_download.search_data.value = $('#form_search').serialize();
    form_download.submit();
}

// 내역보기
$("button[id^='btn_']").on('click', function(e){
	var memberNo = $(e.target).val();
	location.href = `${pageContext.request.contextPath}/admin/member/memberPointList/\${memberNo}`; // \$ : "EL이 아니라 JavaScript $다."를 표시
});

// 상세보기 모달
$(document).on("click", ".detailBtn", function(e){
	var memberNo = $(e.target).val();
	
	$("[name=id]").prop("readonly", true);
	$("#btnCheckId").hide();
	$("#display_status").show();
	$("#display_last_login_date").show();
	$("#display_update_date").show();
	$("#display_reg_date").show();
	$("#btnUpdate").show();
	$("#btnRegister").hide();	
	
	const data = {
			memberNo : memberNo
	};
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/member/memberDetail.do/\${memberNo}`,
		data : data,
		contentType : "application/json; charset=utf-8",
		method : "GET",
		success : function(res) {
			var member = res.member;
			var mobile2 = res.mobile2;
			var mobile3 = res.mobile3;
			var address = res.address;
			var memberMemo = res.memberMemo;
			var authorities = res.authorities;
			var regDate = res.regDate;
			var loginDate = res.loginDate;
			var updateDate = res.updateDate;
			var totalPoint = res.totalPoint + res.pointName;
			
			$("[name=memberNo]").val(member.memberNo);
			$("[name=id]").val(member.id);
			$("[name=lastName]").val(member.lastName);
			$("[name=firstName]").val(member.firstName);
			$("[name=mobile2]").val(mobile2);
			$("[name=mobile3]").val(mobile3);
			$("[name=email]").val(member.email);
			$("[name=addressNo]").val(address.addressNo);
			$("[name=addressZipcode]").val(address.addressZipcode);
			$("[name=addressMain]").val(address.addressMain);
			$("[name=addressSub]").val(address.addressSub);
			$("[name=memberMemoContent]").val(memberMemo.memberMemoContent);
			$("[name=status]").val(member.status);
			$("[name=authority]").val(authorities.authority);
			$("#reg_date").text(regDate);
			$("#last_login_date").text(loginDate);
			$("#update_date").text(updateDate);
			$("#modalRegister").modal();
			$("#current_point").text(totalPoint);
		},
		error : console.log
	});
});

// 상세보기 저장
function update(){
	var id = $("#id").val();
	var password = $("#password").val();
	var passwordCheck = $("#passwordCheck").val();
	var firstName = $("#firstName").val();
	var lastName = $("#lastName").val();
	var memberMemoContent = $("#memberMemoContent").val();
	var authority = $("#memberGradeChk option:selected").val();
	var addressNo = $("#addressNo").val();
	var addressMain = $("#address_main").val();
	var addressSub = $("#address_sub").val();
	var addressZipcode = $("#address_zipcode").val();
	var memberNo = $("#memberNo").val();
	var status = $("#status").val();

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	if(password != ''){
		// 비밀번호 유효성 검사
		if(!/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,15}$/.test(password)){
			alert("비밀번호는 8 ~ 15 글자 이내로 공백 없이 영문자, 숫자, 특수문자를 혼합하여 입력해주세요.");
			$("#password").focus();
			return false;
		}
		// 비밀번호 확인 공란 확인
		if(passwordCheck == ''){
			alert("비밀번호가 확인이 입력되지 않았습니다.");
			$("#passwordCheck").focus();
			return false;	
		}
	}
	
	// 비밀번호 일치 확인
	if(password != passwordCheck){
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		$("#passwordCheck").focus();
		return false;
	}
	
	// 이름 공란 확인
	if(firstName == ''){
		alert("이름이 입력되지 않았습니다.");
		$("#firstName").focus();
		return false;
	}
	// 성 공란 확인
	if(lastName == ''){
		alert("성이 입력되지 않았습니다.");
		$("#lastName").focus();
		return false;
	}
	
	// 휴대폰 번호 유효성 검사
	var mobile1 = $("#mobile1").val();
	var mobile2 = $("#mobile2").val();
	var mobile3 = $("#mobile3").val();
	
	if(mobile2 == '' || mobile3 == ''){
		alert("휴대폰 번호가 입력되지 않았습니다.");
		$("#mobile1").focus();
		return false;
	}
	if(!/^([0-9]{3,4})$/.test(mobile2) || !/^([0-9]{4})$/.test(mobile3)){
		alert("휴대폰 번호를 정확하게 입력해주세요.");
		$("#mobile1").focus();
		return false;
	}

	// 이메일 유효성 검사
	var email = $("#email").val();
	var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	
	if(!regEmail.test(email)){
		alert("이메일을 정확하게 입력해주세요.");
		$("#email").focus();
		return false;
	}
	
	const result = {
			memberNo : memberNo,
			id : id,
			password : password,
			firstName : firstName,
			lastName : lastName,
			mobile1 : mobile1,
			mobile2 : mobile2,
			mobile3 : mobile3,
			email : email,
			addressNo : addressNo,
			addressZipcode : addressZipcode,
			addressMain : addressMain,
			addressSub : addressSub,
			memberMemoContent : memberMemoContent,
			status : status,
			authority : authority
	};
	
	const data = JSON.stringify(result);
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/member/memberUpdate.do`,
		method : "POST",
		data : data,
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		success(data){
			alert("해당 회원이 수정 되었습니다.");
			location.reload();
		}, 
		error : console.log
	});
	
		$(window).unbind("beforeunload");
}


// 등록 모달창
function onclickInsert(){
	$("#modalRegister").modal();
	$('[name=id]').prop('readonly', false);
	$("#btnCheckId").show();
	$("#display_status").hide();
	$("#display_last_login_date").hide();
	$("#display_update_date").hide();
	$("#display_reg_date").hide();
	$("#btnRegister").show();
	$("#btnUpdate").hide();
	memberInsertModalFrm.reset();
};

// 아이디 중복 확인
function onclickCheckId(){
	var id = $("#id").val();
	
	// id 값을 입력하지 않았을 때
	if(id == ""){
		alert("id를 정확히 입력해주세요");
		// 해당 위치로 입력 커서 이동
		$("#id").focus();
		return false;
	}
	
	// 아이디 개수 유효성 검사
	if(!/^[a-zA-Z0-9]{4,12}$/.test(id)){
		alert("id를 정확히 입력해주세요");
		$("#id").focus();
		return false;
	}
	
	const data = {
			id : id
	};
	const jsonData = JSON.stringify(data);
	
	// 비동기 중복 검사
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/member/checkIdDuplicate.do`,
		data : data,
		contentType : "application/json ; charset=utf-8",
		method : "GET",
		success(data) {
			const {available} = data;
			if(available){
				alert("사용 가능한 아이디 입니다.");
				$("#password").focus();
			}
			else{
				alert("[" + id + "]은 이미 사용중인 아이디 입니다. \n\n 다른 아이디를 사용하시기 바랍니다.");
				$("#id").focus();
			}
		},
		error : console.log
	});
	
};


// 저장
function register(){
	var id = $("#id").val();
	var password = $("#password").val();
	console.log("password = " + password);
	var passwordCheck = $("#passwordCheck").val();
	var firstName = $("#firstName").val();
	var lastName = $("#lastName").val();
	var authority = $("#memberGradeChk option:selected").val();
	
	// 아이디 공란 확인
	if(id == ''){
		alert("아이디가 입력되지 않았습니다.");
		$("#id").focus();
		return false;
	}
	
	// 비밀번호 공란 확인
	if(password == ''){
		alert("비밀번호가 입력되지 않았습니다.");
		$("#password").focus();
		return false;
	}
	
	// 비밀번호 유효성 검사
	if(!/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,15}$/.test(password)){
		alert("비밀번호는 8 ~ 15 글자 이내로 공백 없이 영문자, 숫자, 특수문자를 혼합하여 입력해주세요.");
		$("#password").focus();
		return false;
	}
	
	// 비밀번호 확인 공란 확인
	if(passwordCheck == ''){
		alert("비밀번호가 확인이 입력되지 않았습니다.");
		$("#passwordCheck").focus();
		return false;
	}
	
	// 비밀번호 일치 확인
	if(password != passwordCheck){
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		$("#passwordCheck").focus();
		return false;
	}
	
	// 이름 공란 확인
	if(firstName == ''){
		alert("이름이 입력되지 않았습니다.");
		$("#firstName").focus();
		return false;
	}

	// 성 공란 확인
	if(lastName == ''){
		alert("성이 입력되지 않았습니다.");
		$("#lastName").focus();
		return false;
	}
	
	// 휴대폰 번호 유효성 검사
	var mobile2 = $("#mobile2").val();
	var mobile3 = $("#mobile3").val();
	
	if(mobile2 == '' || mobile3 == ''){
		alert("휴대폰 번호가 입력되지 않았습니다.");
		$("#mobile1").focus();
		return false;
	}
	if(!/^([0-9]{3,4})$/.test(mobile2) || !/^([0-9]{4})$/.test(mobile3)){
		alert("휴대폰 번호를 정확하게 입력해주세요.");
		$("#mobile1").focus();
		return false;
	}

	// 이메일 유효성 검사
	var email = $("#email").val();
	var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	
	if(!regEmail.test(email)){
		alert("이메일을 정확하게 입력해주세요.");
		$("#email").focus();
		return false;
	}
	
	$(window).unbind("beforeunload");
	$(document.memberInsertModalFrm).submit();
}


// 주소 입력
function callAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
            
            } 

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('address_zipcode').value = data.zonecode;
            document.getElementById("address_main").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("address_sub").focus();
        }
    }).open();
}


// 타입별 검색
$("#keyword").keydown(function(keyNum){
	if(keyNum.keyCode == 13){
		pagingMember();
	}
});

function pagingMember(cPage){
	var keyword = $('input[name=keyword]').val(); // 검색어
	var type = $('select[name=type]').val(); // 검색 타입
	var cPage;
	
	const search = {
			"type" : type,
			"keyword" : keyword,
			"cPage" : cPage
	};
	
	$.ajax({
		type : "GET",
		url : `${pageContext.request.contextPath}/admin/member/typeSearch.do`,
		data : search,
		contentType: "application/json; charset=utf-8",
		success(data){			
			$("#tbody").html('');
			$("#tbody").html(data["searchMemberListStr"]);
			$("#countContainer").html('');
			$("#countContainer").html(`<label style="margin-top: 5px;">총 \${data["searchListCount"]} 건</label>`);
			$("#pagebarContainer").html('');
			$("#pagebarContainer").html(data["pagebar"]);
		},
		error : console.log	
	});
	
};


// 체크박스 전체 선택
$(".checkbox-group").on("click", "#checkAll", ((e)=>{
	let checked = $(e.target).is(":checked");
	
	if(checked){
		$(e.target).parents(".checkbox-group").find("input:checkbox").prop("checked", true);
	} else {
		$(e.target).parents(".checkbox-group").find("input:checkbox").prop("checked", false);
	}
}));


// 체크박스 개별 선택
$(document).on("click", ".member-is-checked", function(){
	let isChecked = true;
	
	$(".member-is-checked").each((i, item)=>{
		isChecked = isChecked && $(item).is(":checked");
	});
	
	$("#checkAll").prop("checked", isChecked);	
});


// 선택삭제
$(document).on("click", "#memberListDeleteBtn", function(){
	let isChecked = false;
	
	$(".member-is-checked").each((i, item)=>{
		isChecked = isChecked || $(item).is(":checked");
		// target = memberNo
		let target = $(item).data("target");
		
		if($(item).is(":checked")){
			$(item).after(`<input type="hidden" name="memberNo" value="\${target}"/>`);
		}
	});
	
	if(!isChecked){
		alert("선택된 목록이 없습니다.");
		return;
	}
	
	if(confirm("선택된 회원을 삭제하시겠습니까?"))
		$(document.memberDeleteFrm).submit();
});


//쿠폰 모달
function onclickCoupon() {
	
	var check = [];
	
	$("input[name='list[]']").each(function(){
		if($(this).prop("checked")) { // 체크된 memberNo
			check.push($(this).val()); 
		}
	});
	
	if(check.length > 0) {
		for(var i = 0; i < check.length; i++) {
			$("input[name='member_code']").val(check);
            $("#sendCountCoupon").text(check.length);
		}	
	}
	else {
		alert('항목이 없습니다.');
        return false;
	}
	
    $("#modalCoupon").modal({backdrop:"static", show:true});
	
}

// 쿠폰 지급
function registerCoupon() {
    if(formCoupon.coupon_code.value == '') { 
    	alert('쿠폰이 선택되지 않았습니다.'); 
    	formCoupon.coupon_code.focus(); 
    	return false;
    }
    
    // 발송 체크 여부
    var smsCheck = "";
    var emailCheck = "";
    
    if($("input[name='couponSms']").prop("checked")) {
    	smsCheck = "y";
    }
    else {
    	smsCheck = "n";
    }
    
    if($("input[name='couponEmail']").prop("checked")) {
    	emailCheck = "y";
    }
    else {
    	emailCheck = "n";
    }
    
    // data = 회원 번호 + 쿠폰 + 체크 
    var data = {
    	mode : "coupon",
    	memberCode : $("input[name='member_code']").val(),
    	couponCode : $("select[name='coupon_code']").val(),
    	smsCheck : smsCheck,
    	emailCheck : emailCheck
    };
    
    var jsonStr = JSON.stringify(data);
    
    $.ajax({
    	url: "${pageContext.request.contextPath}/admin/comm/sendCouponMsg",
    	method: "POST",
		contentType : "application/json; charset=utf-8",
		headers: {
			"${_csrf.headerName}" : "${_csrf.token}"
		},
		data: jsonStr,
    	success: function(result) {
    		if(result > 0) {
    			alert("쿠폰이 정상 지급되었습니다.");
    			location.reload();
    		}
    	},
    	error: function(textStatus, errorThrown) {
    		alert("쿠폰을 지급할 수 없습니다. 관리자에게 문의해주세요.");
    	}
    });
}

// 적립금 모달
function onclickPoint() {
	
	var check = [];
	
	$("input[name='list[]']").each(function(){
		if($(this).prop("checked")) { // 체크된 memberNo
			check.push($(this).val()); 
		}
	});
	
	if(check.length > 0) {
		for(var i = 0; i < check.length; i++) {
			$("input[name='member_code']").val(check);
            $("#sendCount").text(check.length);
		}	
	}
	else {
		alert('항목이 없습니다.');
        return false;
	}
	
    $('#modalPoint').modal({backdrop:'static', show:true});
}

// 적립금 지급
function registerPoint() {
    if(formPoint.point.value == '') { 
    	alert('적립금이 입력되지 않았습니다.'); 
    	formPoint.point.focus(); 
    	return false;
    }
    if(formPoint.content.value == '') { 
    	alert('메모가 입력되지 않았습니다.'); 
    	formPoint.content.focus(); 
    	return false;
    }
   
    // 발송 체크 여부
    var smsCheck = "";
    var emailCheck = "";
    
    if($("input[name='pointSms']").prop("checked")) {
    	smsCheck = "y";
    }
    else {
    	smsCheck = "n";
    }
    
    if($("input[name='pointEmail']").prop("checked")) {
    	emailCheck = "y";
    }
    else {
    	emailCheck = "n";
    }

    // data = 회원 번호 + 지급 형태 + 적립금 + 메모 + 체크 
    var data = {
    	mode : "point",
    	memberCode : $("input[name='member_code']").val(),
    	type : $("select[name='plus_minus_type']").val(),
    	point : $("input[name='point']").val(),
    	content : $("input[name='content']").val(),
    	smsCheck : smsCheck,
    	emailCheck : emailCheck
    };
    
    var jsonStr = JSON.stringify(data);
    
    $.ajax({
    	url: "${pageContext.request.contextPath}/admin/comm/sendPointMsg",
    	method: "POST",
		contentType : "application/json; charset=utf-8",
		headers: {
			"${_csrf.headerName}" : "${_csrf.token}"
		},
		data: jsonStr,
    	success: function(result) {
    		if(result > 0) {
    			alert("적립금이 정상 지급/차감되었습니다.");
    			location.reload();
    		}
    	},
    	error: function(textStatus, errorThrown) {
    		alert("적립금을 지급할 수 없습니다. 관리자에게 문의해주세요.");
    	}
    });

}
</script>
<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>