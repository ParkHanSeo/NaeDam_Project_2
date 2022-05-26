<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="주문후기 관리" name="title"/>
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	    <h1>
	        주문후기 관리
	        <small>주문후기 list</small>
	    </h1>
	
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li class="active">주문후기 관리</li>
	    </ol>
	</section>
	
	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
	                    <label style="margin-top:5px;">총 ${ reviewList.size() }건</label>
	                    <div class="box-tools pull-right" style="margin-bottom:5px;">
	                        <form name="form_search" method="post" action="${pageContext.request.contextPath }/admin/comm/review?${_csrf.parameterName}=${_csrf.token}">
	                        <div class="has-feedback">
	                            <span>
	                                <input type="text" name="keyword" id="keyword" value="${ param.keyword == null ? '' : param.keyword }" class="form-control input-sm" placeholder="검색"/>
	                                <span class="glyphicon glyphicon-search form-control-feedback"></span>
	                            </span>
	                        </div>
	                    </div>
	
	                    <div class="box-tools pull-right" style="margin-bottom:5px;">
	                        <div class="has-feedback">
	                            <select name="field" class="form-control input-sm" style="float:left; width:130px;">
	                            	<option value="total" ${param.field == 'total' ? 'selected' : ''}>전체</option>  
	      							<option value="a.writer" ${param.field == 'a.writer' ? 'selected' : ''}>작성자</option>      
	      							<option value="productName" ${param.field == 'productName' ? 'selected' : ''}>제품명</option>                            
	      						</select>
	                        </div>
	                        </form>
	                    </div>
	
	                    <table class="table table-bordered table-hover">
	                        <form name="form_list" method="post" action="${pageContext.request.contextPath }/admin/comm/delete?${_csrf.parameterName}=${_csrf.token}">
	                            <input type="hidden" name="mode" id="mode">
	                            <input type="hidden" name="review_code" value="<br /><b>Notice</b>:  Undefined variable: review_code in <b>/home/demoshop/public_html/html/admin/community/review.html</b> on line <b>45</b><br />">
	                            <thead>
		                            <tr>
		                                <td style="width:30px;"><input type="checkbox" name="select_all" onclick="selectAllCheckBox('form_list');" /></td>
		                                <td style="width:60px;">NO</td>
		                                <td style="width:100px;">작성자</td>
		                                <td style="width:150px;">구입상품</td>
		                                <td>내용</td>
		                                <td style="width:100px;">후기종류</td>
		                                <td style="width:120px;">등록일</td>
		                                <td style="width:120px;">명령</td>
		                            </tr>
	                            </thead>
	                            <!-- 리뷰가 있을 경우 조회하기 -->
	                            <tbody>
	                                <c:choose>
                                   		<c:when test="${ empty reviewList and empty param.keyword }">
                                   			<tr>
	                                        	<td colspan="10"><br>등록된 후기가 없습니다.<br><br></td>
	                                        </tr>
                                   		</c:when>
                                   		<c:when test="${ empty reviewList and !empty param.keyword}">
                                   			<tr>
	                                        	<td colspan="10"><br>검색된 후기가 없습니다.<br><br></td>
	                                        </tr>
                                   		</c:when>
                                   		<c:otherwise>
                                   			<c:forEach var="review" items="${ reviewList }"> 
	                                        	<tr>
		                                            <td><input type="checkbox" name="list[]" value="${ review.reviewCode }"/></td> 
		                                            <td>${ review.reviewCode }</td>
		                                            <td>${ review.writer }</td> 
		                                            <td>${ review.productName }</td> 
		                                            <td>${ review.reviewContent }</td> 
		                                            <td>${ review.reviewCategoryName }</td>
		                                            <td><fmt:formatDate value="${ review.reviewDate }" pattern="yyyy-MM-dd"/></td> 
		                                            <td><button type="button" class="btn btn-primary btn-xs" onclick="review_detail(${ review.reviewCode })">상세보기</button></td>
	                                            </tr>
	                                        </c:forEach>
                                   		</c:otherwise>
	                                </c:choose>
	                            </tbody><!-- 리뷰 조회 완료 -->         
	                       	</form>
	                    </table>
	                    <br>
	                    <button type="button" onclick="selectDelete();" class="btn btn-danger btn-sm"><i class="fa fa-minus-square"></i> 선택삭제</button>
						<!-- 페이징 -->
                        <div id="pagebarContainer" style="text-align: right;">
							${pagebar}
						</div>
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section>
	
	<!-- 상세보기 버튼 클릭 시 모달 -->
	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <form name="form_register" method="post" action="?tpf=admin/community/review_process" enctype="multipart/form-data">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabelPortfolio">주문후기 관리</h4>
		            </div>
		            <div class="modal-body" style="background:white;">
		
			            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 글 <span id="board_sub_title">등록</span></p></h4>
			            <table class="table table-bordered">
			                <tr>
			                    <td class="menu">작성자</td>
			                    <td align="left"><input type="text" name="name" id="name" class="form-control input-sm" readonly></td>
			                </tr>
			                <tr>
			                    <td class="menu">한줄후기</td>
			                    <td align="left"><input type="text" name="title" id="title" class="form-control input-sm" readonly></td>
			                </tr>
			                <tr>
			                    <td class="menu">구매후기</td>
			                    <td align="left"><input type="text" name="content" id="content" class="form-control input-sm" readonly></td>
			                </tr>
			                <tr>
			                    <td class="menu">이미지</td>
			                    <td align="left">
			                    <p>
			                        <span id="file_list"></span>
			                    </p>
			                    </td>
			                </tr>
			            </table>
		            </div>
	            </form>
	        </div><!-- / .modal-content -->
	    </div><!-- / .modal-dialog -->
	</div><!-- /.modal -->
