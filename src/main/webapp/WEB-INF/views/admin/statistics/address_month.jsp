<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="지역별 통계" name="title"/>
</jsp:include>



<!-- content-wrapper -->
<div class="content-wrapper">
<style>
	.sum_tr{background-color:#f0efef; font-weight:bold;}
</style>
<section class="content-header">
    <h1>
    지역별 매출 통계
    <small>Sales Statistics by Address</small>
    </h1>

    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">통계</a></li>
        <li class="active">지역별 매출 통계</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">

                    <div class="box-tools " style="margin-bottom:5px;" >
                    <form name="form_search" id="form_search" method="post" action="${pageContext.request.contextPath }/admin/statistics/address_month?${_csrf.parameterName}=${_csrf.token}">
                        <table class="table table-bordered">
						<tbody>
						<tr>
							<td class="menu">통계종류</td>
							<td align="left">
								<input type="radio" name="statistics_type" id="statistics_type_1" value="date" onclick="location.href='${pageContext.request.contextPath}/admin/statistics/address_day'" /> <label for="statistics_type_1">일별통계</label>&nbsp;&nbsp;
								<input type="radio" name="statistics_type" id="statistics_type_2" value="month" checked /> <label for="statistics_type_2">월별통계</label>&nbsp;&nbsp;
								<input type="radio" name="statistics_type" id="statistics_type_3" value="yesr" onclick="location.href='${pageContext.request.contextPath}/admin/statistics/address_year'" /> <label for="statistics_type_3">연도별통계</label>
							</td>
						</tr>
						<tr>
							<td class="menu">기간 검색</td>
							<td align="left">
								<input type="text" name="start_date" id="start_date" value="2022-02" class="form-control input-sm txt_date1" style="width:100px;display:inline-block;" /> ~ 
								<input type="text" name="end_date"  id="end_date" value="2022-04" class="form-control input-sm txt_date1" style="width:100px;display:inline-block;" />

								<button type="button" onclick="setSearchDate('M1');" class="btn btn-primary btn-xs">1개월</button>
								<button type="button" onclick="setSearchDate('M2');" class="btn btn-primary btn-xs">3개월</button>
								<button type="button" onclick="setSearchDate('M5');" class="btn btn-primary btn-xs">6개월</button>
								<button type="button" onclick="setSearchDate('M11');" class="btn btn-primary btn-xs">12개월</button>
							</td>
						</tr>
						</tbody>
						<tfooter>
							<tr>
								<td colspan="2" style="text-align:center;">
								<button type="button" onclick="selectAction();" class="btn btn-danger btn-sm"><i class="fa "></i>검색</button>
								</td>
							</tr>
						</tfooter>
						</table>
                    </div>

					<script>
						var chart_data = new Array();
						var dataRow = [];
						dataRow = ['지역', '매출금액', { role: 'style' }];
						chart_data.push(dataRow);
					</script>
					<div id="chard_div" style="border:1px solid #cdcdcd;width:100%;margin-bottom:10px;">
						<div id="columnchart_values" style="width: 100%; height: 370px;"></div>
					</div>

                    <table class="table table-bordered table-hover">
						<colgroup>
							<col width="100">
							<col width="100">
							<col width="120">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
						</colgroup>
						<thead>
							<tr>
								<td >날짜</td>
								<td >구분</td>
								<td >매출총액</td>
								<td >서울</td>
								<td >부산</td>
								<td >인천</td>
								<td >대구</td>
								<td >광주</td>
								<td >대전</td>
								<td >울산</td>
								<td >세종</td>
								<td >경기</td>
								<td >강원</td>
								<td >충북</td>
								<td >충남</td>
								<td >전북</td>
								<td >전남</td>
								<td >경북</td>
								<td >경남</td>
								<td >제주</td>
							</tr>
						</thead>
						<tbody>
						  <c:forEach var="address" items="${list}" varStatus="status">
							<tr>
		                        <td rowspan="3">
		                        	<fmt:parseDate value="${address.paidAt}" pattern="yyyy-MM" var="paidAt" type="both" />
									<fmt:formatDate pattern="yyyy-MM" value="${paidAt}" />
								</td>
								<td>매출금액</td>
								<td align="right">${address.paymentSum}</td>
								<td align="right">${address.seoul}</td>
								<td align="right">${address.busan}</td>
								<td align="right">${address.incheon}</td>
								<td align="right">${address.daegu}</td>
								<td align="right">${address.gwangju}</td>
								<td align="right">${address.daejeon}</td>
								<td align="right">${address.ulsan}</td>
								<td align="right">${address.sejong}</td>
								<td align="right">${address.gyeonggi}</td>
								<td align="right">${address.gangwon}</td>
								<td align="right">${address.chungbuk}</td>
								<td align="right">${address.chungnam}</td>
								<td align="right">${address.jeonbuk}</td>
								<td align="right">${address.jeonnam}</td>
								<td align="right">${address.gyeongbuk}</td>
								<td align="right">${address.gyeongnam}</td>
								<td align="right">${address.jeju}</td>
		                    </tr>
							<tr>
								<td>환불금액</td>
		                        <td align="right">${address.returnSum}</td>
								<td align="right">${address.seoulReturn}</td>
								<td align="right">${address.busanReturn}</td>
								<td align="right">${address.incheonReturn}</td>
								<td align="right">${address.daeguReturn}</td>
								<td align="right">${address.gwangjuReturn}</td>
								<td align="right">${address.daejeonReturn}</td>
								<td align="right">${address.ulsanReturn}</td>
								<td align="right">${address.sejongReturn}</td>
								<td align="right">${address.gyeonggiReturn}</td>
								<td align="right">${address.gangwonReturn}</td>
								<td align="right">${address.chungbukReturn}</td>
								<td align="right">${address.chungnamReturn}</td>
								<td align="right">${address.jeonbukReturn}</td>
								<td align="right">${address.jeonnamReturn}</td>
								<td align="right">${address.gyeongbukReturn}</td>
								<td align="right">${address.gyeongnamReturn}</td>
								<td align="right">${address.jejuReturn}</td>
		                    </tr>
							<tr class="sum_tr">
								<td>총액</td>
								<td align="right">${address.paymentSum+address.returnSum}</td>
		                        <td align="right">${address.seoul+address.seoulReturn}</td>
								<td align="right">${address.busan+address.busanReturn}</td>
								<td align="right">${address.incheon+address.incheonReturn}</td>
								<td align="right">${address.daegu+address.daeguReturn}</td>
								<td align="right">${address.gwangju+address.gwangjuReturn}</td>
								<td align="right">${address.daejeon+address.daejeonReturn}</td>
								<td align="right">${address.ulsan+address.ulsanReturn}</td>
								<td align="right">${address.sejong+address.sejongReturn}</td>
								<td align="right">${address.gyeonggi+address.gyeonggiReturn}</td>
								<td align="right">${address.gangwon+address.gangwonReturn}</td>
								<td align="right">${address.chungbuk+address.chungbukReturn}</td>
								<td align="right">${address.chungnam+address.chungnamReturn}</td>
								<td align="right">${address.jeonbuk+address.jeonbukReturn}</td>
								<td align="right">${address.jeonnam+address.jeonnamReturn}</td>
								<td align="right">${address.gyeongbuk+address.gyeongbukReturn}</td>
								<td align="right">${address.gyeongnam+address.gyeongnamReturn}</td>
								<td align="right">${address.jeju+address.jejuReturn}</td>
		                    </tr>
		                  </c:forEach>
						</tbody>
                    </table>

					<br />
                    <!-- <button type="button" onclick="downloadExcel();" class="btn btn-warning btn-sm"><i class="fa" aria-hidden="true"></i> Excel 다운로드</button>
                    <form name="form_download" method="post" action="?tpf=admin/order/process">
                        <input type="hidden" name="mode" value="downloadExcel">
                        <input type="hidden" name="search_data">
                    </form> -->
                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>

</div><!-- /.content-wrapper -->

<script>
        
		function selectAction(){
			if(sForm.start_date.value > sForm.end_date.value){
				alert('검색 기간을 확인해주세요.');
				return;
			}
			sForm.submit();
		}
		/* 기간 검색 디폴트 및 기능 */
		setSearchDate("M1");
		function setSearchDate(type){
			$("input[name=start_date]").val(dateStr(type));
			$("input[name=end_date]").val(dateStr('D0'));	
		}
		
		/* 날짜 포맷팅 */
		function dateStr(type){
			var date = new Date();
			var i = type.slice(1,3) * 1;
			if(type.slice(0,1) == 'D'){
				date = new Date(date-(60 * 60 * 24 * i));
			}else if(type.slice(0,1) == 'M'){
				date.setMonth(date.getMonth() - i);
			}
				var year = date.getFullYear();
				var month = ('0' + (date.getMonth() + 1)).slice(-2);
				var dateString = year + '-' + month;	
			return dateString;
		}

        function downloadExcel() {  // Excel 다운로드
            form_download.target = 'iframe_process';
            form_download.search_data.value = $('#form_search').serialize();
            form_download.submit();
        }

		function drawChart() {
			var chartBarColor = '#76A7FA';

			var data = google.visualization.arrayToDataTable([
				['지역', '매출금액', { role: 'style' }],
				<c:forEach var="area" items="${list2}" varStatus="status">
				<c:if test="${!status.last}">
					['${area.areaName}', ${area.areaPayment}, chartBarColor],
				</c:if>
				<c:if test="${status.last}">
					['${area.areaName}', ${area.areaPayment}, chartBarColor]
				</c:if>						
				</c:forEach>				
			]);

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
				title: "지역별 매출금액",
				width: chart_div_width,
				height: 350,
				bar: {groupWidth: "95%"},
				legend: { position: "none" },
			};
			var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
			chart.draw(view, options);
		}

		var sForm = null;

		var currentYear = (new Date()).getFullYear();
		var startYear = currentYear-4;
		
		$(function() {
			sForm = document.form_search;

			$( ".txt_date1" ).datepicker({
				startYear: startYear,
				finalYear: currentYear,
				pattern: 'yyyy-mm',
				monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			});

			google.charts.load("current", {packages:['corechart']});
			google.charts.setOnLoadCallback(drawChart);
		});
		
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>