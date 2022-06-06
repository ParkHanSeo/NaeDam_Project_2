<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="폼메일 관리" name="title"/>
</jsp:include>
<script>
	$(function(){
		
		//form선택삭제
		$("#deleteChoiceForm").on("click", function(){
			
			var formArr = new Array();
			var mode = "delete";
			var part = "form";
			
			$("input[class='formNo']:checked").each(function(){
				formArr.push($(this).val());
 			});
			if(formArr.length == 0){
				alert("항목을 선택하셔야 합니다.");
				return;
			}
			if(!confirm("해당 자료를 정말 삭제 하시겠습니까?")){
				alert("취소 되었습니다.");
				return;
				
			}else{
	  		$.ajax({
  			 	 url : "/admin/form/json/formProcess?${_csrf.parameterName}=${_csrf.token}",
	  		  	 type : "POST",
  		  	 	 data : { 
  		  	 		formArr : formArr,
  		  	 		mode,
  		  	 		part
  		  	 	 },
    		 	 success : function(result){
   					alert("해당 자료가 삭제 되었습니다.")
   					location.href = "/admin/form/list";    		 		
  		  	 	 }
  		  	 	 
	  		});		
			}			
		});
		
	});
	
	function formCopy(){
		var formArr = new Array();
		var mode = "copy";
		var part = "form";
		
		$("input[class='formNo']:checked").each(function(){
			formArr.push($(this).val());
		});
		if(formArr.length == 0){
			alert("항목을 선택하셔야 합니다.");
			return;
		}
		if(!confirm("해당 자료를 복제 하시겠습니까?")){
			alert("취소 되었습니다.");
			return;
			
		}else{
  		$.ajax({
			 url : "/admin/form/json/formProcess?${_csrf.parameterName}=${_csrf.token}",
  		  	 type : "POST",
	  	 	 data : { 
	  	 		formArr : formArr,
	  	 		mode,
	  	 		part
	  	 	 },
		 	 success : function(result){
				alert("해당 자료가 복제 되었습니다.")
				location.href = "/admin/form/list";
		 	 }	 
  		});		

		}		
	}
</script>
<!--  
<style>
    .option_tab { display:inline-block; width:130px;}
