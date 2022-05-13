<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AdminLTE 2 | category_sub</title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css">
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
<!-- content-wrapper -->
<iframe name="iframe_process" width="0" height="0" frameborder="0"></iframe>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <p class="text-light-blue">
                    	<i class="fa fa-fw fa-list-ul"></i> 
                    	<a href="?tpf=admin/product/category_sub&locale=ko">ROOT</a> 
                    	<c:forEach var="rCte" items="${relatedCteList }">
							<strong> > </strong> 
							<a href="${pageContext.request.contextPath}/admin/product/productCategory_sub?cteNo=${rCte.categoryNo}">${rCte.categoryName}</a>
							<c:set value="${rCte.level }" var="level"/>
						</c:forEach>
                    </p>

                    <form name="form_list" method="post" action="${pageContext.request.contextPath }/admin/category/delete?${_csrf.parameterName}=${_csrf.token}">
			            <input type="hidden" name="mode" id="mode">
                    <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <td style="width:30px;"><input type="checkbox" name="select_all" onclick=selectAllCheckBox('form_list'); /></td>
                        <td>카테고리명</td>
                        <td style="width:55px;">상태</td>
                        <td style="width:60px;">
                        <i onclick="changeOrder('down','category','?tpf=admin/product/category_sub','');" class="fa fa-fw fa-arrow-circle-down cp"></i>
                        <i onclick="changeOrder('up','category','?tpf=admin/product/category_sub','');" class="fa fa-fw fa-arrow-circle-up cp"></i>
                        </td>
                        <td style="width:60px;">명령</td>
                    </tr>
                    </thead>
                    <c:forEach var="cte" items="${cteList }">
	      				<tr>
	                        <td><input type="checkbox" name="list[]" value="${cte.categoryNo}" /></td>
	                        <td>${cte.categoryName }</td>
	                        <td><button type="button" class="btn btn-success btn-xs">보임</button></td>
	                        <td><input type="radio" name="order_code" value="1" /></td>
	                        <td><button type="button" onclick="onclickUpdate(${cte.categoryNo});" class="btn btn-primary btn-xs">수정하기</button></td>
	                    </tr>                   
                    </c:forEach>
	                    </table>
                    </form>
                    <br>

                    <button type="button" onclick="selectDelete('deleteCategory');" class="btn btn-danger btn-sm"><i class="fa fa-minus-square" aria-hidden="true"></i> 선택삭제</button>
                    <c:if test="${level != 3 }">
	                    <button type="button" onclick="onclickInsert();" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 카테고리 등록</button>
                    </c:if>
                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>
<!-- jQuery 3 -->
<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/common.js" type="text/javascript" charset="utf-8"></script>

<script>
(function(){
	parent.$('#parent_no').val(${parentNo})

})();
        function setData(code) {
            $.ajax({
                url:'${pageContext.request.contextPath}/admin/category/info',
                type:'post',
                dataType:'json',
                headers: {
					"${_csrf.headerName}" : "${_csrf.token}"
				},
                data:{
					cteNo : code
                },
                success(data){
                    parent.$('form[name="form_register"] #mode').val('updateCategory');
                    parent.$('#code').val(code);
                    parent.$('#title').val(data.categoryName);
                    parent.$('[name=status]').val(data.status);
                },
                error: console.log
            });
        }
        function onclickInsert() {
            parent.$('#modalContent').modal({backdrop:'static', show:true});
            parent.form_register.reset();
            parent.form_register.mode.value = 'insertCategory';
            parent.form_register.category_code.value = '';
            parent.$('input:radio[name=icon_code]').attr('checked', false);
        }
        function onclickUpdate(code) {
            parent.$('#modalContent').modal({backdrop:'static', show:true});
            setData(code);
        }
</script>
</body>
</html>