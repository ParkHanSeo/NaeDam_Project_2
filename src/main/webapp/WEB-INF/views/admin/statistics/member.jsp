<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="회원별 통계" name="title" />
</jsp:include>

<div class="content-wrapper">
	<section class="content-header">
		<h1>
			회원별 매출 통계 
			<small>Sales Statistics by Member</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#">통계</a></li>
			<li class="active">회원별 매출 통계</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<form:form name="form_search" id="form_search" method="post" action="${pageContext.request.contextPath }/admin/statistics/member">
							<div class="box-tools " style="margin-bottom: 5px;">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<td class="menu">기간 검색</td>
											<td align="left">
												<input type="text" name="start_date" id="start_date" value="${startDateStr == null ? '' : startDateStr }" class="form-control input-sm txt_date1" style="width: 100px; display: inline-block;" /> ~ 
												<input type="text" name="end_date" id="end_date" value="${endDateStr == null ? '' : endDateStr }" class="form-control input-sm txt_date1" style="width: 100px; display: inline-block;" />
												<button type="button" onclick="setSearchDate('D0');" class="btn btn-primary btn-xs">오늘</button>
												<button type="button" onclick="setSearchDate('D6');" class="btn btn-primary btn-xs">7일</button>
												<button type="button" onclick="setSearchDate('D15');" class="btn btn-primary btn-xs">15일</button>
												<button type="button" onclick="setSearchDate('M1');" class="btn btn-primary btn-xs">1개월</button>
												<button type="button" onclick="setSearchDate('M3');" class="btn btn-primary btn-xs">3개월</button>
												<button type="button" onclick="setSearchDate('M6');" class="btn btn-primary btn-xs">6개월</button>
											</td>
										</tr>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="2" style="text-align: center;">
												<button type="submit" class="btn btn-danger btn-sm">
													<i class="fa "></i>검색
												</button>
											</td>
										</tr>
									</tfoot>
								</table>
							</div>
						</form:form>
						<script>
							var chart_data = new Array();
							var dataRow = [];
							dataRow = [ '회원', '매출금액', {
								role : 'style'
							} ];
							chart_data.push(dataRow);
						</script>
						<c:forEach var="r" items="${result }">
							<script>
								dataRow = [ '${r.name}', ${r.total}, '#76A7FA' ];
								chart_data.push(dataRow);
							</script>
						</c:forEach>
						<div id="chard_div" style="border: 1px solid #cdcdcd; width: 100%; margin-bottom: 10px;">
							<div id="columnchart_values" style="width: 100%; height: 370px;"></div>
						</div>
						<table class="table table-bordered table-hover">
							<colgroup>
								<col width="5%">
								<col width="*">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<td>순위</td>
									<td>성명(아이디)</td>
									<td>주문건수</td>
									<td>주문금액</td>
									<td>환불건수</td>
									<td>환불금액</td>
									<td>결제총액</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="r" items="${result }">
									<tr>
										<td>${r.ranking }</td>
										<td align="left">${r.name }(${r.id })</td>
										<td align="right">${r.orderCnt }</td>
										<td align="right">${r.totalAmount }</td>
										<td align="right">${r.cancelCnt }</td>
										<td align="right">${r.totalAmountCancel }</td>
										<td align="right">${r.total }</td>
									</tr>
								</c:forEach>
							<tbody>
						</table><br />
						<!-- 
						<button type="button" onclick="downloadExcel();" class="btn btn-warning btn-sm"><i class="fa" aria-hidden="true"></i> Excel 다운로드</button>
	                    <form name="form_download" method="post" action="?tpf=admin/order/process">
	                        <input type="hidden" name="mode" value="downloadExcel">
	                        <input type="hidden" name="search_data">
	                    </form> 
	                    -->
					</div><!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col-xs-12 -->
		</div><!-- /.row --> 
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
	function drawChart() {
		var chartBarColor = '#76A7FA';
	
		var data = google.visualization.arrayToDataTable(chart_data);
	
		var chart_div_width = $('#columnchart_values').width();
		console.log(chart_div_width); 
		var view = new google.visualization.DataView(data);
		view.setColumns([0, 1,
					   { calc: "stringify",
						 sourceColumn: 1,
						 type: "string",
						 role: "annotation" },
					   2]);
	
		var options = {
			title: "상위 TOP 10 회원 매출금액",
			width: chart_div_width,
			height: 350,
			bar: {groupWidth: "95%"},
			legend: { position: "none" },
		};
		var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
		chart.draw(view, options);
	}
	
	var sForm = null;
	
	$(function() {
		sForm = document.form_search;
	
		$( ".txt_date1" ).datepicker({
				defaultDate: "+0d",
				changeYear: true,
				changeMonth: true,
				dateFormat: "yy-mm-dd",
				maxDate : '2022-04-27',
				showMonthAfterYear: true , 
				dayNamesMin: ['일', '월', '화', '수', '목', '금', '토' ],
				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		});
	
		google.charts.load("current", {packages:['corechart']});
		google.charts.setOnLoadCallback(drawChart);
	});
	
	/* 기간 검색 디폴트 및 기능 */
	function setSearchDate(type){
		$("input[name=start_date]").val(dateStr(type));
		$("input[name=end_date]").val(dateStr('D0'));
		$("[name=dateLength]").val(type);
		
	}
	
	/* 날짜 포맷팅 */
	function dateStr(type){
		var date = new Date();
		i = type.slice(1,3) * 1;
		if(type.slice(0,1) == 'D'){
			date = new Date(date-(60 * 60 * 24 * i));
		}else if(type.slice(0,1) == 'M'){
			date.setMonth(date.getMonth() - i);
		}
			var year = date.getFullYear();
			var month = ('0' + (date.getMonth() + 1)).slice(-2);
			var day = ('0' + (date.getDate() - i)).slice(-2);
			var dateString = year + '-' + month  + '-' + day;	
		return dateString;
	}
</script>

<c:if test="${startDateStr == null }">
	<script>
		setSearchDate('M1');
	</script>
</c:if>
<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>