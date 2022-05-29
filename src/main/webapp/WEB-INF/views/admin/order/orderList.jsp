<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="주문 관리" name="title" />
</jsp:include>
<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			주문 관리 <small>order list</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#">주문 관리</a></li>
			<li class="active">Data tables</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<form:form name="form_search" id="form_search" method="post" action="${pageContext.request.contextPath }/admin/order/list?${_csrf.parameterName}=${_csrf.token}">
							<table class="table table-bordered" style="margin-bottom: 0;">
								<tbody>
									<tr>
										<td class="menu">진행상태</td>
										<td align="left"><select name="order_status" class="form-control input-sm" style="float: left; width: 130px; margin-right: 5px;">
												<option value="">상태</option>
												<c:forEach var="orderStatus" items="${orderStatusList }">
													<option value="${orderStatus.orderStatusNo }">${orderStatus.statusName }</option>
												</c:forEach>
										</select></td>
										<td class="menu">기간 검색</td>
										<td align="left"><input type="text" name="start_date" id="start_date" value="" class="form-control input-sm txt_date1" style="width: 100px; display: inline-block;" /> ~ <input type="text" name="end_date" id="end_date" value="" class="form-control input-sm txt_date1" style="width: 100px; display: inline-block;" />

											<button type="button" onclick="setSearchDate('D0');" class="btn btn-primary btn-xs">오늘</button>
											<button type="button" onclick="setSearchDate('D7');" class="btn btn-primary btn-xs">7일</button>
											<button type="button" onclick="setSearchDate('D15');" class="btn btn-primary btn-xs">15일</button>
											<button type="button" onclick="setSearchDate('M1');" class="btn btn-primary btn-xs">1개월</button>
											<button type="button" onclick="setSearchDate('M3');" class="btn btn-primary btn-xs">3개월</button>
											<button type="button" onclick="setSearchDate('M6');" class="btn btn-primary btn-xs">6개월</button></td>
									</tr>
									<tr>
										<td class="menu">결제방법</td>
										<td align="left"><select name="payment_type" class="form-control input-sm" style="float: left; width: 130px; margin-right: 5px;">
												<option value="">결제방법</option>
												<option value="cash">무통장</option>
												<option value="card">신용카드</option>
										</select></td>
										<td class="menu">키워드</td>
										<td align="left"><select name="field" class="form-control input-sm" style="float: left; padding-right: 0; width: 130px;">
												<option value="concat(last_name,first_name)">주문자 성명</option>
												<option value="receiver">수취인 성명</option>
												<option value="phone">휴대폰</option>
												<option value="order_no">주문번호</option>
										</select> <input type="text" name="keyword" id="keyword" value="" class="form-control input-sm" placeholder="주문검색" style="width: 50%; padding-left: 5px;" /></td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="4" style="text-align: center;">
											<button type="button" onclick="selectAction();" class="btn btn-danger btn-sm">
												<i class="fa "></i>검색
											</button>
										</td>
									</tr>
								</tfoot>
							</table>
						</form:form>

						<label style="margin-top: 5px;">총 ${orderCnt } 건</label>
						<form:form name="form_list" method="post" action="${pageContext.request.contextPath }/admin/order/delete">
							<input type="hidden" name="mode" id="mode"> 
							<input type="hidden" name="search_data">
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<td style="width: 30px;"><input type="checkbox" name="select_all" onclick=selectAllCheckBox( 'form_list'); /></td>
										<td style="width: 160px;">주문번호</td>
										<td style="width: 140px;">주문일자</td>
										<td>상품명</td>
										<td style="width: 90px;">주문자</td>
										<td style="width: 110px;">연락처</td>
										<td style="width: 80px;">결제금액</td>
										<td style="width: 80px;">결제방법</td>
										<td style="width: 120px;">결제일</td>
										<td style="width: 90px;">상태</td>
										<td style="width: 60px;">명령</td>
									</tr>
								</thead>
								<c:forEach var="order" items="${orderList }">
									<tr>
										<td><input type="checkbox" name="list[]" value="${order.orderNo }" /></td>
										<td>${fn:substring(order.orderNo,0,6) }-${fn:substring(order.orderNo,7,15) }</td>
										<td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>
										<td align="left">${order.productName }</td>
										<td>${order.lastName}${order.firstName}</td>
										<td>${fn:substring(order.phone,0,3) }-${fn:substring(order.phone,3,7) }-${fn:substring(order.phone,7,13)}</td>
										<td align="right" style="color: #ff0505; font-weight: bold"><fmt:formatNumber value="${order.amount }" pattern="#,###" /></td>
										<td>${order.payMethod == null ? '무통장' :'카드'}</td>
										<c:if test="${order.piStatus == 'ready' }">
											<td>${order.piStatus == 'ready' ? ' - ':'' }</td>
										</c:if>
										<c:if test="${order.piStatus == 'paid' }">
											<td><fmt:formatDate value="${order.paidAt}" pattern="yyyy-MM-dd" /> </td>
										</c:if>
										<td style="font-weight: bold"><span id="order_status_name_${order.orderNo }">${order.piStatus == 'ready' ? '입금 대기' : order.piStatus == 'paid' ? order.statusName : '결제 완료'}</span></td>
										<td><button type="button" onclick="onclick_update(${order.orderNo});" class="btn btn-primary btn-xs">보기</button></td>
									</tr>
								</c:forEach>
							</table>
						</form:form>
						<br>

						<button type="button" onclick="selectDelete();" class="btn btn-danger btn-sm">
							<i class="fa fa-minus-square"></i> 선택삭제
						</button>
						<button type="button" onclick="downloadExcel();" class="btn btn-warning btn-sm">
							<i class="fa" aria-hidden="true"></i> Excel 다운로드
						</button>
						<form name="form_download" method="post" action="${pageContext.request.contextPath }/excel/download.do?${_csrf.parameterName}=${_csrf.token}">
							<input type="hidden" name="mode" value="downloadExcel"> 
							<input type="hidden" name="search_data">
							<input type="hidden" name="download_type" value="order"/>
						</form>

						<div style="text-align: right;">
							<ul class="pagination" style="margin: 0;">
								<li class="active"><a href="?tpf=admin/order/list&start_date=&end_date=&page=1">1</a></li>
							</ul>
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

	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form name="form_register" method="post" action="?tpf=admin/order/process">
					<input type="hidden" name="mode" id="mode" value="update_payment_status"> <input type="hidden" name="payment_code" id="payment_code">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabelPortfolio">주문내역 상세 보기</h4>
					</div>
					<div class="modal-body">
						<div>
							<h4>
								<p class="text-light-blue">
									<i class="fa fa-fw fa-info-circle"></i> 구매 내역
								</p>
							</h4>
	
							<span id="order_list_txt"></span>
							<table class="table table-bordered">
								<thead>
									<tr>
										<td style="width: 350px;">상품명</td>
										<td>가격(원)</td>
										<td>수량(개)</td>
										<td style="width: 120px;">합계(원)</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td id="td_option_target" style="text-align: left;"><img id="p_img" src="" alt="" style="float: left; margin-right: 10px; width: 120px;'" /> "<span id="p_name"></span>"</td>
										<td class="money"><span id="p_sPrice"></span></td>
										<td class="count"><span id="p_amt"></span></td>
										<td class="money"><span class="text-light-blie"><span id="p_ltPrice"></span></span></td>
									</tr>
									<tr>
										<td colspan="3" class="money">상품합계</td>
										<td class="money"><span id="p_priceNoDeli"></span></td>
									</tr>
									<tr>
										<td colspan="3" class="money">배송료</td>
										<td class="money"><span id="deli_fee"></span></td>
									</tr>
									<tr>
										<td colspan="3" class="money">총 결제금액</td>
										<td class="money"><span class="red_16_b"> <b><span id="p_totalPrice"></span></b>
										</span></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div style="width:40%; display:inline-block;">
							<h4>
								<p class="text-light-blue">
									<i class="fa fa-fw fa-info-circle"></i> 결제 정보
								</p>
							</h4>
							<table class="table table-bordered">
								<tr>
									<td class="menu">주문자</td>
									<td align="left"><span id="order_name"></span></td>
								</tr>
								<tr>
									<td class="menu">주문자 휴대폰</td>
									<td align="left"><span id="order_mobile"></span></td>
								</tr>
								<tr>
									<td class="menu">주문번호</td>
									<td align="left"><span id="order_number"></span></td>
								</tr>
								<tr>
									<td class="menu">결제금액</td>
									<td align="left"><span id="total_price"></span> 원</td>
								</tr>
								<tr>
									<td class="menu">결제방법</td>
									<td align="left"><span id="payment_type"></span></td>
								</tr>
								<tr>
									<td class="menu">입금계좌번호</td>
									<td align="left"><span id="bank_account"></span></td>
								</tr>
								<tr>
									<td class="menu">입금은행명</td>
									<td align="left"><span id="bank_name"></span></td>
								</tr>
								<tr>
									<td class="menu">예금주명</td>
									<td align="left"><span id="bank_depositor"></span></td>
								</tr>
								<tr>
									<td class="menu">입금자명</td>
									<td align="left"><span id="pay_name"></span></td>
								</tr>
							</table>
						</div>

						<div style="display:inline-block; float:right; width: 60%;">
							<h4>
								<p class="text-light-blue">
									<i class="fa fa-fw fa-info-circle"></i> 수취인 정보
								</p>
							</h4>
							<table class="table table-bordered">
								<tr>
									<td class="menu">수취인 성명</td>
									<td align="left"><span id="receiver_name"></span></td>
								</tr>
								<tr>
									<td class="menu">휴대폰</td>
									<td align="left"><span id="receiver_mobile"></span></td>
								</tr>
								<tr>
									<td class="menu">배송지 주소</td>
									<td align="left"><span id="receiver_addr"></span></td>
								</tr>
								<tr>
									<td class="menu">메모</td>
									<td align="left"><span id="request_message"></span></td>
								</tr>
								<tr>
									<td class="menu">관리자 메모</td>
									<td align="left"><span style="float: left"> <textarea name="memo" id="memo" class="form-control input-sm" rows="5" style="width: 200px; resize:none;"></textarea>
									</span> <span style="padding: 20px 0 0 10px; float: left">
											<button id="update_admin_memo" type="button" onclick="updateAdminMemo()" class="btn btn-primary btn-sm">
												저장<br>하기
											</button>
									</span></td>
								</tr>
								<tr>
									<td class="menu">상태</td>
									<td align="left"><span style="float: left"> <input type="text" name="delivery_code" id="delivery_code" class="form-control input-sm" style="float: left; margin-right: 2px; width: 100px;" placeholder="송장번호"> <select name="payment_status" id="payment_status" class="form-control input-sm" style="width: 90px; padding: 0;">
												<c:forEach var="status" items="${orderStatusList }">
													<option value="${status.orderStatusNo }">${status.statusName }</option>
												</c:forEach>
										</select>
									</span> <span style="padding-left: 10px; float: left">
											<button id="update_order_status" type="button" onclick="updateOrderStatus()" class="btn btn-primary btn-sm">저장하기</button>
									</span></td>
								</tr>
							</table>
						</div>

					</div>
					<input type="hidden" id="doseosangan" value="null" />
				</form>
			</div>
		</div>
	</div>
