<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AdminLTE 2 | list_sub</title>
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
	<section class="content" style="padding: 15px 15px 0 15px;">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<div class="btn-group pull-right">
							<button type="button" id="locale_ko" onclick="location.href='${pageContext.request.contextPath}/admin/product/list_sub&category_code=&locale=ko'" class="btn btn-primary">
								<i class="fa fa-globe" aria-hidden="true"></i> 한국어
							</button>
							<button type="button" id="locale_en" onclick="location.href='${pageContext.request.contextPath}/admin/product/list_sub&category_code=&locale=en'" class="btn btn-default">
								<i class="fa fa-globe" aria-hidden="true"></i> ENG
							</button>
							<button type="button" id="locale_zh" onclick="location.href='${pageContext.request.contextPath}/admin/product/list_sub&category_code=&locale=zh'" class="btn btn-default">
								<i class="fa fa-globe" aria-hidden="true"></i> 中国
							</button>
							<button type="button" id="locale_vn" onclick="location.href='${pageContext.request.contextPath}/admin/product/list_sub&category_code=&locale=vn'" class="btn btn-default">
								<i class="fa fa-globe" aria-hidden="true"></i> Tiếng việt
							</button>
						</div>
						<br> <br>

						<form:form id="form_search" name="form_search" method="post" action="${pageContext.request.contextPath}/admin/product/list_sub">
							<div class="box-tools pull-right" style="margin-top: 20px;">
								<input type="hidden" name="locale" value="ko"> 
								<input type="hidden" name="category_code" value=""> 
								<input type="hidden" name="is_best" value=""> 
								<input type="hidden" name="is_new" value=""> 
								<input type="hidden" name="is_event" value=""> 
								<input type="hidden" name="status" value="">
								
								<div class="has-feedback">
									<span> 
										<input type="text" name="keyword" value="${keyword }" class="form-control input-sm" placeholder="상품 검색" onkeyup="keywordSeach()"/> 
										<span class="glyphicon glyphicon-search form-control-feedback"></span>
									</span>
								</div>
							</div>
							<div class="box-tools pull-right" style="margin-top: 20px;">
								<div class="has-feedback">
									<span style="float: left; width: 180px;"> 
										<input type="checkbox" name="bne_check" onclick="bne_onclick('best');" value="best" ${bne_check == "best" ? 'checked' : '' }> BEST 
										<input type="checkbox" name="bne_check" onclick="bne_onclick('new')" value="new" ${bne_check == "new" ? 'checked' : '' }> NEW 
										<input type="checkbox" name="bne_check" onclick="bne_onclick('event')" value="event" ${bne_check == "event" ? 'checked' : '' }> EVENT
									</span> 
									
									<select name="field" onchange="location.href='${pageContext.request.contextPath}/admin/product/list_sub?bne_check=${bne_check}&cteNo=${cteNo}&v_status='+this.value" class="form-control input-sm" style="float: left; padding-right: 0; margin-right: 5px; width: 80px;">
										<option value="null">상태</option>
										<option value="Y" ${v_status == "Y" ? 'selected' : '' }>보임</option>
										<option value="N" ${v_status == "N" ? 'selected' : '' }>숨김</option>
									</select> 
									
									<select name="field" class="form-control input-sm" style="float: left; padding-right: 0; width: 100px;">
										<option value="title">상품명</option>
									</select>
								</div>
							</div>
						</form:form>

						<p class="text-light-blue">
							<i class="fa fa-fw fa-list-ul"></i> <a href="${pageContext.request.contextPath}/admin/product/list_sub">ROOT</a>
							<c:forEach var="cte" items="${cteList }">
								<strong> > </strong> 
								<a href="${pageContext.request.contextPath}/admin/product/list_sub?cteNo=${cte.categoryNo}">${cte.categoryName}</a>
							</c:forEach>
						</p>
						<label>총 ${productListCnt } 건</label>

						<form:form name="form_list" method="post" action="${pageContext.request.contextPath }/admin/product/delete">
							<input type="hidden" name="mode" id="mode">
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<td style="width: 30px;"><input type="checkbox" name="select_all" onclick="selectAllCheckBox('form_list');" /></td>
										<td style="width: 50px;">CODE</td>
										<td>제품 이미지</td>
										<td>카테고리</td>
										<td>상품명</td>
										<td>리스트 타이틀</td>
										<td>가격</td>
										<td style="width: 90px;">등록일</td>
										<td style="width: 55px;">상태</td>
										<td style="width: 60px;"><i onclick="changeOrder('down','product','${pageContext.request.contextPath}/admin/product/list_sub','','',);" class="fa fa-fw fa-arrow-circle-down cp"></i> <i onclick="changeOrder('up','product','${pageContext.request.contextPath}/product/list_sub','','',);" class="fa fa-fw fa-arrow-circle-up cp"></i></td>
										<td style="width: 60px;">명령</td>
									</tr>
								</thead>
								<c:forEach var="product" items="${productList }">
									<tr>
										<td><input type="checkbox" name="list[]" value="${product.productNo }" /></td>
										<td>${product.productNo }</td>
										<td><img src="${product.imgUrl }" style="width: 90px;"></td>
										<td>${product.categoryName }</td>
										<td>${product.productName }</td>
										<td>${product.listTitle }</td>
										<td><fmt:formatNumber value="${product.salePrice }" pattern="#,###" /></td>
										<td><fmt:formatDate value="${product.regDate}" pattern="yyyy-MM-dd" /></td>
										<td><button type="button" class="btn btn-success btn-xs">보임</button></td>
										<td><input type="radio" name="order_code" value="10" /></td>
										<td><button type="button" onclick="onclickUpdate('${product.productNo}');" class="btn btn-primary btn-xs">수정하기</button></td>
									</tr>
								</c:forEach>

							</table>
						</form:form>
						<br>

						<button type="button" onclick="selectDelete('deleteProduct');" class="btn btn-danger btn-sm">
							<i class="fa fa-minus-square"></i> 선택삭제
						</button>
						<button type="button" onclick="onclickCopyProduct()" class="btn btn-warning btn-sm">
							<i class="fa fa-copy"></i> 제품 복제
						</button>
						<!-- 상품등록 버튼은 3레벨일때만 출력 -->
						<c:if test="${level == 3 }">
							<button type="button" onclick="onclickInsert()" class="btn btn-primary btn-sm">
								<i class="fa fa-plus-square"></i> 상품 등록
							</button>
						</c:if>

						<button type="button" onclick="downloadExcel();" class="btn btn-warning btn-sm" style="margin-left: 20px;">
							<i class="fa fa-file-excel-o"></i> Excel 다운로드
						</button>

						<form name="form_download" method="post" action="${pageContext.request.contextPath }/excel/download.do?${_csrf.parameterName}=${_csrf.token}">
							<input type="hidden" name="download_type" value="product" /> 
							<input type="hidden" name="mode" value="downloadExcel"> 
							<input type="hidden" name="search_data">
						</form>

						<div style="text-align: right;">
							<ul class="pagination" style="margin: 0;">
								<li class="active"><a href="${pageContext.request.contextPath}/admin/product/list_sub&locale=ko&page=1">1</a></li>
							</ul>
						</div>
					</div>
					<!-- /.box-body -->
				</div>
				<!-- /.box -->
			</div>
			<!-- /.col-xs-12 -->
		</div>
		<!-- /.row -->
	</section>
	<!-- jQuery 3 -->
	<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/common.js" type="text/javascript" charset="utf-8"></script>

	<script>
        function downloadExcel() {  // Excel 다운로드
            form_download.target = 'iframe_process';
            form_download.search_data.value = $('#form_search :input').serialize();
            form_download.submit();
        }
        
        function setData(code) {
            $.ajax({
				url:'${pageContext.request.contextPath}/admin/product/fillForm',
				type:'post',
				dataType:'json',
		        headers: {
						"${_csrf.headerName}" : "${_csrf.token}"
				},
				data:{
                    productNo : code
				},
				success(data){
                    var product = data[0];
					var imgs = data[1];
					var options = data[2];
					var discriptions = data[3];
					
					
					parent.$('#category_depth').html('');
					parent.Depth = 3
					parent.getCategory(product.categoryNo);
					
					parent.form_register.reset();
					parent.$('[name=product_no]').val(product.productNo);
					parent.$('[name=model]').val(product.modelName);
	                parent.$('[name=title]').val(product.productName);
	                parent.$('[name=title_eng]').val('test3');
	                parent.$('[name=list_title]').val(product.listTitle);
	                parent.$('[name=list_title_eng]').val('test5');
	                
	                $.each(discriptions, (k, v)=>{
	                	if(v.discriptionLevel == 1){
			                parent.$('[name=brief]').val(v.content);
	                	}else if(v.discriptionLevel == 2){
			                parent.$('#content').val(v.content)
	                	}
	                });
	                parent.$('[name=brief_eng]').val('test8'); // 
	                
	                
	                parent.$('[name=keyword]').val('test7'); // 키워드
	                parent.$('[name=consumer_price]').val(product.retailPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
	                parent.$('[name=sale_price]').val(product.salePrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
	                parent.$('[name=point]').val(product.individualPoint);
	                if (product.productBest== 'Y') parent.$('input:checkbox[id="is_best"]').prop('checked',true);
                    if (product.productNew == 'Y') parent.$('input:checkbox[id="is_new"]').prop('checked',true);
                    if (product.productEvent == 'Y') parent.$('input:checkbox[id="is_event"]').prop('checked',true);
                    if (product.isSoldOut == 'Y') parent.$('input:checkbox[id="is_soldout"]').prop('checked',true);
                    parent.$('[name=status]').val(product.status);
					
                    parent.$("span[id^='display_file']").css('display','none');
                   


                    
                 // 옵션 처리
             		if(options.length > 0){
             			$.each(options, function(index, option) {
                         	parent.insertOption(option.optionNo, option.optionValueNo, option.optionName, option.optionValue, option.optionValueCost, option.is_necessary);
             			});
             		}
                 
                 // img처리
                 	if(imgs.length > 0){
                 		$.each(imgs, function(index, img){
                 			parent.insertImg(img.productImgNo, img.imgLevel, img.imgUrl);
                 		});
                 	}
                    
				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log(textStatus);
					// $('#content').val(errorThrown);
				}
			});
        }
        function onclickInsert() {
            parent.$('#modalContent').modal({backdrop:'static', show:true});
            parent.$('#option_list').html('');
            parent.form_register.reset();
            parent.getCategory(${cteNo});
            parent.form_register.mode.value = 'insertProduct';
            parent.form_register.locale.value = 'ko';
            parent.form_register.category_code.value = '';
            parent.$('#category_depth').html('');
            parent.$('[id^=display_file]').css('display','none');
        }
        
        function onclickUpdate(code) {
            parent.$('#modalContent').modal({backdrop:'static', show:true});
            parent.form_register.reset();
            parent.$('#option_list').html('');
            setData(code);
            parent.$('#mode').val('updateProduct');
        }
        
        // 제품복제 체크버튼 및 모달레이어창
        function onclickCopyProduct() {
            var count = $(":input[name = 'list[]']").length;
            if (count > 0) {
                if (isCheckedBox('form_list')) {

                    var f = eval('form_list');
                    var chkBox = document.getElementsByName('list[]');
                    var chkLen = chkBox.length;
                    var code = '';
                    // 선택된 파일이 있는지 체크
                    for (i = 0; i < chkLen; i++) {
                        if (chkBox[i].checked){
                        	code += chkBox[i].value+',';
                        }
                    }
                    parent.$('#modalCopyProduct').modal({backdrop:'static', show:true});
                    parent.formCopyProduct.code.value = code;
                }
                else {
                    alert('항목을 선택하여야 합니다.');
                    return false;
                }
            }
            else {
                alert('항목이 없습니다.');
                return false;
            }
        }
        
        function bne_onclick(value){
        	if(${bne_check == "0"}){
    	    	var url = "${pageContext.request.contextPath}/admin/product/list_sub?bne_check=" + value + "&v_status=${v_status}&cteNo=${cteNo}";
        	}else{
        		var url = "${pageContext.request.contextPath}/admin/product/list_sub?bne_check=0&v_status=${v_status}&cteNo=${cteNo}";
        	}
			location.href = url;
        }
        
        function keywordSeach(){
        	if(window.event.keyCode == 13){
        		console.log($('[name=keyword]').val())
        	}
        }
        
        
        $('[name=bne_check]').change((e)=>{
        	var target = "[name=is_" + $(e.target).val() +"]";
        	if($(e.target).is(":checked")){
        		$(target).val('Y');
        	}else{
				$(target).val('');        		
        	}			
        	console.log($(target).val())
        });
        
        $('[name=field]').change((e)=>{
        	$('[name=status]').val($(e.target).val());
        });
        

        
</script>
</body>
</html>