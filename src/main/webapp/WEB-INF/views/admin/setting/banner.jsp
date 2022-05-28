<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="배너 관리" name="title" />
</jsp:include>


<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	<h1>
		메인 이미지 배너 <small>Main Image Banner</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li>설정</li>
		<li class="active">메인 이미지 배너</li>
	</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">
					<div style="text-align: right">
						<button type="button" id="locale_ko" onclick="parent.location.href='?tpf=admin/setting/banner&locale=ko'" class="btn btn-primary" style="margin-left: 3px;">
							<i class="fa fa-globe" aria-hidden="true"></i> 한국어
						</button>
						<button type="button" id="locale_en" onclick="parent.location.href='?tpf=admin/setting/banner&locale=en'" class="btn btn-default" style="margin-left: 3px;">
							<i class="fa fa-globe" aria-hidden="true"></i> ENG
						</button>
						<button type="button" id="locale_zh" onclick="parent.location.href='?tpf=admin/setting/banner&locale=zh'" class="btn btn-default" style="margin-left: 3px;">
							<i class="fa fa-globe" aria-hidden="true"></i> 中国
						</button>
						<button type="button" id="locale_vn" onclick="parent.location.href='?tpf=admin/setting/banner&locale=vn'" class="btn btn-default" style="margin-left: 3px;">
							<i class="fa fa-globe" aria-hidden="true"></i> Tiếng việt
						</button>
					</div>
					<label style="margin-top: 5px;">총 ${bannerList.size() } 건</label>
					<div class="box-tools pull-right" style="margin-bottom: 5px;"></div>

					<form name="form_list" method="post" action="${pageContext.request.contextPath }/admin/banner/banner_process?${_csrf.parameterName}=${_csrf.token}">
						<input type="hidden" name="mode" id="mode">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<td style="width: 30px;"><input type="checkbox" name="select_all" onclick="selectAllCheckBox( 'form_list');" /></td>
									<td style="width: 60px;">NO</td>
									<td style="width: 100px;">category_code</td>
									<td style="width: 100px;">이미지</td>
									<td style="width: 120px;">이름</td>
									<td style="">URL</td>
									<td style="width: 140px;">등록일</td>
									<td style="width: 55px;">상태</td>
									<td style="width: 50px;">target</td>
									<td style="width: 60px;"><i onclick="changeOrder('down','banner','?tpf=admin/setting/banner','1');" class="fa fa-fw fa-arrow-circle-down cp"></i> <i onclick="changeOrder('up','banner','?tpf=admin/setting/banner','1');" class="fa fa-fw fa-arrow-circle-up cp"></i></td>
									<td style="width: 80px;">명령</td>
								</tr>
							</thead>
							<c:forEach var="banner" items="${bannerList }">
								<tr>
									<td><input type="checkbox" name="list[]" value="${banner.bannerNo }" /></td>
									<td>${banner.bannerNo }</td>
									<td>${banner.categoryNo }(${banner.categoryName})</td>
									<td><img src="${banner.imgUrl }" width="144" height="72"></td>
									<td>${banner.bannerName }</td>
									<td></td>
									<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${banner.regDate}" /></td>
									<td>
										<c:if test="${banner.status == 'Y' }">
											<span style="font-size: 12px;" class="label label-success">보임</span>
										</c:if>
										<c:if test="${banner.status == 'N' }">
											<span style="font-size:12px;" class="label label-default">숨김</span>
										</c:if>
										
									</td>
									<td><span style="font-size: 12px;" class="label label-success">${banner.targetNo == '0' ? '현재창' : '새창' }</span></td>
									<td><input type="radio" name="order_code" value="1" /></td>
									<td><button type="button" onclick="onclickUpdate(${banner.bannerNo});" class="btn btn-primary btn-xs">상세보기</button></td>
								</tr>
							</c:forEach>
						</table>
					</form>
					<br>
					<button type="button" onclick="selectDelete();" class="btn btn-danger btn-sm">
						<i class="fa fa-minus-square"></i> 선택삭제
					</button>
					<button type="button" onclick="onclickInsert()" class="btn btn-primary btn-sm">
						<i class="fa fa-plus-square"></i> 배너 등록
					</button>

					<div style="text-align: right;">
						<? echo $data['page'];?>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
		</div>
		<!-- /.col-xs-12 -->
	</div>
	<!-- /.row --> </section>

	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form name="form_register" method="post" action="${pageContext.request.contextPath }/admin/banner/banner_process?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
					<input type="hidden" name="mode" id="mode" value="insert"> 
					<input type="hidden" name="bannerNo" id="code" value="0"> 
					<input type="hidden" name="locale" id="locale" value="ko">
					<input type="hidden" name="imgUrl" />
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabelPortfolio">배너 관리</h4>
					</div>
					<div class="modal-body">

						<h4>
							<p class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 배너 <span id="board_sub_title">등록</span>
							</p>
						</h4>
						<table class="table table-bordered">
							<tr>
								<td class="menu">위치 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><select name="categoryNo" id="category_code" class="form-control input-sm" style="width: 120px;">
									<c:forEach var="cte" items="${menuCteList }">
										<option value="${cte.categoryNo }">${cte.categoryName }</option>
									</c:forEach>
										
								</select></td>
							</tr>
							<tr>
								<td class="menu">이름 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="text" name="bannerName" class="form-control input-sm" style="width: 50%;"></td>
							</tr>
							<tr>
								<td class="menu">URL</td>
								<td align="left">
								
									<input type="text" name="linkUrl" class="form-control input-sm" placeholder="http://whois.co.kr" style="width: 50%; float: left;"> 
									<select name="target" class="form-control input-sm" style="width: 80px; margin-left: 5px; float: left;">
										<option value="0">현재창</option>
										<option value="1">새창</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="menu">태그 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><textarea name="tag" placeholder="" class="form-control input-sm" style="padding: 5px; line-height: 20px; width: 100%; height: 150px;"></textarea></td>
							</tr>
							<tr>
								<td class="menu">파일 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="file" name="file1" class="form-control input-sm" style="width: 70%; display: inline;"> <span id="display_file" style="display: none;">
										<!-- Todo : onclick attr 로 변화시키기. @ajaxt success // https://jinstale.tistory.com/111 -->
										<button type="button" id="btn_img_view" onclick="" class="btn btn-success btn-xs">보기</button>
										<button type="button" onclick="confirmIframeDelete('?tpf=common/image_delete&file_name=banner/'+$('[name=bannerNo]').val()+'&code='+$('#bannerNo').val());" class="btn btn-danger btn-xs">삭제</button>
								</span>
									<div style="font-weight: normal">※ 이미지 크기 : 1920 X 580</div></td>
							</tr>
							<tr>
								<td class="menu">상태 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td><select name="status" id="status" class="form-control input-sm" style="width: 100px;">
										<option value="Y">보임</option>
										<option value="N">숨김</option>
								</select></td>
							</tr>
						</table>

					</div>
					<div class="modal-footer">
						<button type="button" onclick="register()" class="btn btn-primary">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- /.content-wrapper -->
