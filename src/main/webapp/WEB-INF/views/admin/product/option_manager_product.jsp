<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>AdminLTE 2 | Dashboard</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<!-- Bootstrap 3.3.7 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/Ionicons/css/ionicons.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/css/AdminLTE.min.css">
	<link href="//mir9.co.kr/resource/css/admin.css" rel="stylesheet" type="text/css" />
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	<!-- Google Font -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition login-page">
	<iframe name="iframe_process" width="0" height="0" frameborder="0"></iframe>
	<section class="content" style="padding:15px 15px 0 15px;">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
						<form name="form_search" method="post" action="?tpf=admin/product/option_manager_product">
		                    <div class="box-tools pull-right" style="margin-top:20px;margin-bottom:5px;">
		                    	<input type="hidden" name="category_code" value="">
		                        <div class="has-feedback">
			                        <span>
			                        	<input type="text" name="keyword" value="" class="form-control input-sm" placeholder="상품 검색"/>
			                        	<span class="glyphicon glyphicon-search form-control-feedback"></span>
			                        </span>
		                        </div>
		                    </div>
		                    <div class="box-tools pull-right" style="margin-top:20px;">
		                        <div class="has-feedback">
		                        	<select name="field" class="form-control input-sm">
		      							<option value="title">상품명</option>                        
		      						</select>
		                        </div>
							</div>
	                    </form>
	                    <table class="table table-bordered table-hover">
		                    <thead>
			                    <tr>
			                        <td>카테고리</td>
			                        <td>상품명</td>
			                        <td>리스트 타이틀</td>
			                        <td>가격</td>
			                        <td style="width:90px;">등록일</td>
			                        <td style="width:60px;">명령</td>
			                    </tr>
		                    </thead>
	                    	<c:forEach var="product" items="${productList }">
			     				<tr>
			                        <td>${product.categoryName }</td>
			                        <td>${product.productName }</td>
			                        <td>${product.listTitle }</td>
			                        <td><fmt:formatNumber value="${product.salePrice }" pattern="#,###" /></td>
			                        <td><fmt:formatDate value="${product.regDate}" pattern="yyyy-MM-dd" /></td>
			                        <td><button type="button" onclick="setOption(${product.categoryNo});" class="btn btn-primary btn-xs">적용하기</button></td>
			                    </tr>                     
	                    	</c:forEach>
	                    </table>
	                    <br />
	                    <div style="text-align:right;">
	                        <ul class="pagination" style="margin:0;">
								<li class="active">
									<a href="?tpf=admin/product/option_manager_product&locale=ko&page=1">1</a>
								</li>
							</ul>                    
						</div>
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section><!-- /.content -->
<!-- jQuery 3 -->
<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js" type="text/javascript" charset="utf-8"></script>

<script>
	function setOption(optionNo){
		if(confirm('기존 상품의 옵션정보를 등록 할 경우 상품 등록화면에 입력된 옵션이 초기화 후 등록됩니다.\n등록하시겠습니까?')){
			parent.optionTabChange('1', '${pageContext.request.contextPath}/admin/option/option_manager?optionNo='+optionNo);
		}
	}   
</script>
</body>
</html>