<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

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
<script src="https://oss.maxcdn.com${pageContext.request.contextPath}/resources5shiv/3.7.3${pageContext.request.contextPath}/resources5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<!-- Google Font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition login-page">
<!-- content-wrapper -->
<section class="content" style="padding-top:0;">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                <form id="optionUpdateFrm" name="optionUpdateFrm" method="get" action="#">
                    <table class="table table-bordered">
						<tr>
							<td class="menu">옵션명</td>
							<td align="left">
							<input type="hidden" name="optionNo" value="${pOption.optionNo }" />
	                        <input type="text" name="option_name" id="option_name" class="form-control input-sm" value="${pOption.optionName }" style="width:300px; margin-right:10px; float:left;" />
	                        <input type="checkbox" name="is_necessary" value="Y"> 필수 선택 항목
	                        </td>
						</tr>
						<tr>
							<td class="menu">옵션값</td>
							<td align="left">
								<ul id="list_option" style="list-style:none;padding-left:0;margin-bottom:0;">
								<c:forEach var="optionValue" items="${optionValueList }" varStatus="vs">
		                            <li class="first_item">
		                            	<input type="hidden" name="option_value_no" value="${optionValue.optionValueNo }" />
		                                <input type="text" name="option_value" class="form-control input-sm" value="${optionValue.optionValue}" style="width:40%; display:inline; margin-bottom:10px;">
		                                <input type="text" name="option_value_cost" class="form-control input-sm" value="<fmt:formatNumber value='${optionValue.optionValueCost }' pattern="#,###" />" onkeyup="this.value=displayComma(checkAmountNum(this.value))"  style="width:30%; display:inline; margin-bottom:10px;">
										<c:if test="${vs.count == 1 }">
			                                <button type="button" class="btn btn-primary btn-xs" onclick="addOption();"><span class="glyphicon glyphicon-plus"></span> 옵션값 추가</button>
										</c:if>
										<c:if test="${vs.count > 1 }">
											<button type="button" class="btn btn-danger btn-xs" onclick="removeOption(this);"><span class="fa fa-minus-square"></span> 옵션값 제거</button>
										</c:if>
		                            </li>
								</c:forEach>
								</ul>
							</td>
						</tr>
					</table>
                </form>
				<div class="modal-footer">
					<button type="button" onclick="updateOption();" class="btn btn-primary">반영하기</button>
				</div>
                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>

<div id="list_option_tag" class="sr-only">
	<ul>
		<li>
			<input type="text" name="option_value[]" class="form-control input-sm" placeholder="옵션값" style="width:40%; display:inline; margin-bottom:10px;">
			<input type="text" name="option_price[]" class="form-control input-sm" placeholder="추가 가격(숫자만 입력)" onkeyup="this.value=displayComma(checkAmountNum(this.value))" style="width:30%; display:inline; margin-bottom:10px;">
			<button type="button" class="btn btn-danger btn-xs" onclick="removeOption(this);"><span class="fa fa-minus-square"></span> 옵션값 제거</button>
		</li>
	</ul>
</div>
<!-- jQuery 3 -->
<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js" type="text/javascript" charset="utf-8"></script>

<script>
			var row_num = '0';
			function addOption() {
				$('#list_option').append($('#list_option_tag').html());
			}

			function removeOption(ta) {
				$(ta).parent().remove();
			}

			function resetOptions() {
				$('#list_option').find('li:not(".first_item")').remove();
			}

			function setOptionToForm() {
				
				var option_name = $('input[name=option_name]');
				var is_necessary = ($('input[name=is_necessary]').is(":checked"));
                var arr_value = document.getElementsByName('option_value');
				var arr_price = document.getElementsByName('option_value_cost');
				var optionNo = $('input[name=optionNo]').val();
				if(option_name.val() == ''){
					alert('옵션명을 입력해주세요.')
					option_name.focus();
					return;
				}

				var option_value_arr = new Array();
				var option_price_arr = new Array();
				//저장버튼 하단에 복제용 숨겨진 input박스 있음.
				for(var i=0 ; i<(arr_value.length) ; i++) {
					if(arr_value[i].value == '') {
						alert('옵션값을 입력해주세요.');
						arr_value[i].focus();
						return;
					}

					if(arr_price[i].value == '') {
						arr_price[i].value = '0';
					}
					option_value_arr[i] = arr_value[i].value;
					option_price_arr[i] = arr_price[i].value;
				}
				console.log(option_value_arr)
				console.log(option_price_arr)
				if(row_num != '') {
                    parent.updateOption(optionNo, option_name.val(), option_value_arr, option_price_arr, row_num, is_necessary);
				} else {
					parent.insertOption(option_name.val(), option_value_arr, option_price_arr, is_necessary);
				}

				parent.closeOptionManager();
			}

			function modifyOption(row_num) {
				var tm_option_name = $('#option_num_'+row_num, parent.document.body).find('input[name^=option_name]');
				var tm_is_necessary_name = $('#option_num_'+row_num, parent.document.body).find('input[name^=is_necessary]');
				$('input[name=option_name]').val($(tm_option_name).val());
                if (tm_is_necessary_name.is(':checked')) $('input[name=is_necessary]').prop('checked',true);

				var tm_option_value_arr = $('#option_num_'+row_num, parent.document.body).find('input[name^=option_value]');
				var tm_option_price_arr = $('#option_num_'+row_num, parent.document.body).find('input[name^=option_price]');
				for(var i=0 ; i<tm_option_value_arr.length ; i++) {
					if(i > 0) {
						addOption();
					}
					$('#list_option input[name^=option_value]').last().val( $(tm_option_value_arr).get(i).value );
					$('#list_option input[name^=option_price]').last().val( $(tm_option_price_arr).get(i).value );
				}
			}
		

function updateOption(){
	const formData = new FormData(document["optionUpdateFrm"])
	var obj = {};
	for(const [k, v] of formData){
		obj[k] = v;
	};
 	obj.option_value = [];
	obj.option_value_cost = [];
	obj.option_value_no = [];
	$.each($("input[name=option_value]"), (index, value)=>{
		 obj.option_value.push($(value).val());
	});
	$.each($("input[name=option_value_cost]"), (index, value)=>{
		 obj.option_value_cost.push($(value).val());
	}); 
	
		
	$.each($("input[name=option_value_no]"), (index, value)=>{
		obj.option_value_no.push($(value).val());
	});
	const jsonStr = JSON.stringify(obj);
	
	 $.ajax({
		url:"${pageContext.request.contextPath}/admin/option/update",
		method:"POST",
		data: jsonStr,
		headers: {
			"${_csrf.headerName}" : "${_csrf.token}"
		},
		contentType: "application/json; charset=utf-8",
		success(data){
			if(data > 0){
				alert("옵션 정보가 수정되었습니다.");
				setOptionToForm();
			}

		},
		error:console.logd
	});	
}
			
</script>
</body>
</html>