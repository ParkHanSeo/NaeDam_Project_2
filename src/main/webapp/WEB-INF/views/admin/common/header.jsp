<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="_csrf_header" id="_csrf_header" content="${_csrf.headerName}">
<meta name="_csrf" id="_scrf" content="${_csrf.token}">
<meta name="naver-site-verification" content="b08b53e0660f883a76f509d68079560f01abf7bf" />
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<title>ND C&C | ${param.title}</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/76afde4c0b.js" crossorigin="anonymous"></script>
<!-- Ionicons -->
<script src="https://unpkg.com/ionicons@4.4.1/dist/ionicons.js"></script>

<!-- jvectormap -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/jquery.vector-map.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/_all-skins.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/admin.css" type="text/css" />
<!-- fullcalendar -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/fullcalendar/css/bootstrap-colorselector.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/fullcalendar/css/fullcalendar.min.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/fullcalendar/css/fullcalendar.print.css" type="text/css" media="print" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<!-- Google Font -->
<link rel="stylesheet"
	  href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/jquery-ui.css" />
<style>
.modal-body {
    background-color: #fff;
}	  
</style>
<script type="text/javascript">
	$(function(){
		
		$("a[name='board']").one("click", function(){
			
			$.ajax({
				url : "/admin/board/json/listBoard",
				method : "GET" ,
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(Data, status){
					var display = '';
					if(Data.length > 0){
						for(var i = 0; i < Data.length; i++){
							display = "<li>"
									+ "<a href=/admin/board/postList?boardNo="+Data[i].boardNo+">"
									+ "<i class='fa fa-circle-o'></i> "+Data[i].boardTitle
									+ "</a>"
									+ "</li>"
							$('#boardMenu').append(display);
						}
					}			
				}
			});	
		});
		
		$("a[name='form']").one("click", function(){
			$.ajax({
				url : "/admin/form/json/formList",
				method : "GET" ,
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(Data, status){
					var display = '';
					if(Data.length > 0){
						for(var i = 0; i < Data.length; i++){
							display = "<li>"
									+ "<a href=/admin/form/formPostList?formNo="+Data[i].formNo+">"
									+ "<i class='fa fa-circle-o'></i> "+Data[i].title
									+ "</a>"
									+ "</li>"
							$('#formMenu').append(display);
						}
					}			
				}
			});			
		});
		
		$.ajax({
			url : "/admin/board/json/getAdminMenu",
			method : "GET" ,
			dataType : "json" ,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(Data, status){
				if(Data[0].status == 'N'){
					document.getElementById("menuManage").style.display = 'none';
				}if(Data[1].status == 'N'){
					document.getElementById("boardManage").style.display = 'none';
				}if(Data[2].status == 'N'){
					document.getElementById("productManage").style.display = 'none';
				}if(Data[3].status == 'N'){
					document.getElementById("memberManage").style.display = 'none';
				}if(Data[4].status == 'N'){
					document.getElementById("scheduleManage").style.display = 'none';
				}if(Data[5].status == 'N'){
					document.getElementById("formMailManage").style.display = 'none';
				}if(Data[6].status == 'N'){
					document.getElementById("popupManage").style.display = 'none';
				}if(Data[7].status == 'N'){
					document.getElementById("mapManage").style.display = 'none';
				}if(Data[8].status == 'N'){
					document.getElementById("staffManage").style.display = 'none';
				}if(Data[9].status == 'N'){
					document.getElementById("historyManage").style.display = 'none';
				}if(Data[10].status == 'N'){
					document.getElementById("bannerManage").style.display = 'none';
				}if(Data[11].status == 'N'){
					document.getElementById("contractManage").style.display = 'none';
				}if(Data[12].status == 'N'){
					document.getElementById("companyManage").style.display = 'none';
				}if(Data[13].status == 'N'){
					document.getElementById("infoManage").style.display = 'none';
				}if(Data[14].status == 'N'){
					document.getElementById("localeManage").style.display = 'none';
				}if(Data[15].status == 'N'){
					document.getElementById("seoManage").style.display = 'none';
				}if(Data[16].status == 'N'){
					document.getElementById("paymentManage").style.display = 'none';
				}if(Data[17].status == 'N'){
					document.getElementById("snsManage").style.display = 'none';
				}
			}
		})
	})
</script>

<script>
function logoutSubmit(){
	$(document.memberLogoutFrm).submit();
}
</script>

<!-- redirect Msg 처리 : deliveryController 참조 -->
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
		location.reload();
	</script>
</c:if>
	
