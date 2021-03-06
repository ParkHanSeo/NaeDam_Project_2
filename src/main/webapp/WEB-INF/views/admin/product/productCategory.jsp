<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="상품 카테고리" name="title"/>
</jsp:include>

<div class="content-wrapper">
	<section class="content-header">
	    <h1>
		    상품카테고리 관리
		    <small>order list</small>
	    </h1>
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li><a href="#">상품 관리</a></li>
	        <li class="active">상품카테고리</li>
	    </ol>
	</section>

	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
		                <div class="col-xs-3" style="padding:0 5px 0 0;">
		                	<iframe name="tree" id="iframe_tree" src="${pageContext.request.contextPath }/admin/product/tree_model?stp=pc" width="100%" height="794" scrolling="auto" frameborder="1"></iframe>
		                </div>
		                <div class="col-xs-9" style="padding:0 5px 0 0;">
		                	<iframe name="list" id="iframe_list" src="${pageContext.request.contextPath }/admin/product/productCategory_sub" width="100%" height="794" scrolling="auto" frameborder="1"></iframe>
		                </div>
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section><!-- /.content -->

	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:600px;">
	        <div class="modal-content">
	            <form name="form_register" method="post" onsubmit="return false;" action="">
		            <input type="hidden" name="parent_no" id="parent_no" />
		            <input type="hidden" name="mode" id="mode" value="insertCategory">
		            <input type="hidden" name="code" id="code">
		            <input type="hidden" name="category_code" id="category_code">
		            <input type="hidden" name="locale" value="ko">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title">상품카테고리 등록</h4>
		            </div>
	            	<div class="modal-body">
			            <div class="row" style="margin:0">
			                <div class="col-xs-6">
			                	<span style="float:left;"><h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 상품카테고리 등록</p></h4></span>
			                </div>
	                		<div class="col-xs-6" style="padding:0">
	                			<div class="btn-group pull-right">
	  								<button type="button" id="locale_ko" onclick="setLocale('ko')" class="btn btn-primary">
	  									<i class="fa fa-globe" aria-hidden="true"></i> 한국어</button>  
	  								<button type="button" id="locale_en" onclick="setLocale('en')" class="btn btn-default">
	  									<i class="fa fa-globe" aria-hidden="true"></i> ENG</button>  
	  								<button type="button" id="locale_zh" onclick="setLocale('zh')" class="btn btn-default">
	  									<i class="fa fa-globe" aria-hidden="true"></i> 中国</button>  
	  								<button type="button" id="locale_vn" onclick="setLocale('vn')" class="btn btn-default">
	  									<i class="fa fa-globe" aria-hidden="true"></i> Tiếng việt</button>                
	  							</div>
	                		</div>
	            		</div>
	            		<table class="table table-bordered">
				            <tr>
				                <td class="menu">카테고리명</td>
				                <td align="left"><input type="text" name="title" id="title" class="form-control input-sm" /></td>
				            </tr>
				            <tr>
				                <td class="menu">상태</td>
				                <td>
				                	<select name="status" id="status" class="form-control input-sm" style="width:100px;">
				      					<option value="Y">보임</option>      
				      					<option value="N">숨김</option>                
				      				</select>
				                </td>
				            </tr>
	            		</table>
	            	</div><!-- /.modal-body -->
	            	<div class="modal-footer">
	            		<button type="button" onclick="register();" class="btn btn-primary">저장하기</button>
	            	</div><!-- /.modal-footer -->
	            </form>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal fade -->
</div><!-- /.content-wrapper -->

<script>
	function register(){
		if($('#mode').val() == 'updateCategory'){
			var cteNo = $('#code').val()
			updateCategory(cteNo);
		}else{
			insertCategory();
		}
	}
	
	function updateCategory(cteNo){
		const formData = new FormData(document["form_register"])
		var obj = {};
		for(const [k, v] of formData){
			obj[k] = v;
		};

		const jsonStr = JSON.stringify(obj);
		console.log(jsonStr)
		
		 $.ajax({
             url:'${pageContext.request.contextPath}/admin/category/update',
             type:'get',
             dataType:'json',
             headers: {
					"${_csrf.headerName}" : "${_csrf.token}"
				},
             data: {
            	 jsonStr : jsonStr
             },
             contentType: "application/json; charset=utf-8",
             success(data){
                 if(data > 0) alert('카테고리가 수정되었습니다.')
                 location.reload();
             },
             error: console.log
         });
	}
	
	function insertCategory(){
		const formData = new FormData(document["form_register"])
		var obj = {};
		for(const [k, v] of formData){
			obj[k] = v;
		};
		const jsonStr = JSON.stringify(obj);
		console.log(jsonStr)
		
		$.ajax({
            url:'${pageContext.request.contextPath}/admin/category/insert',
            type:'get',
            dataType:'json',
            headers: {
					"${_csrf.headerName}" : "${_csrf.token}"
				},
            data: {
           	 jsonStr : jsonStr
            },
            contentType: "application/json; charset=utf-8",
            success(data){
                if(data > 0) alert('카테고리가 추가되었습니다.')
                location.reload();
            },
            error: console.log
        });
	}
</script>
<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>