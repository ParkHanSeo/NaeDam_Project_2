<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="문의사항 관리" name="title"/>
</jsp:include>

<!-- content-wrapper -->
<div class="content-wrapper" style="min-height: 595px;">
	<section class="content-header">
	    <h1>문의사항 관리<small>문의사항 list</small></h1>
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li class="active">문의사항 관리</li>
	    </ol>
	</section><!-- /.content-header -->

	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
	                    <label style="margin-top:5px;">총 5 건</label>
	
	                    <table class="table table-bordered table-hover">
		                    <form name="form_list" method="post" action="?tpf=admin/form/process"></form>
				            <input type="hidden" name="mode" id="mode">
				            <input type="hidden" name="form_code" value="1">
		                    <thead>
		                    <tr>
		                        <td style="width:30px;">
		                      		<div class="allCheck">
										<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck"></label>
											<script>
												$("#allCheck").click(function() {
													var chk = $("#allCheck").prop("checked");
													if (chk) {
														$('.formPostNo').prop("checked", true);
													} else {
														$('.formPostNo').prop("checked", false);
													}
												});
											</script>
									</div>
		                        </td>
		                        <td style="width:60px;">NO</td>
		      				  <c:forEach var="item" items="${td}" varStatus="status" >
		      					<td>${item.label}</td>   
		      				  </c:forEach>
		      				  	<td style="width:200px;">등록일</td>                           
		                        <td style="width:80px;">
		                            <i onclick="changeOrder('down','form_reply','?tpf=admin/form/list&amp;form_code=1',1,'ko','',);" class="fa fa-fw fa-arrow-circle-down cp" style="cursor:pointer;"></i>
		                            <i onclick="changeOrder('up','form_reply','?tpf=admin/form/list&amp;form_code=1',1,'ko','',);" class="fa fa-fw fa-arrow-circle-up cp" style="cursor:pointer;"></i>
		                        </td>
		                        <td style="width:60px;">명령</td>
		                    </tr>
		                    </thead>
			      			<tbody>
			      			  <c:set var="i" value="0"/>
			      			  <c:set var="num" value="${number}"/>
		      				  <c:forEach var="formPost" items="${fp}" varStatus="status" >
		      				  <c:set var="i" value="${ i+1 }" />
			      				<tr>
			                        <td>
				                        <div>
				                        	<input type="checkbox" class="formPostNo" name="formPostNo"  value="${formPost.code}" />
				                        	<script>
												$(".formPostNo").click(function() {
													$("#allCheck").prop("checked", false);
												});
											</script>
										</div>
			                        </td>
			                        <td>${i}</td>
			                        <c:set var="ex" value="${fn:split(formPost.itemData,'&')}"/>
			                          <c:set var="j" value="0"/>
			                          <c:set var="k" value="0"/>
			                          <c:forEach var="exNum" items="${ex}" varStatus="g">
			                           <c:if test="${j == num[k]}">
			                        	<td style="text-align:left;">${ex[j]}</td>
			                        	<c:set var="k" value="${ k+1 }" />
			                           </c:if>	
			                          	<c:set var="j" value="${ j+1 }" />			                        		
			                          </c:forEach>
			                        <td>${formPost.date}</td>
			                        <td><input type="radio" name="order_code" value="-5"></td>
			                        <td><button type="button" onclick="onclickUpdate(${formPost.code});" class="btn btn-primary btn-xs">수정하기</button></td>
			                    </tr> 
			                  </c:forEach>   
			                  <c:if test="${empty fp}">
			                  	<tr><td colspan="10"><br>등록된 자료가 없습니다.<br><br></td></tr>
			                  </c:if>
		                    </tbody>
	                    </table>
	                    <br>
	
	                    <button type="button" onclick="deleteChoiceFormPost(${formNo});" class="btn btn-danger btn-sm"><i class="fa fa-minus-square"></i> 선택삭제</button>
	                    <button type="button" onclick="onclickInsert();" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 등록</button>
	                    <button type="button" onclick="excelDownload();" class="btn btn-warning btn-sm"><i class="fa fa-file-excel-o"></i> Excel 다운로드</button>
	                    
	                    <form name="form_download" method="post" action="${pageContext.request.contextPath }/excel/download.do?${_csrf.parameterName}=${_csrf.token}">
	                        <input type="hidden" name="mode" value="downloadExcel">
	                        <input type="hidden" name="formNo" value="${formNo}">
	                        <input type="hidden" name="search_data">
	                        <input type="hidden" name="download_type" value="formPost"/>
	                    </form>
	                    
						<!-- page -->
	                    <div style="text-align: right;">
							${pagebar}
						</div>
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section><!-- /.content -->

	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:800px;">
	        <div class="modal-content">
	            <form name="formRegister" method="post" onsubmit="return false;" action="/admin/form/addFormPost?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
		            <input type="hidden" name="mode" id="mode" value="insertReply">
		            <input type="hidden" name="formNo" id="formNo" value="${formNo}">
		            <input type="hidden" name="locale" id="locale">
		            
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                <h4 class="modal-title" id="myModalLabelPortfolio">정보 등록</h4>
		            </div><!-- /.modal-header -->
		            
		            <div class="modal-body">
		            	<h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 정보 등록</p></h4>
		            	<table class="table table-bordered">
		      				<tbody>
		      				  <c:forEach var="item" items="${tr}" varStatus="status" >
			      				<tr>
			                        <td class="menu">${item.label}</td>
			                        <c:if test="${item.input_type == 'text' || item.input_type == 'tel' || item.input_type == 'email'}">
				                        <td align="left">
											<input type="${item.input_type}" name="data${item.itemNo}" placeholder="${item.placeholder}" class="form-control input-sm">          
				                        </td>
			                        </c:if>
			                        <c:if test="${item.input_type == 'textarea'}">
			                        	<td align="left">
			                        		<textarea name="data${item.itemNo}" placeholder="${item.placeholder}" class="form-control input-sm" style="padding:5px; line-height:20px; width:100%; height:200px;"></textarea>
			                        	</td>
			                        </c:if>
			                        <c:if test="${item.input_type == 'webeditor'}">
			                        	<td align="left">
			                        		<textarea id="content18" name="data${item.itemNo}" id="ckEditor" placeholder="${item.placeholder}" style="padding: 5px; line-height: 20px; width: 100%; height: 200px;"></textarea>
			                        	</td>
			                        </c:if>
			                        <c:if test="${item.input_type == 'select'}">
			                        	<td align="left">
				                          <c:if test="${!empty item.input_example}">
				                        	<c:set var="ex" value="${fn:split(item.input_example,'&')}"/>
				                        		<select name="data${item.itemNo}" class="form-control input-sm">
				                        			<option value="">선택하세요</option>
				                        			<c:forEach var="exNum" items="${ex}" varStatus="g">
				                        				<option value="${exNum}">${exNum}</option>
				                        			</c:forEach>
				                        		</select>
				                          </c:if>			                        		
			                        	</td>
			                        </c:if>
			                        <c:if test="${item.input_type == 'radio'}">
			                        	<td align="left">
				                          <c:if test="${!empty item.input_example}">
				                        	<c:set var="ex" value="${fn:split(item.input_example,'&')}"/>
				                        		<c:forEach var="exNum" items="${ex}" varStatus="g">
												  <p>
							                        <input type="radio" name="data${item.itemNo}" value="${exNum}" style="font-size:0.8125rem;">
							                        <label>${exNum}</label>
							                      </p>		
				                        		</c:forEach>
				                          </c:if>			                        		
			                        	</td>
			                        </c:if>	
			                        <c:if test="${item.input_type == 'checkbox'}">
			                        	<td align="left">
				                          <c:if test="${!empty item.input_example}">
				                        	<c:set var="ex" value="${fn:split(item.input_example,'&')}"/>
				                        		<c:forEach var="exNum" items="${ex}" varStatus="g">
												  <p>
							                        <input type="checkbox" name="data${item.itemNo}" value="${exNum}" style="font-size:0.8125rem;">
							                        <label>${exNum}</label>
							                      </p>		
				                        		</c:forEach>
				                          </c:if>			                        		
			                        	</td>
			                        </c:if>
									<c:if test="${item.input_type == 'date'}">
										<td align="left">
											<input type="text" id="datepicker" name="data${item.itemNo}" readonly="" style="width:100px;" class="hasDatepicker">
										</td>
									</c:if>	
									<c:if test="${item.input_type == 'file'}">
										<td align="left">
											<input type="file" id="${item.itemNo}" name="file[]" style="width:80%; float:left;">
										</td>
									</c:if>
			                    </tr>
			                  </c:forEach>               
		                    </tbody>
		            	</table>
		            </div><!-- /.modal-body -->
		            
		            <div class="modal-footer">
		            	<button type="button" onclick="registerForm();" class="btn btn-primary">저장하기</button>
		            </div><!-- /.modal-footer -->
	            </form><!-- /.formRegister -->
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal .fade -->
	
	<div class="modal fade" id="modalContent2" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:800px;">
	        <div class="modal-content">
	            <form name="formRegister2" method="post" onsubmit="return false;" action="/admin/form/updateFormPost?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
		            <input type="hidden" name="mode" id="mode" value="insertReply">
		            <input type="hidden" name="formNo" id="formNo" value="${formNo}">
		            <input type="hidden" name="code" id="code">
		            
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                <h4 class="modal-title" id="myModalLabelPortfolio">정보 수정</h4>
		            </div><!-- /.modal-header -->
		            
		            <div class="modal-body">
		            	<h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 정보 수정</p></h4>
		            	<table class="table table-bordered">
		      				<tbody>
		      				  <c:forEach var="item" items="${tr}" varStatus="status" >
			      				<tr>
			                        <td class="menu">${item.label}</td>
			                        <c:if test="${item.input_type == 'text' || item.input_type == 'tel' || item.input_type == 'email'}">
				                        <td align="left">
											<input type="${item.input_type}" name="data${item.itemNo}" placeholder="${item.placeholder}" class="form-control input-sm">          
				                        </td>
			                        </c:if>
			                        <c:if test="${item.input_type == 'textarea'}">
			                        	<td align="left">
			                        		<textarea name="data${item.itemNo}" placeholder="${item.placeholder}" class="form-control input-sm" style="padding:5px; line-height:20px; width:100%; height:200px;"></textarea>
			                        	</td>
			                        </c:if>
			                        <c:if test="${item.input_type == 'webeditor'}">
			                        	<td align="left">
			                        		<textarea id="content19" name="data${item.itemNo}" id="ckEditor2" placeholder="${item.placeholder}" style="padding: 5px; line-height: 20px; width: 100%; height: 200px;"></textarea>
			                        	</td>
			                        </c:if>
			                        <c:if test="${item.input_type == 'select'}">
			                        	<td align="left">
				                          <c:if test="${!empty item.input_example}">
				                        	<c:set var="ex" value="${fn:split(item.input_example,'&')}"/>
				                        		<select name="data${item.itemNo}" class="form-control input-sm">
				                        			<option value="">선택하세요</option>
				                        			<c:forEach var="exNum" items="${ex}" varStatus="g">
				                        				<option value="${exNum}">${exNum}</option>
				                        			</c:forEach>
				                        		</select>
				                          </c:if>			                        		
			                        	</td>
			                        </c:if>
			                        <c:if test="${item.input_type == 'radio'}">
			                        	<td align="left">
				                          <c:if test="${!empty item.input_example}">
				                        	<c:set var="ex" value="${fn:split(item.input_example,'&')}"/>
				                        		<c:forEach var="exNum" items="${ex}" varStatus="g">
												  <p>
							                        <input type="radio" name="data${item.itemNo}" value="${exNum}" style="font-size:0.8125rem;">
							                        <label>${exNum}</label>
							                      </p>		
				                        		</c:forEach>
				                          </c:if>			                        		
			                        	</td>
			                        </c:if>	
			                        <c:if test="${item.input_type == 'checkbox'}">
			                        	<td align="left">
				                          <c:if test="${!empty item.input_example}">
				                        	<c:set var="ex" value="${fn:split(item.input_example,'&')}"/>
				                        		<c:forEach var="exNum" items="${ex}" varStatus="g">
												  <p>
							                        <input type="checkbox" name="data${item.itemNo}" value="${exNum}" style="font-size:0.8125rem;">
							                        <label>${exNum}</label>
							                      </p>		
				                        		</c:forEach>
				                          </c:if>			                        		
			                        	</td>
			                        </c:if>
									<c:if test="${item.input_type == 'date'}">
										<td align="left">
											<input type="text" id="datepicker" name="data${item.itemNo}" readonly="" style="width:100px;" class="hasDatepicker">
										</td>
									</c:if>	
									<c:if test="${item.input_type == 'file'}">
										<td align="left">
											<input type="file" id="${item.itemNo}" name="file[]" style="width:80%; float:left;">
										</td>
									</c:if>
			                    </tr>
			                  </c:forEach>               
		                    </tbody>
		            	</table>
		            </div><!-- /.modal-body -->
		            
		            <div class="modal-footer">
		            	<button type="button" onclick="registerForm2();" class="btn btn-primary">저장하기</button>
		            </div><!-- /.modal-footer -->
	            </form><!-- /.formRegister -->
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal .fade -->	

	<div class="modal fade" id="modalCopyList" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:400px;">
	        <div class="modal-content">
	            <form name="formCopyContent" method="post" action="?tpf=admin/form/process">
	                <input type="hidden" name="mode" id="mode" value="copyContent">
	                <input type="hidden" name="form_code" value="1">
	                <input type="hidden" name="code" id="code">
	                
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	                    <h4 class="modal-title" id="myModalLabelPortfolio">리스트 복사</h4>
	                </div><!-- /.modal-header -->
	                
	                <div class="modal-body">
	                    <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 리스트 <span id="board_sub_title">복사</span></p></h4>
	                    <table class="table table-bordered">
	                        <tbody>
	                            <tr>
	                                <td class="menu">폼메일 선택</td>
	                                <td align="left">
	                                    <select name="formPostCopy" id="formPostCopy" class="form-control input-sm">
	                                        <option value="">선택</option>                                   
	                          			</select>
	                                </td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div><!-- /.modal-body -->
	                
	                <div class="modal-footer">
	                    <button type="button" onclick="fncformPostCopy()" class="btn btn-primary">확인</button>
		            </div><!-- /.modal-footer -->
	            </form><!-- /.formCopyContent -->
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal .fade -->

	<form name="formFileDelete" method="post" action="?tpf=admin/form/process">
		<input type="hidden" name="mode" id="mode" value="deleteFile">
		<input type="hidden" name="code" id="code">
	</form>

