<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="1:1문의" name="title"/>
</jsp:include>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate"/>  

<!-- content-wrapper -->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.7 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<!-- Ionicons -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ionicons.min.css">
<!-- jvectormap -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-jvectormap.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/_all-skins.min.css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/jquery-ui.css" rel="stylesheet">

<!-- jQuery 3 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath}/resources/js/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/resources/js/adminlte.min.js"></script>
<!-- Sparkline -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.sparkline.min.js"></script>
<!-- jvectormap  -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-jvectormap-1.2.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.slimscroll.min.js"></script>
<!-- ChartJS -->
<script src="${pageContext.request.contextPath}/resources/js/Chart.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/common.js" type="text/javascript" charset="utf-8"></script>

<!-- plupload -->
<script src="${pageContext.request.contextPath}/resources/plupload/js/plupload.full.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<script src="${pageContext.request.contextPath}/resources/plupload/js/jquery.ui.plupload/jquery.ui.plupload.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/resources/plupload/js/i18n/ko.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plupload/js/jquery.ui.plupload/css/jquery.ui.plupload.css">
<!-- 
	<script src="${pageContext.request.contextPath}/resources/plupload/jquery-ui-1.12.1/jquery-ui.min.js"></script>
	<link  href="${pageContext.request.contextPath}/resources/plupload/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/resources/plupload/jquery-ui-1.12.1/jquery-ui.js"></script>
 -->

