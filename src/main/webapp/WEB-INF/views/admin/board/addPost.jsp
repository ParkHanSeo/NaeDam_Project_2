<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script>
	$(function() {
		var result = {
				
				"success" : 0,
				
				"fail" : 0
				
		}
		var boardNo = $("input[name='boardNo']").val();
		
	    var uploader = $("#uploader").plupload({
	    	
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
                   
                   console.log(file.name)
                   
                   var fileName = '<input type="hidden" name="postName" id="postName" value="'+file.name+'" class="form-control input-sm" style="width:100%; display:inline; margin-bottom:10px;">'
                   $("#file_list").append(fileName)
                   
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

	function fncAddPost(){
		
		if("${board2.option.optionMass}" != "y"){
			var postFile = $("input[id='postName']").length;
			var postTitle = $("input[id='postTitle']").val();
			var postContents = CKEDITOR.instances.editor.getData();
			var postName = new Array(postFile);
			if(postTitle == null || postTitle == ''){
				alert("제목을 입력하셔야 합니다.");
				return;
			}else if(postContents == null || postContents == ''){
				alert("내용을 입력하셔야 합니다.");
				return;
			}
			
			for(var i = 0; i < postFile; i++){
				postName[i] = $("input[id='postName']")[i].value;
				//alert(postName[i])
			}	
			alert("게시글이 등록 되었습니다.")
			$("form[name='addPostForm']").attr("method", "POST").attr("action", "/admin/board/postProcess?${_csrf.parameterName}=${_csrf.token}").submit();
		}else if("${board2.option.optionMass}" == "y"){
			var postFile = $("input[id='postName']").length;
			var postTitle = $("input[id='postTitle']").val();
			var postContents = CKEDITOR.instances.editor.getData();
			var postName = new Array(postFile);
			if(postTitle == null || postTitle == ''){
				alert("제목을 입력하셔야 합니다.");
				return;
			}else if(postContents == null || postContents == ''){
				alert("내용을 입력하셔야 합니다.");
				return;
			}
			
			
			for(var i = 0; i < postFile; i++){
				postName[i] = $("input[id='postName']")[i].value;
				//alert(postName[i])
			}	
			
			alert("게시글이 등록 되었습니다.")
			$("form[name='addPostForm']").attr("method", "POST").attr("action", "/admin/board/postProcess?${_csrf.parameterName}=${_csrf.token}").submit();	
		}
	}
	
	function fucAddFile(){
		$("div[name='listFile']").append('<input type="file" name="postName" id="postName" class="form-control input-sm" style="width:100%; display:inline; margin-bottom:10px;">');
	}
	
</script>

<div class="modal fade" id="modalContent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <form name="addPostForm" method="post" enctype="multipart/form-data">
            <input type="hidden" name="mode" id="mode" value="insert">
            <input type="hidden" name="secNo" value="<sec:authentication property='principal.memberNo'/>">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabelPortfolio">게시물 관리</h4>
            </div>
            <div class="modal-body">

            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 글 <span id="board_sub_title">등록</span></p></h4>
            <table class="table table-bordered">
            <tbody>
            <tr>
                <td class="menu">작성자</td>
                <td align="left"><input type="text" name="name" id="name" class="form-control input-sm"></td>
            </tr>
            <c:if test="${board2.option.optionAddinfo eq 'y'}">
            <tr>
                <td class="menu">휴대전화</td>
                <td align="left"><input type="text" name="phone" id="phone" class="form-control input-sm" style="width:50%;"></td>
            </tr>
            <tr>
                <td class="menu">이메일</td>
                <td align="left"><input type="text" name="email" id="email" class="form-control input-sm" style="width:50%;"></td>
            </tr>
            </c:if>
            <tr>
                <td class="menu">제목</td>
                <td align="left">
                <span style="float:left;width:80%;"><input type="text" name="postTitle" id="postTitle" class="form-control input-sm"></span>
                <c:if test="${board2.option.optionNotice eq 'y'}">
	                <span>&nbsp;&nbsp;
	                	<input type="checkbox" name="titleNotice" value="y">공지사항
	                </span>
	            </c:if>
                </td>
            </tr>
			<tr>
                 <td class="menu">내용</td>
                 <td align="left">
                 	<textarea name="postContents" id="editor" rows="10" cols="80" style="visibility: hidden; display: none;"></textarea>
                 	<script type="text/javascript">
					 CKEDITOR.replace('editor'
					                , {filebrowserUploadUrl:'/admin/board/imageUpload?${_csrf.parameterName}=${_csrf.token}'}
					 );
					</script>

                 </td>
            </tr>
            <c:if test="${board2.option.optionSecret eq 'y'}">
	            <td class="menu">비밀글</td>
	            <td align="left">
	                <span>&nbsp;&nbsp;
	                	<input type="checkbox" name="is_secret" value="y"></span>
	                </td>
	            <tr>
            </c:if>
                <td class="menu">썸네일 파일</td>
                <td align="left">
                <input type="file" name="ThombnailName" id="ThombnailName" class="form-control input-sm" style="width:80%; display:inline;">
                <span id="display_thumbnail" style="display:none;">
                <button type="button" onclick="winOpen('?tpf=common/image_view&amp;file_name=product/'+$('#code').val()+'_1');" class="btn btn-success btn-xs">보기</button>
                <button type="button" onclick="confirmIframeDelete('?tpf=common/image_delete&amp;file_name=product/'+$('#code').val()+'_1&amp;table=product&amp;code='+$('#code').val());" class="btn btn-danger btn-xs">삭제</button>
                </span>
                </td>
            </tr>
            <tr>
                <td class="menu">파일</td>
                <td align="left">
                <c:if test="${board2.option.optionMass eq null}">
                <p>
                    <span id="file_list"></span>            
                </p>
				
                <p style="padding-top:10px; float:left; width:100%;">
                    <button type="button" class="btn btn-primary btn-xs" onclick="fucAddFile();"><span class="glyphicon glyphicon-plus"></span> 파일추가</button><br>
                </p>
                    <div id="list_file" name="listFile">
                    	
                    </div>
                </c:if>
                <c:if test="${board2.option.optionMass eq 'y'}">
                <p id="diplay-plupload">
                    <span id="file_list">
                    	
                    </span>            
                </p>  
					<div id="uploader"></div>                              
                </c:if> 
                
                </td>
            </tr>
            </tbody>
            </table>
            <c:if test="${board2.option.optionComment eq 'y'}">
			<div id="displayMemo" style="">
            	<h4>
            		<p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 댓글 관리</p>
            	</h4>
            </div>
            </c:if>
            </div>
            <div class="modal-footer">
            <button type="button" onclick="fncAddPost()" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
            </div>
            <input type="hidden" value="${boardNo}" name="boardNo">
        </form></div>
    </div>
</div>