<script src="//mir9.co.kr/resource/js/ckeditor4.7.2/ckeditor.js"></script>
</div><!-- /.content-wrapper -->

<script>
	
	var a = $("input[id='ckEditor']").val();
	
	if (window.CKEDITOR) {  // CKEDITOR loading 여부 체크 (Web 버젼에서만 사용)
	    var objEditor18 = CKEDITOR.replace('content18', {
	        height: 300,
	        extraPlugins : 'tableresize',
	        extraPlugins: 'codemirror',
	        filebrowserUploadUrl: '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
	        filebrowserImageUploadUrl: '/daemon/ckeditor_upload.php?command=QuickUpload&type=Images',
	        fillEmptyBlocks : true
	    });
	    CKEDITOR.on('dialogDefinition', function (ev) {
	        var dialogName = ev.data.name;
	        var dialog = ev.data.definition.dialog;
	        var dialogDefinition = ev.data.definition;
	
	        if (dialogName == 'image') {
	            dialog.on('show', function (obj) {
	                this.selectPage('Upload'); //업로드텝으로 시작
	            });
	            dialogDefinition.removeContents('advanced'); // 자세히탭 제거
	            dialogDefinition.removeContents('Link'); // 링크탭 제거
	        }
	    });
	    CKEDITOR.config.allowedContent = true;
	    CKEDITOR.config.codemirror = {
	        // Set this to the theme you wish to use (codemirror themes)
	        theme: '3024-night',
	
	        // Whether or not to automatically format code should be done when the editor is loaded
	        autoFormatOnStart: false,
	    };
	}
	if (window.CKEDITOR) {  // CKEDITOR loading 여부 체크 (Web 버젼에서만 사용)
	    var objEditor19 = CKEDITOR.replace('content19', {
	        height: 300,
	        extraPlugins : 'tableresize',
	        extraPlugins: 'codemirror',
	        filebrowserUploadUrl: '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
	        filebrowserImageUploadUrl: '/daemon/ckeditor_upload.php?command=QuickUpload&type=Images',
	        fillEmptyBlocks : true
	    });
	    CKEDITOR.on('dialogDefinition', function (ev) {
	        var dialogName = ev.data.name;
	        var dialog = ev.data.definition.dialog;
	        var dialogDefinition = ev.data.definition;
	
	        if (dialogName == 'image') {
	            dialog.on('show', function (obj) {
	                this.selectPage('Upload'); //업로드텝으로 시작
	            });
	            dialogDefinition.removeContents('advanced'); // 자세히탭 제거
	            dialogDefinition.removeContents('Link'); // 링크탭 제거
	        }
	    });
	    CKEDITOR.config.allowedContent = true;
	    CKEDITOR.config.codemirror = {
	        // Set this to the theme you wish to use (codemirror themes)
	        theme: '3024-night',
	
	        // Whether or not to automatically format code should be done when the editor is loaded
	        autoFormatOnStart: false,
	    };
	}	
	$.fn.modal.Constructor.prototype.enforceFocus = function () {   // bootstrap & ckEdiotr 소스 방지 코드
	    modal_this = this
	    $(document).on('focusin.modal', function (e) {
	        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select') && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
	        }
	    })
	}		
	function excelDownload() {  // Excel 다운로드
	    form_download.target = 'iframe_process';
	    form_download.search_data.value = $('#form_search :input').serialize();
	    form_download.submit();
	}
    // 등록 버튼
    function onclickInsert() {
        $("#modalContent").modal({backdrop:"static", show:true});
        formRegister.reset();
        formRegister.mode.value = "insertReply";
        //formRegister.form_code.value = "1";
        formRegister.locale.value = "ko";
        $("[id^='displayFile']").css("display","none");
    }	
    // 수정 버튼
    function onclickInsert2() {
        $("#modalContent2").modal({backdrop:"static", show:true});
        formRegister2.reset();
        formRegister2.mode.value = "insertReply";
        //formRegister.form_code.value = "1";
        formRegister2.locale.value = "ko";
        $("[id^='displayFile']").css("display","none");
    }    
	
    // 등록 모달 저장
    function registerForm() {
        formRegister.target = 'iframe_process';
        formRegister.submit();
        alert("등록 되었습니다.");
        location.reload();
    }
    // 등록 모달 저장
    function registerForm2() {
        formRegister2.target = 'iframe_process';
        formRegister2.submit();
        alert("수정 되었습니다.");
        location.reload();
    }    
    $(function(){
	    /* datepicker */
	    $('[id^=datepicker]').datepicker({
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
	    $('[id^=datepicker]').datepicker({
	        dateFormat: 'yy-mm-dd'
	    });
    })
    // 모달 데이터 셋팅
    function setData(code) {
        $.ajax({
        	url:'/admin/form/json/getFormPost?${_csrf.parameterName}=${_csrf.token}',
			type:"post",
			dataType:"json",
			data:{
				method:"UtilForm.infoReply",
		                code:code
			},
			success:function(data, textStatus, jqXHR) {
		                 var json_data = data;
		                 var formData = new Array();
		                 var itemNoArr = new Array();
		                 var itemInputArr = new Array();
		                 
		                 formData = data.itemData.split("&");
		                 itemNoArr = data.itemNo.split("&");
		                 itemInputArr = data.itemInput.split("&");
		                 for(var i = 0; i < formData.length; i++){
		                	 
		                	 if(itemInputArr[i] == "select" || itemInputArr[i] == "radio" || itemInputArr[i] == "checkbox"){
		                		 $("input[name='data"+itemNoArr[i]+"'][value='"+formData[i]+"']").prop("checked", true);
		                	 }else if(itemInputArr[i] == "webeditor"){
		                		 var objEditor = eval("objEditor19");
		                		 objEditor.setData(formData[i]);
		                	 }
		                	 $("input[name='data"+itemNoArr[i]+"']").val(formData[i]);
		                 }
		                 $("input[name='code']").val(data.code);
		                 
		                 $("[id^='displayFile']").css("display","none");
		                 if (json_data.files != null && json_data.files.length > 0) {
		                     $.each(json_data.files, function(index, value) {
		                         var file_tag = "<button type='button' onclick='location.replace(\"?tpf=common/save_as&file_path=" + value.file_path + "&file_name=" + value.file_name + "&orig_name=" + encodeURI(value.orig_name) + "\");' class='btn btn-success btn-xs'>보기</button>";
		                         file_tag += "<button type='button' onclick='deleteFile(" + value["code"] + ");' class='btn btn-danger btn-xs'>삭제</button>";
		                         $("#displayFile" + value["plupload_id"]).css("display","");
		                         $("#displayFile" + value["plupload_id"]).html(file_tag);
		                     });
		                 }
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus);
				// $("#content").val(errorThrown);
			}
		});
    }
    
    // 수정하기 버튼
    function onclickUpdate(code) {
        $("#modalContent2").modal({backdrop:"static", show:true});
        formRegister2.reset();
        
        setData(code);
    }    
    
    // 리스트 복사 체크버튼 및 모달창
    function onclickCopyContent() {
		var formPostArr = new Array();
		
		$("input[class='formPostNo']:checked").each(function(){
			formPostArr.push($(this).val());
		});
		if(formPostArr.length == 0){
			alert("항목을 선택하셔야 합니다.");
			return;
		}
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
						display = "<option value="+Data[i].formNo+">"+Data[i].title+"</option>"
						$('#formPostCopy').append(display);
					}
				}
				
			}
		})		
    	$("#modalCopyList").modal({backdrop:"static", show:true});
    }
    
    function fncformPostCopy(){
		var formPostArr = new Array();
		var formNo = $("select[name='formPostCopy']").val();
		$("input[class='formPostNo']:checked").each(function(){
			formPostArr.push($(this).val());
		});
  		$.ajax({
			 url : "/admin/form/addFormPostCopy?${_csrf.parameterName}=${_csrf.token}",
 		  	 type : "POST",
		  	 data : { 
		  		formPostArr : formPostArr, 
		  	 	formNo
		  	 },
  		 	 success : function(result){
 		   	 		
		  	 }	 
 		});
  		alert("게시물 복사가 완료되었습니다.")
  		location.href = "/admin/form/formPostList?formNo="+formNo;
    }
    
    // 리스트 복사 확인
    function registerCopyContent() {
        if(formCopyContent.to_form_code.value == "") { 
        	alert("폼메일이 선택되지 않았습니다."); 
        	formCopyContent.to_form_code.focus(); 
        	return false;
        }
        /*
        formCopyContent.target = 'iframe_process';
        formCopyContent.submit();
        */
    }    
    
	// 엑셀 다운로드 
    function downloadExcel() {  
		/*
        form_download.target = 'iframe_process';
        form_download.search_data.value = $('#form_search :input').serialize();
        form_download.submit();
        */
    }    
	
	//선택삭제
	function deleteChoiceFormPost(formNo) {
		
		var formNo = ${formNo};
		var formPostArr = new Array();
		
		$("input[class='formPostNo']:checked").each(function(){
			formPostArr.push($(this).val());
			});
		if(formPostArr.length == 0){
			alert("항목을 선택하셔야 합니다.");
			return;
		}
		if(!confirm("해당 자료를 정말 삭제 하시겠습니까?")){
			alert("취소 되었습니다.");
			return;
			
		}else{
  		$.ajax({
		 	 url : "/admin/form/deleteChoiceFormPost?${_csrf.parameterName}=${_csrf.token}",
 		  		 type : "POST",
	  	 	 data : { 
	  	 		formPostArr : formPostArr 
	  	 	 },
	 		 success : function(result){
	 		
	  	 	 }
		  	 	 
  		});		
			alert("해당 자료가 삭제 되었습니다.")
			location.href = "/admin/form/formPostList?formNo="+formNo;
		}		
		
	};
	
	//선택 삭제
	function deleteChoiceFormPost(formNo) {
		
		var formNo = ${formNo};
		var formPostArr = new Array();
		
		$("input[class='formPostNo']:checked").each(function(){
			formPostArr.push($(this).val());
			});
		if(formPostArr.length == 0){
			alert("항목을 선택하셔야 합니다.");
			return;
		}
		if(!confirm("해당 자료를 정말 삭제 하시겠습니까?")){
			alert("취소 되었습니다.");
			return;
			
		}else{
  		$.ajax({
		 	 url : "/admin/form/deleteChoiceFormPost?${_csrf.parameterName}=${_csrf.token}",
 		  		 type : "POST",
	  	 	 data : { 
	  	 		formPostArr : formPostArr 
	  	 	 },
	 		 success : function(result){
	 		
	  	 	 }
		  	 	 
  		});		
			alert("해당 자료가 삭제 되었습니다.")
			location.href = "/admin/form/formPostList?formNo="+formNo;
		}		
		
	};

	const paging = (cPage) => {
		location.href = '/admin/form/formPostList?cPage='+cPage+'&formNo='+${formNo};
	}
      
    /* 
    datepicker 
    $('[id^=datepicker]').datepicker({
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
    
    $('[id^=datepicker]').datepicker({
        dateFormat: 'yy-mm-dd'
    });
    */
    
    /* 
         파일 삭제
    function deleteFile(code) {
        if (confirm('해당 파일을 정말 삭제 하시겠습니까?')) {
            formFileDelete.code.value = code;
            formFileDelete.target = 'iframe_process';
            formFileDelete.submit();
        }
    }
	*/   
</script>
<div id="ui-datepicker-div" class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"></div>
<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>