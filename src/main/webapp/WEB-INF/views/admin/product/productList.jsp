<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="상품 관리" name="title" />
</jsp:include>
<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			상품 관리 <small>product list</small>
		</h1>

		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#">상품 관리</a></li>
			<li class="active">상품 리스트</li>
		</ol>
	</section>

	<section class="content" style="padding: 15px 15px 0 15px">
		<div class="row">
			<div class="col-xs-12" style="height:">
				<div class="box">
					<div class="box-body">
						<div class="col-xs-3" style="padding: 0 5px 0 0;">
							<iframe name="tree" id="iframe_tree" src="${pageContext.request.contextPath }/admin/product/tree_model?stp=pl" width="100%" height="100%"></iframe>
						</div>

						<div class="col-xs-9" style="padding: 0 5px 0 0;">
							<iframe name="list" id="iframe_list" src="${pageContext.request.contextPath }/admin/product/list_sub" width="100%" height="100%"></iframe>
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

	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog" style="width: 800px;">
			<div class="modal-content">
				<form name="form_register" method="post" action="?tpf=admin/product/process" enctype="multipart/form-data">
					<input type="hidden" name="mode" id="mode" value="insertProduct"> 
					<input type="hidden" name="locale" value="ko">
					<input type="hidden" name="product_no" value="0"/>
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabelPortfolio">상품 등록</h4>
					</div>
					<div class="modal-body">

						<h4 class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 상품 등록
						</h4>
						<table class="table table-bordered">
							<tr>
								<td class="menu">카테고리</td>
								<td align="left">ROOT <span id="category_depth"></span></td>
							</tr>
							<tr>
								<td class="menu">모델명 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="text" name="model" class="form-control input-sm" /></td>
							</tr>
							<tr>
								<td class="menu">상품명 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="text" name="title" class="form-control input-sm" /></td>
							</tr>
							<tr>
								<td class="menu">리스트 문구 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="text" name="list_title" class="form-control input-sm" /></td>
							</tr>
							<tr>
								<td class="menu">소비자 가격 <span class="text-light-blue"></span> (원)
								</td>
								<td align="left"><input type="text" name="consumer_price" onkeyup="this.value=displayComma(checkAmountNum(this.value))" class="form-control input-sm" /></td>
							</tr>
							<tr>
								<td class="menu">판매 가격 <span class="text-light-blue"><i class="fa fa-check"></i></span> (원)
								</td>
								<td align="left"><input type="text" name="sale_price" onkeyup="this.value=displayComma(checkAmountNum(this.value))" class="form-control input-sm" /></td>
							</tr>
							<tr>
								<td class="menu">개별 적립금</td>
								<td align="left"><input type="text" name="point" value="0" onkeyup="this.value=displayComma(checkAmountNum(this.value))" class="form-control input-sm" /> ※ 설정 > 적립금 관리 > 지급 설정에서 [개별] 옵션에 체크한 경우에만 적용됩니다.</td>
							</tr>
							<tr>
								<td class="menu">옵션</td>
								<td align="left">
									<p style="float: left; width: 100%;">
										<button type="button" class="btn btn-primary btn-xs" onclick="optionManager();">
											<span class="glyphicon glyphicon-plus"></span> 옵션추가
										</button>
									</p> <br>
									<div id="list_option">
									<input type="hidden" name="option_no" value="0"/>
										<table class="table table-bordered table-hover">
											<colgroup>
												<col width="25%" />
												<col width="25%" />
												<col width="25%" />
												<col width="*" />
											</colgroup>
											<thead>
												<tr>
													<td>옵션명</td>
													<td>옵션값</td>
													<td>추가금액</td>
													<td>수정/삭제</td>
												</tr>
											</thead>
											<tbody id="option_list">
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td class="menu">검색키워드</td>
								<td align="left"><input type="text" name="keyword" class="form-control input-sm" /></td>
							</tr>
							<tr>
								<td class="menu">리스트 이미지1</td>
								<td align="left">
									<input type="file" name="file1" class="form-control input-sm" style="width: 80%; display: inline;" />
									<span id="display_file1" style="display: none;"></span>
									<input type="hidden" id="url_file1" name="url_file" />
									<input type="hidden" id="no_file1" name="no_file" />
								</td>
							</tr>
							<tr>
								<td class="menu">리스트 이미지2</td>
								<td align="left">
									<input type="file" name="file2" class="form-control input-sm" style="width: 80%; display: inline;" /> 
									<span id="display_file2" style="display: none;"></span>
									<input type="hidden" id="url_file2" name="url_file" />
									<input type="hidden" id="no_file2" name="no_file" />
								</td>
									
							</tr>
							<tr>
								<td class="menu">제품 이미지(상세)</td>
								<td align="left">
									<input type="file" name="file3" class="form-control input-sm" style="width: 80%; display: inline;" /> 
									<span id="display_file3" style="display: none;"></span>
									<input type="hidden" id="url_file3" name="url_file"/>
									<input type="hidden" id="no_file3" name="no_file" />
								</td>
							</tr>
							<tr>
								<td class="menu">간단 설명</td>
								<td align="left"><textarea name="brief" class="form-control input-sm" style="margin: 0 0 5px 0; height: 120px; width: 91%;"></textarea></td>
							</tr>
							<tr>
								<td class="menu">내용 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td><textarea name="content" id="content" rows="10" cols="80"></textarea></td>
							</tr>
							<!-- <tr>
                <td class="menu">메인표출 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                <td>
                <select name="is_main" id="is_main" class="form-control input-sm" style="width:100px;">
      <option value="y">보임</option>      <option value="n">숨김</option>                </select>
                </td>
            </tr> -->
							<tr>
								<td class="menu">BEST / NEW / EVENT</td>
								<td align="left"><input type="checkbox" id="is_best" name="is_best" value='Y'>BEST&nbsp;&nbsp; <input type="checkbox" id="is_new" name="is_new" value='Y'>NEW&nbsp;&nbsp; <input type="checkbox" id="is_event" name="is_event" value='Y'>EVENT</td>
							</tr>
							<tr>
								<td class="menu">품절 처리</td>
								<td align="left"><input type="checkbox" id="is_soldout" name="is_soldout" value='Y'>품절</td>
							</tr>

							<tr>
								<td class="menu">상태 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td><select name="status" id="status" class="form-control input-sm" style="width: 100px;">
										<option value="Y">보임</option>
										<option value="N">숨김</option>
								</select></td>
							</tr>
						</table>

					</div>
					<div class="modal-footer">
						<button type="button" onclick="register();" class="btn btn-primary">저장하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="modalCopyProduct" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog" style="width: 400px;">
			<div class="modal-content">
				<form name="formCopyProduct" method="post" action="${pageContext.request.contextPath }/admin/product/copy_product?${_csrf.parameterName}=${_csrf.token}">
					<input type="hidden" name="mode" id="mode" value="copyProduct"> <input type="hidden" name="code" id="code">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabelPortfolio">제품 관리</h4>
					</div>
					<div class="modal-body">

						<h4 class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 제품 <span id="board_sub_title">이전</span>
						</h4>
						<table class="table table-bordered">
							<tbody>
								<tr>
									<td class="menu">언어</td>
									<td align="left"><select name="product_locale" id="product_locale" class="form-control input-sm">
											<option value="">선택</option>
											<option value="ko">한국어</option>
											<option value="en">ENG</option>
											<option value="zh">中国</option>
											<option value="vn">Tiếng việt</option>
									</select></td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="modal-footer">
						<button type="button" onclick="registerCopyProduct()" class="btn btn-primary">확인</button>
						&nbsp;&nbsp;&nbsp;
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="modalContent2" tabindex="-3" role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog" style="width: 800px; height: 700px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="modal-title-item">상품 옵션 관리</h4>
				</div>
				<div class="modal-body">
					<div class="row" style="margin: 0 0 5px 0;">
						<div class="col-xs-12" style="padding: 0">
							<div class="btn-group ">
								<button type="button" onclick="optionTabChange('1', '${pageContext.request.contextPath}/admin/option/option_manager')" class="btn btn-default" id="option_tab_btn1">
									<i class="fa fa-file-o" aria-hidden="true"></i> 직접입력
								</button>
								<button type="button" onclick="optionTabChange('2', '${pageContext.request.contextPath}/admin/option/option_manager_bank')" class="btn btn-default" id="option_tab_btn2">
									<i class="fa fa-bookmark-o" aria-hidden="true"></i> 자주쓰는 옵션
								</button>
								<button type="button" onclick="optionTabChange('3', '${pageContext.request.contextPath}/admin/option/option_manager_product')" class="btn btn-default" id="option_tab_btn3">
									<i class="fa fa-clone" aria-hidden="true"></i> 기존 상품 옵션 불러오기
								</button>
							</div>
						</div>
					</div>
					<iframe name="modal_iframe" id="modal_iframe" src="" width="100%" height="600px" style="border: 1px solid #cccccc"></iframe>
				</div>
			</div>
		</div>
	</div>

	<script src="https://mir9.co.kr/resource/js/ckeditor4.7.2/ckeditor.js"></script>

