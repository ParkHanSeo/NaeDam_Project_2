<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="쿠폰 관리" name="title" />
</jsp:include>

<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	<h1>
		쿠폰 관리 <small>coupon list</small>
	</h1>

	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">쿠폰 관리</li>
	</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">
					<label style="margin-top: 5px;">총 ${couponList.size() } 건</label>
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<form name="form_search" method="post" action="${pageContext.request.contextPath }/admin/setting/coupon?${_csrf.parameterName}=${_csrf.token}">
							<div class="has-feedback">
								<span> <input type="text" name="keyword" id="keyword" value="${param.keyword == null ? '' : param.keyword }" class="form-control input-sm" placeholder="검색" /> <span class="glyphicon glyphicon-search form-control-feedback"></span>
								</span>
							</div>
					</div>
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<div class="has-feedback">
							<select name="field" class="form-control input-sm">
								<option value="coupon_name">쿠폰명</option>
							</select>
						</div>
					</div>
					<div class="box-tools pull-right" style="margin: 0 10px 5px 0">
						<div class="has-feedback">
							<input type="text" name="expiry_end_date" id="datepicker1" readonly value="${param.expiry_end_date == null ? '' : param.expiry_end_date }" class="form-control input-sm" placeholder="종료일" style="width: 80px; padding-right: 0;" />
						</div>
					</div>
					<div class="box-tools pull-right" style="padding: 5px 5px 0 5px;">~</div>
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<div class="has-feedback">
							<input type="text" name="expiry_start_date" id="datepicker2" readonly value="${param.expiry_start_date == null ? '' : param.expiry_start_date }" class="form-control input-sm" placeholder="시작일" style="width: 80px; padding-right: 0;" />
						</div>
						</form>
					</div>

					<form name="form_list" method="post" action="${pageContext.request.contextPath }/admin/coupon/coupon_process?${_csrf.parameterName}=${_csrf.token}">
						<input type="hidden" name="mode" id="mode">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<td style="width: 30px;"><input type="checkbox" name="select_all" onclick="selectAllCheckBox( 'form_list');" /></td>
									<td style="width: 60px;">NO</td>
									<td>쿠폰명</td>
									<td style="width: 120px;">지급방법</td>
									<td style="width: 140px;">혜택</td>
									<td style="width: 170px;">결제금액(최소 ~ 최대)</td>
									<td style="width: 180px;">유효기간</td>
									<td style="width: 100px;">등록일</td>
									<td style="width: 80px;">상태</td>
									<td style="width: 80px;">명령</td>
								</tr>
							</thead>
							<c:forEach var="coupon" items="${couponList }" varStatus="vs">
								<tr>
									<td><input type="checkbox" name="list[]" value="${coupon.couponNo }" /></td>
									<td>${vs.count }</td>
									<td align="left">${coupon.couponName }</td>
									<td>${coupon.provideType == 'manual' ? '수동발급' : '다운로드'  }</td>
									<c:if test="${coupon.benefitType == 'discount' }">
										<c:if test="${coupon.discountType == 'amount' }">
											<td>${coupon.discount }원 할인</td>
										</c:if>
										<c:if test="${coupon.discountType == 'percent' }">
											<td>${coupon.discount }% 할인</td>
										</c:if>
									</c:if>
									<c:if test="${coupon.benefitType == 'delivery_free' }">
										<td>배송비 무료</td>
									</c:if>
									<td style="text-align: right; padding-right: 15px;"><fmt:formatNumber value="${coupon.useLimit}" pattern="#,###" /> ~ <fmt:formatNumber value="${coupon.useMax }" pattern="#,###" /></td>
									<c:choose>
										<c:when test="${coupon.expiryStartDate == null and coupon.expiryEndDate == null }">
											<td>무제한</td>
										</c:when>
										<c:otherwise>
											<td><fmt:formatDate pattern = "yyyy-MM-dd" value="${coupon.expiryStartDate}"/> ~ <fmt:formatDate pattern = "yyyy-MM-dd" value="${coupon.expiryEndDate}"/></td>
										</c:otherwise>
									</c:choose>
									<td><fmt:formatDate pattern = "yyyy-MM-dd" value="${coupon.regDate}"/></td>
									<td>
										<c:if test="${coupon.couponStatus == 'use' }">
											<span class="label label-success" style="font-size: 12px;">사용</span>
										</c:if>
										<c:if test="${coupon.couponStatus == 'stop' }">
											<span class="label label-default" style="font-size:12px;">중지</span>
										</c:if>
									</td>
									<td><button type="button" onclick="onclickUpdate(${coupon.couponNo});" class="btn btn-primary btn-xs">상세보기</button></td>
								</tr>
							</c:forEach>
							
						</table>
					</form>
					<br>

					<button type="button" onclick="selectDelete('deleteCoupon');" class="btn btn-danger btn-sm">
						<i class="fa fa-minus-square"></i> 선택삭제
					</button>
					<button type="button" onclick="onclickInsert()" class="btn btn-primary btn-sm">
						<i class="fa fa-plus-square"></i> 쿠폰 등록
					</button>

					<div style="text-align: right;">
						<!--<? echo $data['page'];?>-->
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
		</div>
		<!-- /.col-xs-12 -->
	</div>
	<!-- /.row --> </section>

	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form name="form_register" method="post" action="${pageContext.request.contextPath }/admin/coupon/coupon_process?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
					<input type="hidden" name="mode" id="mode"> <input type="hidden" name="couponNo" value="0">
					<input type="hidden" name="discount" value="0" />
					<input type="hidden" name="useLimit" value="0"/>
					<input type="hidden" name="useMax" value="0"/>
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabelPortfolio">쿠폰 관리</h4>
					</div>
					<div class="modal-body">

						<h4>
							<p class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 쿠폰 <span id="popup_sub_title">등록</span>
							</p>
						</h4>
						<table class="table table-bordered">
							<tr>
								<td class="menu">쿠폰명 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="text" name="couponName" class="form-control input-sm"></td>
							</tr>
							<tr>
								<td class="menu">지급 방법 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="radio" name="provideType" value="download"> 다운로드&nbsp;<span style="line-height: 2.0;"> <small class="text-red">마이페이지 > 쿠폰내역 에서 다운로드 받고 사용</small></span><br> <input type="radio" name="provideType" value="manual"> 수동발급&nbsp;<span style="line-height: 2.0;"> <small class="text-red">회원관리 > 회원 리스트 에서 특정 회원에게 개별 쿠폰 지급 가능</small></span><br> <!--<input type="radio" name="provide_type" value="mail"> 메일--></td>
							</tr>
							<tr>
								<td class="menu">혜택 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><span style="float: left;">
									<input type="radio" name="benefitType" value="discount"> 할인</span> <span style="float: left; margin-left: 5px;">
									<input type="text" name="discount_comma" onkeyup="this.value=displayComma(checkAmountNum(this.value))" class="form-control input-sm" style="width: 100px; text-align: right;"></span> <span style="float: left; margin-left: 5px;"> 
									
									<select name="discountType" class="form-control input-sm" style="padding: 0; width: 50px;">
											<option value="amount">원</option>
											<option value="percent">%</option>
									</select>
								</span> <br>
								<br> <span style="float: left;"><input type="radio" name="benefitType" value="delivery_free"> 배송비 무료</span></td>
							</tr>
							<tr>
								<td class="menu">사용 가능<br>결제금액 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left">
									<p>
										<span style="float: left;"><input type="text" name="useLimit_comma" placeholder="최소금액" onkeyup="this.value=displayComma(checkAmountNum(this.value))" class="form-control input-sm" style="width: 100px; text-align: right;"></span>&nbsp;<span style="line-height: 2.0;"> <small class="text-red">결제금액이 OO 이상 일때 사용 가능 (값을 입력하지 않으면 제한 없음)</small></span>
									</p>
									<p>
										<span style="float: left;"><input type="text" name="useMax_comma" placeholder="최대금액" onkeyup="this.value=displayComma(checkAmountNum(this.value))" class="form-control input-sm" style="width: 100px; text-align: right;"></span>&nbsp;<span style="line-height: 2.0;"> <small class="text-red">결제금액이 OO 이하 일때 사용 가능 (값을 입력하지 않으면 제한 없음)</small></span>
									</p>
								</td>
							</tr>
							<tr>
								<td class="menu">유효 기간 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><span style="float: left;"><input type="radio" name="expiryType" value="unlimited"> 무제한</span> <br>
								<br> <span style="float: left;">
									<input type="radio" name="expiryType" value="fix"> 날짜지정</span> <span style="float: left; margin-left: 5px;">
									<input type="text" name="expiry_start_date" id="datepicker3" readonly placeholder="시작일" class="form-control input-sm" style="width: 80px"></span> <span style="float: left; margin-left: 5px;">&nbsp; ~ &nbsp;</span><span style="float: left;"><input type="text" name="expiry_end_date" id="datepicker4" readonly placeholder="종료일" class="form-control input-sm" style="width: 80px"></span></td>
							</tr>
							<tr>
								<td class="menu">상태</td>
								<td align="left"><input type="radio" name="couponStatus" value="use">사용&nbsp;&nbsp; <input type="radio" name="couponStatus" value="stop">중지</td>
							</tr>
						</table>

					</div>
					<div class="modal-footer">
						<button type="button" onclick="register()" class="btn btn-primary">확인</button>
						&nbsp;&nbsp;&nbsp;
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- /.content-wrapper -->

