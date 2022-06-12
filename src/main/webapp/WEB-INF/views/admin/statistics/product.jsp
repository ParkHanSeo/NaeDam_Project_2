<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="제품별 통계" name="title"/>
</jsp:include>

<script>
	function select(){
		$("select[id='category1_code']").attr("name", "categoryCode");
		$("option[name='categoryOption1']").remove();
		$("option[name='categoryOption2']").remove();
		var langSelect = document.getElementById("category1_code"); 
		// select element에서 선택된 option의 value가 저장된다. 
		var selectValue = langSelect.options[langSelect.selectedIndex].value;
		var categoryNo = Number(selectValue);
		
		<c:forEach var="category" items="${list2}" varStatus="status">
			var parentNo = Number(${category.parentNo})
			if(${category.level == 2}){
				if(categoryNo == parentNo){
					var display = '<option value="${category.categoryNo}" name="categoryOption1">${category.categoryName}</option>'
					$("select[name='category2_code']").append(display);
				}
			}
		</c:forEach>
	}
	
	function select2(){
		$("select[id='category1_code']").attr("name", "category1_code");
		$("select[id='category2_code']").attr("name", "categoryCode");
		$("option[name='categoryOption2']").remove();
		var langSelect = document.getElementById("category2_code"); 
		// select element에서 선택된 option의 value가 저장된다. 
		var selectValue = langSelect.options[langSelect.selectedIndex].value;
		var categoryNo = Number(selectValue);
		
		<c:forEach var="category" items="${list2}" varStatus="status">
			var parentNo = Number(${category.parentNo})
			if(${category.level == 3}){
				if(categoryNo == parentNo){
					var display = '<option value="${category.categoryNo}" name="categoryOption2">${category.categoryName}</option>'
					$("select[name='category3_code']").append(display);
				}
			}
		</c:forEach>
	}	
	
	function select3(){
		$("select[id='category2_code']").attr("name", "category2_code");
		$("select[id='category3_code']").attr("name", "categoryCode");
	}		
	
</script>

