<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="메일 설정" name="title"/>
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- content-wrapper -->
<div class="content-wrapper">
<style>
textarea {
    width:180px;
    height:100px;
}
</style>

	<section class="content-header">
	    <h1>
	    	메일 설정
	    	<small>sms setting</small>
	    </h1>
	
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li>커뮤니티 관리</li>
	        <li class="active">메일 설정</li>
	    </ol>
	</section>
	
	<section class="content">
		<div class="row">
		    <div class="col-xs-12">
		        <div class="box">
		            <div class="box-body">
		                <form name="form_register">
			                <input type="hidden" name="locale" value="ko">
							<h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 메일 발송 문구 설정 </p></h4>
			                <div style="text-align:right;">
								<button type="button" id="locale_ko" onclick="parent.location.href='${pageContext.request.contextPath}/admin/comm/email?locale=ko'" class="btn btn-primary"><i class="fa fa-globe" aria-hidden="true"></i> 한국어</button>
								<button type="button" id="locale_en" onclick="parent.location.href='${pageContext.request.contextPath}/admin/comm/email?locale=en'" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> ENG</button>
								<button type="button" id="locale_zh" onclick="parent.location.href='${pageContext.request.contextPath}/admin/comm/email?locale=zh'" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> 中国</button>
								<button type="button" id="locale_vn" onclick="parent.location.href='${pageContext.request.contextPath}/admin/comm/email?locale=vn'" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> Tiếng việt</button>                
							</div></br>
							<table class="table table-bordered table-hover">
								<thead>
				                    <tr>
				                        <td rowspan="3" class="menu" style="width:350px;">발송항목</td>
										<td colspan="4">발송대상 및 메일 문구설정</td>
										<td rowspan="3" class="menu" style="width:350px;">치환문구 설명</td>
				                    </tr>
									<tr>
				                        <td colspan="2">회원</td>
										<td colspan="2">관리자</td>
				                    </tr>
				                    <tr>
				                        <td>자동발송</td>
										<td>문구</td>
				                        <td>자동발송</td>
										<td>문구</td>
				                    </tr>
				                </thead>
				                <tbody>
				      				<tr>
					                    <input type="hidden" class="join" name="code" value="join" />
										<td class="content">회원가입</td>
					                    <td class="content">
					                    	<input type="checkbox" class="join" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('join');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="join" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('join_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>
												<li>##shop_name## : 사이트명</li> <li>##user_name## : 회원명</li> <li>##user_id## : 회원 아이디</li>			    
											</ul>
										</td>
				               		</tr>      
				               		<tr>
					                    <input type="hidden" class="findid" name="code" value="findid" />
										<td class="content">아이디 찾기<br>[아이디 찾기시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="findid" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('findid');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="findid" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('findid_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##user_name## : 회원명</li> <li>##user_id## : 회원 아이디</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="findpw" name="code" value="findpw" />
										<td class="content">임시비밀번호 발급알림<br>[비밀번호 찾기시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="findpw" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('findpw');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="findpw" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('findpw_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##user_id## : 회원 아이디</li> <li>##tmp_password## : 임시비밀번호</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="order" name="code" value="order" />
										<td class="content">주문접수<br>[무통장/카드 결제시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="order" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('order');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="order" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('order_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##payment_status## : 결제 상태</li> <li>##order_number## : 주문번호</li>		    
												<li>##order_date## : 주문 일자</li> <li>##order_first_name## : 주문자 성</li> <li>##order_name## : 주문자명</li>		    
												<li>##order_email## : 주문자 이메일</li> <li>##order_mobile## : 주문자 휴대폰 번호</li> <li>##order_list## : 주문 내역</li>		    
												<li>##receiver_first_name## : 수신자 성</li> <li>##receiver_name## : 수신자 이름</li> <li>##receiver_email## : 수신자 이메일</li>		    
												<li>##receiver_mobile## : 수신자 휴대폰 번호</li> <li>##receiver_addr## : 수신자 주소</li> <li>##request_message## : 요청 메세지</li>		    
												<li>##payment_info## : 결제 정보</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="pay_done" name="code" value="pay_done" />
										<td class="content">입금확인<br>[무통장 입금 완료시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="pay_done" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('pay_done');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="pay_done" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('pay_done_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>
												<li>##shop_name## : 사이트명</li> <li>##payment_status## : 결제 상태</li> <li>##order_number## : 주문번호</li>		    
												<li>##order_date## : 주문 일자</li> <li>##order_first_name## : 주문자 성</li> <li>##order_name## : 주문자명</li>
												<li>##order_email## : 주문자 이메일</li> <li>##order_mobile## : 주문자 휴대폰 번호</li> <li>##order_list## : 주문 내역</li>		    
												<li>##receiver_first_name## : 수신자 성</li> <li>##receiver_name## : 수신자 이름</li> <li>##receiver_email## : 수신자 이메일</li>		    
												<li>##receiver_mobile## : 수신자 휴대폰 번호</li> <li>##receiver_addr## : 수신자 주소</li> <li>##request_message## : 요청 메세지</li>		    
												<li>##payment_info## : 결제 정보</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="delivery_ready" name="code" value="delivery_ready" />
										<td class="content">상품 배송 준비중<br>[주문상태 배송준비중으로 변경시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="delivery_ready" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('delivery_ready');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="delivery_ready" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('delivery_ready_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##payment_status## : 결제 상태</li> <li>##order_number## : 주문번호</li>		    
												<li>##order_date## : 주문 일자</li> <li>##order_first_name## : 주문자 성</li> <li>##order_name## : 주문자명</li>		    
												<li>##order_email## : 주문자 이메일</li> <li>##order_mobile## : 주문자 휴대폰 번호</li> <li>##order_list## : 주문 내역</li>		    
												<li>##receiver_first_name## : 수신자 성</li> <li>##receiver_name## : 수신자 이름</li> <li>##receiver_email## : 수신자 이메일</li>		    
												<li>##receiver_mobile## : 수신자 휴대폰 번호</li> <li>##receiver_addr## : 수신자 주소</li> <li>##request_message## : 요청 메세지</li>		    
												<li>##payment_info## : 결제 정보</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="delivery_ing" name="code" value="delivery_ing" />
										<td class="content">상품 배송중<br>[주문상태 배송중으로 변경시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="delivery_ing" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('delivery_ing');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="delivery_ing" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('delivery_ing_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##payment_status## : 결제 상태</li> <li>##order_number## : 주문번호</li>
												<li>##order_date## : 주문 일자</li> <li>##order_first_name## : 주문자 성</li> <li>##order_name## : 주문자명</li>
												<li>##order_email## : 주문자 이메일</li>	<li>##order_mobile## : 주문자 휴대폰 번호</li> <li>##order_list## : 주문 내역</li>		    
												<li>##receiver_first_name## : 수신자 성</li> <li>##receiver_name## : 수신자 이름</li> <li>##receiver_email## : 수신자 이메일</li>
												<li>##receiver_mobile## : 수신자 휴대폰 번호</li> <li>##receiver_addr## : 수신자 주소</li> <li>##request_message## : 요청 메세지</li>
												<li>##payment_info## : 결제 정보</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="delivery_done" name="code" value="delivery_done" />
										<td class="content">상품 배송 완료<br>[주문상태 배송완료로 변경시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="delivery_done" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('delivery_done');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="delivery_done" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('delivery_done_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##payment_status## : 결제 상태</li> <li>##order_number## : 주문번호</li>		    
												<li>##order_date## : 주문 일자</li>	 <li>##order_first_name## : 주문자 성</li> <li>##order_name## : 주문자명</li>		    
												<li>##order_email## : 주문자 이메일</li> <li>##order_mobile## : 주문자 휴대폰 번호</li> <li>##order_list## : 주문 내역</li>		    
												<li>##receiver_first_name## : 수신자 성</li> <li>##receiver_name## : 수신자 이름</li> <li>##receiver_email## : 수신자 이메일</li>		    
												<li>##receiver_mobile## : 수신자 휴대폰 번호</li> <li>##receiver_addr## : 수신자 주소</li> <li>##request_message## : 요청 메세지</li>		    
												<li>##payment_info## : 결제 정보</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="order_cancel" name="code" value="order_cancel" />
										<td class="content">주문취소<br>[주문 취소시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="order_cancel" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('order_cancel');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="order_cancel" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('order_cancel_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##payment_status## : 결제 상태</li> <li>##order_number## : 주문번호</li>		    
												<li>##order_date## : 주문 일자</li> <li>##order_first_name## : 주문자 성</li> <li>##order_name## : 주문자명</li>		    
												<li>##order_email## : 주문자 이메일</li> <li>##order_mobile## : 주문자 휴대폰 번호</li> <li>##order_list## : 주문 내역</li>		    
												<li>##receiver_first_name## : 수신자 성</li> <li>##receiver_name## : 수신자 이름</li> <li>##receiver_email## : 수신자 이메일</li>		    
												<li>##receiver_mobile## : 수신자 휴대폰 번호</li> <li>##receiver_addr## : 수신자 주소</li> <li>##request_message## : 요청 메세지</li>		    
												<li>##payment_info## : 결제 정보</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="refund" name="code" value="refund" />
										<td class="content">환불완료<br>[주문상태 환불완료로 변경시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="refund" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('refund');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="refund" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('refund_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##payment_status## : 결제 상태</li> <li>##order_number## : 주문번호</li>		    
												<li>##order_date## : 주문 일자</li> <li>##order_first_name## : 주문자 성</li> <li>##order_name## : 주문자명</li>		    
												<li>##order_email## : 주문자 이메일</li> <li>##order_mobile## : 주문자 휴대폰 번호</li> <li>##order_list## : 주문 내역</li>		    
												<li>##receiver_first_name## : 수신자 성</li> <li>##receiver_name## : 수신자 이름</li> <li>##receiver_email## : 수신자 이메일</li>		    
												<li>##receiver_mobile## : 수신자 휴대폰 번호</li> <li>##receiver_addr## : 수신자 주소</li> <li>##request_message## : 요청 메세지</li>		    
												<li>##payment_info## : 결제 정보</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="point" name="code" value="point" />
										<td class="content">적립금 적립<br>[개별 적립금 적립시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="point" name="is_send" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('point');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="point" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('point_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##point## : 포인트</li> <li>##point_type## : 포인트 구분</li>			    
											</ul>
										</td>
					                </tr>      
					                <tr>
					                    <input type="hidden" class="coupon" name="code" value="coupon" />
										<td class="content">쿠폰 지급<br>[개별 쿠폰 지급시]</td>
					                    <td class="content">
					                    	<input type="checkbox" class="coupon" name="is_send"/>
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('coupon');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td class="content">
					                    	<input type="checkbox" class="coupon" name="is_send_admin" />
					                    </td>
					                    <td class="content">
					                    	<button type="button" onclick="onclickUpdate('coupon_admin');" class="btn btn-primary btn-xs">편집</button>
					                    </td>
					                    <td align="left">
											<ul>		    
												<li>##shop_name## : 사이트명</li> <li>##coupon_name## : 쿠폰명</li> <li>##date## : 유효기간</li>			    
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
	</section><!-- /.content -->

	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:1000px;">
	        <div class="modal-content">
	            <form name="formContent" id="formContent" method="post" action="${pageContext.request.contextPath}/admin/comm/load/emailModal" enctype="multipart/form-data">
		            <input type="hidden" name="action" id="action">
		            <input type="hidden" name="locale" id="locale" value="ko">
		            
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabelPortfolio">메일 문구설정 관리</h4>
		            </div>
		            <div class="modal-body">
		            	<h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 메일 문구설정</h4>
			            <table class="table table-bordered">
				            <tr>
				                <td class="menu">제목</td>
				                <td align="left">
				                	<span style="float:left;width:80%;">
				                		<input type="text" name="title" id="title" class="form-control input-sm">
				                	</span>
				                </td>
				            </tr>
				            <tr>
				                <td class="menu">내용</td>
				                <td align="left">
				                	<textarea name="content" id="content" rows="10" cols="80"></textarea>
				                </td>
				            </tr>
			            </table>
		            </div>
		            <div class="modal-footer">
			            <button type="button" onclick="registerContent()" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
			            <!-- getDefaultTemplate(type, action, is_admin) -->
			            <button type="button" onclick="getDefaultTemplate();" class="btn btn-warning">기본문구 가져오기</button>
		            </div>
	            </form>
	        </div><!-- / .modal-content -->
	    </div><!-- / .modal-dialog -->
	</div><!-- / .modal -->
</div><!-- /.content-wrapper -->

<script src="//mir9.co.kr/resource/js/ckeditor4.7.2/ckeditor.js"></script>

<script type="text/javascript">	
	// CHEDITOR
	var objEditor = CKEDITOR.replace('content', {
		height: 300,
	    extraPlugins : 'tableresize',
	    filebrowserUploadUrl: '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
	    filebrowserImageUploadUrl: '/daemon/ckeditor_upload.php?command=QuickUpload&type=Images',
	    fillEmptyBlocks : true,
	    line_height : '0px'
	});
	
	CKEDITOR.on('dialogDefinition', function (ev) {
	    var dialogName = ev.data.name;
	    var dialog = ev.data.definition.dialog;
	    var dialogDefinition = ev.data.definition;
	
	    if (dialogName == 'image') {
	        dialog.on('show', function (obj) {
	            this.selectPage('Upload'); // 업로드탭으로 시작
	        });
	        dialogDefinition.removeContents('advanced'); // 자세히탭 제거
	        dialogDefinition.removeContents('Link'); // 링크탭 제거
	    }
	});
	
	CKEDITOR.config.allowedContent = true;

	// cheditor 값 넣기
	function setData(content){}
			
	// 체크박스 조회
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath }/admin/comm/load/emailAutoSendCheck",
			method : "GET",
			success : function(result) {
				var set = result.emailSetting;
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
	});
	
	// 문구 편집 버튼
	function onclickUpdate(action) {
		// 모달 열기
		$("#action").val(action.concat("_mod")); 
		$("#modalContent").modal({backdrop:"static", show:true});

		// 저장문구 조회
		$.ajax({
			url : "${pageContext.request.contextPath }/admin/comm/load/savedEmail",
			method : "GET",
			data : { templateId : $("#action").val() },
			success : function(result) {
				var set = result.savedEmail;
				$("#title").val(set.title); 
				objEditor.setData(set.content); 
			}
		});
	}
	
	// 기존 양식 불러오기
	function getDefaultTemplate() {
		// 기본문구 조회
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/comm/load/originEmail", 
			type : "GET",
			data : { templateId : $("#action").val() },
			success : function(result){
				var set = result.originEmail;
				if(set.title.length > 0 && set.content.length > 0) { 
					if(confirm("기본 문구로 적용하시겠습니까?")) {
						$("#title").val(set.title); 
						objEditor.setData(set.content);
					}
				}
			}
		});
	}
	
	// 문구 저장 버튼
	function registerContent() {
		var templateId = $("#action").val();
		var title = $("#title").val();
		var content = objEditor.getData();
		
		if(title == "") { // 제목 입력 필수
	    	alert("제목이 입력되지 않았습니다."); 
	    	$("#title").focus(); 
	    	return false;
	    }
	    	     
	    if(content == "") { // 내용 입력 필수
	    	alert("내용이 입력되지 않았습니다.");
	    	return false;
	    }
	    
		var data = {
			templateId : templateId,
			title : title,
			content : content
		};
		var jsonStr = JSON.stringify(data);
		
		// 변경 저장
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/comm/load/emailModalModify", 
			method : "POST",
			headers : {"${_csrf.headerName}" : "${_csrf.token}"},
			contentType : "application/json;charset=utf-8",
			data : jsonStr,
			success : function(result){
				var set = result.emailModalModify;
				if(set > 0) {
					alert("'" + category_txt(templateId) + "' 발송 문구를 수정했습니다.");
					location.reload();
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
		var code = []; 
		var isSend = [];
		
		// 값 담기
		$.each($("input[name='code']"), function() { 
			code.push($(this).val());
		});
		$.each($("input[name='is_send'], input[name='is_send_admin']"), function() {
			isSend.push($(this).val()); 
		});
		
		// 설정 저장
		var data = { 
			code : code, 
			isSend : isSend 
		};
		var jsonStr = JSON.stringify(data);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/comm/load/emailSettingModify",
			method : "POST",
			headers : {"${_csrf.headerName}" : "${_csrf.token}"},
			contentType : "application/json;charset=utf-8",
			data : jsonStr,
			success : function(result) {
				var set = result.modify;
				if(set == "success") {
					alert("메일 설정이 수정되었습니다.");
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