<script>
function register() {
    if(form_register.couponName.value == '') { alert('쿠폰명이 입력되지 않았습니다.'); form_register.title.focus(); return false;}
    if (!$("input[name='provideType']").is(':checked')) { alert('지급방법이 선택되지 않았습니다.'); return false;}
    if (!$("input[name='benefitType']").is(':checked')) { alert('혜택이 선택되지 않았습니다.'); return false;}
    if($("input[name='benefitType']:checked").val() == 'discount' && form_register.discount_comma.value == '') { alert('할인액이 입력되지 않았습니다.'); form_register.discount.focus(); return false;}
    if (!$("input[name='expiryType']").is(':checked')) { alert('유효 기간이 선택되지 않았습니다.'); return false;}
    if($("input[name='expiryType']:checked").val() == 'fix') {
        if (form_register.expiry_start_date.value == '') { alert('시작일이 입력되지 않았습니다.'); form_register.expiry_start_date.focus(); return false;}
        if (form_register.expiry_end_date.value == '') { alert('종료일이 입력되지 않았습니다.'); form_register.expiry_end_date.focus(); return false;}
    }
    form_register.target = 'iframe_process';
    $('[name=discount]').val($('[name=discount_comma]').val().replace(',',''));
    $('[name=useLimit]').val($('[name=useLimit_comma]').val().replace(',',''));
    $('[name=useMax]').val($('[name=useMax_comma]').val().replace(',',''));
    form_register.submit();
}
function setData(code) {
	$.ajax({
		url:'${pageContext.request.contextPath}/admin/coupon/getCoupon',
		type:'post',
		dataType:'json',
		headers: {
            "${_csrf.headerName}" : "${_csrf.token}"
        },
		data:{
			method:'BizCoupon.infoCoupon',
            couponNo : code,
		},
		success(data){
            var startDate = new Date(data.expiryStartDate);
			var endDate = new Date(data.expiryEndDate);
			var startDateStr = "";
			startDateStr += startDate.getFullYear() + "-";
			startDateStr += (startDate.getMonth() + 1) + "-";
			startDateStr += startDate.getDate();
			var endDateStr = "";
			endDateStr += endDate.getFullYear() + "-";
			endDateStr += (endDate.getMonth() + 1) + "-";
			endDateStr += endDate.getDate();
             $('form[name="form_register"] #mode').val('updateCoupon');
			$('[name=couponNo]').val(data.couponNo);
			$('[name=couponName]').val(data.couponName);
            $('input[name=provideType][value='+data.provideType+']').prop('checked', true);
            $('input[name=benefitType][value='+data.benefitType+']').prop('checked', true);
            // TODO
            // discount, useLimit, useMax ~> comma처리해야 함.
            if($("input[name='benefitType']:checked").val() == 'discount') {
                $('[name=discount_comma]').val(data.discount);
                $('[name=discountType]').val(data.discountType);
            }
            
            if(data.useLimit != null) $('[name=useLimit_comma]').val(data.useLimit);
            if(data.useMax != null) $('[name=useMax_comma]').val(data.useMax);
            $('input[name=expiryType][value='+data.expiryType+']').prop('checked', true);
            if($("input[name='expiryType']:checked").val() == 'fix') {
                $('[name=expiry_start_date]').val(startDateStr);
                $('[name=expiry_end_date]').val(endDateStr);
            }
            $('input[name=couponStatus][value='+data.couponStatus+']').prop('checked', true);
		},
		error:console.log
	});
}
function onclickInsert() {
    $('#modalContent').modal('show');
    form_register.reset();
    $('form[name="form_register"] #mode').val('insertCoupon');
    $('input[name=coupon_status][value=use]').prop('checked', true);
}
function onclickUpdate(code) {
    $('#modalContent').modal({backdrop:'static', show:true});
    form_register.reset();
    setData(code);
}
$(function() {
    $("#datepicker1,#datepicker2,#datepicker3,#datepicker4").datepicker({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNames: ['일','월','화','수','목','금','토'],
        dayNamesShort: ['일','월','화','수','목','금','토'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        showMonthAfterYear: true,
        yearSuffix: '년'
    });
});
$(document).ready(function() {
    $('#keyword').keydown(function(event) {
        if(event.keyCode == 13) {
            form_search.submit();
        }
    });
});

</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>