<div class="content-wrapper">
	<section class="content-header">
	    <h1>
		    제품별 매출 통계
		    <small>Sales Statistics by Product</small>
	    </h1>
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li><a href="#">통계</a></li>
	        <li class="active">제품별 매출 통계</li>
	    </ol>
	</section>

	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
	                    <div class="box-tools " style="margin-bottom:5px;" >
		                    <form name="form_search" id="form_search" method="post" action="/admin/statistics/product?${_csrf.parameterName}=${_csrf.token}">
		                        <table class="table table-bordered">
									<tbody>
										<tr>
											<td class="menu">분류선택</td>
											<td align="left">
												<select name="category1_code" id="category1_code" onchange="select()" class="form-control input-sm " style="width:100px;display:inline-block;" >
													<option value="">1차 분류</option>
													<c:forEach var="category" items="${list2}" varStatus="status">
														<c:if test="${category.level == 1}">
															<option value="${category.categoryNo}" >${category.categoryName}</option>
														</c:if>
													</c:forEach>
												</select>
												<select name="category2_code" id="category2_code" onchange="select2()" class="form-control input-sm " style="width:100px;display:inline-block;" >
													<option value="" name="category2">2차 분류</option>
												</select>
												<select name="category3_code" id="category3_code" onchange="select3()" class="form-control input-sm " style="width:100px;display:inline-block;" >
													<option value="" name="category3">3차 분류</option>								
												</select>
											</td>
										</tr>
										<tr>
											<td class="menu">기간 검색</td>
											<td align="left">
												<input type="text" name="start_date" id="start_date" value="" class="form-control input-sm txt_date1" style="width:100px;display:inline-block;" /> ~ 
												<input type="text" name="end_date"  id="end_date" value="" class="form-control input-sm txt_date1" style="width:100px;display:inline-block;" />
												<button type="button" onclick="setSearchDate('D1');" class="btn btn-primary btn-xs">오늘</button>
												<button type="button" onclick="setSearchDate('D7');" class="btn btn-primary btn-xs">7일</button>
												<button type="button" onclick="setSearchDate('D15');" class="btn btn-primary btn-xs">15일</button>
												<button type="button" onclick="setSearchDate('M1');" class="btn btn-primary btn-xs">1개월</button>
												<button type="button" onclick="setSearchDate('M3');" class="btn btn-primary btn-xs">3개월</button>
												<button type="button" onclick="setSearchDate('M6');" class="btn btn-primary btn-xs">6개월</button>
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
							</form>
	                    </div>
						<script>
							var chart_data1 = new Array();
							var dataRow1 = [];
							
							dataRow1 = ['제품명', '결제수량'];
							
							chart_data1.push(dataRow1);
	
							var chart_data2 = new Array();
							var dataRow2 = [];
							dataRow2 = ['제품명', '환불수량'];
							chart_data2.push(dataRow2);
						</script>
						<div id="chard_div" style="width:100%;margin-bottom:10px;height:380px;">
							<div id="columnchart_values1" style="width: 49%; height: 370px; float: left; border:1px solid #cdcdcd; margin-right:2%;"></div>
							<div id="columnchart_values2" style="width: 49%; height: 370px; float: left; border:1px solid #cdcdcd;"></div>
						</div>
	                    <table class="table table-bordered table-hover">
							<colgroup>
								<col width="5%">
								<col width="*">
								<col width="20%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<td >순위</td>
									<td >제품분류</td>
									<td >제품명</td>
									<td >판매가</td>
									<td >결제수량</td>
									<td >환불수량</td>
									<td >총 판매수량</td>
									<td >총 판매금액</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="product" items="${list}" varStatus="status">
		     						 <tr>
		     						 	<td>${product.productRank}</td>
		     						 	<td>${product.categoryName}</td>
		     						 	<td>${product.productName}</td>
		     						 	<td>${product.amount}원</td>
		     						 	<td>${product.paymentCount}</td>
		     						 	<td>${product.returnCount}</td>
		     						 	<td>${product.paymentCount-product.returnCount}</td>
		     						 	<td>${product.paymentSum}원</td>
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
		function selectAction(){
			if(sForm.start_date.value > sForm.end_date.value){
				alert('검색 기간을 확인해주세요.');
				return;
			}
			sForm.submit();
		}
		
		/* 기간 검색 디폴트 및 기능 */
		setSearchDate("D6");
		function setSearchDate(type){
			$("input[name=start_date]").val(dateStr(type));
			$("input[name=end_date]").val(dateStr('D0'));	
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
		
        function downloadExcel() {  // Excel 다운로드
            form_download.target = 'iframe_process';
            form_download.search_data.value = $('#form_search').serialize();
            form_download.submit();
        }

		function drawChart() {

			var data = google.visualization.arrayToDataTable([
				['제품명', '결제수량'],
				<c:forEach var="product" items="${list}" varStatus="status">
					<c:if test="${!status.last}">
						['${product.productName}', ${product.paymentCount}],
					</c:if>
					<c:if test="${status.last}">
						['${product.productName}', ${product.paymentCount}]
					</c:if>						
				</c:forEach>
			]);

			var chart_div_width = $('#columnchart_values1').width();

			var options = {
				title: "상위 TOP 10 제품 결제수량",
				width: chart_div_width,
				height: 350,
				pieHole : 0.4,
			};

			var chart = new google.visualization.PieChart(document.getElementById("columnchart_values1"));
			chart.draw(data, options);
		}

		function drawChart2() {

			var data = google.visualization.arrayToDataTable([
				['제품명', '결제수량'],
				<c:forEach var="product" items="${list}" varStatus="status">
					<c:if test="${!status.last}">
						['${product.productName}', ${product.returnCount}],
					</c:if>
					<c:if test="${status.last}">
						['${product.productName}', ${product.returnCount}]
					</c:if>						
				</c:forEach>
			]);

			var chart_div_width = $('#columnchart_values2').width();

			var options = {
				title: "상위 TOP 10 제품 환불수량",
				width: chart_div_width,
				height: 350,
				pieHole : 0.4,
			};

			var chart = new google.visualization.PieChart(document.getElementById("columnchart_values2"));
			chart.draw(data, options);
		}

		var sForm = null;
		
		$(function() {
			sForm = document.form_search;

			$( ".txt_date1" ).datepicker({
					defaultDate: "+0d",
					changeYear: true,
					changeMonth: true,
					dateFormat: "yy-mm-dd",
					maxDate : '2022-04-26',
					showMonthAfterYear: true , 
					dayNamesMin: ['일', '월', '화', '수', '목', '금', '토' ],
					monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			});

			google.charts.load("current", {packages:['corechart']});
			google.charts.setOnLoadCallback(drawChart);
			google.charts.setOnLoadCallback(drawChart2);
		});
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>