</style>
-->
<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	    <h1>폼메일 관리  <small>form list</small></h1>
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li>폼메일 관리</li>
	        <li class="active">폼메일 리스트</li>
	    </ol>
	</section><!-- /.content-header -->
	
	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
	                    <label style="margin-top:5px;">총 ${formCount} 건</label>
	
						<table class="table table-bordered table-hover">
						<!-- 
	                    <form name="form_list" method="post" action="?tpf=admin/form/process"></form>
	                    -->
				            <input type="hidden" name="mode" id="mode">
				            <thead>
			                    <tr>
			                        <td style="width:30px;">
			                      		<div class="allCheck">
											<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck"></label>
												<script>
													$("#allCheck").click(function() {
														var chk = $("#allCheck").prop("checked");
														if (chk) {
															$('.formNo').prop("checked", true);
														} else {
															$('.formNo').prop("checked", false);
														}
													});
												</script>
										</div>
			                        </td>
			                        <td style="width:60px;">NO</td>
			                        <td>제목</td>
			                        <td style="width:120px;">보안코드</td>
			                        <td style="width:120px;">개인정보수집</td>
			                        <td style="width:400px;">연결주소</td>
			                        <td style="width:80px;">등록 글수</td>
			                        <td style="width:120px;">등록일</td>
			                        <td style="width:220px;">명령</td>
			                    </tr>
		                    </thead>
		      				<tbody>
		      				  <c:set var="i" value="0"/>
		      				  <c:forEach var="form" items="${list}" varStatus="status" >
		      				  <c:set var="i" value="${ i+1 }" />
		      					<tr>
			                        <td>
				                        <div>
				                        	<input type="checkbox" class="formNo" name="formNo"  value="${form.formNo}" />
				                        	<script>
												$(".formNo").click(function() {
													$("#allCheck").prop("checked", false);
												});
											</script>
										</div>
			                        </td>
			                        <td>${i}</td>
			                        <td align="left">${form.title}</td>
			                        <td>
			                          <c:if test="${form.is_captcha eq 'y'}">
			                        	<i class="fa fa-check"></i>
			                          </c:if>
			                        </td>
			                        <td>
			                          <c:if test="${form.is_agree eq 'y'}">			                          
			                        	<i class="fa fa-check"></i>
			                          </c:if>
			                        </td>
			                        <td align="left">http://localhost:8080/admin/form/formPostList?formNo=${form.formNo}</td>
			                        <td>${formPostCount[i-1]}</td>
			                        <td>${form.formDate}</td>
			                        <td>
			                        	<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/form/formPostList?formNo=${form.formNo}'" class="btn btn-success btn-xs">바로가기</button>
			                        	<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/form/itemList?formNo=${form.formNo}'" class="btn btn-warning btn-xs">문항관리</button>
			                        	<button type="button" onclick="onclickUpdate(${form.formNo});" class="btn btn-primary btn-xs">상세보기</button>
			                        </td>
			                    </tr>
			                   </c:forEach>                      
		                    </tbody>
	                 	</table>
	                    <br>
	                    <button type="button" id="deleteChoiceForm" class="btn btn-danger btn-sm"><i class="fa fa-minus-square"></i> 선택삭제</button>
	                    <button type="button" onclick="onclickInsert()" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 폼메일 생성</button>
						<button type="button" onclick="formCopy()" class="btn btn-warning btn-sm"><i class="fa fa-copy"></i> 폼메일 복제</button>
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section><!-- /.content -->
	
	<!-- 폼 등록 모달 -->
	<div class="modal fade" id="modalRegister" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:600px;">
	        <div class="modal-content">
	            <form name="addForm" method="post" action="/admin/form/formProcess?${_csrf.parameterName}=${_csrf.token}">
		            <input type="hidden" name="mode" value="insert">
		            <input type="hidden" name="part" value="form">
		            <input type="hidden" name="locale" value="<br/><b>Notice</b>: Undefined variable: locale in <b>/home/demoshop/public_html/html/admin/form/manage.html</b> on line <b>85</b><br/>">
		            
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                <h4 class="modal-title" id="myModalLabel">폼메일 생성</h4>
		            </div><!-- /.modal-header -->
		            
		            <div class="modal-body">
			            <div class="row" style="margin:0">
			                <div class="col-xs-4">
			                	<span style="float:left;">
			                		<h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 폼메일 정보</p></h4>
			                	</span>
			                </div>
			                <div class="col-xs-8" style="padding:0"></div>
			            </div><!-- /.row -->
			
			            <table class="table table-bordered">
							<tbody>
								<tr>
					                <td class="menu">제목</td>
					                <td align="left">
					                	<input type="text" name="title" class="form-control input-sm">
					                </td>
					            </tr>
					            <tr>
					                <td class="menu">수신 메일 주소</td>
					                <td align="left">
					                	<input type="text" name="receive_email" placeholder=", 구분" class="form-control input-sm">
					                </td>
					            </tr>
					            <!--<tr>
					                <td class="menu">수신 휴대폰 번호</td>
					                <td align="left">
					                	<input type="text" name="receive_sms" placeholder=", 구분" class="form-control input-sm">
					                </td>
					            </tr>-->
					            <tr>
					                <td class="menu">보안코드</td>
					                <td align="left">
					                	<input type="checkbox" name="is_captcha" value="y"> 사용
					                </td>
					            </tr>
					            <tr>
					                <td class="menu">개인정보 수집·이용 동의</td>
					                <td align="left">
					                	<input type="checkbox" name="is_agree" onclick="checkAgree(this.value)" value="y"> 표출
					                	<textarea name="agree_content" id="agree_content" rows="6" class="form-control input-sm" placeholder="약관정보 입력" style="width:100%; display:none;"></textarea>
					                </td>
					            </tr>
				            </tbody>
			            </table><!-- /.table .table-bordered -->
		            </div><!-- /.modal-body -->
		            
		            <div class="modal-footer">
		            	<button type="button" onclick="register()" class="btn btn-primary">확인</button>
		            </div><!-- /.modal-footer -->
	            </form>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal .fade -->
	<!-- 폼 수정 모달 -->
	<div class="modal fade" id="modalRegister2" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:600px;">
	        <div class="modal-content">
	            <form name="updateForm" method="post" action="/admin/form/formProcess?${_csrf.parameterName}=${_csrf.token}">
		            <input type="hidden" name="mode" value="update">
		            <input type="hidden" name="part" value="form">
		            <input type="hidden" name="formNo">
		            <input type="hidden" name="locale" value="<br/><b>Notice</b>: Undefined variable: locale in <b>/home/demoshop/public_html/html/admin/form/manage.html</b> on line <b>85</b><br/>">
		            
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                <h4 class="modal-title" id="myModalLabel">폼메일 생성</h4>
		            </div><!-- /.modal-header -->
		            
		            <div class="modal-body">
			            <div class="row" style="margin:0">
			                <div class="col-xs-4">
			                	<span style="float:left;">
			                		<h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 폼메일 정보</p></h4>
			                	</span>
			                </div>
			                <div class="col-xs-8" style="padding:0"></div>
			            </div><!-- /.row -->
			
			            <table class="table table-bordered">
							<tbody>
								<tr>
					                <td class="menu">제목</td>
					                <td align="left">
					                	<input type="text" name="title" class="form-control input-sm">
					                </td>
					            </tr>
					            <tr>
					                <td class="menu">수신 메일 주소</td>
					                <td align="left">
					                	<input type="text" name="receive_email" placeholder=", 구분" class="form-control input-sm">
					                </td>
					            </tr>
					            <!--<tr>
					                <td class="menu">수신 휴대폰 번호</td>
					                <td align="left">
					                	<input type="text" name="receive_sms" placeholder=", 구분" class="form-control input-sm">
					                </td>
					            </tr>-->
					            <tr>
					                <td class="menu">보안코드</td>
					                <td align="left">
					                	<input type="checkbox" name="is_captcha" value="y"> 사용
					                </td>
					            </tr>
					            <tr>
					                <td class="menu">개인정보 수집·이용 동의</td>
					                <td align="left">
					                	<input type="checkbox" name="is_agree" onclick="checkAgree(this.value)" value="y"> 표출
					                	<textarea name="agree_content" id="agree_content" rows="6" class="form-control input-sm" placeholder="약관정보 입력" style="width:100%; display:none;"></textarea>
					                </td>
					            </tr>
				            </tbody>
			            </table><!-- /.table .table-bordered -->
		            </div><!-- /.modal-body -->
		            
		            <div class="modal-footer">
		            	<button type="button" onclick="register2()" class="btn btn-primary">확인</button>
		            </div><!-- /.modal-footer -->
	            </form>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal .fade -->	
