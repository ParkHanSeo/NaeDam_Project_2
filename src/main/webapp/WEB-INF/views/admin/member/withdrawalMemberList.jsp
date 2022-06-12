<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="탈퇴회원 관리" name="title" />
</jsp:include>

<style>
.ui-menu {
	z-index: 9999;
	width: 400px;
}
</style>

<script>
<!-- redirect Msg 처리 -->
<c:if test="${not empty msg}">
		alert("${msg}");
		location.reload();
</c:if>
</script>

<div class="content-wrapper">
	<section class="content-header">
		<h1>
			탈퇴 회원 관리 
			<small>member list</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>회원 관리</li>
			<li class="active">탈퇴 회원 리스트</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<label id="countContainer" style="margin-top: 5px;">총 ${totalwithdrawalCount} 건</label>
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
						<form:form id="withdrawalDeleteFrm" name="withdrawalDeleteFrm" action="${pageContext.request.contextPath}/admin/member/memberProcess" method="POST">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" name="mode" value="withdrawalDelete"/>
							<table class="table table-bordered table-hover checkbox-group">
								<thead>
									<tr>
										<td style="width: 30px;">
											<input type="checkbox" name="select_all" id="checkAll" /> 
										</td>
										<td style="width: 110px;">아이디</td>
										<td style="width: 110px;">이름</td>
										<td style="width: 110px;">휴대폰</td>
										<td>주소</td>
										<td style="width: 120px;">가입일</td>
										<td style="width: 50px;">상태</td>
										<td style="width: 60px;">명령</td>
									</tr>
								</thead>
								<tbody id="tbody">
									<c:forEach items="${withdrawalMemberList}" var="withdrawal">
										<c:if test="${withdrawal.status eq 'N'}">
											<tr>
												<td style="width: 30px;"><input type="checkbox" class="member-is-checked" name="" value="${withdrawal.memberNo}" data-target="${withdrawal.memberNo}" /></td>
												<td style="width: 110px;">${withdrawal.id}</td>
												<td style="width: 110px;">${withdrawal.lastName}${withdrawal.firstName}</td>
												<td style="width: 110px;">${withdrawal.phone}</td>
												<td>${withdrawal.addressMain}${withdrawal.addressSub}</td>
												<td style="width: 120px;">
													<fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${withdrawal.regDate}" />	
												</td>
												<td style="width: 50px;">
													<span class="label label-default" style="font-size:12px;">탈퇴</span>
												</td>
												<td style="width: 60px;">
													<button type="button" value="${withdrawal.memberNo}" class="btn btn-primary btn-xs detailWithdrawalBtn">상세보기</button>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</form:form>
						<br>
						<button type="button" id="withdrawalDeleteBtn" class="btn btn-danger">
							<i class="fa fa-minus-square"></i> 선택삭제
						</button>
						<div id="pagebarContainer" style="text-align: right;">
							${pagebar}
						</div>
					</div><!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col-xs-12 -->
		</div><!-- /.row --> 
	</section><!-- /.content -->

	<!-- 회원 상세보기 -->
	<div class="modal fade" id="modalRegister" z-index:10; role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog" style="width: 620px;">
			<div class="modal-content">
				<input type="hidden" id="addressNo" name="addressNo" value="" />
				<input type="hidden" id="memberNo" name="memberNo" value="" />
				<input type="hidden" name="member_code">
				<form name="memberInsertModalFrm" id="memberInsertModalFrm" method="POST" action="${pageContext.request.contextPath}/admin/member/memberProcess?${_csrf.parameterName}=${_csrf.token}">
					<input type="hidden" name="mode" value="withdrawalUpdate"/>
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">회원 등록</h4>
					</div>
					<div class="modal-body" name="modalBody">
						<h4>
							<p class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 회원정보
							</p>
						</h4>
						<table class="table table-bordered">
							<tr>
								<td class="menu">아이디</td>
								<td align="left">
									<input type="text" name="id" id="id" class="form-control input-sm" style="width: 30%; float: left;" />&nbsp;
									<button type="button" id="btn_check_id" class="btn btn-sm btn-default" onclick="onclickCheckId();">아이디 중복확인</button> 4~12자로 입력하세요.
								</td>
							</tr>
							<tr>
								<td class="menu">비밀번호</td>
								<td align="left"><input type="password" name="password" id="password" placeholder="" class="form-control input-sm" style="width: 30%; float: left;" /> 대소문자와 숫자 포함 8~15자로 입력하세요</td>
							</tr>
							<tr>
								<td class="menu">비밀번호 확인</td>
								<td align="left"><input type="password" name="passwordCheck" id="passwordCheck" placeholder="" class="form-control input-sm" style="width: 30%;" /></td>
							</tr>
							<tr>
								<td class="menu">이름</td>
								<td align="left"><input type="text" name="firstName" id="firstName" class="form-control input-sm" style="width: 30%; float: left;" placeholder="이름" /> <input type="text" name="lastName" id="lastName" class="form-control input-sm" style="width: 30%;" placeholder="성" /></td>
							</tr>
							<tr>
								<td class="menu">휴대폰</td>
								<td align="left">
									<select name="mobile1" id="mobile1" class="form-control input-sm" style="width: 15%; float: left;">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
									</select> 
									<span style="float: left;">-</span> 
									<input type="text" name="mobile2" id="mobile2" class="form-control input-sm" style="width: 15%; float: left;" maxlength="4" /> 
									<span style="float: left;">-</span> 
									<input type="text" name="mobile3" id="mobile3" class="form-control input-sm" style="width: 15%; float: left;"maxlength="4" />
								</td>
							</tr>
							<tr>
								<td class="menu">이메일</td>
								<td align="left">
									<input type="text" name="email" id="email" class="form-control input-sm" style="width: 60%;" />
								</td>
							</tr>
							<tr>
								<td class="menu">주소</td>
								<td align="left">
									<input type="text" name="addressZipcode" id="address_zipcode" readonly class="form-control input-sm" style="width: 15%; background-color: #dddddd; float: left;" />&nbsp;
									<button type="button" onclick="callAddress();" class="btn btn-sm btn-default">주소입력</button><br> 
									<input type="text" name="addressMain" id="address_main" readonly class="form-control input-sm" style="margin: 5px 0; width: 100%; background-color: #dddddd;" />
									<input type="text" name="addressSub" id="address_sub" placeholder="상세주소" class="form-control input-sm" style="width: 100%;" />
								</td>
							</tr>
							<tr>
								<td class="menu">메모</td>
								<td align="left">
									<textarea name="memberMemoContent" id="memberMemoContent" rows="4" class="form-control input-sm" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr>
								<td class="menu">탈퇴사유</td>
								<td align="left">
									<textarea name="reason" id="reason" rows="4" class="form-control input-sm" style="width: 100%;"></textarea>
								</td>
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
								<td class="menu">상태 
									<span class="text-light-blue">
										<i class="fa fa-check"></i>
									</span>
								</td>
								<td>
									<select name="status" id="status" class="form-control input-sm" style="width: 120px;">
										<option value="N">대기</option>
										<option value="Y">정상</option>
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
							<tr id="display_reg_date">
								<td class="menu">탈퇴일</td>
								<td align="left"><span id="withdraw_date"></span></td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" onclick="update()" class="btn btn-primary">저장</button>
					</div>
				</form>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal fade -->
