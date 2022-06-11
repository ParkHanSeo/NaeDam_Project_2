<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<% 
pageContext.setAttribute("CR", "\r"); 
pageContext.setAttribute("LF", "\n"); 
pageContext.setAttribute("CRLF", "\r\n"); 
pageContext.setAttribute("SP", "&nbsp;"); 
pageContext.setAttribute("BR", "<br/>");
%>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="폼 문항 관리" name="title"/>
</jsp:include>
<script>
	function deleteChoiceItem(formNo){
			
			var formArr = new Array();
			var mode = "delete";
			var part = "item";
			
			$("input[class='itemNo']:checked").each(function(){
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
    		 		
  		  	 	 }
  		  	 	 
	  		});		
				alert("해당 자료가 삭제 되었습니다.")
				location.href = "/admin/form/itemList?formNo="+formNo+"";
			}			
	}
	
	function fncUp(){
		var itemAsc = $("input:radio[name='order_code']:checked").val();
		var itemIndex = $("input:radio[name='order_code']:checked").parent().parent().index()+1;
		var itemUpAsc = $("tr").eq(itemIndex-1).children().find("input:radio").val();
		var itemNo = $("input:radio[name='order_code']:checked").parent().parent().find("input[name='itemNo']").val();
		if(itemIndex == 0){
			alert("1개의 항목을 선택하여야 합니다.");
			return;
		}
		if(itemAsc == itemUpAsc){
			itemIndex--;
			itemUpAsc = $("tr").eq(itemIndex-1).children().find("input:radio").val();
			var upItemNo = $("tr").eq(itemIndex-1).children().find("input[name='itemNo']").val();
		}else{
			var upItemNo = $("tr").eq(itemIndex-1).children().find("input[name='itemNo']").val();
		}
		if(itemIndex == 1){
			alert("더이상 상위로의 위치 변경은 불가능합니다.");
			return;
		}else{
	  		$.ajax({
			 	 url : "/admin/form/json/updateUpAsc?${_csrf.parameterName}=${_csrf.token}",
	 		  	 type : "POST",
		  	 	 data : { 
		  	 		itemAsc,
		  	 		itemUpAsc,
		  	 		itemNo,
		  	 		upItemNo
		  	 	 },
			 	 success : function(result){
			 		if(result == true){
			 			location.reload();
			 		}
			  	 }
	 		});
		}
	}
	
	function fncDown(){
		var lastIndex = $("input:radio[name='order_code']:checked").parent().parent().parent().find("tr").last().index()+1;
		var itemAsc = $("input:radio[name='order_code']:checked").val();
		var itemIndex = $("input:radio[name='order_code']:checked").parent().parent().index()+1;
		var itemDownAsc = $("tr").eq(itemIndex+1).children().find("input:radio").val();
		var itemNo = $("input:radio[name='order_code']:checked").parent().parent().find("input[name='itemNo']").val();

		if(itemIndex == 0){
			alert("1개의 항목을 선택하여야 합니다.")
			return;
		}
		if(itemAsc == itemDownAsc){
			itemIndex++;
			itemDownAsc = $("tr").eq(itemIndex+1).children().find("input:radio").val();
			var downItemNo = $("tr").eq(itemIndex+1).children().find("input[name='itemNo']").val();
		}else{
			var downItemNo = $("tr").eq(itemIndex+1).children().find("input[name='itemNo']").val();
		}
		if(itemIndex == lastIndex){
			alert("더이상 하위로의 위치 변경은 불가능합니다.")
			return;
		}else{
	  		$.ajax({
			 	 url : "/admin/form/json/updateDownAsc?${_csrf.parameterName}=${_csrf.token}",
	 		  	 type : "POST",
		  	 	 data : { 
		  	 		itemAsc,
		  	 		itemDownAsc,
		  	 		itemNo,
		  	 		downItemNo
		  	 	 },
			 	 success : function(result){
			 		if(result == true){
			 			location.reload();
			 		}
			  	 }
	 		});				
		}
	}	
	
	