</div><!-- /.content-wrapper -->

<script>

	// 폼메일 생성 버튼
	function onclickInsert(code) {
	    $('#modalRegister').modal({backdrop:'static', show:true});
	    form.reset();
	    form.mode.value = 'insertForm';
	    $('#myModalLabel').text('폼 등록');
	}

	// 상세보기 버튼
	function onclickUpdate(code) {
	    $('#modalRegister2').modal({backdrop:'static', show:true});
	    //form.mode.value = 'updateForm';
	    $('#myModalLabel').text('폼 수정');
	    setData(code);
	}
	
	// 상세보기 데이터 셋팅
	function setData(code) {
		$.ajax({
			url:'/admin/form/json/getForm?${_csrf.parameterName}=${_csrf.token}',
			type:'post',
			dataType:'json',
			data:{
				method:'form.getForm',
	            locale : $('[name=locale]').val(),
	            code:code
			},
			success:function(data, textStatus, jqXHR){
	            var json_data = data;
	            $('[name=formNo]').val(json_data.formNo);
	            $('[name=title]').val(json_data.title);
	            $('[name=receive_email]').val(json_data.receive_email);
	            $('[name=receive_sms]').val(json_data.receive_sms);
	            if (json_data.is_captcha == 'y') $('[name=is_captcha]').prop('checked',true);
	            else $('[name=is_captcha]').prop('checked',false);
	            if (json_data.is_agree == 'y') {
	                $('#agree_content').show();
	                $('[name=is_agree]').prop('checked',true);
	            }
	            else {
	                $('#agree_content').hide();
	                $('[name=is_agree]').prop('checked',false);
	            }
	            $('[name=agree_content]').val(json_data.agree_content);
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				// $('#content').val(errorThrown);
			}
		});
	}

	// 개인 정보 수집 동의 시 약관 정보 보이기
	function checkAgree(value) {
	    if ($("input[name=is_agree]").is(":checked")) {
	    	$("#agree_content").show();
	    }
	    else {
	    	$("#agree_content").hide();
	    }
	}
	
	// 모달 내용 저장
	function register() {
	    if(addForm.title.value == "") { 
	    	alert("제목이 입력되지 않았습니다."); 
	    	addForm.title.focus(); 
	    	return false;
	    }
	    if($("input[name=is_agree]").is(":checked") && addForm.agree_content.value == "") { 
	    	alert("약관정보가 입력되지 않았습니다."); 
	    	addForm.agree_content.focus(); 
	    	return false;
	    }
	    alert("폼메일이 등록 되었습니다.");
	    $("form[name='addForm']").submit();
	}
	
	// 모달 내용 저장
	function register2() {
	    if(updateForm.title.value == "") { 
	    	alert("제목이 입력되지 않았습니다."); 
	    	updateForm.title.focus(); 
	    	return false;
	    }
	    if($("input[name=is_agree]").is(":checked") && updateForm.agree_content.value == "") { 
	    	alert("약관정보가 입력되지 않았습니다."); 
	    	updateForm.agree_content.focus(); 
	    	return false;
	    }
	    alert("폼메일이 수정 되었습니다.");
	    $("form[name='updateForm']").submit();
	}	
	
	
	/*
	언어 설정
	function setLocale(locale) {
	    $('button[id^=locale_]').attr('class', 'btn btn-default');
	    $('#locale_'+locale).attr('class', 'btn btn-primary');
	    $('[name=locale]').val(locale);
	    setData($('[name=code]').val());
	}
	*/
		
	/*
	폼 주소 복사
	function onclickCopy(code) {
	    var UtilForm_url = 'index.php?tpf=UtilForm/list&UtilForm_code='+code;
	    var IE=(document.all)?true:false;
	    if (IE) {
	        if(confirm('이 폼 주소를 복사하시겠습니까?'))
	        window.clipUtilFormData.setData('Text', UtilForm_url);
	    } else {
	        temp = prompt('이 폼의 URL 입니다. Ctrl+C를 눌러 복사하세요', UtilForm_url);
	    }
	}
	*/

</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>