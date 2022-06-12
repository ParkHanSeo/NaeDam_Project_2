<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	p {
	    display: block;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	}
	element.style {
	    heigth: 150px;
	    overflow-y: scroll;
	}	
</style>

<script>
	$(function() {
		var result = {				
				"success" : 0,				
				"fail" : 0				
		}
		var boardNo = $("input[name='boardNo']").val();		
	    var uploader2 = $("#uploader2").plupload({	    	
	        // General settings
	        runtimes : 'html5,flash,silverlight,html4',
	        multiple_queues: true,
	        multipart: true,
	        url : "/admin/board/json/plupload?${_csrf.parameterName}=${_csrf.token}",	        
			//파일 형식 필터 집합
	        filters : {
	            // Maximum file size
	            max_file_size : '1000mb',
	            // Specify what files to browse for
	        },	        
	        init : {
	        	FileUploaded: function(up, file, result) {	               	               
	               var fileName = '<input type="hidden" name="postName" id="postName" value="'+file.name+'" class="form-control input-sm" style="width:100%; display:inline; margin-bottom:10px;">'
	               $("span[id='file_list']").append(fileName)	               
	               up.start();
	            }	            
	        },
	        //대기열에 있는 파일 이름 변환
	        rename: true,			
	        //
	        //업로드 우선 순위 변경 파일 정렬
	        sortable: true,	
	        //드래그 앤 드롭 하여 파일 삽입 가능
	        dragdrop: true,	
	        // Views to activate
	        views: {
	            list: true,
	            thumbs: true, // Show thumbs
	            active: 'thumbs'
	        },			
	        // Flash swf의 url
	        flash_swf_url : '../../js/Moxie.swf',	
	        // Silverlight xap의 URL
	        silverlight_xap_url : '../../js/Moxie.xap'
	    });	
	    $('#form').submit(function(e) {
	        // Files in queue upload them first
	        if ($('#uploader').plupload('getFiles').length > 0) {
	
	            // When all files are uploaded submit form
	            $('#uploader').on('complete', function() {
	                $('#form')[0].submit();
	            });
	
	            $('#uploader').plupload('start');
	        } else {
	            alert('You must have at least one file in the queue.');
	        }
	        return false; // Keep the form from submitting
	    });
	});

	function funReply(){	
		$("span[name='board_sub_title']").text('답변');
		$("button[name='display_reply']").css("display", "none");
		$("button[name='updatePost']").attr("onclick", "funReply2();");
		$("input[name='mode']").val('answer');
		var append = $("#getPostTitle").val();
		$("#getPostTitle").val(" RE   :   "+append);
	}
	
	function funReply2(){	
		alert("답변 등록이 완료되었습니다.")
		$("form[name='getPostForm']").attr("method", "POST").attr("action", "/admin/board/postProcess?${_csrf.parameterName}=${_csrf.token}").submit();
	}
	
	function fncDeleteThombnail(){
		if(!confirm("정말 삭제 하시겠습니까?")){
			alert("취소 되었습니다.");
			return;
		}else{
			alert("해당 파일이 삭제 되었습니다.")
			$("form[name='getPostForm']").attr("method", "POST").attr("action", "/admin/board/deleteThombnail?${_csrf.parameterName}=${_csrf.token}").submit();	
		}
	}
	
	function fncUpdatePost(){
		if("${board2.option.optionMass}" != "y"){
			var postFile = $("input[id='getPostFile']").length;
			var postName = new Array(postFile);
			
			for(var i = 0; i < postFile; i++){
				postName[i] = $("input[id='getPostFile']")[i].value;
				alert(postName[i])
			}
			alert("수정 되었습니다.");
			$("form[name='getPostForm']").attr("method", "POST").attr("action", "/admin/board/postProcess?${_csrf.parameterName}=${_csrf.token}").submit();
		}else if("${board2.option.optionMass}" == "y"){
			var postFile = $("input[id='getPostFile']").length;
			var postName = new Array(postFile);
			
			for(var i = 0; i < postFile; i++){
				postName[i] = $("input[id='getPostFile']")[i].value;
				alert(postName[i])
			}
			alert("수정 되었습니다.");
			$("form[name='getPostForm']").attr("method", "POST").attr("action", "/admin/board/postProcess?${_csrf.parameterName}=${_csrf.token}").submit();
		}
	}
	
	function fucAddFile2(){
		$("div[name='listFile2']").append('<input type="file" name="postName" id="getPostFile" class="form-control input-sm" style="width:100%; display:inline; margin-bottom:10px;">');
	}
	
	function fncDeleteFile(fileNo){
		
		if(!confirm("정말 삭제 하시겠습니까?")){
			alert("취소 되었습니다.");
			return;
			
		}else{
		$.ajax({
			url : "/admin/board/json/deleteFile/"+fileNo,
			method : "GET",
			dataType : "JSON",	
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"	 						
			} ,
			success : function(JSONData, status){
				
			}
		})
		alert("파일이 삭제 되었습니다.")
  		$("span[id='"+fileNo+"']").remove();
		}
	}
	
	function fileDownload(postNo){
		$.ajax({
			url : "/admin/board/json/postFileCount/"+postNo,
			method : "GET",
			dataType : "JSON",	
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"	 						
			} ,
			success : function(JSONData, status){
				
			}
			
		})
	}
	
	function fncAddComment(){
		
		var secNo = $("input[name='secNo']").val();

		$.ajax({
			url : "/admin/board/json/getMemberData/"+secNo,
			method : "GET",
			dataType : "JSON",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"	 						
			} ,
			success : function(JSONData, status){
				
				$("input[id='commentName']").val(JSONData.lastName+JSONData.firstName);
				$("input[id='commentMemberNo']").val(JSONData.memberNo);
			}
		})
	}
	
	function deleteComment(commentNo){
		
		if(!confirm("정말 삭제 하시겠습니까?")){
			alert("취소 되었습니다.");
			return;
		}else{
			$.ajax({
				url : "/admin/board/json/deleteComment/"+commentNo,
				method : "GET",
				dataType : "JSON",	
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"	 						
				} ,
				success : function(JSONData, status){
					
				}
			})
			alert("파일이 삭제 되었습니다.")
	  		$("tr[name='comment"+commentNo+"']").remove();
		}
	}

	$(function(){
		$("button[name='x']").on("click", function(){
			$("span[name='board_sub_title']").text('수정');
			$("button[name='display_reply']").css("display", "")
			$("span[name='thumbnailSpan']").remove();
			$("span[name='getFile']").remove();
		})
		
		$("#modalContent4").on("hidden.bs.modal", function(){
			$("span[name='board_sub_title']").text('수정');
			$("button[name='display_reply']").css("display", "")
			$("span[name='thumbnailSpan']").remove();
			$("span[name='getFile']").remove();
		})
		
		$("button[name='getPostBotton']").on("click", function(){
			var postNo = $(this).val();
			
			$.ajax({
				url : "/admin/board/json/getPostData/"+postNo,
				method : "GET",
				dataType : "JSON",	
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"	 						
				} ,
				success : function(JSONData, status){
					$("input[name='postNo']").val(JSONData.postNo);
					$("input[id='commentPostNo']").val(JSONData.postNo);
					$("input[name='postOrd']").val(JSONData.postOrd);
					$("input[name='postLayer']").val(JSONData.postLayer);
					$("input[name='postAsc']").val(JSONData.postAsc);
					$("input[name='postOriginNo']").val(JSONData.postOriginNo);

					CKEDITOR.instances.editor1.setData(JSONData.postContents)

					if(JSONData.postThombnail != null){
						
						var thombnail = "'${pageContext.request.contextPath}/resources/imgs/imageBoard/board"+JSONData.postThombnail+"'"
						if(JSONData.postThombnail != null && JSONData.postThombnail != ''){
							var	display = '<span id="display_thumbnail" name="thumbnailSpan">'
										+ '<button type="button" onclick="window.open('+thombnail+')" class="btn btn-success btn-xs">보기</button>'
										+ '<button type="button" onclick="fncDeleteThombnail()" name="deleteThombnail" value="'+JSONData.postNo+'" class="btn btn-danger btn-xs">삭제</button>'
										+ '</span>';
										
										
										//<input type="hidden" name="postNo" id="getPostNo" >
						$("td[name='thombnailTd']").append(display);
						}else{
							var	display = '<span id="display_thumbnail" name="thumbnailSpan">'
								+ '</span>';	
						}
					}
					
					$("#getPostTitle").val(JSONData.postTitle);
					$("#getThombnailName").val(JSONData.postThombnail);
					$("#getPostName").val(JSONData.postFile);
					
					if(JSONData.postNotice == 0){
						$("#getPostNotice").prop("checked", false);
					}else if(JSONData.postNotice == 1){
						$("#getPostNotice").prop("checked", true);
					}	
				}				
			})
			
			var memberNo = $(this).find('input').val();
			
			$.ajax({
				url : "/admin/board/json/getMemberData2/"+memberNo,
				method : "GET",
				dataType : "JSON",	
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"	 						
				} ,
				success : function(JSONData, status){
					$("#postGetName").val(JSONData.lastName+JSONData.firstName);
					$("#postGetPhone").val(JSONData.phone);
					$("#postGetEmail").val(JSONData.email);
				}
				
			})
			
			$.ajax({
				url : "/admin/board/json/postViewCount/"+postNo,
				method : "GET",
				dataType : "JSON",	
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"	 						
				} ,
				success : function(JSONData, status){
					
				}
				
			})
			
			$.ajax({
				url : "/admin/board/json/getPostFile/"+postNo,
				method : "GET",
				dataType : "JSON",	
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"	 						
				} ,
				success : function(JSONData, status){			
					for(var i = 0; i < JSONData.length; i++){
						var display = "";
						display += '<span id="'+JSONData[i].fileNo+'" name="getFile" style="float:left; position:relative; text-align:center; padding-right:15px;">'
								+  '<a href="${pageContext.request.contextPath}/resources/imgs/imageBoard/board'+JSONData[i].fileName+'" download="" value="'+postNo+'" name="fileDownload">'
								+  '<img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/board'+JSONData[i].fileName+'" style="width:80px; cursor:pointer;" onclick="fileDownload('+postNo+')">'
								+  '</a>'
								+  '<img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/delete.png" onclick="fncDeleteFile('+JSONData[i].fileNo+')" name="file'+JSONData[i].fileNo+'" style="width:30px;position: absolute;left:43px; top:3px; z-index:10; cursor:pointer;">'
								+  '</span>';
						$("span[id='file_list']").append(display);
					}
				}
			})

			$.ajax({
				url : "/admin/board/json/getCommentList/"+postNo,
				method : "GET",
				dataType : "JSON",	
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"	 						
				} ,
				success : function(JSONData, status){			
					for(var i = 0; i < JSONData.length; i++){
						var display = "";
						display += '<tr name="comment'+JSONData[i].commentNo+'">'
								+  '	<td>'+JSONData[i].commentWriter+'</td>'
								+  '	<td align="left">'+JSONData[i].commentContents+'</td>'
								+  '	<td>'+JSONData[i].commentData+'</td>'
								+  '	<td><button type="button" class="btn btn-danger btn-xs" onclick="deleteComment('+JSONData[i].commentNo+');">삭제</button></td>'
								+  '</tr>';
						$("tbody[id='commentList']").append(display);
					}
				}
			})			
		})
	})