</script>
<!-- content-wrapper -->
<div class="content-wrapper" style="min-height: 645px;">
	<section class="content-header">
	    <h1>폼 문항 관리<small>research detail</small></h1>
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li class="active">폼 문항 관리</li>
	    </ol>
	</section><!-- /.content-header -->
	
	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
	                    <div align="center"><h2>문의사항</h2></div>
	                    <label style="margin-top:5px;">총 6 문항</label>
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
															$('.itemNo').prop("checked", true);
														} else {
															$('.itemNo').prop("checked", false);
														}
													});
												</script>
										</div>
			                        </td>
			                        <td style="width:80px; color:red;"><b>문항 번호</b></td>
			                        <td>문항명</td>
			                        <td style="width:140px;">입력 종류</td>
			                        <td style="width:100px;">필수항목</td>
			                        <td style="width:200px;">입력 예시</td>
			                        <td style="width:140px;">입력값 체크</td>
			                        <td style="width:100px;">리스트 표출</td>
			                        <td style="width:60px;">
			                        	<i onclick="fncDown();" class="fa fa-fw fa-arrow-circle-down cp" style="cursor:pointer;"></i>
			                        	<i onclick="fncUp();" class="fa fa-fw fa-arrow-circle-up cp" style="cursor:pointer;"></i>
			                        </td>
			                        <td style="width:80px;">명령</td>
			                    </tr>
		                    </thead>
		      				<tbody>
		      				  <c:set var="i" value="0"/>
		      				  <c:forEach var="item" items="${list}" varStatus="status" >
		      				  <c:set var="i" value="${ i+1 }" />		      				  
			      				<tr>
			                        <td>
				                        <div>
				                        	<input type="checkbox" class="itemNo" name="itemNo"  value="${item.itemNo}" />
				                        	<script>
												$(".itemNo").click(function() {
													$("#allCheck").prop("checked", false);
												});
											</script>
										</div>
			                        </td>
			                        <td>${item.itemNo}</td>
			                        <td align="left">${item.label}</td>
			                        <td>${item.input_type}</td>
			                        <td>${item.placeholder}</td>
			                        <td align="left">
			                          <c:if test="${!empty item.input_example}">
			                        	<c:set var="ex" value="${fn:split(item.input_example,'/')}"/>
			                        	<c:forEach var="exNum" items="${ex}" varStatus="g">
											<li style="margin-left:10px;">${exNum}</li>			                        		
			                        	</c:forEach>
			                          </c:if>
			                        </td>
			                        <td>${item.check_type}</td>
			                        <td>
			                          <c:if test="${item.is_show eq 'y'}">
			                        	<i class="fa fa-check"></i>
			                          </c:if>
			                        </td>
			                        <td><input type="radio" name="order_code" value="${item.itemAsc}"></td>
			                        <td><button type="button" onclick="onclickUpdate(${item.itemNo});" class="btn btn-primary btn-xs">상세보기</button></td>
			                    </tr> 
			                  </c:forEach>
			                  <c:if test="${empty list}">
			                  	<tr><td colspan="10"><br>등록된 자료가 없습니다.<br><br></td></tr>
			                  </c:if>			                       
		                    </tbody>
		               	</table>
	                    <br>
	                    <span style="float:left;">
	                    	<button type="button" onclick="deleteChoiceItem(${formNo})" class="btn btn-danger btn-sm"><i class="fa fa-minus-square"></i> 선택 삭제</button>
	                    	<button type="button" onclick="onclickInsert()" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 문항 등록</button>
	                    </span>
	                    <span style="float:right;">
							<button type="button" onclick="javascript:onclickHtmlDesign('list','${formNo}')" class="btn btn-primary btn-sm"><i class="fa fa-list"></i> 폼 HTML 디자인 - 리스트</button>
							<button type="button" onclick="javascript:onclickHtmlDesign('write','${formNo}')" class="btn btn-primary btn-sm"><i class="fa fa-pencil"></i> 폼 HTML 디자인 - 쓰기</button>
	                    	<button type="button" onclick="javascript:history.back();" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 폼 관리 바로 가기</button>
	                    </span>
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section><!-- /.content -->
	
	<!-- 폼 문항 등록 -->
	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width: 600px;">
	        <div class="modal-content">
	            <form name="form_register" method="post" action="/admin/form/formProcess?${_csrf.parameterName}=${_csrf.token}">
		            <input type="hidden" name="mode" value="insert">
					<input type="hidden" name="part" value="item">
		            <input type="hidden" name="formNo" value="${formNo}">

		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                <h4 class="modal-title" id="myModalLabelPortfolio">폼 문항 관리</h4>
		            </div><!-- /.modal-header -->
		            
		            <div class="modal-body">
			            <div class="row" style="margin:0">
			                <div class="col-xs-4">
			                	<span style="float:left;"><h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 문항 정보</p></h4></span>
			                </div>
			                <div class="col-xs-8" style="padding:0"></div>
			            </div><!-- /.row -->
		
			            <table class="table table-bordered">
				            <tbody>
					            <tr>
					                <td class="menu">문항명</td>
					                <td align="left"><input type="text" name="label" class="form-control input-sm"></td>
					            </tr>
					            <tr>
					                <td class="menu">입력 종류</td>
					                <td align="left">
						                <span style="float:left">
						                	<select name="input_type" onchange="if(this.value) checkInputType(this.value)" class="form-control input-sm" style="width:150px;">
						      					<option value="text">텍스트</option>      
						      					<option value="tel">전화</option>      
						      					<option value="email">이메일</option>      
						      					<option value="textarea">텍스트에어리어</option>      
						      					<option value="webeditor">웹에디터</option>      
						      					<option value="select">콤보박스</option>      
						      					<option value="radio">라디오</option>      
						      					<option value="checkbox">체크박스</option>      
						      					<option value="date">날짜</option>      
						      					<option value="file">파일</option>                
						      				</select>
						                </span>
						                <span style="padding-left:10px; float:left">
						                	<input type="checkbox" name="is_require" value="y"> 필수항목 (※ 입력여부 체크)
						                </span>
					                </td>
					            </tr>
					            <tr id="displayPlaceholder">
					                <td class="menu">placeholder</td>
					                <td align="left">
					                	<input type="text" name="placeholder" class="form-control input-sm"> ※ 디폴트 표출 문구
					                </td>
					            </tr>
								<tr id="displayHtmlId">
					                <td class="menu">HTML ID</td>
					                <td align="left">
					                	<input type="text" name="html_id" class="form-control input-sm"> ※ 라디오, 체크박스, 날짜, 파일에서는 ID 사용 불가
					                </td>
					            </tr>
								<tr id="displayHtmlClass">
					                <td class="menu">HTML CLASS</td>
					                <td align="left">
					                	<input type="text" name="html_class" class="form-control input-sm">
					                </td>
					            </tr>
					            <tr id="displayInputExample" style="display:none;">
					                <td class="menu">입력 예시</td>
					                <td align="left">
										<textarea name="input_example" rows="5" style="width:100%;" class="form-control input-sm" placeholder="매우좋음&#13;&#10;좋음&#13;&#10;나쁨&#13;&#10;아주나쁨"></textarea>
					                </td>
					            </tr>
					            <tr>
					                <td class="menu">입력값 체크</td>
					                <td align="left">
						                <select name="check_type" class="form-control input-sm" style="width:150px;">
						                	<option value="">선택하기</option>
						      				<option value="email">이메일</option>      
						      				<option value="mobile">휴대폰</option>      
						      				<option value="tel">전화번호</option>      
						      				<option value="mobile_tel">휴대폰 or 전화번호</option>      
						      				<option value="number">숫자</option>      
						      				<option value="img">이미지파일</option>                
						      			</select>
					                </td>
					            </tr>
					            <tr>
					                <td class="menu">리스트</td>
					                <td align="left">
					                	<input type="checkbox" name="is_show" value="y"> 표출
					                </td>
					            </tr>
				            </tbody>
			            </table>
		            </div><!-- /.modal-body -->
		            
		            <div class="modal-footer">
		            	<!--<button type="button" onclick="" class="btn btn-danger">삭제</button>-->
		            	<button type="button" onclick="register(${formNo})" class="btn btn-primary">확인/수정</button>
		            </div><!-- /.modal-footer -->
	            </form><!-- /.form_register -->
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal .fade -->
	
	<!-- 폼 문항 수정 -->
	<div class="modal fade" id="modalContent2" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width: 600px;">
	        <div class="modal-content">
	            <form name="form_register2" method="post" action="/admin/form/formProcess?${_csrf.parameterName}=${_csrf.token}">
		            <input type="hidden" name="mode" value="update">
					<input type="hidden" name="part" value="item">
		            <input type="hidden" name="formNo" value="${formNo}">
		            <input type="hidden" name="itemNo">
		            
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                <h4 class="modal-title" id="myModalLabelPortfolio">폼 문항 관리</h4>
		            </div><!-- /.modal-header -->
		            
		            <div class="modal-body">
			            <div class="row" style="margin:0">
			                <div class="col-xs-4">
			                	<span style="float:left;"><h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 문항 정보</p></h4></span>
			                </div>
			                <div class="col-xs-8" style="padding:0"></div>
			            </div><!-- /.row -->
		
			            <table class="table table-bordered">
				            <tbody>
					            <tr>
					                <td class="menu">문항명</td>
					                <td align="left"><input type="text" name="label" class="form-control input-sm"></td>
					            </tr>
					            <tr>
					                <td class="menu">입력 종류</td>
					                <td align="left">
						                <span style="float:left">
						                	<select name="input_type" onchange="if(this.value) checkInputType2(this.value)" class="form-control input-sm" style="width:150px;">
						      					<option value="text">텍스트</option>      
						      					<option value="tel">전화</option>      
						      					<option value="email">이메일</option>      
						      					<option value="textarea">텍스트에어리어</option>      
						      					<option value="webeditor">웹에디터</option>      
						      					<option value="select">콤보박스</option>      
						      					<option value="radio">라디오</option>      
						      					<option value="checkbox">체크박스</option>      
						      					<option value="date">날짜</option>      
						      					<option value="file">파일</option>                
						      				</select>
						                </span>
						                <span style="padding-left:10px; float:left">
						                	<input type="checkbox" name="is_require" value="y"> 필수항목 (※ 입력여부 체크)
						                </span>
					                </td>
					            </tr>
					            <tr id="displayPlaceholder2">
					                <td class="menu">placeholder</td>
					                <td align="left">
					                	<input type="text" name="placeholder" class="form-control input-sm"> ※ 디폴트 표출 문구
					                </td>
					            </tr>
								<tr id="displayHtmlId2">
					                <td class="menu">HTML ID</td>
					                <td align="left">
					                	<input type="text" name="html_id" class="form-control input-sm"> ※ 라디오, 체크박스, 날짜, 파일에서는 ID 사용 불가
					                </td>
					            </tr>
								<tr id="displayHtmlClass2">
					                <td class="menu">HTML CLASS</td>
					                <td align="left">
					                	<input type="text" name="html_class" class="form-control input-sm">
					                </td>
					            </tr>
					            <tr id="displayInputExample2" style="display:none;">
					                <td class="menu">입력 예시</td>
					                <td align="left">
										<textarea name="input_example" rows="5" style="width:100%;" class="form-control input-sm" placeholder="매우좋음&#13;&#10;좋음&#13;&#10;나쁨&#13;&#10;아주나쁨"></textarea>
					                </td>
					            </tr>
					            <tr>
					                <td class="menu">입력값 체크</td>
					                <td align="left">
						                <select name="check_type" class="form-control input-sm" style="width:150px;">
						                	<option value="">선택하기</option>
						      				<option value="email">이메일</option>      
						      				<option value="mobile">휴대폰</option>      
						      				<option value="tel">전화번호</option>      
						      				<option value="mobile_tel">휴대폰 or 전화번호</option>      
						      				<option value="number">숫자</option>      
						      				<option value="img">이미지파일</option>                
						      			</select>
					                </td>
					            </tr>
					            <tr>
					                <td class="menu">리스트</td>
					                <td align="left">
					                	<input type="checkbox" name="is_show" value="y"> 표출
					                </td>
					            </tr>
				            </tbody>
			            </table>
		            </div><!-- /.modal-body -->
		            
		            <div class="modal-footer">
		            	<!--<button type="button" onclick="" class="btn btn-danger">삭제</button>-->
		            	<button type="button" onclick="register2(${formNo})" class="btn btn-primary">확인/수정</button>
		            </div><!-- /.modal-footer -->
	            </form><!-- /.form_register -->
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal .fade -->	
	
	<div class="modal fade" id="modalContentDesign" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:90%">
	        <div class="modal-content">
	            <form name="form_html_design" method="post" action="/admin/form/formProcess?${_csrf.parameterName}=${_csrf.token}">
		            <input type="hidden" name="mode" id="mode" value="">
		            <input type="hidden" name="part" value="item">
		            <input type="hidden" name="formNo" value="${formNo}">
		            <input type="hidden" name="design_type">
		            <input type="hidden" name="html_list" 
		            	   value="<table class=&quot;basic-board-row&quot;>
