<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="카드결제 로그관리" name="title" />
</jsp:include>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js" type="text/javascript"></script>

<script>
	const { IMP } = window;
	IMP.init('imp86621495');
</script>

<div class="content-wrapper">
	<section class="content-header">
		<h1>
			카드결제로그 관리 
			<small>meta</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>주문 관리</li>
			<li class="active">카드결제로그 관리</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<table class="table table-bordered">
							<tr>
								<td align="left">
									<textarea rows="40" cols="30" name="contents" id="mydiv" class="form-control input-sm" onfocus="this.value = this.value;">
										<c:forEach var="p" items="${paymentInfoList }">
[name]=${p.name }
[amount]=${p.amount }
[imp_uid]=${p.impUid }
[merchant_uid]=${p.merchantUid }
[paid_at]=${p.paidAt }
[pay_method]=${p.payMethod }
[status]=${p.status }
[buyer_addr]=${p.buyerAddr }
[buyer_postcode]=${p.buyerPostcode }
[buyer_name]=${p.buyerName}
[buyer_tel]=${p.buyerTel}
[cancel_amount]=${p.cancelAmount }
[cancel_history]=${p.cancelHistory }
[cnacel_reason]=${p.cancelReason }
[cancel_at]=${p.cancelAt }
										</c:forEach>
									</textarea>
								</td>
							</tr>
						</table>
					</div><!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col-xs-12 -->
		</div><!-- /.row -->
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
	// IMP.certification(param, callback) 호출
	IMP.certification({ // param
	  merchant_uid: "merchant_1650586972341", // 주문 번호
	  m_redirect_url : "{${pageContext.request.contextPath}/admin/order/log_list}", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
	  popup : false // PC환경에서는 popup 파라메터가 무시되고 항상 true 로 적용됨
	}, function (rsp) { // callback
	  if (rsp.success) {
	    console.log(rsp)
	  } else {
	    console.log("fail")
	    console.log(rsp)
	  }
	});
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>