</script>

<div class="modal fade" id="modalContent4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <form name="getPostForm" method="post" enctype="multipart/form-data">
	            <input type="hidden" name="postNo" id="getPostNo" >
	            <input type="hidden" name="postOrd" id="getPostOrd" >
	            <input type="hidden" name="postLayer" id="getPostLayer" >
	            <input type="hidden" name="postAsc" id="getPostAsc" >
	            <input type="hidden" name="postOriginNo" id="getPostOriginNo" >
	            <input type="hidden" name="mode" id="mode" value="update">
	            <input type="hidden" name="secNo" value="<sec:authentication property='principal.memberNo'/>">            
	            <div class="modal-header">
	                <button type="button" name="x" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabelPortfolio">게시물 관리</h4>
	            </div>
            	<div class="modal-body">
		            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 글 <span name="board_sub_title">수정</span></p></h4>
		            <table class="table table-bordered">
            			<tbody>
				            <tr>
				                <td class="menu">작성자</td>
				                <td align="left"><input type="text" name="name" id="postGetName" class="form-control input-sm"></td>
				            </tr>
				            <c:if test="${board2.option.optionAddinfo eq 'y'}">
					            <tr>
					                <td class="menu">휴대전화</td>
					                <td align="left"><input type="text" name="phone" id="postGetPhone" class="form-control input-sm" style="width:50%;"></td>
					            </tr>
					            <tr>
					                <td class="menu">이메일</td>
					                <td align="left"><input type="text" name="email" id="postGetEmail" class="form-control input-sm" style="width:50%;"></td>
					            </tr>
				            </c:if>
				            <tr>
				                <td class="menu">제목</td>
				                <td align="left">
					                <span style="float:left;width:80%;"><input type="text" name="postTitle" id="getPostTitle" class="form-control input-sm"></span>
					                <c:if test="${board2.option.optionNotice eq 'y'}">
						                <span>&nbsp;&nbsp;
						                	<input type="checkbox" id="getPostNotice" name="postNotice" value="1" >공지사항
						                </span>
						            </c:if>
				                </td>
				            </tr>
							<tr>
				                <td class="menu">내용</td>
				                <td align="left">
				                 	<textarea name="postContents" id="editor1" rows="10" cols="80" style="visibility: hidden; display: none;"></textarea>
				                 	<script type="text/javascript">
									 CKEDITOR.replace('editor1'
									                , {filebrowserUploadUrl:'/admin/board/imageUpload?${_csrf.parameterName}=${_csrf.token}'}
									 );
									</script>	                 	
				                </td>
				            </tr>
				            <c:if test="${board2.option.optionSecret eq 'y'}">
					            <tr>
						            <td class="menu">비밀글</td>
						            <td align="left">
						                <span>&nbsp;&nbsp;
						                <input type="checkbox" name="is_secret" value="y"></span>
						            </td>
					            </tr>
				            </c:if>            
				            <tr>
				                <td class="menu">썸네일 파일</td>
				                <td align="left" name="thombnailTd">
				                	<input type="file" name="ThombnailName" id="getThombnailName" class="form-control input-sm" style="width:80%; display:inline;">
				                </td>
				            </tr>
				            <tr>
				                <td class="menu">파일</td>
				                <td align="left">
					                <c:if test="${board2.option.optionMass eq null}">
						                <p><span id="file_list"></span></p>
						                <p style="padding-top:10px; float:left; width:100%;">
						                    <button type="button" class="btn btn-primary btn-xs" onclick="fucAddFile();"><span class="glyphicon glyphicon-plus"></span> 파일추가</button><br>
						                </p>
					                    <div id="list_file" name="listFile">
					                    	<input type="file" name="postName" id="postName" class="form-control input-sm" style="width:100%; display:inline; margin-bottom:10px;" >
					                    </div>
					                </c:if>
					                <c:if test="${board2.option.optionMass eq 'y'}">
						                <p id="diplay-plupload" style="heigth:150px; overflow-y:scroll;" >
						                    <span id="file_list">
						                    	<input type="hidden" name="postName" id="postName" class="form-control input-sm" style="width:100%; display:inline; margin-bottom:10px;" >
						                    </span>            
						                </p>  
										<div id="uploader2"></div>                              
					                </c:if> 
				                </td>
				            </tr>
            			</tbody>
            		</table>
            		<c:if test="${board2.option.optionComment eq 'y'}">
						<div id="displayMemo" style="">
			            	<h4>
	            				<p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 댓글 관리
	            					<button type="button" onclick="fncAddComment()" name="comment" class="btn btn-info" data-toggle="modal" data-target="#modalContent5">댓글 작성</button>
	            				</p>
	            			</h4>
			            	<span id="memo_list">
			            		<table class="table table-bordered">
			            			<tbody id="commentList">
				            			<tr>  
				            				<td class="menu" style="width:80px;">글쓴이</td>  
				            				<td class="menu">내용</td>  
				            				<td class="menu" style="width:60px;">등록일</td>  
				            				<td class="menu" style="width:50px;">명령</td>
				            			</tr>
			            			</tbody>
			            		</table>
			            	</span>
	            		</div>
            		</c:if>
            	</div><!-- /.modal-body -->
	            <div class="modal-footer">
		            <button type="button" onclick="fncUpdatePost()" name="updatePost" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
		            <c:if test="${board2.option.optionAnswer eq 'y'}">
		            	<button type="button" onclick="funReply()" name="display_reply" style="" class="btn btn-danger">답변 페이지로 전환</button>
		            </c:if>
	            </div>
            	<input type="hidden" value="${boardNo}" name="boardNo">
        	</form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal fade -->