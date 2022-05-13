<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" style="height: auto; min-height: 100%;"><head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AdminLTE 2 | Dashboard</title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet" href="/html/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="/html/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/Ionicons/css/ionicons.min.css">
<!-- jvectormap -->
<link rel="stylesheet" href="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jvectormap/jquery-jvectormap.css">
<!-- Theme style -->
<link rel="stylesheet" href="//mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="//mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/css/skins/_all-skins.min.css">
<link href="//mir9.co.kr/resource/css/admin.css" rel="stylesheet" type="text/css">
<link href="//mir9.co.kr/resource/css/jquery-ui.css" rel="stylesheet">
<!-- fullcalendar -->
<link href="//mir9.co.kr/resource/css/bootstrap-colorselector.css" rel="stylesheet">
<link href="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/fullcalendar/dist/fullcalendar.min.css" rel="stylesheet" type="text/css">
<link href="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/fullcalendar/dist/fullcalendar.print.css" rel="stylesheet" type="text/css" media="print">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<!-- Google Font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;box-sizing: content-box;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style></head>

<body class="skin-red sidebar-mini" style="height: auto; min-height: 100%;">
<iframe name="iframe_process" width="0" height="0" frameborder="0" style="display:none;"></iframe>

<div class="wrapper" style="height: auto; min-height: 100%;">

<!-- header -->
<header class="main-header">
    <a href="/admin" class="logo">
    <!-- mini logo for sidebar mini 50x50 pixels -->
    <span class="logo-mini"><b>A</b></span>
    <!-- logo for regular state and mobile devices -->
    <span class="logo-lg"><b>MIR9 SHOP Admin</b></span>
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
                <img src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/img/avatar5.png" class="user-image" alt="User Image">
                <span class="hidden-xs">길동이</span>
            </a>
            <ul class="dropdown-menu">
                <li class="user-header">
                    <img src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/img/avatar5.png" class="img-circle" alt="User Image">
                    <p>
                    길동이 - Web Administrator
                    <small>MIR9 SHOP 관리자</small>
                    </p>
                </li>
                <li class="user-footer">
                    <div class="pull-right">
                        <a href="?tpf=member/logout" class="btn btn-danger btn-flat">Sign out</a>
                    </div>
                </li>
            </ul>
            </li>
        </ul>
        </div>
    </nav>
</header><!-- /.header -->

