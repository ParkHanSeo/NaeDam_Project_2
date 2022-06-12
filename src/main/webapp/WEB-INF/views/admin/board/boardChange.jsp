<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	var postArr = new Array();
	console.log(postArr)
	
	function fncBoardTitle(){
		var postArr = new Array();
		$("input[class='postNo']:checked").each(function(){
			postArr.push($(this).val());
		});
		if(postArr.length == 0){
			alert("항목을 선택하여야 합니다.");
			return;
		}
		$('#modalContent3').modal('show');		
		$.ajax({
			url : "/admin/board/json/listBoard",
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
						display = "<option value="+Data[i].boardNo+">"+Data[i].boardTitle+"</option>"
						$('#boardNoChange').append(display);				
					}
				}		
			}
		})
	}
	
	function funPostChange(){
		var postArr = new Array();
		var mode = "change";
		var boardNo = $("select[name='boardNoChange']").val();
		$("input[class='postNo']:checked").each(function(){
			postArr.push($(this).val());
		});
  		$.ajax({
			 	 url : "/admin/board/json/postProcess?${_csrf.parameterName}=${_csrf.token}",
  		  	 	 type : "POST",
		  	 	 data : { 
		  	 		 postArr : postArr, 
		  	 		 boardNo,
		  	 		 mode
		  	 	 },
		 		 success : function(result){   	 		
		 	  		alert("게시물 이전이 완료되었습니다.")
		 	  		location.href = "/admin/board/postList?boardNo="+boardNo;		 			 
		  	 	 }  	 	 
  		});		
	}	
</script>

<div class="modal fade" id="modalContent3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" style="width:400px;">
        <div class="modal-content">
            <form name="form_copy_data" method="post" action="?tpf=admin/board/process">
	            <input type="hidden" name="mode" id="mode">
	            <input type="hidden" name="code" id="code">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalLabelPortfolio">게시물 관리</h4>
	            </div>
	            <div class="modal-body">
		            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 게시물 이전 <span id="board_sub_title2"></span></p></h4>
		            <table class="table table-bordered">
		            <tr>
		                <td class="menu">게시판 제목</td>
		                <td align="left">
			                <select name="boardNoChange" id="boardNoChange" class="form-control input-sm">
				                <option value="">선택</option>
			  				</select>
		                </td>
		            </tr>
		            </table>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" id="boardCopy" onclick="funPostChange()" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
	            </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal fade -->