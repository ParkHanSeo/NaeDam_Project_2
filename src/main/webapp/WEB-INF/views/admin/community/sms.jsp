<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="SMS 설정" name="title"/>
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
	textarea {
	    width:180px;
	    height:100px;
	    resize:none;
	}
</style>
<div class="content-wrapper">
	<section class="content-header">
	    <h1>
	    SMS 설정
	    <small>sms setting</small>
	    </h1>
	
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li>커뮤니티 관리</li>
	        <li class="active">sms 설정</li>
	    </ol>
	</section>
	
	<section class="content">
		<div class="row">
		    <div class="col-xs-12">
		        <div class="box">
		            <div class="box-body">
		                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> SMS 발송 정보 설정 </p></h4>
					 	<table class="table table-bordered">
			                <tbody>
				                <tr>
				                    <td class="menu">SMS 이용 요금</td>
				                    <td align="left">
				                    	<input type="hidden" name="secName" value="<sec:authentication property='principal.username'/>">
				                    	<span name="charge" style="float:left;"></span>
				                    </td>
				                </tr>
							</tbody>
		                </table>
		                <br>
		                <div id="smsSetting"><!-- 발신번호 미등록시 숨김처리 -->
							<form name="form_register">
				                <input type="hidden" name="mode" value="sms">
								<h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> SMS 발송 문구 설정 </p></h4>
								<table class="table table-bordered table-hover">
									<thead>
					                    <tr>
					                        <td rowspan="3" class="menu" style="width:250px;">발송항목</td>
											<td colspan="6">발송대상 및 SMS 문구설정</td>
											<td rowspan="3" class="menu" style="width:350px;">치환문구 설명</td>
					                    </tr>
										<tr>
					                        <td colspan="3">회원</td>
											<td colspan="3">관리자</td>
					                    </tr>
					                    <tr>
					                        <td>문구</td>
											<td>자동발송</td>
											<td>기본문구</td>
					                        <td>문구</td>
											<td>자동발송</td>
											<td>기본문구</td>
					                    </tr>
					                </thead>
					                <tbody>
					      				<tr>
											<td class="content">회원가입</td>
						                    <td>
						                        <input type="hidden" class="join" name="code" value="join" /> 
						                        <textarea class="join" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="join" name="is_send" />
						                    </td>
						                    <td class="content">
						                   		<button type="button" onclick="getDefaultTemplate('join');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="join_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="join" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('join_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##user_name## : 회원명</li>			
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">아이디 찾기<br>[아이디 찾기시]</td>
						                    <td>
						                        <input type="hidden" class="findid" name="code" value="findid" />
						                        <textarea class="findid" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="findid" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('findid');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="findid_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="findid" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('findid_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##user_name## : 회원명</li>			
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">임시비밀번호 발급알림<br>[비밀번호 찾기시]</td>
						                    <td>
						                        <input type="hidden" class="findpw" name="code" value="findpw" />
						                        <textarea class="findpw" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="findpw" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('findpw');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="findpw_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="findpw" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('findpw_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##user_name## : 회원명</li>			
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">주문접수<br>[무통장/카드 결제시]</td>
						                    <td>
						                        <input type="hidden" class="order" name="code" value="order" />
						                        <textarea class="order" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="order" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('order');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="order_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="order" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('order_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##order_name## : 주문자명</li> <li>##order_number## : 주문번호</li>			
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">입금확인<br>[무통장 입금 완료시]</td>
						                    <td>
						                        <input type="hidden" class="pay_done" name="code" value="pay_done" />
						                        <textarea class="pay_done" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="pay_done" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('pay_done');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="pay_done_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="pay_done" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('pay_done_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##order_name## : 주문자명</li> <li>##order_number## : 주문번호</li>
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">상품 배송 준비중<br>[주문상태 배송준비중으로 변경시]</td>
						                    <td>
						                        <input type="hidden" class="delivery_ready" name="code" value="delivery_ready" />
						                        <textarea class="delivery_ready" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="delivery_ready" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('delivery_ready');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="delivery_ready_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="delivery_ready" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('delivery_ready_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##order_name## : 주문자명</li>
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">상품 배송중<br>[주문상태 배송중으로 변경시]</td>
						                    <td>
						                        <input type="hidden" class="delivery_ing" name="code" value="delivery_ing" />
						                        <textarea class="delivery_ing" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="delivery_ing" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('delivery_ing');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="delivery_ing_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="delivery_ing" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('delivery_ing_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##order_name## : 주문자명</li>			
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">상품 배송 완료<br>[주문상태 배송완료로 변경시]</td>
						                    <td>
						                        <input type="hidden" class="delivery_done" name="code" value="delivery_done" />
						                        <textarea class="delivery_done" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="delivery_done" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('delivery_done');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="delivery_done_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="delivery_done" name="is_send_admin"  /></td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('delivery_done_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##order_name## : 주문자명</li>
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">주문취소<br>[주문 취소시]</td>
						                    <td>
						                        <input type="hidden" class="order_cancel" name="code" value="order_cancel" />
						                        <textarea class="order_cancel" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="order_cancel" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('order_cancel');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="order_cancel_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="order_cancel" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('order_cancel_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##order_name## : 주문자명</li> <li>##order_number## : 주문번호</li>			
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">환불완료<br>[주문상태 환불완료로 변경시]</td>
						                    <td>
						                        <input type="hidden" class="refund" name="code" value="refund" />
						                        <textarea class="refund" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="refund" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('refund');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="refund_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="refund" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('refund_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##order_name## : 주문자명</li> <li>##order_number## : 주문번호</li>			
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">적립금 적립<br>[개별 적립금 적립시]</td>
						                    <td>
						                        <input type="hidden" class="point" name="code" value="point" />
						                        <textarea class="point" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="point" name="is_send">
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('point');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="point_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="point" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('point_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##user_name## : 회원명</li> <li>##point## : 포인트</li> <li>##point_type## : 포인트 구분</li>
												</ul>
											</td>      
										</tr>      
										<tr>
											<td class="content">쿠폰 지급<br>[개별 쿠폰 지급시]</td>
						                    <td>
						                        <input type="hidden" class="coupon" name="code" value="coupon" />
						                        <textarea class="coupon" name="content" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="coupon" name="is_send" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('coupon');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>
						                    <td>
						                    	<textarea class="coupon_admin" name="content_admin" ></textarea>
						                    </td>
						                    <td class="content">
						                    	<input type="checkbox" class="coupon" name="is_send_admin" />
						                    </td>
						                    <td class="content">
						                    	<button type="button" onclick="getDefaultTemplate('coupon_admin');" class="btn btn-primary btn-xs">가져오기</button>
						                    </td>		
						                    <td align="left">
												<ul>
													<li>##shop_name## : 사이트명</li> <li>##user_name## : 회원명</li> <li>##coupon_name## : 쿠폰명</li> 
												</ul>
											</td>      
										</tr>				
									</tbody>
				                </table>
				                <br>
							</form>	
			                <div style="text-align:center;"><button type="button" onclick="register()" class="btn btn-primary">확인</button></div>
		                </div><!-- /.smsSetting -->
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
	/*
		[NHN CLOUD API]
		# 사용자 가이드
		SMS : https://docs.toast.com/ko/Notification/SMS/ko/api-guide/
		EMAIL : https://docs.toast.com/ko/Notification/Email/ko/api-guide/
		
		# 이용 방법
		1. 회원가입 후 결제 정보를 등록합니다.
		2. 콘솔에서 조직과 프로젝트를 차례로 생성 후 서비스(SMS와 EMAIL)를 신청합니다. 
		4. 신청한 SMS와 EMAIL의 AppKey와 SecretKey 정보를 각각 저장합니다. 
		5. CommunityServiceImpl 상단에 위치한 Appkey와 SecretKey 값을 복사한 값으로 수정합니다. => 수정 필요
		6. SMS와 EMAIL의 템플릿을 등록합니다. 
			=> SMS의 경우 발신번호를 미리 등록해야합니다. 
			=> 치환문구는 ##key값## 으로 처리합니다.
			=> 기본 템플릿과 수정 템플릿으로 나눠서 작업을 했습니다. (기본 : join, join_admin / 수정 : join_mod, join_admin_mod)
				=> 현 방법은 추후에 문제가 발생할 것 같아 수정이 필요합니다.
				=> 추가로 'templateId + 발신번호(발신이메일)' 방식으로 이용자간 구분이 필요할 듯 합니다.
		7. 사용자 가이드를 참고하여 API를 요청하고 결과값을 받아옵니다.
		
		# 구현 내용
		1. 기본 템플릿 불러오기
		2. 템플릿 수정하기
		3. SMS, EMAIL 발송하기
		4. SMS, EMAIL 조회하기
		
		# 추가 구현 필요
		1. 이용자간의 구분을 위해 설정 저장시 1회성으로 해당 이용자만의 수정 템플릿 생성 필요
			=> 'templateId + 발신번호(발신이메일)' 템플릿이 존재하는지 확인
			=> 없다면 'templateId + 발신번호(발신이메일)'로 템플릿 생성
			=> 생성된 템플릿명으로 메시지 발송
		2. 이용자 요청시 SMS 발신번호 등록 필요 
	*/
		
	// 템플릿 정보
	var code = []; // 코드
	var originTemplate = []; // 기본템플릿
	var modifyTemplate = []; // 수정템플릿
	$.each($("input[name='code']"), function() { 
		code.push($(this).val()); 
		originTemplate.push($(this).val()); 
		originTemplate.push($(this).val() + "_admin"); // 템플릿명에 따른 가공 => 수정 필요 
		modifyTemplate.push($(this).val() + "_mod"); 
		modifyTemplate.push($(this).val() + "_admin_mod"); 
	});
	
	// 이용 요금, 체크박스, 저장된 양식 조회
	$(function(){		
		// SMS 이용 내역 조회
		var id = $("input[name='secName']").val();
		$.ajax({
			url : "${pageContext.request.contextPath }/admin/comm/load/charge",
			method : "GET",
			data : {id : id},
			success : function(result) {
				var set = result.sendCount;
				if(set > 0) {
					var str = Math.ceil(set * 9.9) + "원 (총 " + set + "건 발송)";
					$("span[name='charge']").html(str);
				}
				else {
					var str = "발신번호가 등록된 사용자가 아닙니다.<br>"
							+ "<small class='text-red'>"
							+ "※ 발신번호 등록 후 ND이커머스 관리자에게 SMS 이용 신청을 해 주시면 발송이 가능합니다."
							+ "</small>";
					$("span[name='charge']").html(str);
					$("#smsSetting").css("display", "none");
				}
			}
		});		
		
		// 체크박스 조회
		$.ajax({
			url : "${pageContext.request.contextPath }/admin/comm/load/smsAutoSendCheck",
			method : "GET",
			success : function(result) {
				var set = result.smsSetting;
				for(var i = 0; i < set.length; i++) {
					if(set[i].isSend == "y") {
						$("input[class='" + set[i].templateId + "'][name='is_send']").attr("checked", true);
					}
					if(set[i].isSendAdmin == "y") {
						$("input[class='" + set[i].templateId + "'][name='is_send_admin']").attr("checked", true);
					}
				}
			}
		});

		// 저장문구 조회
		$.ajax({
			url : "${pageContext.request.contextPath }/admin/comm/load/savedSms",
			method : "GET",
			success : function(result) {
				var set = result.savedSms;
				for(var j = 0; j < modifyTemplate.length; j++) {
					for(var i = 0; i < set.templateId.length; i++) {
						if(set.templateId[i] == modifyTemplate[j]) {
							$("textarea[class='" + originTemplate[j] + "']").val(set.content[i]);	
						}
					}
				}
			}
		});
	});
	
	// 기본 양식 불러오기 
	function getDefaultTemplate(action) {
		// 기본문구 조회
		$.ajax({
			url : "${pageContext.request.contextPath }/admin/comm/load/originSms",
			method : "GET",
			data : {templateId : action},
			success : function(result) {
				var set = result.originSms;
				for(var i = 0; i < set.templateId.length; i++) {
					if(set.templateId[i] == action) {
						if(confirm(set.content[i] + "\n\n해당 문구로 적용하시겠습니까?")) {
							$("textarea[class='" + action + "']").val(set.content[i]);		
						}
					}
				}
			}
		});
	}		
		
	// 전체 변경 확인 버튼 
	function register() { 				
		// 체크박스 값 설정
		$("input:checkbox[name='is_send'], input:checkbox[name='is_send_admin']").each(function() {
        	if($(this).is(":checked")) { // 자동 발송이 체크
        		$(this).attr("value", "y");
        	}
        	else {
        		$(this).attr("value", "n");
        	}
        });
		
		// 수정 정보 담기
		var isSend = [];
		var content = [];
		
		$.each($("input[name='is_send'], input[name='is_send_admin']"), function() {
			isSend.push($(this).val()); // 자동 발송 체크값
		});
		$.each($("textarea"), function() {
			content.push($(this).val()); // 발송 문구
		});
		
		// 자동발송 시 문구 조건
		for(var i = 0; i < isSend.length; i++) {
			if(isSend[i] == "y" && content[i].length < 10) {
				alert("자동발송을 하려면 '" + category_txt(originTemplate[i]) + "' 안내메시지가 최소 10자 이상 입력되어야 합니다."); 
				$("textarea[class='" + originTemplate[i] + "']").focus();
			}
		}
		
		// 설정 저장
		var data = {
			code : code,
			templateId : modifyTemplate,
			isSend : isSend,
			content : content
		};
		var jsonStr = JSON.stringify(data);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/comm/load/smsSettingModify",
			method : "POST",
			headers : {"${_csrf.headerName}" : "${_csrf.token}"},
			contentType : "application/json; charset=utf-8",
			data : jsonStr,
			success : function(result) {
				var set = result.modify;
				if(set == "success") {
					alert("SMS 설정이 수정되었습니다.");
					location.reload();
				}
			}
		});
	}	
	
	// alert code 값 치환
	function category_txt(t_name){
		var return_txt = "";
		
		if(t_name.includes("join")){
				return_txt = "회원가입";
			}
		else
			if(t_name.includes("findid")){
				return_txt = "아이디 찾기 [아이디 찾기시]";
			}
		else
			if(t_name.includes("findpw")){
				return_txt = "임시비밀번호 발급알림 [비밀번호 찾기시]";
			}
		else
			if(t_name.includes("order")){
				return_txt = "주문접수 [무통장/카드 결제시]";
			}
		else
			if(t_name.includes("pay_done")){
				return_txt = "입금확인 [무통장 입금 완료시]";
			}
		else
			if(t_name.includes("delivery_ready")){
				return_txt = "상품 배송 준비중 [주문상태 배송준비중으로 변경시]";
			}
		else
			if(t_name.includes("delivery_ing")){
				return_txt = "상품 배송중 [주문상태 배송중으로 변경시]";
			}
		else
			if(t_name.includes("delivery_done")){
				return_txt = "상품 배송 완료 [주문상태 배송완료로 변경시]";
			}
		else
			if(t_name.includes("order_cancel")){
				return_txt = "주문취소 [주문 취소시]";
			}
		else
			if(t_name.includes("refund")){
				return_txt = "환불완료 [주문상태 환불완료로 변경시]";
			}
		else
			if(t_name.includes("point")){
				return_txt = "적립금 적립 [개별 적립금 적립시]";
			}
		else
			if(t_name.includes("coupon")){
				return_txt = "쿠폰 지급 [개별 쿠폰 지급시]";
			}
		return return_txt;
	}
</script>


<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>