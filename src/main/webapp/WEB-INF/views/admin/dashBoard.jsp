<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="today" value="<%=new java.util.Date()%>" />
<!-- 현재년도 -->
<c:set var="year"><fmt:formatDate value="${today}" pattern="yyyy" /></c:set> 
<!-- 현재월 -->
<c:set var="month"><fmt:formatDate value="${today}" pattern="MM" /></c:set>
<!-- 현재일 -->
<c:set var="day"><fmt:formatDate value="${today}" pattern="dd"/></c:set>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="Dashboard" name="title" />
</jsp:include>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap-colorselector@0.1.0/dist/bootstrap-colorselector.min.js">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel='stylesheet'  href='${pageContext.request.contextPath}/resources/fullcalendar/lib/main.css'/>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/resources/css/colorselector.css">
<script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/locales/ko.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/moment.js'></script>
<!-- content-wrapper test-->
<div class="content-wrapper">
	<style>
ul {
	list-style: none;
}

.nav-tabs-custom .list li:not(:last-child) {
	margin: 0 0 13px;
}

.cs-m-right20 {
	margin-right: 20px;
	font-size: 14px;
	color: #97989b;
}
</style>
<style>
	a { 
		color: #333;
		
	}
	.fc .fc-button-primary {
	 	color: #444;
	  	color: var(--fc-button-text-color, #2C3E50);
	  	background-color: #f4f4f4;
	  	background-color: var(--fc-button-bg-color, #f4f4f4);
	  	border-color: #ddd;
	  	border-color: var(--fc-button-border-color, #ddd);
	}	
	.fc .fc-button-primary:not(:disabled):active, .fc .fc-button-primary:not(:disabled).fc-button-active {
    	color: #444;
    	color: var(--fc-button-text-color, #2C3E50);
    	background-color: #f4f4f4;
    	background-color: var(--fc-button-active-bg-color, #f4f4f4);
    	border-color: #ddd;
    	border-color: var(--fc-button-active-border-color, #ddd);
	}
	.fc .fc-button-primary:disabled {
	    color: #444;
	    color: var(--fc-button-text-color, #2C3E50);
	    background-color: #f4f4f4;
	    background-color: var(--fc-button-bg-color, #f4f4f4);
	    border-color: #ddd;
	    border-color: var(--fc-button-border-color, #ddd);
	}
	.fc-day-sun {
	    color: red;
	}	
	.fc-sat {
	    color: blue;
	}
	.fc-event, .fc-event:hover {
	    color: #fff;
	    text-decoration: none;
	}	
	.fc-event {
	    border: #fff;
	}
	h3, h4, strong{
		font-weight : bolder;
	}
</style>
<script>


	function fncPostList(boardNo){
		
		$("li[name='postData']").remove();
		
		$.ajax({
			url : "/admin/board/json/getPostList/"+boardNo,
			method : "GET",
			dataType : "JSON",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"	 						
			} ,
			success : function(JSONData, status){
				if(status == 'success'){
					if(JSONData.list.length != 0){
						for(var i = 0; i <= JSONData.list.length; i++){
							var post = JSONData.list;
							display = '<li name="postData">'
									+ '<a href="/mir9/board/postList?boardNo='+post[i].postBoard.boardNo+'">'+post[i].postTitle+''
									+ '<span class="pull-right cs-m-right20">'+post[i].postDate+'</span>'
									+ '</a>'
									+ '</li>';
							$("ul[class='list']").append(display);
						}
					}else if(JSONData.list.length == 0){
						display = '<li name="postData">등록된 게시물이 없습니다.</li>';
						$("ul[class='list']").append(display);
					}
				}
			},
			error:function(request, status, error){
				alert("에러")
			}
		});
	}
	$(function(){
		<c:forEach var="board" items="${boardList}" varStatus="status">
			<c:if test="${status.first}">
				var boardNo = ${board.boardNo}
			</c:if>						
		</c:forEach>
	
		$.ajax({
			url : "/admin/board/json/getPostList/"+boardNo,
			method : "GET",
			dataType : "JSON",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"	 						
			} ,
			success : function(JSONData, status){
				if(status == 'success'){
					if(JSONData.list.length != 0){
						for(var i = 0; i <= JSONData.list.length; i++){
							var post = JSONData.list;
							display = '<li name="postData">'
									+ '<a href="/mir9/board/postList?boardNo='+post[i].postBoard.boardNo+'">'+post[i].postTitle+''
									+ '<span class="pull-right cs-m-right20">'+post[i].postDate+'</span>'
									+ '</a>'
									+ '</li>';
							$("ul[class='list']").append(display);
						}
					}else if(JSONData.list.length == 0){
						display = '<li name="postData">등록된 게시물이 없습니다.</li>';
						$("ul[class='list']").append(display);
					}
				}
			},
			error:function(request, status, error){
				alert("에러")
			}
		});	
	})
	
	document.addEventListener('DOMContentLoaded', function() {
		
        var calendarEl = document.getElementById('calendar');
        var calendar;
        
		calendar = new FullCalendar.Calendar(calendarEl, {
	          locale: 'ko',	//한국어 설정
			  //헤더에 표시할 툴바
			  headerToolbar: { 
					left: 'prev,next today', 
					center: 'title', 
					right: 'dayGridMonth' 
			  },
	          events: 
		      		$.ajax({
		    			url : "/admin/schedule/json/getScheduleList/",
		    			method : "GET",
		    			dataType : "JSON",	
		    			headers : {
		    				"Accept" : "application/json",
		    				"Content-Type" : "application/json"	 						
		    			} ,
		    			success : function(JSONData, status){
		    				//alert(JSONData[0].scheduleStartDate)
		    				//alert(JSONData[0].scheduleNo)
		    				
		    				for(var i = 0; i < JSONData.length; i++){
	    						calendar.addEvent({
	    							title: JSONData[i].scheduleTitle,
	    							start: JSONData[i].scheduleStartDate,
	    							end: JSONData[i].scheduleEndDate,
	    							backgroundColor: JSONData[i].scheduleColor,
	    							contents: JSONData[i].scheduleContents,
	    							id: JSONData[i].scheduleNo
	    						});
	    						
		    				}
		    			},
	        			error:function(request, status, error){
	        				alert("경고")
	        			}
		    			
		    		})
		});
		calendar.render();
	});
</script>

	<section class="content-header">
		<h1>
			Dashboard <small>쇼핑몰 운영현황</small>
		</h1>

		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>Dashboard</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<br>
					<div class="box-header with-border">
						<h3 class="box-title">금일 매출 현황 (<c:out value="${year}"/>년 <c:out value="${month}"/>월 <c:out value="${day}"/>일)</h3>
					</div>
					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-aqua">
							<div class="inner">
								<h3>${counts.todayOrderCnt }</h3>
								<p>주문건</p>
							</div>
							<div class="icon">
								<i class="fa fa-shopping-cart"></i>
							</div>
							<a class="small-box-footer"
								href="/admin/order/list">더보기 <i
								class="fa fa-arrow-circle-right"></i></a>
						</div>
					</div>
					<!-- ./col -->
					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-green">
							<div class="inner">
								<h3>${counts.todayPaidCnt }</h3>
								<p>입금완료</p>
							</div>
							<div class="icon">
								<i class="fa fa-pie-chart"></i>
							</div>
							<a class="small-box-footer"
								href="/admin/order/dashBoardOrderList?order_status=2">더보기
								<i class="fa fa-arrow-circle-right"></i>
							</a>
						</div>
					</div>
					<!-- ./col -->
					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-yellow">
							<div class="inner">
								<h3>${counts.todayPayReadyCnt }</h3>
								<p>입금대기</p>
							</div>
							<div class="icon">
								<i class="fa fa-files-o"></i>
							</div>
							<a class="small-box-footer"
								href="/admin/order/dashBoardOrderList?order_status=1">더보기
								<i class="fa fa-arrow-circle-right"></i>
							</a>
						</div>
					</div>
					<!-- ./col -->
					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-red">
							<div class="inner">
								<h3>${counts.todayRegMemberCnt }</h3>

								<p>가입회원 수</p>
							</div>
							<div class="icon">
								<i class="fa fa-user"></i>
							</div>
							<a class="small-box-footer"
								href="/admin/member/list.do">더보기 <i
								class="fa fa-arrow-circle-right"></i></a>
						</div>
					</div>
					<!-- ./col -->
					<div class="box-body">
						<div class="row">
							<div class="col-md-9" >
								<p class="text-center">
									<h4 style="text-align:center;"><c:out value="${year}"/>년 작년 대비 월매출</h4>
								</p>
								<div class="chart">
									<script>
										var chart_data3 = new Array();
										var dataRow3 = [];
										dataRow3 = [ '월', '<c:out value="${year}"/>년','<c:out value="${year-1}"/>년','<c:out value="${year-2}"/>년' ];
										chart_data3.push(dataRow3);
									</script>
									<c:set var="i" value="0"/>
									<c:forEach var="s" items="${byList }">
									    <c:set var="i" value="${ i+1 }" />
										<script>
											dataRow3 = ['${i}월', ${s.year}, ${s.yearsAgo}, ${s.twoYearsAgo}];
											chart_data3.push(dataRow3);
										</script>
									</c:forEach>										
									<div id="chart_div3" style="width: 1150px; height: 400px;"></div>
								</div>
							</div>
							<p class="text-center">
								<h4 style="text-align:center;">일정</h4>
								<!-- Goal Completion -->
							</p>
							<div>
								<div class="col-md-3" id="calendar" ></div>
							</div>							
							
						</div>
						<!-- /.row -->
					</div>
					<!-- ./box-body -->					
					<div class="box-header with-border">
						<h3 class="box-title">월별 요약표</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<div class="row">
							<div class="col-md-8">
								<p class="text-center">
									<strong><c:out value="${year}"/>년 기준 월단위 매출</strong>
								</p>

								<div class="chart">
									<script>
										var chart_data = new Array();
										var dataRow = [];
										dataRow = [ '월', '<c:out value="${year}"/>년' ];
										chart_data.push(dataRow);
									</script>
									<c:forEach var="r" items="${periodMonthList }">
										<c:set var="dateStr">
											<fmt:formatDate value="${r.paidAt}" pattern="M월" />
										</c:set>
										<c:set var="tAmount">${r.totalAmount == null ? '0' : r.totalAmount - r.totalCancelAmount}</c:set>
										<script>
											dataRow = ['${dateStr}', ${tAmount}];
											chart_data.push(dataRow);
										</script>
									</c:forEach>									
									<div id="chart_div" style="width: 100%; height: 100%;"></div>

									<!-- Sales Chart Canvas -->
									<!-- <canvas width="964" height="180" id="salesChart" style="width: 964px; height: 180px;"></canvas> -->
								</div>
								<!-- /.chart-responsive -->
							</div>
							<!-- /.col -->
							<div class="col-md-4">

								<p class="text-center">
									<strong>주문상태별 비율</strong>(<c:out value="${month}"/>월)
									<!-- Goal Completion -->
								</p>
								<div class="chart">
									<script>
										var chart_data2 = new Array();
										var dataRow2 = [];
										dataRow2 = [ '진행상태', '건수' ];
										chart_data2.push(dataRow2);
									</script>
									<c:forEach var="s" items="${orderStatusList }">
										<script>
											dataRow2 = ['${s.statusName}', ${s.statusCount}];
											chart_data2.push(dataRow2);
										</script>
									</c:forEach>									
									<div id="chart_div2" style="width: 100%; height: 100%;"></div>

									<!-- Sales Chart Canvas -->
									<!-- <canvas width="964" height="180" id="salesChart" style="width: 964px; height: 180px;"></canvas> -->
								</div>
								<!-- <div class="progress-group">
                            <span class="progress-text">배송준비중</span>
                            <span class="progress-number"><b>4</b>/10</span>

                            <div class="progress sm">
                              <div class="progress-bar progress-bar-aqua" style="width: 40%;"></div>
                            </div>
                          </div>
                          <div class="progress-group">
                            <span class="progress-text">배송중</span>
                            <span class="progress-number"><b>2</b>/10</span>

                            <div class="progress sm">
                              <div class="progress-bar progress-bar-red" style="width: 20%;"></div>
                            </div>
                          </div>
                          <div class="progress-group">
                            <span class="progress-text">배송완료</span>
                            <span class="progress-number"><b>3</b>/10</span>

                            <div class="progress sm">
                              <div class="progress-bar progress-bar-green" style="width: 30%;"></div>
                            </div>
                          </div>
                          <div class="progress-group">
                            <span class="progress-text">주문취소</span>
                            <span class="progress-number"><b>1</b>/10</span>

                            <div class="progress sm">
                              <div class="progress-bar progress-bar-yellow" style="width: 10%;"></div>
                            </div>
                          </div> -->
								<!-- /.progress-group -->

							</div>
							<!-- /.col -->
						</div>
						<!-- /.row -->
					</div>
					<!-- ./box-body -->
					<div class="box-footer">
						<div class="row">
							<div class="col-sm-3 col-xs-6">
								<div class="description-block border-right">
									<span class="description-percentage text-green">총 누적판매액</span>
									<h5 class="description-header"><fmt:formatNumber value="${counts.totalSaleAmountMonth }" pattern="#,###" /></td></h5>
									<span class="description-text">(원)</span>
								</div>
								<!-- /.description-block -->
							</div>
							<!-- /.col -->
							<div class="col-sm-3 col-xs-6">
								<div class="description-block border-right">
									<span class="description-percentage text-yellow">
										<!--i class="fa fa-caret-left"></i--> 총 주문건수
									</span>
									<h5 class="description-header">${counts.monthOrderCnt }</h5>
									<span class="description-text">(건)</span>
								</div>
								<!-- /.description-block -->
							</div>
							<!-- /.col -->
							<div class="col-sm-3 col-xs-6">
								<div class="description-block border-right">
									<span class="description-percentage text-green">
										<!--i class="fa fa-caret-up"></i--> 총 누적환불액
									</span>
									<h5 class="description-header"><fmt:formatNumber value="${counts.totalCancelAmountMonth }" pattern="#,###" /></h5>
									<span class="description-text">(원)</span>
								</div>
								<!-- /.description-block -->
							</div>
							<!-- /.col -->
							<div class="col-sm-3 col-xs-6">
								<div class="description-block">
									<span class="description-percentage text-red">총 환불건수</span>
									<h5 class="description-header">${counts.monthCancelCnt }</h5>
									<span class="description-text">(건)</span>
								</div>
								<!-- /.description-block -->
							</div>
						</div>
						<!-- /.row -->
					</div>
					
					
					<!-- /.box-footer -->
				</div>
				<!-- /.box -->
			</div>
			<!-- /.col-md-12 -->
		</div>
		<!-- /.row -->


		<div class="row">
			<div class="col-md-12">

				<div class="box">
					<div class="box-body">
						<div class="col-md-6">

							<div class="box-header with-border">
								<h3 class="box-title">최근 주문건</h3>
							</div>
							<!-- /.box-header -->

							<table class="table table-bordered">
								<thead>
									<tr>
										<th style="text-align: center;">주문번호</th>
										<th style="text-align: center;">주문상품</th>
										<th style="text-align: center;">진행상태</th>
										<th style="text-align: center;">주문일시</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="order" items="${orderList }">
										<tr>
											<td><a href="${pageContext.request.contextPath }/admin/order/list">${fn:substring(order.orderNo,0,6) }-${fn:substring(order.orderNo,7,15) }</a></td>
											<td>${order.productName }</td>
											
											<c:choose>
												<c:when test="${order.orderStatusNo == 1 }">
													<td><span class="label label-info">입금 대기</span></td>
												</c:when>
												<c:when test="${order.orderStatusNo == 2 }">
													<td><span class="label label-warning">입금확인</span></td>
												</c:when>
												<c:when test="${order.orderStatusNo == 4 }">
													<td><span class="label label-success">배송중</span></td>
												</c:when>
												<c:when test="${order.orderStatusNo == 5 }">
													<td><span class="label label-success">배송완료</span></td>
												</c:when>
											</c:choose>
											
											<c:if test="${order.piStatus == 'ready' }">
												<td>${order.piStatus == 'ready' ? ' - ':'' }</td>
											</c:if>
											<c:if test="${order.piStatus == 'paid' }">
												<td><fmt:formatDate value="${order.paidAt}" pattern="yyyy-MM-dd" /> </td>
											</c:if>
											
										</tr>
									</c:forEach>
									
								</tbody>
							</table>
						</div>
						<!-- ./col-md-6 -->

						<div class="col-md-6">

							<div class="box-header with-border">
								<h3 class="box-title">최근 등록상품</h3>
							</div>
							<!-- /.box-header -->

							<table class="table table-bordered">
								<thead>
									<tr>
										<th style="text-align: center;">상품코드</th>
										<th style="text-align: center;">상품명</th>
										<th style="text-align: center;">카테고리</th>
										<th style="text-align: center;">등록일자</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="product" items="${productList }">
										<tr>
											<td><a href="${pageContext.request.contextPath }/admin/product/list">${product.modelName }</a></td>
											<td>${product.productName }</td>
											<td>${product.categoryName }</td>
											<td><fmt:formatDate value="${product.regDate}" pattern="yyyy-MM-dd" /></td>
										</tr>
									</c:forEach>
									
								</tbody>
							</table>
						</div>
						<!-- ./col-md-6 -->


					</div>
					<!-- /.box-body -->
				</div>
				<!-- /.box -->

			</div>
			<!-- /.col-md-12 -->
		</div>
		<!-- /.row -->

		<div class="row">
			<div class="col-md-4">
				<div class="small-box bg-aqua">
					<div class="inner">
						<h4>결제PG 신청</h4>
						<li>엑심베이(PayPal, 중국, 일본, 동남아 결제)</li>
						<li>이니시스</li>
					</div>
					<div class="icon">
						<i class="fa fa-credit-card"></i>
					</div>
					<a class="small-box-footer"
						href="/mir9/setting/paymentpg">신청하기 <i
						class="fa fa-arrow-circle-right"></i></a>
				</div>

				<div style="text-align: center;">
					<a href="${pageContext.request.contextPath }/admin/product/list"
						class="btn btn-default btn-lg"><i class="fa fa-gift"></i> 상품
						관리</a> <a href="${pageContext.request.contextPath }/admin/setting/point"
						class="btn btn-default btn-lg"><i class="fa fa-dollar"></i>
						적립금 관리</a> <a href="${pageContext.request.contextPath }/admin/setting/coupon"
						class="btn btn-default btn-lg"><i class="fa fa-credit-card"></i>
						쿠폰 관리</a>
				</div>
			</div>

			<div class="col-md-8">

				<!-- Custom Tabs -->
				<div class="nav-tabs-custom">
					<ul class="nav nav-tabs">
						<c:forEach var="board" items="${boardList}" varStatus="status">
							<c:if test="${status.first}">
								<li class="">
									<a aria-expanded="true" name="dashBoardNo" href="#tab_${board.boardNo}" data-toggle="tab" onclick="fncPostList(${board.boardNo})" >${board.boardTitle}</a>
								</li>
							</c:if>
							<c:if test="${!status.first}">
								<li class="">
									<a aria-expanded="true" name="dashBoardNo" href="#tab_${board.boardNo}" data-toggle="tab" onclick="fncPostList(${board.boardNo})">${board.boardTitle}</a>
								</li>
							</c:if>							
						</c:forEach>
						<li class="pull-right">
							<a class="text-muted" href="/mir9/board/listBoard">더보기 
								<i class="fa fa-arrow-circle-right"></i>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1">
							<ul class="list">
								
							</ul>
						</div>
						
					</div>
					<!-- /.tab-content -->
				</div>
				<!-- /.nav-tabs-custom -->
			</div>
			<!-- /.col-md-12 -->
		</div>
		<!-- /.row -->
	</section>
</div>
<!-- /.content-wrapper -->

<script>
			function drawChart() {
				var data = google.visualization.arrayToDataTable(chart_data);

				var options = {
					title: "",
					pieHole : 0.4,			
				};

				var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
				chart.draw(data, options);
			}

			function drawChart2() {

				var data = google.visualization.arrayToDataTable(chart_data2);
				var options = {
					title: "",
					pieHole : 0.4,
					is3D: true,
				};

				var chart = new google.visualization.PieChart(document.getElementById("chart_div2"));
				chart.draw(data, options);
			}
			
			function drawChart3() {

				var data = google.visualization.arrayToDataTable(chart_data3);
				var options = {
					  title: '(금액:천단위)',
			          curveType: 'function',
			          legend: { position: 'bottom' }
				};

				var chart = new google.visualization.LineChart(document.getElementById("chart_div3"));
				chart.draw(data, options);
			}
			

			
			$(function() {
				google.charts.load("current", {packages:['corechart']});
				google.charts.setOnLoadCallback(drawChart);
				google.charts.setOnLoadCallback(drawChart2);
				google.charts.setOnLoadCallback(drawChart3);
			});
		
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>