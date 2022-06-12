<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="" name="title" />
</jsp:include>

<link href="https://mir9.co.kr/resource/css/s9soft_juso.css" rel="stylesheet">
<style>
	.ui-menu {
		z-index: 9999;
		width: 400px;
	}
</style>

<div class="content-wrapper">
	<section class="content-header">
		<h1>
			택배사 관리 
			<small>member list</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>택배사 관리</li>
			<li class="active">택배사 리스트</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<label id="companyListCnt" style="margin-top: 5px;">총 ${companyListCnt } 건</label>
						<form name="form_search" method="post" action="" onsubmit="return false"> 
							<div class="box-tools pull-right" style="margin-bottom: 5px;">
								<div class="has-feedback">
									<span> 
										<input type="text" name="keyword" id="keyword" value="" class="form-control input-sm" placeholder="검색" onkeyup="if(window.event.keyCode==13){search()}"/> 
										<span class="glyphicon glyphicon-search form-control-feedback"></span>
									</span>
								</div>
							</div>
							<div class="box-tools pull-right" style="margin-bottom: 5px;">
								<div class="has-feedback">
									<select name="field" class="form-control input-sm">
										<option value="deli_com_name">택배사명</option>
										<option value="trace_url">배송조회 url</option>
									</select>
								</div>
							</div>
						</form>
						<form name="form_list" method="post" action="/admin/delivery/deliveryCompanyProcess?${_csrf.parameterName}=${_csrf.token}">
							<table class="table table-bordered table-hover">
								<input type="hidden" name="mode" value="delete"/>
								<thead>
									<tr>
										<td style="width: 30px;"><input type="checkbox" name="select_all" onclick= "selectAllCheckBox( 'form_list');" /></td>
										<td style="width: 110px;">택배사</td>
										<td>배송조회 url</td>
										<td style="width: 140px;">등록일</td>
										<td style="width: 50px;">표출여부</td>
										<td style="width: 60px;">명령</td>
									</tr>
								</thead>
								<tbody id="delivery_company_list_tbody">
									<c:forEach var="company" items="${deliveryCompanyList }">
										<tr>
											<td><input type="checkbox" name="checkedNo" value="${company.deliComNo }" /></td>
											<td>${company.deliComName }</td>
											<td>${company.traceUrl }</td>
											<td><fmt:formatDate value="${company.regDate}"
													pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td>
												<c:choose>
													<c:when test="${company.showYn == 'Y' }">
														<span class="label label-success" style="font-size: 12px;">보임</span>
													</c:when>
													<c:otherwise>
														<span class="label label-default" style="font-size: 12px;">숨김</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<button type="button" onclick="onclickUpdate(${company.deliComNo});" class="btn btn-primary btn-xs">상세보기</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<input type="hidden" id="companyNoList" name="companyNoList"/>
						</form>
						<br>
						<button type="button" onclick="selectCompanyDelete();" class="btn btn-danger"> 
							<i class="fa fa-minus-square"></i> 선택삭제
						</button>
						<button type="button" onclick="onclickInsert();" class="btn btn-primary">등록</button>
						<!--    
						// 관리자단에서 택배사가입 숨김
	                    <button type="button" onclick="onclickSMS();" class="btn btn-danger"><i class="fa fa-bell"></i> SMS발송</button>
						-->
						<div style="text-align: right;">
							<? echo $data['page'];?>
						</div>
					</div><!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col-xs-12 -->
		</div><!-- /.row --> 
	</section><!-- /.content -->

	<!-- // 택배사 등록 폼 -->
	<div class="modal fade" id="modalRegister" tabindex="-2"; role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog" style="width: 620px;">
			<div class="modal-content">
				<form name="form" method="post" onsubmit="return false;" action="?tpf=admin/setting/delivery_company_process"> 
					<input type="hidden" name="deliComNo" value="0"/>
					<input type="hidden" name="mode" value="">
					<div class="modal-header"> 
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">택배사 등록</h4>
					</div>
					<div class="modal-body">
						<h4>
							<p class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 택배사정보
							</p>
						</h4>
						<table class="table table-bordered">
							<tr>
								<td class="menu">택배사명</td>
								<td align="left"><input type="text" name="deliComName" class="form-control input-sm" /></td>
							</tr>
							<tr>
								<td class="menu">배송조회 url</td>
								<td align="left"><input type="text" name="traceUrl" class="form-control input-sm" placeholder="http://" /></td>
							</tr>
							<tr id="display_status">
								<td class="menu">상태 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td>
									<select name="showYn" id="showYn" class="form-control input-sm" style="width: 120px;">
										<option value="Y">정상</option>
										<option value="N">대기</option>
									</select>
								</td>
							</tr>
							<tr id="display_reg_date">
								<td class="menu">등록일자</td>
								<td align="left"><span id="regDate"></span></td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button id="in_del_btn" type="button" onclick="register();" class="btn btn-primary">저장</button>
						<!--<button type="button" onclick="deleteCompany();" class="btn btn-danger">삭제</button>-->
					</div>
				</form>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal fade -->
</div><!-- /.content-wrapper -->

