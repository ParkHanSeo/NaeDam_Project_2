<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="배송 설정" name="title"/>
</jsp:include>

<!-- content-wrapper -->
<div class="content-wrapper">
<section class="content-header">
    <h1>
    배송 설정
    <small>Delivery setting</small>
    </h1>

    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li>설정</li>
        <li class="active">배송 설정</li>
    </ol>
</section>

<section class="content">
<div class="row">
    <div class="col-xs-12">
        <div class="box">
            <div class="box-body">
				<form name="form_register" method="post" action="/index.php?tpf=admin/setting/process">
				<input type="hidden" name="mode" value="updateDeliverySetting">

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 기본 설정</p></h4>
                <table class="table table-bordered">
                <tbody>
				<tr>
                    <td class="menu">기본 배송비</td>
                    <td align="left">
                    <span style="float:left;"><input type="text" name="delivery_price" value="<fmt:formatNumber value="${deliverySetting.basicDeliveryFee }" pattern="#,###" />" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="width:100px; text-align:right;" maxlength="7" /></span>
                    </td>
                </tr>
                <tr>
                    <td class="menu">무료배송 설정</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="delivery_limit" value="<fmt:formatNumber value="${deliverySetting.freeShippingSettings }" pattern="#,###" />" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="text-align:right; width:100px;"></span>&nbsp;
                        <span style="line-height:2.0;"> <small class="text-red">총 상품금액이 설정된 금액 이상이면 무료배송됨.</small></span>
                    </td>
                </tr>
                <tr>
                    <td class="menu">도서산간 추가배송료 사용 여부</td>
                    <td align="left">
                    <input type="radio" name="delivery_extra_cost_area" value="Y" ${deliverySetting.extraDeliFeeYn == 'Y' ? 'checked' : '' } onclick="changeDeliveryExtraCostArea(this.value)" />사용&nbsp;&nbsp;
                    <input type="radio" name="delivery_extra_cost_area" value="N" ${deliverySetting.extraDeliFeeYn == 'N' ? 'checked' : '' } onclick="changeDeliveryExtraCostArea(this.value)" />사용안함
                    </td>
                </tr>
                </tbody>
                </table>
                <br>
				
				<div id="extra_cost_div" style="">
					<h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 도서산간 추가배송비 설정</p></h4>
					<label style="margin-top:5px;">총 37 건</label>
					<table class="table table-bordered table-hover" style="margin-bottom:0;">
						<colgroup>
							<col width="100px" />
							<col width="300px" />
							<col width="600px" />
							<col width="*" />
						</colgroup>
						<thead>
						<tr>
							<td >NO</td>
							<td >우편번호</td>
							<td >지역명</td>
							<td >추가배송비</td>
						</tr>
						</thead>
					</table>
					<div style="overflow:scroll; width:100%; height:350px;">
					<table class="table table-bordered table-hover" style="margin-bottom:0;">
						<colgroup>
							<col width="100px" />
							<col width="300px" />
							<col width="600px" />
							<col width="*" />
						</colgroup>
						<c:forEach var="doseo" items="${doseosanganList }">
							<tr>
								<td>${doseo.doseoNo }</td>
								<td>${doseo.startZipcode } ~ ${doseo.endZipcode }</td>
								<td>${doseo.region }</td>
								<td>
									<input type="hidden" name="doseo_no" value="${doseo.doseoNo }" />
									<input type="text" name="extra_fee" value="<fmt:formatNumber value="${doseo.extraFee }" pattern="#,###" />" onkeyup="this.value=displayComma(checkNum(this.value))" class="form-control input-sm" style="text-align:right; width:150px;" maxlength="7" />
								</td>
							</tr>
						</c:forEach>
						
					</table>
					</div>
					<br>
				</div>
                <div style="text-align:center;"><button type="button" onclick="register()" class="btn btn-primary">확인</button></div>
				</form>
                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>
</div><!-- /.content-wrapper -->

<script>
function register(){
	const formData = new FormData(document["form_register"]);
	var obj = {};
	for(const [k, v] of formData){
		obj[k] = v;
	};
	
	obj.doseo_no = [];
	obj.extra_fee = [];
	$.each($("input[name=doseo_no]"), (idex, value)=>{
		 obj.doseo_no.push($(value).val());
	});
	$.each($("input[name=extra_fee]"), (idex, value)=>{
		 obj.extra_fee.push($(value).val());
	});
	
	const jsonStr = JSON.stringify(obj);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/delivery/updateDeliSet_Doseo",
		method:"get",
		data: {
			jsonStr : jsonStr
		},
		contentType: "application/json; charset=utf-8",
		success(data){
			if(data > 0){
				alert("배송 설정이 변경되었습니다.");
			}

		},
		error:console.log
	});	
}
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>