</div>
<!-- /.content-wrapper -->

<!-- jsp 실행 즉시, 택배 실시간 조회하여 update한다. -->
<c:forEach var="order" items="${orderList }">
	<script>
		(function(){
			if(${order.trackingNo} != 0){				
				const myKey = "KIYJ8r5TthgMsHznkinW3g";
				var deliComNo = ${order.deliComNo}
				if(deliComNo < 10){
					var t_code = "0" + deliComNo;				
				}else{
					var t_code = deliComNo;
	 			}
				
		        var t_invoice = ${order.trackingNo};
		        // DB에서 온거. 동일한 운송장의 하루 요청 건수를 초과 하였습니다.
		        var url = "http://info.sweettracker.co.kr/api/v1/trackingInfo?t_key="+myKey+"&t_code="+t_code+"&t_invoice="+t_invoice;
		        //var url ="http://info.sweettracker.co.kr/api/v1/trackingInfo?t_key=FV9kkSwcgfdK76xfE8qHIA&t_code=04&t_invoice=647223588260";
			    var statusNo = 0;

		        $.ajax({
		            type:"GET",
		            dataType : "json",
		            url: url,
		            success(data){
		            	var trackingDetails = data.trackingDetails;
		            	var latestStatus = trackingDetails[trackingDetails.length-1];
			                // 배송준비중 상태
			                if(latestStatus.level < 2){
			                	statusNo = 3;
			                // 배송완료 상태
			                }else if(latestStatus.level >= 6){
			                	statusNo = 5;
			               	// 배송중 상태
			                }else{
			                	statusNo = 4;
			                }			                
		            },
		            error : console.log
		        });
		        	
			        setTimeout(()=>{
				        if(statusNo != 0){
			        		
				        	$.ajax({
								url : "${pageContext.request.contextPath}/admin/order/statusAutoUpdate",
								data : {
									orderNo : ${order.orderNo},
									statusNo : statusNo
								},
								contentType : "application/json; charset:UTF-8",
								dataType : "json",
								type : "get",
								success(data){
									var target = "#order_status_name_" + "${order.orderNo}";
									$(target).text(data.orderStatusName);
								},
								error:console.log
								
							});
				        }
				   },1000);
				
			}

		})();
	</script>