<script>
	/* 택배사 등록 모달 제어 */
	function onclickInsert(){
		$("input[name='mode']").val("insert");
		$(document["form"])[0].reset();
		$(modalRegister).modal('show');
	}
	
	/* 택배사 등록 */
	function register(type){
		if(type == null){
			const formData = new FormData(document["form"]);
			var obj = {};
			for(const [k, v] of formData){
				console.log(k)
				obj[k] = v;
			};
			
			$.ajax({
				url:"${pageContext.request.contextPath}/admin/delivery/deliveryCompanyProcess?${_csrf.parameterName}=${_csrf.token}",
				method:"post",
				data: obj,
				dataType: "json",
				success(data){
					if(data > 0){
						alert("택배사가 등록되었습니다.");
						location.reload();
					}
				},
				error:console.log
			});	
		}else{
			const formData = new FormData(document["form"]);
			var obj = {};
			for(const [k, v] of formData){
				obj[k] = v;
			};
			
			$.ajax({
				url:"${pageContext.request.contextPath}/admin/delivery/deliveryCompanyProcess?${_csrf.parameterName}=${_csrf.token}",
				method:"post",
				data: obj,
				dataType: "json",
				success(data){
					if(data > 0){
						alert("택배사 정보가 변경되었습니다.");
						location.reload();
					}
				},
				error:console.log
			});
		}
	}
	
	/* 택배사 삭제  --> common.js에 기술되어있으나 별도도 구현함. (selectDelete)*/
	function selectCompanyDelete(){
		if($("input:checkbox[name=checkedNo]:checked").length == 0){
			alert('항목을 선택하여야 합니다.');			
		}
		
		var checkedNo = new Array();
		var mode = "delete";
		
		$("input[name='checkedNo']:checked").each(function(){
			checkedNo.push($(this).val());
		});
		console.log(checkedNo)
		
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/delivery/deliveryCompanyProcess?${_csrf.parameterName}=${_csrf.token}",
			method:"post",
			data:{ 
				checkedNo : checkedNo,
				mode
			},
			success(data){
				if(data > 0){
					alert("택배사 정보가 삭제되었습니다.");
					location.reload();
				}
			},
			error:console.log
		});
	}
	
	/* 택배사 상세보기 */
	function onclickUpdate(deliveryCompanyNo){
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/delivery/companyDetail?${_csrf.parameterName}=${_csrf.token}",
			data : {
				comNo : deliveryCompanyNo
			},
			type : "post",
			success(data){
				var date = new Date(data.regDate);

				const formatDate = (current_datetime)=>{
				    let formatted_date = current_datetime.getFullYear() + "-" + (current_datetime.getMonth() + 1) + "-" + current_datetime.getDate() + " " + current_datetime.getHours() + ":" + current_datetime.getMinutes() + ":" + current_datetime.getSeconds();
				    return formatted_date;
				}
				console.log(data)
				
				$("input[name='mode']").val("update");
				$("input[name=deliComName]").val(data.deliComName);
				$("input[name=traceUrl]").val(data.traceUrl);
				$("#showYn").val(data.showYn);
				$("#regDate").text(formatDate(date));
				$("input[name=deliComNo]").val(data.deliComNo);
				$("#in_del_btn").attr('onclick', "register('update');");
			},
			error : console.log
		});
		$(modalRegister).modal('show');
	}
	
	/* 택배사 검색 */
	function search(){
		const formData = new FormData(document["form_search"]);
		var obj = {};
		for(const [k, v] of formData){
			obj[k] = v;
		};
		const jsonStr = JSON.stringify(obj);
		
		var cnt = 0;
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/delivery/companySearch",
			method:"get",
			data: {
				jsonStr : jsonStr
			},
			contentType: "application/json; charset=utf-8",
			success(data){
				$("#delivery_company_list_tbody").html('');
				$.each(data, (k,v)=>{
					var date = new Date(v.regDate);

					var formatDate = (current_datetime)=>{
					    let formatted_date = current_datetime.getFullYear() + "-" + (current_datetime.getMonth() + 1) + "-" + current_datetime.getDate() + " " + current_datetime.getHours() + ":" + current_datetime.getMinutes() + ":" + current_datetime.getSeconds();
					    return formatted_date;
					}
					var ynStr = "";
					if(v.showYn == 'Y'){
						ynStr = `<span class="label label-success" style="font-size: 12px;">보임</span>`;
					}else{
						ynStr = `<span class="label label-default" style="font-size: 12px;">숨김</span>`;
					}
					
					$("#delivery_company_list_tbody").append(`
							<tr>
							<td><input type="checkbox" name="checkedNo" value="\${v.deliComNo }" /></td>
							<td>\${v.deliComName }</td>
							<td>\${v.traceUrl }</td>
							<td>\${formatDate(date)}</td>
							<td>
								\${ynStr}
							</td>
							<td>
								<button type="button" onclick="onclickUpdate(\${v.deliComNo});" class="btn btn-primary btn-xs">상세보기</button>
							</td>
						</tr>`);
					cnt += 1;
				});
				$("#companyListCnt").text("총 " + cnt + " 건" );
			},
			error:console.log
		});
	}
</script>
<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>