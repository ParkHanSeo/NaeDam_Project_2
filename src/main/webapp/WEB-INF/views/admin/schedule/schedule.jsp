<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="1:1문의" name="title"/>
</jsp:include>
<!-- content-wrapper -->

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AdminLTE 2 | Dashboard</title>
<!-- jQuery 3 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath}/resources/js/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/resources/js/adminlte.min.js"></script>
<!-- Sparkline -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.sparkline.min.js"></script>
<!-- jvectormap  -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-jvectormap-1.2.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.slimscroll.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/common.js" type="text/javascript" charset="utf-8"></script>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Ionicons -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ionicons.min.css">
<!-- jvectormap -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-jvectormap.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/_all-skins.min.css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/jquery-ui.css" rel="stylesheet">

<!-- Google Font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;box-sizing: content-box;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style>
<body class="skin-red sidebar-mini" style="height: auto; min-height: 100%;">
<iframe name="iframe_process" width="0" height="0" frameborder="0" style="display:none;"></iframe>
<script class="cssdesk" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.0/moment.min.js" type="text/javascript"></script>
<!-- content-wrapper -->
<div class="content-wrapper">
<!-- ?? -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap-colorselector@0.1.0/dist/bootstrap-colorselector.min.js">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel='stylesheet'  href='${pageContext.request.contextPath}/resources/fullcalendar/lib/main.css'/>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/resources/css/colorselector.css">
<script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/locales/ko.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/moment.js'></script>
<style>
	.fc-col-header-cell.fc-day.fc-day-sun{ 
		color:red; 
		background-color: red;
	}
	.fc-col-header-cell.fc-day.fc-day-sat{ 
		color:blue;
		background-color: blue; }
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
</style>
<script>

	$(function(){
		
		$('button[name="updateSchedule"]').on("click", function(arg){
  		  
  		    var scheduleNo = $('input[name="getSchedulNo"]').val();
      	    var scheduleStartDate = $('input[name="getScheduleStartDate"]').val();
      		var scheduleEndDate = $('input[name="getScheduleEndDate"]').val();
      		var scheduleStartTime = $('select[name="getScheduleStartTime"]').val();
      		var scheduleEndTime = $('select[name="getScheduleEndTime"]').val();
      		var scheduleColor = $("select[name='getScheduleColor']").val();
      		var scheduleTitle = $("input[name='getScheduleTitle']").val();
      		var scheduleContents = $("textarea[name='getScheduleContents']").val();

      		var startDate = scheduleStartDate+" "+scheduleStartTime;
      		var endDate = scheduleEndDate+" "+scheduleEndTime;
				
      		
      		
      		
      		$.ajax({
      			method : "POST",
      			data: JSON.stringify({
      				'scheduleStartDate':startDate,
      				'scheduleEndDate':endDate,
      				'scheduleColor':scheduleColor,
      				'scheduleTitle':scheduleTitle,
      				'scheduleContents':scheduleContents,
      				'scheduleNo':scheduleNo
      			}),
      			dataType : 'JSON',
      			headers : {
      				"Accept" : "application/json",
      				"Content-Type" : "application/json"	 						
      			} ,
      			async: false,
      			url : "/admin/schedule/json/updateSchedule?${_csrf.parameterName}=${_csrf.token}",
      			success : function(result){
      				alert("일정이 수정 되었습니다.");
      				location.reload();
      			},
      			error:function(request, status, error){
      				
      			}
      				
      		})
      	
			  
		  });
		
		$('button[name="deleteSchedule"]').on("click", function(){
			  
			  var scheduleNo = $('input[name="getSchedulNo"]').val();
				
			  if(!confirm("해당 일정을 정말 삭제하시겠습니까?")){
					return;
					
			  }else{
	  		  $.ajax({
		    			url : "/admin/schedule/json/deleteSchedule/"+scheduleNo,
		    			method : "GET",
		    			dataType : "JSON",	
		    			headers : {
		    				"Accept" : "application/json",
		    				"Content-Type" : "application/json"	 						
		    			} ,
		    			success : function(JSONData, status){
		    				alert("일정이 삭제 되었습니다.")
		    				location.reload();
		    			}
		    			
		      })
		      
			  }
			  
		  })
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
					right: 'dayGridMonth,timeGridWeek,timeGridDay' 
			  },
	          allDayText: '시간',
	          axisFormat: 'HH:mm',
	          timeFormat: 'HH:mm',
	          monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	          dayNames: ['일','월','화','수','목','금','토'],
	          dayNamesShort: ['일','월','화','수','목','금','토'],
	          buttonText: {
	              today: '오늘',
	              month: '월간',
	              week: '주간',
	              day: '일간'
	          },
              fixedWeekCount: false,
              selectable: true,
              selectHelper: true,
              editable: true,     // 드래그 수정 가능 여부
              droppable: true,    // drop 가능하게
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
    						console.log($("div[class='fc-daygrid-event-harness']"))
    						
	    				}
	    			},
        			error:function(request, status, error){
        				alert("경고")
        			}
	    			
	    		})
	          ,
			 eventClick: function(arg){
			  
					 $('#modalContent7').modal({backdrop:'static', show:true});
					 $("input[name='getScheduleTitle']").val(arg.event.title);
					 $("textarea[name='getScheduleContents']").val(arg.event.extendedProps.contents);
					 $("input[name='getScheduleStartDate']").val(moment(arg.event.start).format('YYYY-MM-DD'));
					 $("input[name='getScheduleEndDate']").val(moment(arg.event.end).format('YYYY-MM-DD'));
					 $("select[name='getScheduleStartTime']").val(moment(arg.event.start).format('HH:mm'))
					 $("select[name='getScheduleEndTime']").val(moment(arg.event.end).format('HH:mm'))
					 $("select[name='getScheduleColor']").val(arg.event.backgroundColor);
					 $("select[name='getScheduleColor']").colorselector('setColor', arg.event.backgroundColor);
					 $("input[name='getSchedulNo']").val(arg.event.id);
			 },
          eventDrop: function(arg){
        	  var scheduleNo = arg.event.id;
        	  var scheduleTitle = arg.event.title;
        	  var scheduleContents = arg.event.extendedProps.contents;
        	  var scheduleStartDate = moment(arg.event.start).format('YYYY-MM-DD');
        	  var scheduleEndDate = moment(arg.event.end).format('YYYY-MM-DD');
        	  var scheduleStartTime = moment(arg.event.start).format('HH:mm');
        	  var scheduleEndTime = moment(arg.event.end).format('HH:mm');
        	  var scheduleColor = arg.event.backgroundColor;
        	  
        	  var startDate = scheduleStartDate+" "+scheduleStartTime;
        	  var endDate = scheduleEndDate+" "+scheduleEndTime;
        	  
       		  $.ajax({
       			  url : "/admin/schedule/json/updateSchedule?${_csrf.parameterName}=${_csrf.token}",
       			  method : "POST",
       			  data: JSON.stringify({
       				  'scheduleStartDate':startDate,
       				  'scheduleEndDate':endDate,
       				  'scheduleColor':scheduleColor,
       				  'scheduleTitle':scheduleTitle,
       				  'scheduleContents':scheduleContents,
       				  'scheduleNo':scheduleNo
       		  	  }),
       			  dataType : 'JSON',
       			  headers : {
       				  "Accept" : "application/json",
       				  "Content-Type" : "application/json"	 						
       			  } ,
       			  success : function(data){
						alert("일정이 수정 되었습니다.");
       			  },
       			  error:function(request, status, error){
       				
       			  }  
       				
       		  })
        	  
          },
			  select: function(event) {
				  $('#modalContent6').modal({backdrop:'static', show:true});
	              $('input[name="scheduleStartDate"]').val(moment(event.start).format('YYYY-MM-DD'));
	              $('input[name="scheduleEndDate"]').val(moment(event.end).format('YYYY-MM-DD'));
	              $('select[name="scheduleStartTime"]').val(moment(event.start).format('09:00'));
	              $('select[name="scheduleEndTime"]').val(moment(event.end).format('09:30'));
	              $("input[name='scheduleTitle']").val(event.title);
	              $("textarea[name='scheduleContents']").val(event.content);
	              $("select[name='scheduleColor']").val(event.backgroundColor);
	              $('.btn-colorselector').css('background-color',event.backgroundColor);
	              $('#display_reply').css('display','');
	              //$('#colorselector').colorselector('setColor', event.backgroundColor);
	              
	              $('button[name="addSchedule"]').on("click", function(){
					
	            	  var scheduleStartDate = $('input[name="scheduleStartDate"]').val();
		        		var scheduleEndDate = $('input[name="scheduleEndDate"]').val();
		        		var scheduleStartTime = $('select[name="scheduleStartTime"]').val();
		        		var scheduleEndTime = $('select[name="scheduleEndTime"]').val();
		        		var scheduleColor = $("select[name='scheduleColor']").val();
		        		var scheduleTitle = $("input[name='scheduleTitle']").val();
		        		var scheduleContents = $("textarea[name='scheduleContents']").val();
		        	
		        		var schedule = {
		        				scheduleStartDate:scheduleStartDate,
		        				scheduleEndDate:scheduleEndDate,
		        				scheduleColor:scheduleColor,
		        				scheduleTitle:scheduleTitle,
		        				scheduleContents:scheduleContents
		        		};
		        		var startDate = scheduleStartDate+" "+scheduleStartTime;
		        		var endDate = scheduleEndDate+" "+scheduleEndTime;

		        		
		        		$.ajax({
		        			url : "/admin/schedule/json/addSchedule?${_csrf.parameterName}=${_csrf.token}",
		        			method : "POST",
		        			data: JSON.stringify({
		        				'scheduleStartDate':startDate,
		        				'scheduleEndDate':endDate,
		        				'scheduleColor':scheduleColor,
		        				'scheduleTitle':scheduleTitle,
		        				'scheduleContents':scheduleContents
		        			}),
		        			dataType : 'JSON',
		        			headers : {
		        				"Accept" : "application/json",
		        				"Content-Type" : "application/json"	 						
		        			} ,
		        			success : function(data){

		        				calendar.addEvent({
		        					title: scheduleTitle,
		        					start: scheduleStartDate,
		        					end: scheduleEndDate,
		        					backgroundColor: scheduleColor
		        				});
		        				location.reload();
		        			},
		        			error:function(request, status, error){
		        				alert("경고")
		        			}
		        				
		        		})
					  
				  })
			  }

        });
        calendar.render();
      }); 
      

		$(function(){      
		    /* datepicker */
		    $( "#datepicker1,#datepicker2,#datepicker3,#datepicker4" ).datepicker({
		        dateFormat: 'yy-mm-dd',
		        prevText: '이전 달',
		        nextText: '다음 달',
		        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        dayNames: ['일','월','화','수','목','금','토'],
		        dayNamesShort: ['일','월','화','수','목','금','토'],
		        dayNamesMin: ['일','월','화','수','목','금','토'],
		        showMonthAfterYear: true,
		        yearSuffix: '년'
		    });
		    $('#datepicker1,#datepicker2,#datepicker3,#datepicker4').datepicker({
		        dateFormat: 'yy-mm-dd'
		    });
		    $('#colorselector').colorselector();
		    $('#colorselector2').colorselector();
		});
	
    	
     
      
</script>

</head>

<section class="content-header">
    <h1>
    일정 관리
    <small>schedule list</small>
    </h1>

    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">일정 관리</li>
    </ol>
</section>

<section class="content">
  <div class="row">
    <div class="col-md-12">
      <div class="box box-primary">
        <div class="box-body no-padding">
          <!-- THE CALENDAR -->          
          <div id="calendar"></div>
        </div><!-- /.box-body -->
      </div><!-- /. box -->
    </div><!-- /.col -->
  </div><!-- /.row -->
</section>

<jsp:include page="/WEB-INF/views/admin/schedule/addSchedule.jsp"/>
<jsp:include page="/WEB-INF/views/admin/schedule/getSchedule.jsp"/>
</div><!-- /.content-wrapper -->

<footer class="main-footer">
<div class="pull-right hidden-xs">
    <b>Version</b> 2.7.4
</div>
<strong>Copyright &copy; 2017 <a href="/admin">MIR9 SHOP</a>.</strong> All rights reserved.
</footer>