</c:forEach>

<script>
	<!-- 모달창 제어 -->
	function onclick_update(orderNo){
		console.log(orderNo)
			getDoseosangan(orderNo)
				.catch(function(orderNo){})
				.then(fillForm(orderNo))
				
			$("#modalContent").modal('show');			
	}
	
	/* 비동기 순서를 정하기 위해 promise 객체 선언 */
	function getDoseosangan(orderNo){
		return new Promise(function(resolve, reject){
			$(document["form_register"])[0].reset();
			$.ajax({
				url : "${pageContext.request.contextPath}/admin/order/getDoseosangan",
				data : {
					orderNo : orderNo
				},
				type : "get",
				success(data){
					$(doseosangan).val(data);
				}
			});
			if($(doseosangan).val() != 'null') resolve();
			else reject(orderNo);
		});

	}
	
	/* 모달창 내용 기입 */
	function fillForm(orderNo){
		setTimeout(() =>{
			
			var doseoFee = 0;
			console.log($(doseosangan).val())
			console.log($(doseosangan).val() != 'null')
			
			if($(doseosangan).val() != 'null'){
				doseoFee = $(doseosangan).val() * 1;
			}	
			
			console.log(doseoFee)
				$.ajax({
					//url: `\${restServerUrl}/menus`,
					url:`${pageContext.request.contextPath}/admin/order/orderDetail`,
					data:{
						orderNo : orderNo
					},
					method: "GET",
					success(data){
						// 구매내역 append? 값 채우기?
							
							$("#p_img").attr('src', data.orderDetail.imgUrl);
						
							var salePrice = data.orderDetail.salePrice * 1;
							var orderAmt = data.orderDetail.orderAmt * 1;

							var deliFee = ${deliSet.basicDeliveryFee}
							
							if(${deliSet.extraDeliFeeYn == 'Y'}){
								deliFee += doseoFee; 
							}
							
							var optionCost = 0;
							// 상품명
							$("#p_name").text(data.orderDetail.productName);
							// 판매가
							$("#p_sPrice").text(salePrice);
							
							// 옵션 (존재하는 경우에만 입력 되도록)
							$.each(data.orderOptionList, (k,v)=>{
								$("#td_option_target").append(`<br />" - \${v.optionName} : \${v.optionValue} (+ \${v.optionValueCost})"`);
								optionCost += v.optionValueCost;
								
							});
							//console.log(optionCost);
							// 상품 수량
							$("#p_amt").text(orderAmt);
							
							// tr에서의 합계 금액 : (판매가 + 옵션) * 수량
							var trTotalPrice = ((salePrice + optionCost) * orderAmt);
							$("#p_ltPrice").text(trTotalPrice);
							
							// 상품합계 (배송비 제외) : 모든 tr 합계 금액의 합 
							$("#p_priceNoDeli").text(trTotalPrice);
							
							// 배송비 & 총 결제 금액
							if(trTotalPrice >= ${deliSet.freeShippingSettings}){
								$("#deli_fee").text("무료배송");					
								$("#p_totalPrice").text(trTotalPrice);
							}else{
								$("#deli_fee").text(deliFee);
								$("#p_totalPrice").text(trTotalPrice + deliFee);
							}
							

						
						
						// 결제 정보
						$("#order_name").text(data.orderDetail.name);
						$("#order_mobile").text(data.orderDetail.phone);
						$("#order_number").text(data.orderDetail.orderNo);
						$("#total_price").text(data.orderDetail.amount);
						
						var paymentType = '';
						if(data.orderDetail.payMethod == null){
							paymentType = '무통장';
						}else{
							paymentType = '카드';
						}
						
						$("#payment_type").text(paymentType);
						$("#bank_account").text(data.orderDetail.account);
						$("#bank_name").text(data.orderDetail.bankName);
						$("#bank_depositor").text(data.orderDetail.owner);
						$("#pay_name").text(data.orderDetail.buyerName);
						
						
						
						// 수취인 정보
						$("#receiver_name").text(data.orderDetail.receiver);
						$("#receiver_mobile").text(data.orderDetail.receiverPhone);
						$("#receiver_addr").text(data.orderDetail.shippingAddress);
						$("#request_message").text(data.orderDetail.memo);
						$("#memo").val(data.orderDetail.adminMemo);
						$("#delivery_code").val(data.orderDetail.trackingNo == 0 ? '' : data.orderDetail.trackingNo);
						var orderStatusNo = 0;
						if(data.orderDetail.piStatus == 'ready'){
							orderStatusNo = 1;
						}else{
							orderStatusNo = data.orderDetail.orderStatusNo;
						}
						$('#payment_status').val(orderStatusNo).prop("selected",true);
						
						// 주문 상태 변경
						
						// 업데이트 온클릭 속성 추가
						$("#update_order_status").attr('onclick', 'updateOrderStatus(' + data.orderDetail.orderNo +')')
						$("#update_admin_memo").attr('onclick', 'updateAdminMemo(' + data.orderDetail.orderInfoNo + ')')
						$(doseosangan).val('null');

						
					},
					error: console.log
				});
		}, 500);

	}
	
	<!-- 모달창 -> 상태 업데이트 -->
	function updateOrderStatus(orderNo){
		
		var statusNo = $("#payment_status").val();
		
		$.ajax({
			//url: `\${restServerUrl}/menus`,
			url:`${pageContext.request.contextPath}/admin/order/updateOrderStatus`,
			data:{
				orderNo : orderNo,
				statusNo : statusNo
			},
			method: "GET",
			success(data){
				if(data > 0){
					alert('주문 상태가 변경되었습니다.');
					location.reload();
	
					sendAutoMsg(orderNo, statusNo); // 성공시 메시지 자동발송 실행
				}
			},
			error: console.log
		});  
	}
	
	<!-- 자동발송msg -->
	function sendAutoMsg(orderNo, statusNo) {
		
		console.log("======자동발송msg 함수 실행되나?======");
		
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/comm/sendMsg",
			headers: {
				"${_csrf.headerName}" : "${_csrf.token}"
			},
			method: "POST",
			data: {
				orderNo : orderNo,
				statusNo : statusNo
			},
			success: function(data){
				if(data > 0) {
					console.log("메시지 자동 발송 성공");
				}
			},
			error: console.log
		});
	}
	
	/* 모달창 --> 관리자 메모 업데이트 */
	function updateAdminMemo(orderInfoNo){
		$.ajax({
			//url: `\${restServerUrl}/menus`,
			url:`${pageContext.request.contextPath}/admin/order/updateAdminMemo`,
			data:{
				orderInfoNo : orderInfoNo,
				memo : $("#memo").val()
			},
			method: "GET",
			success(data){
				console.log(data)
				if(data > 0){
					alert('관리자 메모가 업데이트 되었습니다.');
				}
			},
			error: console.log
		});  
	}
	
	
	function selectAction(){
		if($("select[name=order_status]").val() == '' & $("select[name=payment_type]").val() == '' & $("input[name=keyword]").val() == '' & ($("input[name=start_date]").val() == '' & $("input[name=end_date]").val() == '')){
			return false;
		}else{
			$(document["form_search"]).submit();
		}
		
	}

	function setSearchDate(type){
		$("input[name=start_date]").val(dateStr(type));
		$("input[name=end_date]").val(dateStr('D0'));

		
	}
	/* 날짜 포맷팅 */
	function dateStr(type){
		var date = new Date();
		i = type.slice(1,3) * 1;
		if(type.slice(0,1) == 'D'){
			console.log(date)
			date = new Date(date - (60 * 60 * 24 * 1000 * i)/2);
			console.log(date)
			
		}else if(type.slice(0,1) == 'M'){
			date.setMonth(date.getMonth() - i);
		}
			var year = date.getFullYear();
			var month = ('0' + (date.getMonth() + 1)).slice(-2);
			var day = ('0' + (date.getDate() - i)).slice(-2);
			var dateString = year + '-' + month  + '-' + day;	
		return dateString;
	}
	


/* downloadExcel() --> 구현 후 common.js로 이동 */
 
        function downloadExcel() {
            form_download.target = 'iframe_process';
            form_download.search_data.value = $('#form_search').serialize();
            form_download.submit();
        }


</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>