<script>
function register() {
    if(form_register.title.value == '') { 
        alert('이름이 입력되지 않았습니다.'); form_register.title.focus(); return false;
    }
    if(form_register.tag.value == '') {
        alert('태그가 입력되지 않았습니다.'); form_register.tag.focus(); return false;
    }    
    if (form_register.mode.value == 'insert') {
        if(form_register.file1.value == '') { alert('파일이 입력되지 않았습니다.'); form_register.file1.focus(); return false;}
    }
    if($('[name=imgUrl]').val() == '') return false;
    form_register.target = 'iframe_process';
    form_register.submit();
}

function setData(code) {
    $.ajax({
		url:'${pageContext.request.contextPath}/admin/banner/getBenner',
		type:'post',
		dataType:'json',
		headers: {
            "${_csrf.headerName}" : "${_csrf.token}"
        },
		data:{
            bannerNo : code
		},
		success(data){
            console.log(data)
            $('form[name="form_register"] #mode').val('update');
            $('[name=bannerNo]').val(data.bannerNo);
            $('[name=categoryNo]').val(data.categoryNo);
            $('[name=bannerName]').val(data.bannerName);
            $('[name=linkUrl]').val(data.linkUrl);
            $('[name=target]').val(data.targetNo);
            $('[name=status]').val(data.status);
            $('[name=tag]').val(data.tag);
            $('[name=imgUrl]').val(data.imgUrl);
            $('#btn_img_view').attr('onclick', 'openWindow('+ data.bannerNo +');');
            if(data.imgUrl != null) $('#display_file').css('display','');
            else $('#display_file').css('display','none'); 
            // objEditor.setData(json_data.content);
		},
		error:function(jqXHR, textStatus, errorThrown){
			console.log(textStatus);
		}
	});
}

function onclickInsert() {
    $('#modalContent').modal('show');
    form_register.reset();
    $('form[name="form_register"] #mode').val('insert');
    $('#display_file').css('display','none')
}

function onclickUpdate(code) {
    $('#modalContent').modal({backdrop:'static', show:true});
    setData(code);
}

function alertNo() {
     alert('슬라이드는 5개까지 등록 하실 수 있습니다');
}

function openWindow(bannerNo){
	window.open('${pageContext.request.contextPath}/admin/banner/img_view?bannerNo='+bannerNo, 'img_view', 'width=400, height=300, top=10, left=10');
}
// 이미지 업로드
$("input[type=file]").change(function(e){
   var file = e.target;
   var form = new FormData();
   form.append("image", file.files[0]);
   var settings = {
     "url": "https://api.imgbb.com/1/upload?key=f84bfb11eb3ee5eedb859de8b49fdff1",
     "method": "POST",
     "timeout": 0,
     "processData": false,
     "mimeType": "multipart/form-data",
     "contentType": false,
     "data": form
   };
   
   // 이미지 업로드 -> 확인
   $.ajax(settings).done(function (response) {
     var imgbb = JSON.parse(response);
     var url = imgbb.data.thumb.url;
     $('[name=imgUrl]').val(url);
   });
});
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>