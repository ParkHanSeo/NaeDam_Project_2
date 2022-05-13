<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	
	function fncAddComment2(){
		
		var commentContents = $("textarea[id='commentContents']").val();
		var commentPostNo = $("input[id='commentPostNo']").val();
		var commentMemberNo = $("input[id='commentMemberNo']").val();

		$.ajax({
			url : "/admin/board/json/addComment?${_csrf.parameterName}=${_csrf.token}",
			method : "POST",
			data: JSON.stringify({
				'commentContents': commentContents,
				'commentMemberNo': commentMemberNo,
				'commentPostNo': commentPostNo
			}),
			dataType : 'JSON',
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"	 						
			} ,
			success : function(JSONData, status){
				
			}
				
		})
		alert("댓글이 등록 되었습니다.")
		$('#modalContent5').modal("hide");
	}
	
</script>

<div class="modal fade" id="modalContent5" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
           <form name="addCommentForm" method="boardComment" enctype="multipart/form-data">
            
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabelPortfolio">게시물 관리</h4>
            </div>
            <div class="modal-body">

            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 댓글 <span>등록</span></p></h4>
            <table class="table table-bordered">
            <tbody>
            <tr>
                <td class="menu">작성자</td>
                <td align="left"><input type="text" id="commentName" class="form-control input-sm"></td>
            </tr>
			<tr>
                 <td class="menu">내용</td>
                 <td align="left">
                 	<textarea type="text" class="form-control" id="commentContents" name="commentContents" maxLength="2048" style="height: 180px" placeholder="내용을 입력해 주세요."></textarea>
                 </td>
            </tr>
			</tbody>
            </table>
            </div>
            <div class="modal-footer">
            <button type="button" onclick="fncAddComment2()" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
            </div>
            <input type="hidden" name="postNo" id="commentPostNo" >
            <input type="hidden" name="memberNo" id="commentMemberNo" >
        </form></div>
    </div>
</div>