<!-- sidebar -->
<aside class="main-sidebar">
    <section class="sidebar" style="height: auto;">
        <ul class="sidebar-menu tree" data-widget="tree">
            <li class="header">MAIN NAVIGATION</li>
            <li>
                <a href="?tpf=admin/dashboard/list">
                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                </a>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-shopping-cart"></i> <span>주문 관리</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="?tpf=admin/order/list"><i class="fa fa-circle-o"></i> 주문 리스트</a></li>
                    <li><a href="https://iniweb.inicis.com/security/login.do" target="_new"><i class="fa fa-circle-o"></i> 이니시스 상점관리자</a></li>
                    <li><a href="?tpf=admin/order/log_list"><i class="fa fa-circle-o"></i>카드결제로그 리스트</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-file-text-o"></i> <span>메뉴 관리</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="?tpf=admin/menu/list&amp;menu=manager"><i class="fa fa-circle-o"></i> 메뉴 관리</a></li>
                    <li><a href="?tpf=admin/menu/head"><i class="fa fa-circle-o"></i> 헤더 관리</a></li>
                    <li><a href="?tpf=admin/menu/bottom"><i class="fa fa-circle-o"></i> 하단 관리</a></li>
                    <li><a href="?tpf=admin/menu/meta"><i class="fa fa-circle-o"></i> 메타 관리</a></li>
                </ul>
            </li>

            <li class="active treeview menu-open">
                <a href="#">
                <i class="fa fa-list-alt"></i> <span>게시판 관리</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li class="active"><a href="index.php?tpf=admin/board/manage"><i class="fa fa-circle-o"></i> 리스트</a></li>
      <li><a href="index.php?tpf=admin/board/list_upload&amp;board_code=1"><i class="fa fa-circle-o"></i> 공지사항</a></li>      <li><a href="index.php?tpf=admin/board/list&amp;board_code=2"><i class="fa fa-circle-o"></i> 자주하는 질문</a></li>      <li><a href="index.php?tpf=admin/board/list&amp;board_code=3"><i class="fa fa-circle-o"></i> 1:1 문의</a></li>              </ul>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-gift"></i> <span>제품</span>  <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="?tpf=admin/product/list"><i class="fa fa-circle-o"></i> 리스트 </a></li>
                    <li><a href="?tpf=admin/product/category"><i class="fa fa-circle-o"></i> 카테고리 </a></li>
                    <li><a href="?tpf=admin/product/option_bank"><i class="fa fa-circle-o"></i> 자주쓰는 옵션 관리 </a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-user"></i> <span>회원 관리</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="?tpf=admin/member/list"><i class="fa fa-circle-o"></i> 회원 리스트</a></li>
                    <li><a href="?tpf=admin/member/withdraw_list"><i class="fa fa-circle-o"></i> 탈퇴회원 리스트</a></li>
                    <li><a href="?tpf=admin/member/log"><i class="fa fa-circle-o"></i> 회원 접속이력 관리</a></li>
                    <li><a href="?tpf=admin/member/level"><i class="fa fa-circle-o"></i> 등급 관리</a></li>
                    <li><a href="?tpf=admin/member/point"><i class="fa fa-circle-o"></i> 회원 적립금 관리</a></li>
                </ul>
            </li>
            <li class="">
                <a href="?tpf=admin/schedule/list">
                <i class="fa fa-calendar"></i> <span>일정 관리</span>
                </a>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-check-square-o"></i> <span>폼메일 관리</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li class="active"><a href="index.php?tpf=admin/form/manage"><i class="fa fa-circle-o"></i> 리스트</a></li>
      <li><a href="index.php?tpf=admin/form/list&amp;form_code=1"><i class="fa fa-circle-o"></i> 문의사항</a></li>      <li><a href="index.php?tpf=admin/form/list&amp;form_code=8"><i class="fa fa-circle-o"></i> test</a></li>              </ul>
            </li>
			<li class="treeview">
                <a href="#">
                <i class="fa fa-shopping-cart"></i> <span>통계</span>  <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="?tpf=admin/statistics/sales_day"><i class="fa fa-circle-o"></i>기간별 매출 통계 </a></li>
					<li><a href="?tpf=admin/statistics/sales_product"><i class="fa fa-circle-o"></i>제품별 매출 통계 </a></li>
					<li><a href="?tpf=admin/statistics/sales_member"><i class="fa fa-circle-o"></i>회원별 매출 통계 </a></li>
					<li><a href="?tpf=admin/statistics/sales_address_day"><i class="fa fa-circle-o"></i>지역별 매출 통계 </a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-commenting"></i> <span>커뮤니티 관리</span>  <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="?tpf=admin/community/email"><i class="fa fa-circle-o"></i>메일 설정</a></li>
                    <li><a href="?tpf=admin/community/email_list"><i class="fa fa-circle-o"></i>메일 발송 내역</a></li>
                    <li><a href="?tpf=admin/community/sms"><i class="fa fa-circle-o"></i>SMS 설정</a></li>
                    <li><a href="?tpf=admin/community/sms_list"><i class="fa fa-circle-o"></i>SMS 발송 내역</a></li>
                    <li><a href="?tpf=admin/community/review"><i class="fa fa-circle-o"></i>주문후기 리스트</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-gear"></i> <span>설정</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="?tpf=admin/setting/point"><i class="fa fa-circle-o"></i> 적립금 관리</a></li>
                    <li><a href="?tpf=admin/setting/coupon"><i class="fa fa-circle-o"></i> 쿠폰 관리</a></li>
