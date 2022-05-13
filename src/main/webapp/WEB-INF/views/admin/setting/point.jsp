<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="적립금 설정" name="title"/>
</jsp:include>

<!-- content-wrapper -->
<div class="content-wrapper">
<section class="content-header">
    <h1>
    적립금 설정
    <small>point</small>
    </h1>

    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li>설정</li>
        <li class="active">적립금 설정</li>
    </ol>
</section>

<section class="content">
<div class="row">
    <div class="col-xs-12">
        <div class="box">
            <div class="box-body">
                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 기본 설정</p></h4>
					<form name="form_register" method="post" action="${pageContext.request.contextPath }/admin/point/updatePoints?${_csrf.parameterName}=${_csrf.token}">
						<table class="table table-bordered">
							<tbody>
								<tr>
									<td class="menu">사용 여부</td>
									<td align="left">
										<input type="radio" name="pointUseType" value="Y" ${point.pointUseType == 'Y' ? 'checked' : '' }>사용&nbsp;&nbsp; 
										<input type="radio" name="pointUseType" value="N" ${point.pointUseType == 'N' ? 'checked' : '' }>사용안함
									</td>
								</tr>
								<tr>
									<td class="menu">단위 설정</td>
									<td align="left">
										<span style="float: left;">
											<input type="text" name="pointName" value="${point.pointName }" class="form-control input-sm" style="width: 100px;">
										</span>&nbsp;
										<span style="line-height: 2.0;">
											<small class="text-red">적립금 뒤에 표출될 단위 설정</small>
										</span>
									</td>
										
								</tr>
							</tbody>
						</table>
						<br>

						<h4>
							<p class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 지급 설정
							</p>
						</h4>
						<table class="table table-bordered">
							<tbody>
								<tr>
									<td class="menu">회원 가입</td>
									<td align="left">
										<span style="float: left;">
											<input type="text" name="pointMemberAmount" value="<fmt:formatNumber value="${pointSave.pointMemberAmount}" pattern="#,###" />" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="width: 100px; text-align: right;">
										</span>&nbsp; 
										<span style="line-height: 2.0;"> 
											<small class="text-red">회원 가입시 적립</small>
										</span>
									</td>
								</tr>
								<tr>
									<td class="menu">제품 후기 등록</td>
									<td align="left">
										<span style="float: left;">
											<input type="text" name="pointMemoAmount" value="<fmt:formatNumber value="${pointSave.pointMemoAmount}" pattern="#,###" />" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="text-align: right; width: 100px;">
										</span>&nbsp; 
										<span style="line-height: 2.0;"> 
											<small class="text-red">구매한 제품의 후기 등록시 지급</small>
										</span>
									</td>
								</tr>
								<tr>
									<td class="menu">상품구매시 적립</td>
									<td align="left">
										<span style="float: left;">
											<input type="radio" name="pointType" value="${pointSave.pointType }" checked>일괄&nbsp;&nbsp;
										</span> 
										<span style="float: left;">
											<input type="text" name="pointRate" value="${pointSave.pointRate }" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="width: 80px; text-align: right;">
										</span> 
										<span style="float: left; line-height: 2.0;">% 
											<small class="text-red">상품 금액의 OO%를 지급 (소숫점 이하 버림)</small>
										</span>
										<br>
										<br> 
										<span style="float: left;">
											<input type="radio" name="pointType" value="${pointSave.pointType }"> 개별
											<small class="text-red">상품마다 적립금을 개별로 지정할수 있음 (제품 > 리스트 > 상품 등록에서 설정)</small>
										</span>
									</td>
								</tr>
								<tr>
									<td class="menu">동시 적립 여부</td>
									<td align="left">
										<input type="radio" name="pointUseReceive" value="Y" ${pointSave.pointUseReceive == 'Y' ? 'checked' : '' }>적립&nbsp;&nbsp; 
										<input type="radio" name="pointUseReceive" value="N" ${pointSave.pointUseReceive == 'N' ? 'checked' : '' }>미적립 
										<small class="text-red">적립금 사용시에도 적립금을 적립 여부</small>
									</td>
								</tr>
							</tbody>
						</table>
						<br>

						<h4>
							<p class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 사용 설정
							</p>
						</h4>
						<table class="table table-bordered">
							<tbody>
								<tr>
									<td class="menu">사용 단위</td>
									<td align="left">
										<span style="float: left;">
											<input type="text" name="pointUnit" value="<fmt:formatNumber value="${pointUse.pointUnit}" pattern="#,###" />" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="width: 100px; text-align: right;">
										</span>&nbsp; 
										<span style="line-height: 2.0;">
											<small class="text-red">적립금 사용시 OO 단위로 사용</small>
										</span>
									</td>
								</tr>
								<tr>
									<td class="menu">사용 가능 적립금액</td>
									<td align="left">
										<span style="float: left;">
											<input type="text" name="pointLimitUsePoint" value="<fmt:formatNumber value="${pointUse.pointLimitUsePoint}" pattern="#,###" />" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="width: 100px; text-align: right;">
										</span>&nbsp; 
										<span style="line-height: 2.0;"> 
											<small class="text-red">적립금이 OO 이상일때 사용 가능</small>
										</span>
									</td>
								</tr>
								<tr>
									<td class="menu">사용 가능<br>최소 결제금액
									</td>
									<td align="left">
										<span style="float: left;">
											<input type="text" name="pointLimitUseAmount" value="<fmt:formatNumber value="${pointUse.pointLimitUseAmount}" pattern="#,###" />" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="width: 100px; text-align: right">
										</span>&nbsp; 
										<span style="line-height: 2.0;">
											<small class="text-red">결제금액이 OO 이상일때 사용 가능</small>
										</span>
									</td>
								</tr>
								<tr>
									<td class="menu">사용 가능 일수</td>
									<td align="left">
										<span style="float: left;">
											<input type="text" name="pointLimitUseDay" value="${pointUse.pointLimitUseDay }" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="width: 100px; text-align: right">
										</span>&nbsp; 
										<span style="line-height: 2.0;">
											<small class="text-red">적립금 받은 날로부터 O일 경과후 사용 가능 (취소, 환불시 해당 적립금 삭제 처리)</small>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<br>

                <div style="text-align:center;">
                	<button type="button" onclick="register()" class="btn btn-primary">확인</button>
                </div>

                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>