<tr>
	<th>번호</th>
<c:forEach var="item" items="${list}" varStatus="status" >	<th>${item.label}</th>
</c:forEach></tr>
<for>
<tr><c:forEach var="item" items="${list}" varStatus="status" >
	<td>[no]</td>
	<td>[itemNo:${item.itemNo}]</td></c:forEach>
</tr>
</for>
</table>">
<input type="hidden" name="html_design_write" value="
<table class=&quot;basic-board-row&quot;>
<colgroup>
   <col width=&quot;220&quot; />
   <col width=&quot;*&quot; />
</colgroup>
<c:forEach var="item" items="${list}" varStatus="status" ><tr>
   <th>${item.label}</th>
   <td>[itemNo:${item.itemNo}]</td>
</tr></c:forEach>
<c:if test="${form.is_captcha eq 'y'}"><tr>
   <th>보안코드</th>
   <td>[code:captcha]</td>
</tr></c:if>
<c:if test="${form.is_agree eq 'y'}"><tr>
   <th>개인정보 수집·이용 동의</th>
   <td>[code:agree]</td>
</tr></c:if></table>">

								
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                <h4 class="modal-title" id="myModalLabelPortfolio">폼 HTML 디자인 관리</h4>
		            </div><!-- /.modal-header -->
		            
		            <div class="modal-body">
						<table class="table table-bordered">
							<colgroup>
								<col width="*">
								<col width="25%">
							</colgroup>
							<tbody>
								<tr>
									<td class="menu">
			                        	폼 HTML 디자인 - <span id="design_type_txt"></span>
			                        	<span style="float:right">
			                        		<button type="button" onclick="setTableForm()" class="btn btn-warning btn-xs"><i class="fa fa-list"></i> 디폴트 폼</button>
			                        	</span>
			                        </td>
									<td class="menu">문항 목록</td>
								</tr>
								<tr>
									<td align="left" style="padding:0">
										<textarea name="content" id="content-editor" onfocus="javascript:this.value=''" rows="10" cols="80"  style="visibility: hidden; display: none; "></textarea>
									</td>
									<td align="left">
				                        <table class="table table-bordered">
					                        <colgroup>
					                            <col width="*">
					                            <col width="20%">
					                            <col width="30%">
					                        </colgroup>
					                        <tbody>
					                        	<tr>
					                            	<td class="menu">문항명</td>
					                            	<td class="menu">입력 종류</td>
					                            	<td class="menu">치환코드</td>
						                        </tr>
						                        <c:forEach var="item" items="${list}" varStatus="status" >   
							                        <tr>
							                            <td class="left">${item.label}</td>
							                            <td class="left">${item.input_type}</td>
							                            <td class="left">[itemNo:${item.itemNo}]</td>
							                        </tr>
						                        </c:forEach>
						                      <c:if test="${form.is_captcha eq 'y'}">
						                        <tr id="displayCaptcha">
						                            <td class="left" style="color:#ff0000;font-wighth:bode;">보안코드</td>
						                            <td class="left">-</td>
						                            <td class="left">[code:captcha]</td>
						                        </tr>
						                      </c:if>
						                      <c:if test="${form.is_agree eq 'y'}">
						                        <tr id="displayAgree">
						                            <td class="left" style="color:#ff0000;font-wighth:bode;">개인정보수집</td>
						                            <td class="left">-</td>
						                            <td class="left">[code:agree]</td>
						                        </tr>
						                      </c:if>
						                        <tr id="displaySearch">
						                            <td class="left" style="font-wighth:bode;">검색폼</td>
						                            <td class="left">-</td>
						                            <td class="left"><button type="button" onclick="addForm('search')" class="btn btn-warning btn-xs"><i class="fa fa-plus"></i> 사용</button></td>
						                        </tr>
						                        <tr id="displayPage">
						                            <td class="left" style="font-wighth:bode;">페이지</td>
						                            <td class="left">-</td>
						                            <td class="left"><button type="button" onclick="addForm('page')" class="btn btn-warning btn-xs"><i class="fa fa-plus"></i> 사용</button></td>
						                        </tr>
					                        </tbody>
				                        </table><!-- /.table table-bordered -->
			                        	<span style="color:#ff0000">※ 붉은색 항목은 필수 항목 입니다.</span>						
			                        </td>
								</tr>
							</tbody>
						</table><!-- /.table table-bordered -->
		            </div><!-- /.modal-body -->
		            
		            <div class="modal-footer">
						<button type="button" onclick="registerHtmlDesign()" class="btn btn-primary">확인/수정</button>
		            </div><!-- /.modal-footer -->
	            </form><!-- /.form_html_design -->
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal .fade -->