<li><a href="?tpf=admin/setting/popup"><i class="fa fa-circle-o"></i> 팝업 관리</a></li><li><a href="?tpf=admin/setting/map"><i class="fa fa-circle-o"></i> 약도 관리</a></li><li><a href="?tpf=admin/setting/staff"><i class="fa fa-circle-o"></i> 임원 관리</a></li><li><a href="?tpf=admin/setting/history"><i class="fa fa-circle-o"></i> 연혁 관리</a></li><li><a href="?tpf=admin/setting/banner"><i class="fa fa-circle-o"></i> 배너 관리</a></li><li><a href="?tpf=admin/setting/contract"><i class="fa fa-circle-o"></i> 약관 관리</a></li>				<li><a href="?tpf=admin/setting/delivery_setting"><i class="fa fa-circle-o"></i> 배송 설정</a></li>
<li><a href="?tpf=admin/setting/delivery_company"><i class="fa fa-circle-o"></i> 택배사 관리</a></li><li><a href="?tpf=admin/setting/info"><i class="fa fa-circle-o"></i> 기본 설정</a></li><li><a href="?tpf=admin/setting/seo"><i class="fa fa-circle-o"></i> SEO 설정</a></li><li><a href="?tpf=admin/setting/paymentpg"><i class="fa fa-circle-o"></i> 결제PG 설정</a></li><li><a href="?tpf=admin/setting/snslogin"><i class="fa fa-circle-o"></i> SNS  연동 설정</a></li><li><a href="?tpf=admin/setting/locale"><i class="fa fa-circle-o"></i> 다국어 번역</a></li>                </ul>
            </li>
            <li>
                <a href="?tpf=admin/setting/version">
                <i class="fa fa-exclamation-circle"></i> <span>Version</span> <small class="label pull-right bg-green">2.8.1</small>
                </a>
            </li>
        </ul>
    </section>
</aside><!-- /.sidebar -->
<!-- content-wrapper -->
<div class="content-wrapper" style="min-height: 868px;">
<style>
.option_tab { display:inline-block; width:130px;}
</style>

<section class="content-header">
    <h1>
    게시판 관리
    <small>게시판 list</small>
    </h1>

    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li>게시판 관리</li>
        <li class="active">게시판 리스트</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <label style="margin-top:5px;">총 3 건</label>

                    <table class="table table-bordered table-hover">
                    <form name="form_list" method="post" action="?tpf=admin/board/manage_process"></form>
		            <input type="hidden" name="mode" id="mode">
		            <thead>
                    <tr>
                        <td style="width:30px;"><input type="checkbox" name="select_all" onclick="selectAllCheckBox('form_list');"></td>
                        <td style="width:60px;">NO</td>
                        <td>제목</td>
                        <td style="width:250px;">연결주소</td>
                        <td style="width:100px;">type</td>
                        <td style="width:80px;">등록 글수</td>
                        <td style="width:220px;">명령</td>
                    </tr>
                    </thead>
      <tbody><tr>
                        <td><input type="checkbox" name="list[]" value="1"></td>
                        <td>1</td>
                        <td align="left">공지사항</td>
                        <td align="left">[include:tpf=board/list&amp;board_code=1]</td>
                        <td>갤러리</td>
                        <td>1</td>
                        <td>
                        <button type="button" onclick="_onclickView('board',1);" class="btn btn-success btn-xs">바로가기</button>
                        <button type="button" onclick="onclickCopy(1);" class="btn btn-warning btn-xs">링크복사</button>
                        <button type="button" onclick="onclickUpdate(1);" class="btn btn-primary btn-xs">상세보기</button>
                        </td>
                    </tr>      <tr>
                        <td><input type="checkbox" name="list[]" value="2"></td>
                        <td>2</td>
                        <td align="left">자주하는 질문</td>
                        <td align="left">[include:tpf=board/list&amp;board_code=2]</td>
                        <td>FAQ</td>
                        <td>0</td>
                        <td>
                        <button type="button" onclick="_onclickView('board',2);" class="btn btn-success btn-xs">바로가기</button>
                        <button type="button" onclick="onclickCopy(2);" class="btn btn-warning btn-xs">링크복사</button>
                        <button type="button" onclick="onclickUpdate(2);" class="btn btn-primary btn-xs">상세보기</button>
                        </td>
                    </tr>      <tr>
                        <td><input type="checkbox" name="list[]" value="3"></td>
                        <td>3</td>
                        <td align="left">1:1 문의</td>
                        <td align="left">[include:tpf=board/list&amp;board_code=3]</td>
                        <td>갤러리</td>
                        <td>1</td>
                        <td>
                        <button type="button" onclick="_onclickView('board',3);" class="btn btn-success btn-xs">바로가기</button>
                        <button type="button" onclick="onclickCopy(3);" class="btn btn-warning btn-xs">링크복사</button>
                        <button type="button" onclick="onclickUpdate(3);" class="btn btn-primary btn-xs">상세보기</button>
                        </td>
                    </tr>                    
                    </tbody></table>
                    <br>

                    <button type="button" onclick="selectDelete('deleteBoard');" class="btn btn-danger btn-sm"><i class="fa fa-minus-square"></i> 선택삭제</button>
                    <button type="button" onclick="onclickInsert()" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 게시판 생성</button>

                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>