</div>
<!-- /.content-wrapper -->

<script>

// 파일 변경 시 업로드 후 url 받아오기
$("input[type=file]").change(function(e){
	console.log($(e.target))
	console.log($(e.target).attr('name'))
	var target = "#url_" + $(e.target).attr('name');
   // 이미지 업로드
   var file = e.target;
   //var imgPreview = document.getElementById("imgPreview");
   var form = new FormData();
   form.append("image", file.files[0]);

   var settings = {
     "url": "https://api.imgbb.com/1/upload?key=f84bfb11eb3ee5eedb859de8b49fdff1",
     "method": "POST",
     "timeout": 0,
     "processData": false,
     "mimeType": "multipart/form-data",
     "contentType": false,
     "data": form
   };
   
   // 이미지 업로드 -> 확인
   $.ajax(settings).done(function (response) {
     // console.log("response" + response);
     
     var imgbb = JSON.parse(response);
     // console.log("imgbb : " + imgbb);
     
     // 이미지 조회 및 다운로드
     var url = imgbb.data.thumb.url;
     $(target).val(url);

     //imgPreview.src = url; // imgbb url
     //imgPreview.name = name;
     //$("#deleteUrl").attr("value", delUrl);

   });
   
});

	function insertOption(optionNo, optionValueNo, option_name, option_value, option_price, is_necessary) {
	    var check_necessary = '';
	    if (is_necessary == true || is_necessary == 'Y') check_necessary = 'checked';
	    $('input[name=option_no]').val(optionNo);
	    var row_num = 0;
		var last_class = $('#option_list tr:last').attr('id');
		if(!(typeof last_class == 'undefined')) {
			var target = '#option_value_td';
			var option_val_txt = '<input type="text" name="option_value['+optionValueNo+']" class="form-control input-sm" value="'+option_value+'" readonly />'
			$(target).append(option_val_txt);
			target = '#option_value_cost_td';
			option_val_txt = '<input type="text" name="option_price['+optionValueNo+']" class="form-control input-sm" value="'+option_price+'" readonly />';
			$(target).append(option_val_txt);
			target = '#option_btns_td';
			option_val_txt = '\n<button type="button" class="btn btn-primary btn-xs" onclick="modifyOption('+ optionNo +');"><span class="glyphicon glyphicon-plus"></span> 수정</button>\n<button type="button" class="btn btn-danger btn-xs" onclick="removeOption('+ optionNo +');"><span class="fa fa-minus-square"></span> 삭제</button>'
			$(target).append(option_val_txt);
		}else if(typeof last_class == 'undefined'){
			var create_txt = '<tr id="option_num_'+optionNo+'" >';
			create_txt += '<td>';
			create_txt += '	<input type="text" name="option_name['+row_num+']" class="form-control input-sm" value="'+option_name+'" readonly />';
			create_txt += '	<input type="checkbox" name="is_necessary['+row_num+']" '+check_necessary+' value="y"> 필수 선택 항목';
			create_txt += '</td>';
			create_txt += '<td id="option_value_td">';
			create_txt += '	<input type="text" name="option_value['+optionValueNo+']" class="form-control input-sm" value="'+option_value+'" readonly />';
			
			create_txt += '</td>';
			create_txt += '<td id="option_value_cost_td">';
			
			create_txt += '	<input type="text" name="option_price['+optionValueNo+']" class="form-control input-sm" value="'+option_price+'" readonly />';
			
			create_txt += '</td>';
			create_txt += '<td id="option_btns_td">';
			create_txt += '	<button type="button" class="btn btn-primary btn-xs" onclick="modifyOption('+ optionNo +');"><span class="glyphicon glyphicon-plus"></span> 수정</button>';
			create_txt += '	<button type="button" class="btn btn-danger btn-xs" onclick="removeOption('+ optionNo +');"><span class="fa fa-minus-square"></span> 삭제</button>';
			create_txt += '</td>';
			create_txt += '</tr>';
		
			$('#option_list').append(create_txt);
		}
	

		
	}
	
	function getCategory(cteNo){
		 $.ajax({
				url:'${pageContext.request.contextPath}/admin/category/getCategory',
				type:'post',
				dataType:'json',
		        headers: {
						"${_csrf.headerName}" : "${_csrf.token}"
				},
				data:{
                 	cteNo : cteNo
				},
				success(data){
					createSelectBox(data.depth, data.lv1NameList, data.lv2NameList, data.lv3NameList);
					
					if(typeof data.cteList != 'undefined'){
						for(var i = 0; i < data.depth; i++){
							var target = '#category_select_box_'+i;
							$(target).val(data.cteList[i].categoryNo).prop("selected",true);
						};
					};
				},
				error : console.log
			});
	}
	
	function createSelectBox(depth, lv1List, lv2List, lv3List){
		for(var i = 0; i < depth; i++){
			var selectBox = document.createElement('select');			
			var selectboxName = 'category_select_box_'+i;
		    selectBox.name = selectboxName;
		    selectBox.id = selectboxName;
		    selectBox.className = 'form-control input-sm categorySelectBox';
		    selectBox.style.width = '30%';
		    selectBox.style.margin = '0 0 0 5px';
		    selectBox.style.display = 'inline-block';
		    var cteNameList = null;
		    
		    switch (i){
			    case 0 : cteNameList = lv1List; break;
			    case 1 : cteNameList = lv2List; break;
			    case 2 : cteNameList = lv3List; break;
			    default : break;
		    }
		    
		    $.each(cteNameList, (k,v)=>{
			    var option = document.createElement('option');
		        option.text = v.categoryName;
		        option.value = v.categoryNo;
			    selectBox.add(option, null);
		    });
		    
		    $('#category_depth').append(selectBox)
		}
	}
	
	function register(){
		if($('#mode').val() == 'insertProduct'){
			$(document["form_register"]).attr('action', '${pageContext.request.contextPath}/admin/product/insert?${_csrf.parameterName}=${_csrf.token}').submit();
			
		}else if($('#mode').val() == 'updateProduct'){
			$(document["form_register"]).attr('action', '${pageContext.request.contextPath}/admin/product/update?${_csrf.parameterName}=${_csrf.token}').submit();
		}

	}
	function modifyOption(optionNo) {
		optionTabChange('1', '${pageContext.request.contextPath}/admin/option/option_manager?optionNo='+optionNo);
		var url = '${pageContext.request.contextPath}/admin/option/option_manager?optionNo='+optionNo
		$('#option_tab_btn1').attr('onclick',"optionTabChange('1','" + url + "')");
		$('#modalContent2').modal({backdrop:'static', show:true});
	}
	
	function optionTabChange(on_idx, url){
		$('#option_tab_btn1').attr('class','btn btn-default');
		$('#option_tab_btn2').attr('class','btn btn-default');
		$('#option_tab_btn3').attr('class','btn btn-default');
		$('#option_tab_btn'+on_idx).attr('class','btn btn-primary');

		$('#modal_iframe').attr('src', url);
	}
	
	function closeOptionManager() {
		$('#modal_iframe').attr('src','#')
		$('#modalContent2').modal('hide');
	}
	
	function updateOption(optionNo, option_name, option_value_arr, option_price_arr, row_num, is_necessary) {
		var tr = $('#option_num_'+optionNo);
		$(tr).find('input[name^=option_name]').val(option_name);
		$(tr).find('input[name^=is_necessary]').prop("checked", is_necessary);  // 필수 선택

		var tm_option_value_arr = $(tr).find('input[name^=option_value]');
		var tm_option_price_arr = $(tr).find('input[name^=option_price]');

		for(var i=0 ; i<option_value_arr.length ; i++) {
			if(i >= tm_option_value_arr.length) { // 새로운 옵션값이 추가될 경우
				create_txt = '	<input type="text" name="option_value['+row_num+']['+i+']" class="form-control input-sm" value="'+option_value_arr[i]+'" readonly />';
				var befor_html = $(tr).find('td:nth-child(2)').html();
				$(tr).find('td:nth-child(2)').html(befor_html+create_txt);

				var create_txt2 = '	<input type="text" name="option_price['+row_num+']['+i+']" class="form-control input-sm" value="'+option_price_arr[i]+'" readonly />';
				var befor_html2 = $(tr).find('td:nth-child(3)').html();
				$(tr).find('td:nth-child(3)').html(befor_html2+create_txt2);
			} else {
				$(tm_option_value_arr).get(i).value = option_value_arr[i];
				$(tm_option_price_arr).get(i).value = option_price_arr[i];
			}
		}

		if(option_value_arr.length < tm_option_value_arr.length){ // 배열 개수 비교로 값 체크
			var delete_cnt = tm_option_value_arr.length - option_value_arr.length;
			for(var i=0 ; i<delete_cnt ; i++){
				$(tr).find('input[name^=option_value]:last').remove();
				$(tr).find('input[name^=option_price]:last').remove();
			}
		}

	}
	
	function insertImg(pImgNo, level, url){
		console.log(pImgNo, level, url)
		var target = "#url_file"+level;
		$(target).val(url);
		var target = "#no_file"+level;
		$(target).val(pImgNo);
	}
	
	function removeOptionf(optionValueNo){
		console.log()
	}
	
	function registerCopyProduct(){
		$(document.formCopyProduct).submit();
	}
	
    function optionManager() {
		optionTabChange('1', '${pageContext.request.contextPath}/admin/option/option_manager?optionNo=0');
		$('#modalContent2').modal({backdrop:'static', show:true});
    }
	
	
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>