<script src="//mir9.co.kr/resource/js/ckeditor4.7.2/ckeditor.js"></script>
</div><!-- /.content-wrapper -->

<script>
	
	// 모달 체크에디터
	if (window.CKEDITOR) {  // CKEDITOR loading 여부 체크 (Web 버젼에서만 사용)
	    var objEditor = CKEDITOR.replace("content-editor", {
	        height: 800,
	        extraPlugins : "tableresize",
	        extraPlugins: "codemirror",
	        //removeButtons: "Source",
	        filebrowserUploadUrl: "/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files",
	        filebrowserImageUploadUrl: "/daemon/ckeditor_upload.php?command=QuickUpload&type=Images",
	        contentsCss : ["/html/css/common.css','/html/css/style.css"]
	    });
	
	    CKEDITOR.on("dialogDefinition", function (ev) {
	        var dialogName = ev.data.name;
	        var dialog = ev.data.definition.dialog;
	        var dialogDefinition = ev.data.definition;
	
	        if (dialogName == "image") {
	            dialog.on("show", function (obj) {
	                this.selectPage("Upload"); //업로드텝으로 시작
	            });
	            dialogDefinition.removeContents("advanced"); // 자세히탭 제거
	            dialogDefinition.removeContents("Link"); // 링크탭 제거
	        }
	    });
	    
	    CKEDITOR.config.allowedContent = true;
	    CKEDITOR.config.wsc_left = 10;
	    CKEDITOR.config.startupMode = "source";
	    CKEDITOR.config.codemirror = {
	        // Set this to the theme you wish to use (codemirror themes)
	        theme: "3024-night",
	        // Whether or not to automatically format code should be done when the editor is loaded
	        autoFormatOnStart: false
	    };
	}

	// 문항 등록 버튼      
	function onclickInsert() {
	    $("form[name='form_register'] #mode").val("insertItem");
	    $("#modalContent").modal("show");
	    form_register.reset();
	}
	 
	// 상세보기 버튼
	function onclickUpdate(code) {
	    $("form[name='form_register'] #mode").val("updateItem");
	    $("#modalContent2").modal({backdrop:"static", show:true});
	    setData(code);
	}	
	
	// 문항 정보 입력 종류에 따라 정보 입력창 변경
	function checkInputType(value) {
	    $("#displayPlaceholder").hide(); // placeholder : text, textarea 일 경우 표시
	    $("#displayInputExample").hide(); // inputExample : select, radio, checkbox 일 경우 표시 
	    if (value == "text" || value == "textarea") {
	    	$("#displayPlaceholder").show();
	    }
	    else if (value == "select" || value == "radio" || value == "checkbox") {
	    	$("#displayInputExample").show();
	    }
	}
	
	// 문항 정보 입력 종류에 따라 정보 입력창 변경
	function checkInputType2(value) {
	    $("#displayPlaceholder2").hide(); // placeholder : text, textarea 일 경우 표시
	    $("#displayInputExample2").hide(); // inputExample : select, radio, checkbox 일 경우 표시 
	    if (value == "text" || value == "textarea") {
	    	$("#displayPlaceholder2").show();
	    }
	    else if (value == "select" || value == "radio" || value == "checkbox") {
	    	$("#displayInputExample2").show();
	    }
	}	
	      
	// 상세보기 데이터 셋팅
	function setData(itemNo) {
	    $.ajax({
	        url: "/admin/form/json/getItem?${_csrf.parameterName}=${_csrf.token}",
	        type: "post",
	        dataType: "json",
	        data: {
	            method : "UtilForm.infoItem",
	            locale : $("[name=locale]").val(),
	            itemNo : itemNo
	        },
	        timeout: 5000,  // timeout : 5초
	        success: function(data, textStatus, jqXHR) {
	            var json_data = data;
	            $("[name=itemNo]").val(json_data.itemNo);
	            $("[name=label]").val(json_data.label);
	            $("[name=input_type]").val(json_data.input_type);
	            $("[name=placeholder]").val(json_data.placeholder);
	            checkInputType(json_data.input_type);
	            if(json_data.is_require == "y") {
	         	   $("[name=is_require]").prop("checked", true);
	            }
	            else {
	         	   $("[name=is_require]").prop("checked", false);
	            }
	            $("[name=placeholder]").val(json_data.placeholder);
	            $("[name=input_example]").val(json_data.input_example);
	    	    if (json_data.input_type == "text" || json_data.input_type == "textarea") {
	    		    $("#displayPlaceholder2").hide(); // placeholder : text, textarea 일 경우 표시
	    		    $("#displayInputExample2").hide(); // inputExample : select, radio, checkbox 일 경우 표시	    	    	
	    	    	$("#displayPlaceholder2").show();
	    	    }
	    	    else if (json_data.input_type == "select" || json_data.input_type == "radio" || json_data.input_type == "checkbox") {
	    		    $("#displayPlaceholder2").hide(); // placeholder : text, textarea 일 경우 표시
	    		    $("#displayInputExample2").hide(); // inputExample : select, radio, checkbox 일 경우 표시	    	    	
	    	    	$("#displayInputExample2").show();
	    	    }	            
	            $("[name=check_type]").val(json_data.check_type);
	            if(json_data.is_show == "y") {
	         	   $("[name=is_show]").prop("checked", true);
	            }
	            else {
	         	   $("[name=is_show]").prop("checked", false);
	            }
				$("[name=html_id]").val(json_data.html_id);
				$("[name=html_class]").val(json_data.html_class);
			},
	        error: function(xhr, textStatus, errorThrown){
	            $("#result_area").val("request failed : " + errorThrown);
	        }
	    });
	}
	
	// 문항 정보 확인 및 수정 버튼
	function register(formNo) {
	    if(form_register.label.value == "") { 
	    	alert("문항명이 입력되지 않았습니다."); 
	    	form_register.label.focus(); 
	    	return false;
	    }
	    alert("항목이 등록 되었습니다.");
	    $("form[name='form_register']").submit();
	}
	
	function register2(formNo) {
	    if(form_register2.label.value == "") { 
	    	alert("문항명이 입력되지 않았습니다."); 
	    	form_register2.label.focus(); 
	    	return false;
	    }
	    alert("항목이 수정 되었습니다.");
	    $("form[name='form_register2']").submit();
	}	
	      	
	// 폼 HTML 디자인 리스트 및 쓰기 버튼
	function onclickHtmlDesign(design_type, code) {
	    $("[name=design_type]").val(design_type);
	    $("#modalContentDesign").modal({backdrop:"static", show:true});
	    // DB값 가져오기
	    $.ajax({
	    	url:'/admin/form/json/getForm?${_csrf.parameterName}=${_csrf.token}',
	        type: "post",
	        dataType: "json",
	        data: {
	            method : "form.getForm",
	            code : code
	        },
	        timeout: 5000,  // timeout : 5초
	        success: function(data, textStatus, jqXHR) {
	            var json_data = data;
	            // 폼제목에 따른 문항 목록 설정
	            console.log(data)
	            if (design_type == "list") {
	                $("#design_type_txt").text("리스트 폼"); // 폼 제목
					$("form[name='form_html_design']").find("input[name='mode']").val("updateDesignList");
	                var html = json_data.html_design_list;
	                //objEditor.setData(json_data.html_design_list);
	                $("#displayCaptcha").hide();
	                $("#displayAgree").hide();
	                $("#displaySearch").show();
	                $("#displayPage").show();
	            }
	            else {
	                $("#design_type_txt").text("쓰기 폼"); // 폼 제목
	                $("form[name='form_html_design']").find("input[name='mode']").val("updateDesignWrite");
	                var html = json_data.html_design_write;
	                //objEditor.setData(json_data.html_design_write);
	                $("#displayCaptcha").show();
	                $("#displayAgree").show();
	                $("#displaySearch").hide();
	                $("#displayPage").hide();
	            }
	
	            setTimeout(function() {
	                objEditor.setData("\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n");
	            }, 200);
	
	            setTimeout(function() {
	                if(html != null) {
	                	objEditor.setData(html);
	                }
	            }, 200);
	        },
	        error: function(xhr, textStatus, errorThrown) {
	            $("#result_area").val("request failed : " + errorThrown);
	        }
	    });
	}
	
	// 디폴트 폼 버튼 : 히든 list 또는 write 데이터 셋팅
	function setTableForm() {
	    var design_type = $("[name=design_type]").val();
	    objEditor.setData($("[name=html_" + design_type + "]").val());
	}
	
	// 추가 문항 사용
	function addForm(type) {
	    var tag = "";
	    switch (type) {
	        case "search": 
	        	tag += "<form name='formSearch' method='post' action=''>\n";
      			tag += "<input type='hidden' name='url' value='[url]'>\n";
      			tag += "<input type='hidden' name='tpf' value='form/list'>\n";
		        tag += "<input type='hidden' name='form_code' value='[form_code]'>\n";
		        tag += "<select name='field'>\n";
		        tag += "";
		        tag += "</select>\n";
		        tag += "<input type='text' name='keyword' value='[keyword]'>\n";
		        tag += "<input type='button' value='확인' onclick='formSearch.submit();'>\n";
		        tag += "</form>"; break;
	        case "page": 
	        	tag += "<page>"; break;
	    }
	    objEditor.setData(objEditor.getData() + "\n\n" + tag);
	}	
	
	// 폼 HTML 디자인 리스트 및 쓰기 확인 및 수정 버튼
	function registerHtmlDesign() {
		var html_design_value = parent.objEditor.getData();
		var mode = $("form[name='form_html_design']").find("input[name='mode']").val();
	    if(confirm("폼 HTML 디자인을 저장하시겠습니까?")) {
	    	if(mode == "updateDesignList"){
	    		$("textarea[name='content']").attr('name','html_design_list');
	    	}else if(mode == "updateDesignWrite"){
	    		$("textarea[name='content']").attr('name','html_design_write');
	    	}
			$("form[name='form_html_design']").submit();
		}
	}
	
	/*
	언어 설정
	function setLocale(locale) {
	    $("button[id^=locale_]").attr("class", "btn btn-default");
	    $("#locale_" + locale).attr("class", "btn btn-primary");
	    $("[name=locale]").val(locale);
	    setData($("[name=code]").val());
	}
	*/	
	
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>