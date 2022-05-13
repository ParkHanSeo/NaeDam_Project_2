<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
 <!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js" type="text/javascript"></script>
  <script>
  const { IMP } = window;
  IMP.init('imp86621495');
  
  </script>
<body>
<sec:authentication property="principal" var="loginMember" />
	<button onclick="paymentComplete();">결제 정보확인test @log</button>
	<button onclick="pay();">결제</button>
</body>

<script>

function pay(){
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:결제테스트',
	    amount : 100,
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456'
	}, function(rsp) {
	    if ( rsp.success ) {
			ajax(rsp);
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }

	    alert(msg);
	});
}

function ajax(rsp){
	const jsonStr = JSON.stringify(rsp);
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/payment/insert",
		data: {
			jsonStr : jsonStr
		},
		headers: {
            "${_csrf.headerName}" : "${_csrf.token}"
        },
		method:"POST",
		success(data){
			console.log(data)
		},
		error:console.log
	});
}




function paymentComplete(){
	console.log(new Date(1650593265))
	const data = {
			payMethod : 'card',
			orderNo : "220316000000008",
			amount : 40000,
			buyer_email : '${loginMember.email}',
			buyer_name : '${loginMember.lastName}${loginMember.firstName}',
			buyer_tel : '${loginMember.phone}',
			buyer_addr : '서울특별시 강남구 삼성동',
			buyer_postcode : '123-456',
			imp_uid : "imp_679227711838",
			merchant_uid : "220316000000008",
			totalPrice : 40000
	}
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/payment/complete",
		method : "POST",
		headers: {
            "${_csrf.headerName}" : "${_csrf.token}"
        },
		data : data,
		success(data){
			console.log(data)
		},
		error : console.log
	});
}
</script>
</html>