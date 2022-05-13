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
	<jsp:param value="회원 접속이력 관리" name="title" />
</jsp:include>


<!-- content-wrapper -->
<div class="content-wrapper">
	<link href="https://mir9.co.kr/resource/css/s9jss_single.css"
		rel="stylesheet">
	<style>
.ui-menu {
	z-index: 9999;
	width: 400px;
}
</style>

	<section class="content-header">
	<h1>
		회원 접속이력 관리 <small>member access history</small>
	</h1>

	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"> Home</i></a></li>
		<li>회원 관리</li>
		<li class="active">회원 접속이력 관리</li>
	</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">
					<label id="countContainer" style="margin-top: 5px;">총 ${totalAccessHistoryCount} 건</label>
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<div class="has-feedback">
							<span> <input type="text" name="keyword" id="keyword"
								value="" class="form-control input-sm" placeholder="검색" /> <span
								class="glyphicon glyphicon-search form-control-feedback"></span>
							</span>
						</div>
					</div>
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<div class="has-feedback">
							<select name="type" class="form-control input-sm">
								<option value="access_history_id">아이디</option>
								<option value="access_history_name">이름</option>
								<option value="access_history_ip">IP 주소</option>
							</select>
						</div>
					</div>
				<form:form id="accessHistoryDeleteFrm" name="accessHistoryDeleteFrm" action="${pageContext.request.contextPath}/admin/member/accessHistoryDelete.do" method="POST">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<table class="table table-bordered table-hover checkbox-group">
							<thead>
								<tr>
									<td style="width: 30px;"><input type="checkbox" name="select_all" id="checkAll" /></td>
									<td style="width: 60px;">NO</td>
									<td style="width: 110px;">아이디</td>
									<td style="width: 110px;">이름</td>
									<td style="width: 110px;">접속 IP</td>
									<td style="width: 110px;">상태</td>
									<td style="width: 110px;">일시</td>
								</tr>
							</thead>
							<tbody id = "tbody">
								<c:forEach items="${memberAccessHistoryList}" var="history" varStatus="status" >
									<tr>
										<td style="width: 30px;"><input type="checkbox" class="member-is-checked" name="" value="${history.accessHistoryNo}" data-target="${history.accessHistoryNo}" /></td>
										<td style="width: 60px;">${history.accessHistoryNo}</td>
										<td style="width: 110px;">${history.accessHistoryId}</td>
										<td style="width: 110px;">${history.accessHistoryName}</td>
										<td style="width: 110px;">${history.accessHistoryIp}</td>
										<td style="width: 110px;">${history.accessHistoryStatus}</td>
										<td style="width: 110px;"><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${history.loginDate}" /></td>
									</tr>
								</c:forEach>
							</tbody>		
					</table>
					</form:form>
					<br>
					<button type="button"
						id = "accessHistoryDeleteBtn"
						class="btn btn-danger">
						<i class="fa fa-minus-square"></i> 선택삭제
					</button>
					<button type="button" onclick="downloadExcel();"
						class="btn btn-warning" style="margin-left: 20px;">
						<i class="fa" aria-hidden="true"></i> Excel 다운로드
					</button>
					<form name="form_download" method="post" action="${pageContext.request.contextPath }/excel/download.do?${_csrf.parameterName}=${_csrf.token}">
						<input type="hidden" name="mode" value="downloadExcel"> <input type="hidden" name="search_data"> <input type="hidden" name="download_type" value="memberAccessHistoryList">
					</form>
					<div style="text-align: right;">
						<ul class="pagination" style="margin: 0;">
							<li class="active"><a href="?tpf=admin/member/log&page=1">1</a></li>
							<li><a href="?tpf=admin/member/log&page=2">2</a></li>
							<li><a href="?tpf=admin/member/log&page=3">3</a></li>
							<li><a href="?tpf=admin/member/log&page=4">4</a></li>
							<li><a href="?tpf=admin/member/log&page=5">5</a></li>
							<li class="next"><a href="?tpf=admin/member/log&page=6">Next
									→ </a></li>
							<li><a href="?tpf=admin/member/log&page=46">Last → </a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