<div class="modal fade" id="modalRegister" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
    <div class="modal-dialog" style="width:600px;">
        <div class="modal-content">
            <form name="form" method="post" action="?tpf=admin/board/manage_process">
            <input type="hidden" name="mode" id="mode">
            <input type="hidden" name="board_code" id="board_code">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">게시판 생성</h4>
            </div>
            <div class="modal-body">

            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 게시판 정보</p></h4>
            <table class="table table-bordered">
            <tbody><tr>
                <td class="menu">제목</td>
                <td align="left" colspan="3"><input type="text" name="title" id="title" class="form-control input-sm"></td>
            </tr>
            <tr>
                <td class="menu">종류 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                <td colspan="3">
                <select name="type" id="type" class="form-control input-sm" style="width:120px;">
      <option value="list">일반</option>      <option value="gallery">갤러리</option>      <option value="qna">FAQ</option>      <option value="webzine">웹진</option>      <option value="movie">동영상</option>      <option value="event">이벤트</option>      <option value="manual">메뉴얼</option>      <option value="brochure">브로슈어</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">카테고리</td>
                <td align="left" colspan="3"><input type="text" name="category" id="category" class="form-control input-sm" placeholder=",(콤마)로 구분해 주세요"></td>
            </tr>
            <tr>
                <td class="menu">수신 메일 주소</td>
                <td align="left" colspan="3"><input type="text" name="receive_email" placeholder=", 구분" class="form-control input-sm"></td>
            </tr>
<!--
            <tr>
                <td class="menu">리스트 표출</td>
                <td align="left">
                <input type="radio" name="show_list" id="show_list_y" value="y">사용&nbsp;&nbsp;
                <input type="radio" name="show_list" id="show_list_n" value="n">숨김&nbsp;&nbsp;
                <span class="text-light-blue">※ 글 상세보기에서 리스트가 표출됩니다.<span>
                </td>
            </tr>
