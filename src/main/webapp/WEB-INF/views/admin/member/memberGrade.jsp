<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="등급 관리" name="title" />
</jsp:include>

<!-- content-wrapper -->
<div class="content-wrapper">
	
	<section class="content-header">
	<h1>등급 관리 <small>grade list</small></h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li>회원 관리</li>
		<li class="active">등급 관리</li>
	</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">
					<form:form id="memberGradeUpdateFrm" name="memberGradeUpdateFrm">
						<table class="table table-bordered table-hover" style="width: 30%;">
							<thead>
								<tr>
									<td style="width: 60px;">등급</td>
									<td>명칭</td>
									<td style="width: 80px;">회원수</td>
								</tr>
							</thead>
							<tbody id = "tbody">
								<c:forEach items="${memberGradeList}" var="memberGrade" varStatus="status">
									<tr>
										<td>${memberGrade.memberGradeNo}
										<td>
											<input type="text" id="memberGradeName_${memberGrade.memberGradeNo}" name="memberGradeName" value="${memberGrade.memberGradeName}" class="form-control input-sm" style="width: 100%;" />
											<input type="hidden" id="memberGradeNo_${memberGrade.memberGradeNo}" name="memberGradeNo" value="${memberGrade.memberGradeNo}" />
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</td>
										<td>${memberGrade.memberGradeCount}</td>
									</tr>
								</c:forEach>
							</tbody>		
						</table>
						<br>
						<button type="button" onclick="memberGradeUpdate()" class="btn btn-primary btn-sm">
							<i class="fa fa-gear"></i> 등급 수정
						</button>
					</form:form>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
		</div>
		<!-- /.col-xs-12 -->
	</div>
	<!-- /.row --> </section>
</div>
<!-- /.content-wrapper -->

<script>
// 등급 수정
function memberGradeUpdate(){	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	// memberGradeNo 배열
	var memberGradeNoList = new Array();
	$("input[name=memberGradeNo]").each(function(index, item){
		memberGradeNoList.push($(item).val());
	});
	
	// memberGradeName 배열
	var memberGradeNameList = new Array();
	$("input[name=memberGradeName]").each(function(index, item){
		memberGradeNameList.push($(item).val());
	});
	
	const keys = memberGradeNoList;
	const values = memberGradeNameList;
	const result = keys.reduce((acc, curr, idx) => {
		acc[curr] = values[idx];
		return acc;
	}, new Object);
	
	const data = JSON.stringify(result);
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/member/memberGradeUpdate.do`,
		method : "POST",
		data : data,
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		success(data){
			console.log(data);
			alert("등급이 수정 되었습니다.");
			location.reload();
		}, 
		error : console.log
	});
};

// 첫번 째 input 태그 readonly로 설정
document.getElementById('memberGradeName_1').readOnly = true;
// 두번 째 input 태그 readonly로 설정
document.getElementById('memberGradeName_2').readOnly = true;
</script>
<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>