</div><!-- /.content-wrapper -->

<script>
function register() {
    if (!$("input[name='pointUseType']").is(':checked')) { alert('사용 여부가 선택되지 않았습니다.'); return false;}
    if(form_register.pointName.value == '') { alert('단위 설정이 입력되지 않았습니다.'); form_register.pointName.focus(); return false;}
    if (!$("input[name='pointType']").is(':checked')) { alert('상품구매시 적립 방법이 선택되지 않았습니다.'); return false;}
    if($("input[name='pointType']:checked").val() == 'b' && form_register.point_rate.value == '') { alert('일괄 적립률이 입력되지 않았습니다.'); form_register.pointRate.focus(); return false;}
    if(form_register.pointLimitUseDay.value == '') { alert('사용 가능 일수가 입력되지 않았습니다.'); form_register.pointLimitUseDay.focus(); return false;}
    form_register.target = 'iframe_process';
    $('[name=pointMemberAmount]').val($('[name=pointMemberAmount]').val().replace(',',''));
    $('[name=pointMemoAmount]').val($('[name=pointMemoAmount]').val().replace(',',''));
    $('[name=pointUnit]').val($('[name=pointUnit]').val().replace(',',''));
    $('[name=pointLimitUsePoint]').val($('[name=pointLimitUsePoint]').val().replace(',',''));
    $('[name=pointLimitUseAmount]').val($('[name=pointLimitUseAmount]').val().replace(',',''));
    form_register.submit();
}

</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>