</head>
<body class="hold-transition skin-red sidebar-mini">
	<iframe name="iframe_process" width="0" height="0" frameborder="0" style="display: none;"></iframe>

	<div class="wrapper">
		<!-- header -->
		<header class="main-header">
			<a href="${pageContext.request.contextPath}/admin/dashBoard" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini"><b>A</b></span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg">
					<b><img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/neadam_logo.png"></b>
				</span>
			</a>
			<nav class="navbar navbar-static-top">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button"> 
					<span class="sr-only">Toggle navigation</span>
				</a>
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<li class="dropdown user user-menu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
								<img src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/img/avatar5.png" class="user-image" alt="User Image" /> 
								<span class="hidden-xs">
									<sec:authentication property="principal.username" />
									<sec:authentication property="authorities" />${loginMember.lastName}${loginMember.firstName}님
								</span>
							</a>
							<ul class="dropdown-menu">
								<li class="user-header">
									<img src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/img/avatar5.png" class="img-circle" alt="User Image" />
									<p>
										<sec:authentication property="principal.username" />
										${loginMember.lastName}${loginMember.firstName}님 - Web Administrator 
										<small>NaeDam 관리자</small>
									</p>
								</li>
								<li class="user-footer">
									<div class="pull-left">
										<button class="btn btn-outline-success my-2 my-sm-0" type="button" onclick="location.href='${pageContext.request.contextPath}/admin/member/memberWithdrawal.do';">탈퇴</button>
									</div>
									<div class="pull-right">
										<form:form id="memberLogoutFrm" name="memberLogoutFrm" method="POST" action="${pageContext.request.contextPath}/admin/member/memberLogout.do">
											<a onclick="logoutSubmit()" class="btn btn-danger btn-flat" type="submit">Sign out</a>
										</form:form>
									</div>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</nav>
		</header> <!-- /.header -->
		
		<!-- sidebar -->
		<aside class="main-sidebar">
			<section class="sidebar">
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header">NaeDam Admin</li>
					<li>
						<a href="${pageContext.request.contextPath}/admin/dashBoard"> 
							<i class="fa fa-dashboard"></i> <span>Dashboard</span>
						</a>
					</li>
					<li class="treeview">
						<a href="#"> 
							<i class="fa fa-shopping-cart"></i> <span>주문 관리</span> 
							<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="${pageContext.request.contextPath }/admin/order/list">
									<i class="fa fa-circle-o"></i> 주문 리스트
								</a>
							</li>
							<li>
								<a href="https://iniweb.inicis.com/security/login.do" target="_new">
									<i class="fa fa-circle-o"></i> 이니시스 상점관리자
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/order/log_list">
									<i class="fa fa-circle-o"></i> 카드결제로그 리스트
								</a>
							</li>
						</ul>
					</li>
					<li class="treeview" id="menuManage">
						<a href="#"> 
							<i class="fa fa-file-text-o"></i> <span>메뉴 관리</span> 
							<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="${pageContext.request.contextPath}/admin/menu/menu">
									<i class="fa fa-circle-o"></i> 메뉴 관리
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/menu/headList">
									<i class="fa fa-circle-o"></i> 헤더 관리
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/menu/bottomList">
									<i class="fa fa-circle-o"></i> 하단 관리
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/menu/meta">
									<i class="fa fa-circle-o"></i> 메타 관리
								</a>
							</li>
						</ul>
					</li>
					<li class="treeview" id="boardManage">
						<a href="#" name="board"> 
							<i class="fa fa-list-alt"></i> <span>게시판 관리</span> 
							<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu" id="boardMenu" >
							<li>
								<a href="/admin/board/listBoard">
									<i class="fa fa-circle-o"></i> 리스트
								</a>
							</li>
						</ul>
					</li>
					<li class="treeview" id="productManage">
						<a href="${pageContext.request.contextPath }/admin/product/list"> 
							<i class="fa fa-gift"></i> <span>제품</span> 
							<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="${pageContext.request.contextPath }/admin/product/list">
									<i class="fa fa-circle-o"></i> 리스트 
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/admin/product/category">
									<i class="fa fa-circle-o"></i> 카테고리 
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/admin/product/option">
									<i class="fa fa-circle-o"></i> 자주쓰는 옵션 관리 
								</a>
							</li>
						</ul>
					</li>
					<li class="treeview" id="memberManage">
						<a href="#"> 
							<i class="fa fa-user"></i> <span>회원 관리</span> 
							<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="${pageContext.request.contextPath}/admin/member/list.do">
									<i class="fa fa-circle-o"></i> 회원 리스트
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/member/withdrawalList.do">
									<i class="fa fa-circle-o"></i> 탈퇴회원 리스트
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/member/log">
									<i class="fa fa-circle-o"></i> 회원 접속이력 관리
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/member/memberGrade.do">
									<i class="fa fa-circle-o"></i> 등급 관리
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/member/point">
									<i class="fa fa-circle-o"></i> 회원 적립금 관리
								</a>
							</li>
						</ul>
					</li>
					<li class="" id="scheduleManage">
						<a href="/admin/schedule/schedule"> 
							<i class="fa fa-calendar"></i> <span>일정 관리</span>
						</a>
					</li>
					<li class="treeview" id="formManage" >
						<a href="#" name="form"> 
							<i class="fa fa-check-square-o"></i> <span>폼메일 관리</span> 
							<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu" id="formMenu">
							<li>
								<a href="${pageContext.request.contextPath}/admin/form/list">
									<i class="fa fa-circle-o"></i> 리스트
								</a>
							</li>
							<!-- 폼메일 리스트 
							<li>
								<a href="${pageContext.request.contextPath}/admin/form/qna">
									<i class="fa fa-circle-o"></i> 문의사항
								</a>
							</li>
							 -->
						</ul>
					</li>
					<li class="treeview" id="statisticsManage">
						<a href="#"> 
							<i class="fa fa-shopping-cart"></i> <span>통계</span> 
							<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="${pageContext.request.contextPath}/admin/statistics/period_day">
									<i class="fa fa-circle-o"></i> 기간별 매출 통계 
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/statistics/product">
									<i class="fa fa-circle-o"></i> 제품별 매출 통계 
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/statistics/member">
									<i class="fa fa-circle-o"></i> 회원별 매출 통계 
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/statistics/address_day">
									<i class="fa fa-circle-o"></i> 지역별 매출 통계 
								</a>
							</li>
						</ul>
					</li>
					<li class="treeview">
						<a href="#"> 
							<i class="fa fa-commenting"></i> <span>커뮤니티 관리</span> 
							<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="${pageContext.request.contextPath}/admin/comm/email">
									<i class="fa fa-circle-o"></i> 메일 설정
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/comm/emailList">
									<i class="fa fa-circle-o"></i> 메일 발송 내역
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/comm/sms">
									<i class="fa fa-circle-o"></i> SMS 설정
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/comm/smsList">
									<i class="fa fa-circle-o"></i> SMS 발송 내역
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/comm/review">
									<i class="fa fa-circle-o"></i> 주문후기 리스트
								</a>
							</li>
						</ul>
					</li>
					<li class="treeview">
						<a href="#"> 
							<i class="fa fa-gear"></i> <span>설정</span> 
							<i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="${pageContext.request.contextPath}/admin/setting/point">
									<i class="fa fa-circle-o"></i> 적립금 관리
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/setting/coupon">
									<i class="fa fa-circle-o"></i> 쿠폰 관리
								</a>
							</li>
							<li id="popupManage">
								<a href="${pageContext.request.contextPath}/admin/setting/popup">
									<i class="fa fa-circle-o"></i> 팝업 관리
								</a>
							</li>
							<li id="mapManage">
								<a href="${pageContext.request.contextPath }/admin/setting/map">
									<i class="fa fa-circle-o"></i> 약도 관리
								</a>
							</li>
							<li id="staffManage">
								<a href="${pageContext.request.contextPath}/admin/setting/staff.do">
									<i class="fa fa-circle-o"></i> 임원 관리
								</a>
							</li>
							<li id="historyManage">
								<a href="${pageContext.request.contextPath }/admin/setting/history">
									<i class="fa fa-circle-o"></i> 연혁 관리
								</a>
							</li>
							<li id="bannerManage">
								<a href="${pageContext.request.contextPath}/admin/setting/banner">
									<i class="fa fa-circle-o"></i> 배너 관리
								</a>
							</li>
							<li id="contractManage">
								<a href="${pageContext.request.contextPath}/admin/setting/contract">
									<i class="fa fa-circle-o"></i> 약관 관리
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/admin/setting/delivery_setting">
									<i class="fa fa-circle-o"></i> 배송 설정
								</a>
							</li>
							<li id="companyManage">
								<a href="${pageContext.request.contextPath }/admin/setting/delivery_company">
									<i class="fa fa-circle-o"></i> 택배사 관리
								</a>
							</li>
							<li id="infoManage">
								<a href="${pageContext.request.contextPath}/admin/setting/info">
									<i class="fa fa-circle-o"></i> 기본 설정
								</a>
							</li>
							<li id="seoManage">
								<a href="${pageContext.request.contextPath}/admin/setting/seo">
									<i class="fa fa-circle-o"></i> SEO 설정
								</a>
							</li>
							<li id="paymentManage">
								<a href="${pageContext.request.contextPath}/admin/setting/paymentpg">
									<i class="fa fa-circle-o"></i> 결제PG 설정
								</a>
							</li>
							<li id="snsManage">
								<a href="${pageContext.request.contextPath}/admin/setting/snslogin">
									<i class="fa fa-circle-o"></i> SNS 연동 설정
								</a>
							</li>
							<li id="localeManage">
								<a href="${pageContext.request.contextPath}/admin/setting/locale">
									<i class="fa fa-circle-o"></i> 다국어 번역
								</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/admin/setting/version"> 
							<i class="fa fa-exclamation-circle"></i> <span>Version</span> 
							<small class="label pull-right bg-green">2.8.1</small>
						</a>
					</li>
				</ul>
			</section>
		</aside> <!-- /.sidebar -->
