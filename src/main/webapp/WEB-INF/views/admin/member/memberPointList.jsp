<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="" name="title" />
</jsp:include>

<div class="content-wrapper">
	<section class="content-header">
		<h1>
			회원 적립금 관리 
			<small>Member point list</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>회원 관리</li>
			<li class="active">회원 적립금 관리</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<label style="margin-top: 5px;">총 ${mPointList.size() } 건</label>
						<form name="form_search" method="post">
							<div class="box-tools pull-right" style="margin-bottom: 5px;">
								<div class="has-feedback">
									<span> 
										<input type="text" name="keyword" id="keyword" value="${param.keyword == null ? '' : param.keyword }" class="form-control input-sm" placeholder="검색" /> 
										<span class="glyphicon glyphicon-search form-control-feedback"></span>
									</span>
								</div>
							</div>
							<div class="box-tools pull-right" style="margin-bottom: 5px;">
								<div class="has-feedback">
									<select name="field" id="field" class="form-control input-sm">
										<option value="total" ${param.field == 'total' ? 'selected' : ''}>전체</option>
										<option value="id" ${param.field == 'id' ? 'selected' : ''}>아이디</option>
										<option value="CONCAT(last_name, first_name)" ${param.field == 'CONCAT(last_name, first_name)' ? 'selected' : ''}>이름</option>
										<option value="point_title" ${param.field == 'point_title' ? 'selected' : ''}>사용내역</option>
									</select>
								</div>
							</div>
						</form>
						<form name="form_list" method="post" action="?tpf=admin/member/process">
							<input type="hidden" name="mode" id="mode" value="deletePointLog">
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<td style="width: 30px;"><input type="checkbox" name="select_all" onclick="selectAllCheckBox( 'form_list');" /></td>
										<td style="width: 60px;">NO</td>
										<td style="width: 110px;">아이디</td>
										<td style="width: 110px;">이름</td>
										<td style="width: 180px;">이메일</td>
										<td>적립금 사용내역</td>
										<td style="width: 100px;">사용 적립금</td>
										<td style="width: 140px;">일시</td>
										<!-- <td style="width:60px;">명령</td> -->
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty mPointList and empty param.keyword}">
											<tr>
												<td colspan="8">조회 결과가 없습니다.</td> 
											</tr>
										</c:when>
										<c:when test="${empty mPointList and !empty param.keyword}">
											<tr>
												<td colspan="8">검색된 적립금 내역이 없습니다.</td> 
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="mPoint" items="${mPointList }" varStatus="vs">
												<tr>
													<td><input type="checkbox" name="list[]" value="${mPoint.memberPointNo }" /></td>
													<td>${mPointList.size() - vs.index }</td>
													<td>${mPoint.id }</td>
													<td>${mPoint.memberName }</td>
													<td>${mPoint.email }</td>
													<td>${mPoint.pointTitle }</td>
													<td><fmt:formatNumber value="${mPoint.pointAmount }" pattern="#,###" /></td>
													<td><fmt:formatDate pattern = "yyyy-MM-dd HH:mm" value="${mPoint.regDate}"/></td>
													<!-- <td><button type="button" onclick="viewDetail()" class="btn btn-primary btn-xs">상세보기</button></td> -->
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</form>
						<br>
						<!-- // 적립금 사용내역을 삭제하면 getPoint 함수가 제대로 된 적립금을 계산하지 못하여 주석처리
	                    <button type="button" onclick="selectDelete('deletePointLog', '해당 회원의 적립금 사용이력을 삭제하시겠습니까?');" class="btn btn-danger"><i class="fa fa-minus-square"></i> 선택삭제</button> -->
						<button type="button" onclick="downloadExcel();" class="btn btn-warning">
							<i class="fa" aria-hidden="true"></i> Excel 다운로드
						</button>
						<button type="button" onclick="location.replace('${pageContext.request.contextPath}/admin/member/list.do')" class="btn btn-primary" style="margin-left: 20px;">
							<i class="fa fa-minus-square" aria-hidden="true"></i> 회원 리스트 이동
						</button>
						<form name="form_download" method="post" action="${pageContext.request.contextPath }/excel/download.do?${_csrf.parameterName}=${_csrf.token}">
							<input type="hidden" name="download_type" value="memberPoint" /> 
							<input type="hidden" name="mode" value="downloadExcelPointLog"> 
							<input type="hidden" name="search_data" value=""> 
							<input type="hidden" name="search_type" value="">
						</form>
						<!-- 페이징 -->
	                    <div id="pagebarContainer" style="text-align: right;">
	                        ${pagebar}
						</div>
					</div><!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col-xs-12 -->
		</div><!-- /.row -->
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
	$(function(){
		var path = document.location.pathname;
		var str = path.substring(path.lastIndexOf("/") + 1);
		
		if(str == "point") {
			$("form[name='form_search']").attr("action", "${pageContext.request.contextPath }/admin/member/point?${_csrf.parameterName}=${_csrf.token}");
		}
		else {
			$("form[name='form_search']").attr("action", "${pageContext.request.contextPath }/admin/member/memberPointList/" + str + "?${_csrf.parameterName}=${_csrf.token}");
			$("input[name='search_type']").val(str); // 해당 멤버 번호
		}
	});
	
	function downloadExcel() {  // Excel 다운로드
	    form_download.target = 'iframe_process';
	    form_download.search_data.value = $('#form_search').serialize();
	    form_download.submit();
	}
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>