</div><!-- /.content-wrapper -->
<!-- 다음 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	//타입별 검색
	$("#keyword").keydown(function(keyNum){
		if(keyNum.keyCode == 13){
			pagingWithdrawal();
		}
	});
	
	function pagingWithdrawal(cPage){
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
			url : `${pageContext.request.contextPath}/admin/member/withdrawalTypeSearch.do`,
			data : search,
			contentType: "application/json; charset=utf-8",
			success(data){
				
				$("#tbody").html('');
				$("#tbody").html(data["searchWithdrawalListStr"]);
				$("#countContainer").html('');
				$("#countContainer").html(`<label style="margin-top: 5px;">총 \${data["searchListCount"]} 건</label>`);
				$("#pagebarContainer").html('');
				$("#pagebarContainer").html(data["pagebar"]);
			},
			error : console.log
		});
	}
	
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
	
	// 선택 삭제
	$(document).on("click", "#withdrawalDeleteBtn", function(){
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
			$(document.withdrawalDeleteFrm).submit();
	});
	
	// 상세보기 모달
	$(document).on("click", ".detailWithdrawalBtn", function(e){
		var memberNo = $(e.target).val();
		
		$("[name=id]").prop("readonly", true);
		$("#modalRegister").modal();
		
		const data = {
				memberNo : memberNo
		};
		
		$.ajax({
			url : `${pageContext.request.contextPath}/admin/member/withdrawalMemberDetail.do/\${memberNo}`,
			data : data,
			contentType : "application/json; charset=utf8",
			method : "GET",
			success : function(res){
				console.log("ajaxData = " + JSON.stringify(res));
				var withdrawalMemberEntity = res.withdrawalMemberEntity;
				var authorities = res.authorities;
				var mobile1 = res.mobile1;
				var mobile2 = res.mobile2;
				var mobile3 = res.mobile3;
				var address = res.address;
				var memberMemo = res.memberMemo;
				var regDate = res.regDate;
				var loginDate = res.loginDate;
				var updateDate = res.updateDate;
				var withdrawalDate = res.withdrawalDate;
	 			var display = '<input type="hidden" id="memberNo" name="memberNo" value="'+withdrawalMemberEntity.memberNo+'" />'
							+ '<input type="hidden" id="addressNo" name="addressNo" value="'+address.addressNo+'" />'
							+ '<input type="hidden" id="memberMemoNo" name="memberMemoNo" value="'+memberMemo.memberMemoNo+'" />';
				$("div[name='modalBody']").append(display);	
				$("[name=memberNo]").val(withdrawalMemberEntity.memberNo);
				$("[name=id]").val(withdrawalMemberEntity.id);
				$("[name=lastName]").val(withdrawalMemberEntity.lastName);
				$("[name=firstName]").val(withdrawalMemberEntity.firstName);
				$("[name=mobile1]").val(mobile1);
				$("[name=mobile2]").val(mobile2);
				$("[name=mobile3]").val(mobile3);
				$("[name=email]").val(withdrawalMemberEntity.email);
				$("[name=addressNo]").val(address.addressNo);
				$("[name=addressZipcode]").val(withdrawalMemberEntity.addressZipcode);
				$("[name=addressMain]").val(withdrawalMemberEntity.addressMain);
				$("[name=addressSub]").val(withdrawalMemberEntity.addressSub);
				$("[name=memberMemoContent]").val(withdrawalMemberEntity.memberMemoContent);
				$("[name=reason]").val(withdrawalMemberEntity.reason);
				$("[name=authority]").val(authorities.authority);
				$("#last_login_date").text(loginDate);
				$("#update_date").text(updateDate);
				$("#withdraw_date").text(withdrawalDate);
				$("#reg_date").text(regDate);
			},
			error : console.log
		});
	});
	
	//주소 입력
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
	
	//상세보기 저장
	function update(){
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
	
	$("#modalRegister").on("hidden.bs.modal", function(){
		$("input[name='memberNo']").remove();
		$("input[name='addressNo']").remove();
		$("input[name='memberMemoNo']").remove();
	});
</script>
<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>