</div>
<!-- /.content-wrapper -->
<script>
// 타입별 검색
$(document).ready(function(){
	// Enter Event
	$("#keyword").keydown(function(keyNum){
		var keyword = $('input[name=keyword]').val();
		var type = $('select[name=type]').val();
		
		if(keyNum.keyCode == 13){
			console.log("Enter Event! - 타입별 검색");
			console.log("keyword = " + keyword);
			console.log("type = " + type);
			
			const search = {
				"type" : type,
				"keyword" : keyword
			};
			
		
			$.ajax({
				type : "GET",
				url : `${pageContext.request.contextPath}/admin/member/typeSearchByAcceessHistory.do`,
				data : search,
				contentType : "application/json; charset=utf-8",
				success(data){
					console.log("ajaxData = " + JSON.stringify(data));
					
					$("#tbody").html('');
					
					$.each(data.searchAccessHistoryList, (k, v) => {
						$("#tbody").append(`
								<tr>
								<td style="width: 30px;"><input type="checkbox" class="member-is-checked" name="" value="\${v.accessHistoryNo}" data-target="\${v.accessHistoryNo}" /></td>
								<td style="width: 60px;">\${v.accessHistoryNo}</td>
								<td style="width: 110px;">\${v.accessHistoryId}</td>
								<td style="width: 110px;">\${v.accessHistoryName}</td>
								<td style="width: 110px;">\${v.accessHistoryIp}</td>
								<td style="width: 110px;">\${v.accessHistoryStatus}</td>
								<td style="width: 110px;">\${v.loginDate}</td>
							</tr>
								`);
					});
					$("#countContainer").html('');
					$("#countContainer").html(`<label style="margin-top: 5px;">총 \${data["searchHistoryListCount"]} 건</label>`)
				}
			});
		};
	});
});
	
// 체크박스 전체 선택
$(".checkbox-group").on("click", "#checkAll", ((e)=>{
	let checked = $(e.target).is(":checked");
	console.log("전체 선택 : " + checked);
	if(checked){
		$(e.target).parents(".checkbox-group").find("input:checkbox").prop("checked", true);
	} else {
		$(e.target).parents(".checkbox-group").find("input:checkbox").prop("checked", false);
	}
}));
//체크박스 개별 선택
$(document).on("click", ".member-is-checked", function(){
	let isChecked = true;
	console.log("개별 선택 : " + isChecked);
	
	$(".member-is-checked").each((i, item)=>{
		isChecked = isChecked && $(item).is(":checked");
		console.log("i : " + i);
		//console.log(item);
		console.log($(item).is(":checked"));
	});
	
	$("#checkAll").prop("checked", isChecked);	
});
//선택삭제
$(document).on("click", "#accessHistoryDeleteBtn", function(){
	let isChecked = false;
	
	$(".member-is-checked").each((i, item)=>{
		isChecked = isChecked || $(item).is(":checked");
		let target = $(item).data("target");
		console.log("target = ", target); // target = accessHistoryNo
		
		if($(item).is(":checked")){
			$(item).after(`<input type="hidden" name="accessHistoryNo" value="\${target}"/>`);
		}
	});
	
	if(!isChecked){
		alert("선택된 목록이 없습니다.");
		return;
	}
	
	console.log("클릭");
	console.log($(document.accessHistoryDeleteFrm));
	if(confirm("선택된 회원을 삭제하시겠습니까?"))
		$(document.accessHistoryDeleteFrm).submit();
});

//Excel 다운로드
function downloadExcel() {  
	console.log("엑셀 다운로드");
    form_download.target = 'iframe_process';
    form_download.search_data.value = $('#form_search :input').serialize();
    form_download.submit();
}

</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>