-->
            <tr>
                <td class="menu">리스트 권한</td>
                <td align="left">
                <select name="auth_list" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="5">모</option>      <option value="3">df</option>      <option value="2">뭐야 이</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
                <td class="menu">보기 권한</td>
                <td align="left">
                <select name="auth_view" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="5">모</option>      <option value="3">df</option>      <option value="2">뭐야 이</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">쓰기 권한</td>
                <td align="left">
                <select name="auth_write" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="5">모</option>      <option value="3">df</option>      <option value="2">뭐야 이</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
                <td class="menu">수정 권한</td>
                <td align="left">
                <select name="auth_update" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="5">모</option>      <option value="3">df</option>      <option value="2">뭐야 이</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">삭제 권한</td>
                <td align="left">
                <select name="auth_delete" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="5">모</option>      <option value="3">df</option>      <option value="2">뭐야 이</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
                <td class="menu">답변 권한</td>
                <td align="left">
                <select name="auth_reply" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="5">모</option>      <option value="3">df</option>      <option value="2">뭐야 이</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">공지 권한</td>
                <td align="left">
                <select name="auth_notice" class="form-control input-sm" style="width:120px;">
      <option value="5">모</option>      <option value="3">df</option>      <option value="2">뭐야 이</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
                <td class="menu">댓글 권한</td>
                <td align="left">
                <select name="auth_memo" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="5">모</option>      <option value="3">df</option>      <option value="2">뭐야 이</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">기타 옵션</td>
                <td align="left" colspan="3">
                <span class="option_tab"><input type="checkbox" name="is_notice" value="y">공지기능</span>
                <span class="option_tab"><input type="checkbox" name="show_memo" value="y">댓글</span>
                <span class="option_tab"><input type="checkbox" name="is_secret" value="y">비밀글</span>
                <span class="option_tab"><input type="checkbox" name="is_reply" value="y">답변기능</span>
                <span class="option_tab"><input type="checkbox" name="is_captcha" value="y">도용방지문자</span>
                <span class="option_tab"><input type="checkbox" name="is_mass" value="y">대용량 업로드</span>
                <span class="option_tab"><input type="checkbox" name="is_order" value="y">순서변경</span>
                <span class="option_tab" style="width:263px;"><input type="checkbox" name="is_addinfo" value="y">추가정보(휴대전화,이메일)</span>
                <span class="option_tab"><input type="checkbox" name="is_popup" value="y">상세보기(팝업)</span>
                </td>
            </tr>
            <tr>
                <td class="menu">구글번역 언어</td>
                <td align="left" colspan="3">
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_ko" value="ko">한국어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_en" value="en">영어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_zh-CN" value="zh-CN">중국어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_ja" value="ja">일본어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_de" value="de">독일어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_vi" value="vi">베트남어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_es" value="es">스페인어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_ar" value="ar">아랍어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_th" value="th">태국어</span>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                <textarea name="header" id="header" rows="6" class="form-control input-sm" placeholder="상단에 들어갈 css" style="width:100%;"></textarea>
                </td>
            </tr>
            </tbody></table>

            </div>
            <div class="modal-footer">
            <button type="button" onclick="register()" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
            </div>
            </form>
        </div>
    </div>
</div>
</div><!-- /.content-wrapper -->

<footer class="main-footer">
<div class="pull-right hidden-xs">
    <b>Version</b> 2.7.4
</div>
<strong>Copyright © 2017 <a href="/admin">MIR9 SHOP</a>.</strong> All rights reserved.
</footer>
</div>

<!-- jQuery 3 -->
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/js/adminlte.min.js"></script>
<!-- Sparkline -->
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
<!-- jvectormap  -->
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll -->
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- ChartJS -->
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/chart.js/Chart.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/js/demo.js"></script>
<script src="//mir9.co.kr/resource/js/jquery/jquery-ui.min.js"></script>
<script src="/html/js/common.js" type="text/javascript" charset="utf-8"></script>
<!-- fullcalendar -->
<script src="//mir9.co.kr/resource/js/bootstrap-colorselector.js"></script>
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/fullcalendar/dist/fullcalendar.moment.min.js" type="text/javascript"></script>
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/fullcalendar/dist/fullcalendar.min.js" type="text/javascript"></script>