</div><!-- /.content-wrapper -->

<script>
	// 모달 띄우기
	function review_detail(reviewCode){
		$("#modalContent").modal({backdrop:"static", show:true}); // backdrop : 모달 영역 밖 클릭 시 닫힘 방지 
		// console.log(reviewCode); 
		setData(reviewCode);
	}
	
	// 비동기로 모달에 값 불러오기
	function setData(reviewCode){
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/comm/review_modal",
			type: 'get',
			data: { reviewCode : reviewCode },
			success: function(result){
				// 작성자, 한줄 후기, 구매 후기
				$("#name").val(result.review[0].writer);
				$("#title").val(result.review[0].reviewTitle);
				$("#content").val(result.review[0].reviewContent);
				
				// 관련 변수
				var origin = '';
				var imgUrl = '';
				var imgList = '';
				var aTag = '';
				var reviewImg = '';
				var dataUrl = '';
				var leng = result.reviewImg.length;
				
				// 태그 생성
				if(leng > 0) { // 이미지가 leng개 있는 경우
					for(var i = 0; i < leng; i++) {
						imgList += "<a href='' download='' id='aTag" + i + "'><img src='' name='' id='reviewImg" + i + "' style='width:80px; cursor:pointer;'></a>";	
					}
					$('#file_list').html(imgList);
				}
				else { // 이미지가 없는 경우
					$('#file_list').html('');
				}
				
				// 태그 속성값 부여
				for(var i = 0; i < leng; i++) {
					aTag = document.getElementById("aTag" + i);
					reviewImg = document.getElementById("reviewImg" + i);
					origin = result.reviewImg[i].originName;
					imgUrl = result.reviewImg[i].reviewImgUrl;
					
					toDataURL(imgUrl, leng); // 데이터url : a태그 href 속성값
					aTag.download = origin;
					reviewImg.src = imgUrl;
					reviewImg.name = origin;
				}

			},
			error: function(textStatus, errorThrown){
				console.log("리뷰 상세 조회에 실패했습니다.");
				// console.log(textStatus);
				// console.log(errorThrown);
			}
		});
		
	}
	
	// 데이터url 생성
	function toDataURL(imgUrl, leng) {
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			var reader = new FileReader();
		    reader.onload= function() {
		      for(var i = 0; i < leng; i++) {
		      	var a = document.getElementById("aTag" + i);
		      	a.href = reader.result;
		      }
		    }
		    reader.readAsDataURL(xhr.response);
		};
		xhr.open('GET', imgUrl);
		xhr.responseType = 'blob';
		xhr.send();
	}

</script>


<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>