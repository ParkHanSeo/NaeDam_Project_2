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
<!-- content-wrapper -->
<div class="content-wrapper">
<style>
textarea {
    width:180px;
    height:100px;
    resize:none;
}
</style>
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
	
						<form name="form_register">
			                <input type="hidden" name="mode" value="updateSMS">
			                
			                <c:forEach var="setting" items="${ smsSetting }">
			                	<input type="hidden" name="setTemplateId" value="${ setting.templateId }">
			                	<input type="hidden" name="setIsSend" value="${ setting.isSend }">
			                	<input type="hidden" name="setIsSendAdmin" value="${ setting.isSendAdmin }">
			                </c:forEach>
			                <c:forEach var="templateId" items="${ templateId }">
			                	<input type="hidden" name="templateId" value="${ templateId }">
			                </c:forEach>
			                <c:forEach var="content" items="${ content }">
			                	<input type="hidden" name="bodyContent" value="${ content }">
			               	</c:forEach>
			                <c:forEach var="savedTemplateId" items="${ savedTemplateId }">
			                	<input type="hidden" name="savedTemplateId" value="${ savedTemplateId }">
			                </c:forEach>
			                <c:forEach var="savedContent" items="${ savedContent }">
			                	<input type="hidden" name="savedContent" value="${ savedContent }">
			               	</c:forEach>			            
			               	
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
					                    	<!-- action에 해당하는 이름값 class로 분리하기 -->
					                        <input type="hidden" class="join" name="code" value="join" /> 
					                        <textarea class="join" name="content" ></textarea>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="join" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<!-- getDefaultTemplate(type, action, is_admin) -->
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
	                	
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section>
</div><!-- /.content-wrapper -->

<script>

	// 이용 요금 및 저장된 양식 조회
	$(function(){
		// 로그인 정보 보내기
		var secName = $("input[name='secName']").val();
		console.log(secName);
		
		$.ajax({
			url : "${pageContext.request.contextPath }/admin/comm/charge",
			method : "POST",
			headers: {
				"${_csrf.headerName}" : "${_csrf.token}"
			},
			data: { id : secName },
			success: function(result) {
				if(result > 0) {
					$("span[name='charge']").html((result * 9.9) + "원 (총 " + result + "건 발송)");
				}
				else {
					var str = "발신번호가 등록된 사용자가 아닙니다.<br><small class='text-red'>※ 발신번호 등록(관리자 > 설정 > 기본설정 > 발신자 번호)을 사전에 하여야 발송이 가능합니다.</small>";
					$("span[name='charge']").html(str);
				}
			}
		});		
		
		// savedTemplateId, savedContent, textarea 선언
		var savedTemplateId = [];
		var savedContent = [];
		var textarea = [];
		
		var setTemplateId = [];
		var setIsSend = [];
		var setIsSendAdmin = [];
		
		// 값 담기
		$.each($("input[name='savedTemplateId']"), function(index, value) { 
			savedTemplateId.push($(value).val());
		});
		$.each($("input[name='savedContent']"), function(index, value) { 
			savedContent.push($(value).val());
		});
		$("textarea").each(function() { 
			textarea.push($(this).attr("class"));
		});	
		
		// 체크박스 조회 데이터 담기
		$("input[name='setTemplateId']").each(function() { 
			setTemplateId.push($(this).val());
		});
		$("input[name='setIsSend']").each(function() { 
			setIsSend.push($(this).val());
		});
		$("input[name='setIsSendAdmin']").each(function() { 
			setIsSendAdmin.push($(this).val());
		});
		
		// is_send, is_send_admin 값이 y일 때 checked 속성 부여
		for(var i = 0; i < setTemplateId.length; i++) {
			if(setIsSend[i] == "y") {
				$("input[class='" + setTemplateId[i] + "'][name='is_send']").attr("checked", true);
			}
			else if(setIsSendAdmin[i] == "y") {
				$("input[class='" + setTemplateId[i] + "'][name='is_send_admin']").attr("checked", true);
			}
		}

		// class와 일치하는 textarea에 문구 적용
		for(var i = 0; i < savedTemplateId.length; i++) {
			for(var j = 0; j < textarea.length; j++) {
				if(savedTemplateId[i] == textarea[j].concat("_mod")) { 
					$("textarea[class='" + textarea[j] + "']").val(savedContent[i]);	
				}	
			}
		}
	});
	
	// 기본 양식 불러오기 
	function getDefaultTemplate(action) { 
		// templateId, content 선언
		var templateId = [];
		var content = [];
		
		// 값 담기
		$.each($("input[name='templateId']"), function(index, value) { 
			templateId.push($(value).val());
		});
		$.each($("input[name='bodyContent']"), function(index, value) { 
			content.push($(value).val());
		});
				
		// action과 일치하는 textarea에 문구 적용
		for(var i = 0; i < templateId.length; i++) {
			if(templateId[i] == action) { 
				if(confirm(content[i] + "\n\n해당 문구로 적용하시겠습니까?")) {
					$("textarea[class='" + action + "']").val(content[i]);		
				}
			}
		}
	}		
		
	// 전체 변경 확인 버튼 
	function register() { 
		// 체크박스 값 설정
		$("input:checkbox[name='is_send']").each(function() {
        	if($(this).is(":checked")) { // 회원 자동 발송이 체크
        		$(this).attr("value", "y");
        	}
        	else {
        		$(this).attr("value", "n");
        	}
        });
        $("input:checkbox[name='is_send_admin']").each(function() { 
        	if($(this).is(":checked")) { // 관리자 자동 발송이 체크
        		$(this).attr("value", "y");
        	}
        	else {
        		$(this).attr("value", "n");
        	}
        });
				
		// code, is_send, cotent 선언
		var code = []; // textarea의 class 값
		var is_send = []; // checkbox 값
		var content = []; // textarea 값
		
		// 값 담기
		$("textarea").each(function() {
			code.push($(this).attr("class"));
		});
		$.each($("input[name='is_send'], input[name='is_send_admin']"), function(index, value) {
			is_send.push($(value).val());
		});
		$.each($("textarea[name='content'], textarea[name='content_admin']"), function(index, value) {
			content.push($(value).val());
		});
		
		// 자동발송 문구 조건
		for(var i = 0; i < is_send.length; i++) {
			if(is_send[i] == "y" && content[i].length < 10) {
				alert("자동발송을 하려면 '" + category_txt(code[i]) + "' 안내메시지가 최소 10자 이상 입력되어야 합니다."); 
				return;
			}
		}
		
		// data -> json
		var data = { code : code, is_send : is_send, content : content }		
		var jsonStr = JSON.stringify(data);

		// ajax로 값 넘기기
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/comm/sms",
			method:"POST",
			headers: {
				"${_csrf.headerName}" : "${_csrf.token}"
			},
			contentType: "application/json; charset=utf-8",
			data: jsonStr,
			success: function(result) {
				if(result > 0) {
					alert("SMS 설정이 수정되었습니다.");
					location.reload();
				}
			},
			error: function(textStatus, errorThrown) {
				console.log("SMS 설정 수정에 실패했습니다.");
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