<script>
        function register() {
            if(form.title.value == '') { alert('제목이 입력되지 않았습니다.'); form.title.focus(); return false;}
            form.target = 'iframe_process';
            form.submit();
        }
        function setData(code) {
        	$.ajax({
				url:'http://demoshop.mir9.kr/api/process.php',
				type:'post',
				dataType:'json',
				data:{
					method:'Board.info',
                    board_code:code
				},
				success:function(data, textStatus, jqXHR){
                    var json_data = data.data;
                    console.log('-----------');
                    console.log(json_data);
                    $('#board_code').val(json_data.code);
                    $('#title').val(json_data.title);
                    $('#header').val(json_data.header);
                    $('[name=type]').val(json_data.type);
                    $('#category').val(json_data.category);
                    $('[name=receive_email]').val(json_data.receive_email);
                    $('[name=auth_list]').val(json_data.auth_list);
                    $('[name=auth_view]').val(json_data.auth_view);
                    $('[name=auth_write]').val(json_data.auth_write);
                    $('[name=auth_reply]').val(json_data.auth_reply);
                    $('[name=auth_update]').val(json_data.auth_update);
                    $('[name=auth_memo]').val(json_data.auth_memo);
                    $('[name=auth_delete]').val(json_data.auth_delete);
                    $('[name=auth_notice]').val(json_data.auth_notice);
                    if(json_data.show_memo == 'y') $('[name=show_memo]').prop('checked', true);
                    else $('[name=show_memo]').prop('checked', false);
                    if(json_data.is_secret == 'y') $('[name=is_secret]').prop('checked', true);
                    else $('[name=is_secret]').prop('checked', false);
                    if(json_data.is_mass == 'y') $('[name=is_mass]').prop('checked', true);
                    else $('[name=is_mass]').prop('checked', false);
                    if(json_data.is_order == 'y') $('[name=is_order]').prop('checked', true);
                    else $('[name=is_order]').prop('checked', false);
                    if(json_data.is_captcha == 'y') $('[name=is_captcha]').prop('checked', true);
                    else $('[name=is_captcha]').prop('checked', false);
                    if(json_data.is_reply == 'y') $('[name=is_reply]').prop('checked', true);
                    else $('[name=is_reply]').prop('checked', false);
                    if(json_data.is_addinfo == 'y') $('[name=is_addinfo]').prop('checked', true);
                    else $('[name=is_addinfo]').prop('checked', false);
                    if(json_data.is_notice == 'y') $('[name=is_notice]').prop('checked', true);
                    else $('[name=is_notice]').prop('checked', false);
                    if(json_data.is_popup == 'y') $('[name=is_popup]').prop('checked', true);
                    else $('[name=is_popup]').prop('checked', false);
                    $('[name^=google_translate]').prop('checked', false);
                    if (json_data.google_translate != '' && json_data.google_translate != undefined) {
                        var arrGoogleTranslate = json_data.google_translate.split(',');
                        arrGoogleTranslate.forEach(function(element) {
                            $('#google_'+element).prop('checked', true);
                        });
                    }
				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log(textStatus);
					// $('#content').val(errorThrown);
				}
			});
        }
        function onclickInsert(code) {
            $('#modalRegister').modal({backdrop:'static', show:true});
            form.reset();
            form.mode.value = 'insert';
            $('[name=auth_write]').val(2);
            $('[name=auth_reply]').val(1);
            $('[name=auth_update]').val(2);
            $('[name=auth_memo]').val(2);
            $('[name=auth_delete]').val(2);
            $('[name=auth_notice]').val(1);
            $('[name=is_captcha]').prop('checked', true);
            $('[name=is_notice]').prop('checked', true);
            $('#myModalLabel').text('게시판 등록');
        }
        function onclickCopy(code) {
            var board_url = '[include:tpf=board/list&board_code='+code+']';
            var IE=(document.all)?true:false;
            if (IE) {
                if(confirm('이 게시판 주소를 복사하시겠습니까?'))
                window.clipboardData.setData('Text', board_url);
            } else {
                temp = prompt('이 게시판의 URL 입니다. Ctrl+C를 눌러 복사하세요', board_url);
            }
        }
        function onclickUpdate(code) {
            $('#modalRegister').modal({backdrop:'static', show:true});
            form.mode.value = 'update';
            $('#myModalLabel').text('게시판 수정');
            setData(code);
        }
</script>

</body></html>