<script type="text/javascript">
	
	$(function(){

		//post 선택삭제 시작
		$("#deleteChoicePost").on("click", function(){
			
			var postArr = new Array();
			var mode = "delete";
			var boardNo = $("input[name='boardNo']").val();
						
			$("input[class='postNo']:checked").each(function(){
				postArr.push($(this).val());
			});
			if(postArr.length == 0){
				alert("항목을 선택하셔야 합니다.");
				return;
			}
			if(!confirm("해당 자료를 정말 삭제 하시겠습니까?")){
				alert("취소 되었습니다.");
				return;
				
			}else{
	  		$.ajax({
  			 	 url : "/admin/board/json/postProcess?${_csrf.parameterName}=${_csrf.token}",
	  		  	 type : "POST",
  		  	 	 data : { postArr : postArr,
  		  	 		 	  mode
  		  	 		  	},
    		 	 success : function(result){
   			  		alert("게시글이 삭제 되었습니다.")
   			  		location.href = "/admin/board/postList?boardNo="+boardNo;
  		  	 	 }
  		  	 	 
	  		});		

			}
		})
		
		
	})
	
	function fncPost(){
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
				
				$("#name").val(JSONData.lastName+JSONData.firstName);
				$("#phone").val(JSONData.phone);
				$("#email").val(JSONData.email);
				$("#name").val(JSONData.lastName+JSONData.firstName);
				
			}
		})
		
	}
	
	const paging = (cPage) => {
		$("input[name='cPage']").val(cPage)
		$("form[name='searchForm']").attr("method" , "POST").attr("action" , "/admin/board/postList?${_csrf.parameterName}=${_csrf.token}").submit();
	}
	
	function fncUp(){
		var boardAsc = $("input:radio[name='order_code']:checked").val();
		var boardIndex = $("input:radio[name='order_code']:checked").parent().parent().index()+1;
		var boardUpAsc = $("tr").eq(boardIndex-1).children().find("input:radio").val();
		var postNo = $("input:radio[name='order_code']:checked").parent().parent().find("input[name='originNo']").val();
		var boardNo = $("input[name='boardNo']").val();
		if(boardIndex == 0){
			alert("1개의 항목을 선택하여야 합니다.")
			return;
		}
		if(boardAsc == boardUpAsc){
			boardIndex--;
			boardUpAsc = $("tr").eq(boardIndex-1).children().find("input:radio").val();
			var upPostNo = $("tr").eq(boardIndex-1).children().find("input[name='originNo']").val();
		}else{
			var upPostNo = $("tr").eq(boardIndex-1).children().find("input[name='originNo']").val();
		}
		if(boardIndex == 1){
			alert("더이상 상위로의 위치 변경은 불가능합니다.");
			return;
		}else{
	  		$.ajax({
			 	 url : "/admin/board/json/updateUpAsc?${_csrf.parameterName}=${_csrf.token}",
	 		  	 type : "POST",
		  	 	 data : { 
		  	 		boardAsc,
		  	 		boardUpAsc,
		  	 		postNo,
		  	 		upPostNo
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
		var boardAsc = $("input:radio[name='order_code']:checked").val();
		var boardIndex = $("input:radio[name='order_code']:checked").parent().parent().index()+1;
		var boardDownAsc = $("tr").eq(boardIndex+1).children().find("input:radio").val();
		var postNo = $("input:radio[name='order_code']:checked").parent().parent().find("input[name='originNo']").val();
		var boardNo = $("input[name='boardNo']").val();
		if(boardIndex == 0){
			alert("1개의 항목을 선택하여야 합니다.")
			return;
		}
		if(boardAsc == boardDownAsc){
			boardIndex++;
			boardDownAsc = $("tr").eq(boardIndex+1).children().find("input:radio").val();
			var downPostNo = $("tr").eq(boardIndex+1).children().find("input[name='originNo']").val();
		}else{
			var downPostNo = $("tr").eq(boardIndex+1).children().find("input[name='originNo']").val();
		}
		if(boardIndex == 5){
			alert("더이상 하위로의 위치 변경은 불가능합니다.")
			return;
		}else{
	  		$.ajax({
			 	 url : "/admin/board/json/updateDownAsc?${_csrf.parameterName}=${_csrf.token}",
	 		  	 type : "POST",
		  	 	 data : { 
		  	 		boardAsc,
		  	 		boardDownAsc,
		  	 		postNo,
		  	 		downPostNo
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

<script src="${pageContext.request.contextPath}/resources/ckeditor_4.18.0_0efc8d0dbe1a/ckeditor/ckeditor.js"></script>
</head>


<div class="content-wrapper">
<section class="content-header">
    <h1>
    ${board2.boardTitle} 관리
    <small>${board2.boardTitle} list</small>
    </h1>

    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">${board2.boardTitle} 관리</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <label style="margin-top:5px;">총 ${pageCount} 건</label>
                    <form name="searchForm" method="post" action="/admin/board/postList?${_csrf.parameterName}=${_csrf.token}">
                    <div class="box-tools pull-right" style="margin-bottom:5px;">
                    	
	                    	<input type="hidden" name="boardNo" value="${boardNo}">
	                    	<input type="hidden" name="cPage">
	                        <div class="has-feedback">
		                        <span>
		                      	  <input type="text" name="searchKeyword" id="searchKeyword" class="form-control input-sm" placeholder="검색" value="${search.searchKeyword}"/>
		                      	  <span class="glyphicon glyphicon-search form-control-feedback"></span>
		                        </span>
	                        </div>
                        
                    </div>
					
                    <div class="box-tools pull-right" style="margin-bottom:5px;">
                        <div class="has-feedback">
                        <select name="searchType" class="form-control input-sm" style="float:left; width:130px;">
      						<option value="1">제목</option>      
      						<option value="2">작성자</option>                        
      					</select>
                        </div>
                    
                    </div>
                    </form>
                    <table class="table table-bordered table-hover">
                    <form name="form_list" method="post">
                    <thead>
                    <tr>
                        <td style="width:30px;">
                      		<div class="allCheck">
								<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck"></label>
									<script>
										$("#allCheck").click(function() {
											var chk = $("#allCheck").prop("checked");
											if (chk) {
												$('.postNo').prop("checked", true);
											} else {
												$('.postNo').prop("checked", false);
											}
										});
									</script>
							</div>
                        </td>
                        <td style="width:60px;">NO</td>
                        <td>제목</td>
                        <td style="width:100px;">작성자</td>
                        <td style="width:140px;">등록일</td>
                        <td style="width:80px;">조회수</td>
                        <c:if test="${board2.option.optionOrder eq 'y'}">
                        <td style="width:60px;">
                            <i onclick="fncDown();" name="up" class="fa fa-fw fa-arrow-circle-down cp" style="cursor:pointer;"></i>
                            <i onclick="fncUp();" class="fa fa-fw fa-arrow-circle-up cp" style="cursor:pointer;"></i>
                        </td>
                        </c:if>
                        <td style="width:100px;">다운로드수</td>
                        <td style="width:80px;">명령</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="post" items="${list}">
                    <c:if test="${post.postNotice eq '1'}">
                    <tr>
                        <td></td>
                        <td>공지</td>          
                   		<td align="left">
                   			<c:if test="${nowDate eq post.postDate}">
                   				<img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/new.png" width="15">
                   			</c:if>           
	                		<c:if test="${post.postLayer > 0}">
	                			&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/right.png" width="15">
	                			&nbsp;&nbsp;
	                		</c:if>                   				     				
                   			${post.postTitle}
                   			<c:if test="${post.postThombnail != null && post.postThombnail != ''}">
                   				<img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/disk.png" width="15">
                   			</c:if>
                   		</td>        
                        <td>${post.postMemberName}</td>            
                        <td>${post.postDate}</td>                        
                        <td>${post.postViewCount}</td>
               			<c:if test="${board2.option.optionOrder eq 'y'}">
               				<td>
               					<input type="radio" name="order_code" value="${post.postAsc}" chack="">
               					<input type="hidden" name="originNo" value="${post.postOriginNo}">
               				</td>
               			</c:if>                        
                        <td>${post.postDownloadCount}</td>
                        <td>
                		<button type="button" name="getPostBotton" data-toggle="modal" data-target="#modalContent4" class="btn btn-primary btn-xs" value="${post.postNo}">상세보기
                			<input type="hidden" value="${post.postMember.memberNo}">
                		</button>
                   		</td>
                    </tr>
                    </c:if>
                    </c:forEach>
                    <c:if test="${empty list}">
                    <tr>
                   		<td colspan="10"><br>등록된 자료가 없습니다.<br><br></td>
                   	</tr>
                    </c:if>
                    
                  	<c:set var="i" value="0"/>
                   	 <c:forEach var="post" items="${list}">
                   	 <c:if test="${post.postNotice eq '0'}">
                   	   <c:set var="i" value="${ i+1 }" />
                   		<tr>
                        	<td>
		                        <div>
		                        	<input type="checkbox" class="postNo" name="postNo"  value="${post.postNo}" />
		                        	<script>
										$(".postNo").click(function() {
											$("#allCheck").prop("checked", false);
										});
									</script>
								</div>
                        	</td>
                   			<td>${ i }</td>
                   			<td align="left">
                   				<c:if test="${nowDate eq post.postDate}">
                   					<img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/new.png" width="15">
                   				</c:if>           
	                			<c:if test="${post.postLayer > 0}">
	                				&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/right.png" width="15">
	                				&nbsp;&nbsp;
	                			</c:if>                   				     				
                   				${post.postTitle}
                   				<c:if test="${post.postThombnail != null && post.postThombnail != ''}">
                   					<img src="${pageContext.request.contextPath}/resources/imgs/imageBoard/disk.png" width="15">
                   				</c:if>
                   			</td>
                   			<td>${post.postMemberName}</td>
                   			<td>
	                        	${post.postDate}
	                        </td>
                   			<td>${post.postViewCount}</td>
                   			<c:if test="${board2.option.optionOrder eq 'y'}">
                   			<td>
                   				<input type="radio" name="order_code" value="${post.postAsc}" chack="">
                   				<input type="hidden" name="originNo" value="${post.postOriginNo}">
                   			</td>
                   			</c:if>
                   			<td>${post.postDownloadCount}</td>
                   			<td>
                   			<button type="button" name="getPostBotton" data-toggle="modal" data-target="#modalContent4" class="btn btn-primary btn-xs" value="${post.postNo}">상세보기
                   				<input type="hidden" value="${post.postMember.memberNo}">
                   			</button>
                   			</td>
                   		</tr>
                      </c:if>
                   	 </c:forEach>                  	                   
      				</tbody>
      				
      				</form>
                    </table>
                    <br>
                    <button type="button" id="deleteChoicePost" class="btn btn-danger btn-sm"><i class="fa fa-minus-square"></i> 선택삭제</button>
                    <button type="button" onclick="fncPost()" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modalContent"><i class="fa fa-plus-square"></i> 글 등록</button>
                    <button type="button" onclick="fncBoardTitle2()" class="btn btn-warning btn-sm"><i class="fa fa-random"></i> 게시물 복사</button>
                    <button type="button" onclick="fncBoardTitle()" class="btn btn-warning btn-sm"><i class="fa fa-random"></i> 게시물 이전</button>

					<div style="text-align: right;">
						${pagebar}
					</div>
                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>





<div id="list_file_tag" class="sr-only">
    <input type="file" name="file[]" class="form-control input-sm" style="width:100%; display:inline; margin-bottom:10px;">
</div>
<jsp:include page="/WEB-INF/views/admin/board/addPost.jsp"/>
<jsp:include page="/WEB-INF/views/admin/board/getPost.jsp"/>
<jsp:include page="/WEB-INF/views/admin/board/addComment.jsp"/>
<jsp:include page="/WEB-INF/views/admin/board/boardCopy.jsp"/>
<jsp:include page="/WEB-INF/views/admin/board/boardChange.jsp"/>

</div><!-- /.content-wrapper -->

<footer class="main-footer">
<div class="pull-right hidden-xs">
    <b>Version</b> 2.7.4
</div>
<strong>NDC&C<a href="/admin">  Since:2017  </a> Phone 031-712-8315 | Fax 031-789-3545</strong>
</footer>
</div>