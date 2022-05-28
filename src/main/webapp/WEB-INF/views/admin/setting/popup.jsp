<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="팝업 설정" name="title" />
</jsp:include>

<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	<h1>
		팝업 관리 <small>popup list</small>
	</h1>

	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">팝업 관리</li>
	</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">
					<label style="margin-top: 5px;">총 ${popupList.size() } 건</label>
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<form name="form_search" method="post" action="${pageContext.request.contextPath }/admin/setting/popup?${_csrf.parameterName}=${_csrf.token}">
							<input type="hidden" name="tpf" value="admin/setting/popup"> <input type="hidden" name="board_code" value="<br />
								<b>Notice</b>:  Undefined variable: board_code in <b>/home/demoshop/public_html/html/admin/setting/popup.html</b> on line <b>22</b><br />
								">
							<div class="has-feedback">
								<span> <input type="text" name="keyword" id="keyword" value="${param.keyword == null ? '' : param.keyword }" class="form-control input-sm" placeholder="검색" /> <span class="glyphicon glyphicon-search form-control-feedback"></span>
								</span>
							</div>
					</div>
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<div class="has-feedback">
							<select name="field" class="form-control input-sm">
								<option value="title">제목</option>
							</select>
						</div>
					</div>
					<div class="box-tools pull-right" style="margin: 0 10px 5px 0">
						<div class="has-feedback">
							<input type="text" name="end_date" id="datepicker1" readonly value="${param.end_date == null ? '' : param.end_date }" class="form-control input-sm" placeholder="종료일" style="width: 80px; padding-right: 0;" />
						</div>
					</div>
					<div class="box-tools pull-right" style="padding: 5px 5px 0 5px;">~</div>
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<div class="has-feedback">
							<input type="text" name="start_date" id="datepicker2" readonly value="${param.start_date == null ? '' : param.start_date }" class="form-control input-sm" placeholder="시작일" style="width: 80px; padding-right: 0;" />
						</div>
						</form>
					</div>


						<form name="form_list" method="post" action="${pageContext.request.contextPath }/admin/popup/popup_process?${_csrf.parameterName}=${_csrf.token}">
							<input type="hidden" name="mode" id="mode">
					<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<td style="width: 30px;"><input type="checkbox" name="select_all" onclick="selectAllCheckBox( 'form_list');" /></td>
									<td style="width: 60px;">NO</td>
									<td style="width: 100px;">다국어</td>
									<td>제목</td>
									<td style="width: 140px;">시작일</td>
									<td style="width: 140px;">종료일</td>
									<td style="width: 50px;">노출</td>
									<td style="width: 150px;">하루동안 열지않기</td>
									<td style="width: 140px;">작성일</td>
									<td style="width: 80px;">명령</td>
								</tr>
							</thead>
							<c:if test="popupList == null">
								<tr>
									<td colspan="10"><br>등록된 자료가 없습니다.<br>
									<br></td>
								</tr>
							</c:if>
							<c:forEach var="popup" items="${popupList }" varStatus="vs">
								 <tr>
								    <td><input type="checkbox" name="list[]" value="${popup.code }" /></td>
			                        <td>${vs.count }</td>
			                        <td>${popup.locale == 'ko' ? '한국어' : '외국어' }</td>
			                        <td align="left">${popup.title }</td>
			                        <td><fmt:formatDate pattern = "yyyy-MM-dd" value="${popup.startDate}"/></td>
			                        <td><fmt:formatDate pattern = "yyyy-MM-dd" value="${popup.endDate}"/></td>
			                        <c:choose>
			                        	<c:when test="${popup.display == 'Y' }">
					                        <td><span class="label label-success" style="font-size:12px;">보임</span></td>
			                        	</c:when>
			                        	<c:otherwise>
											<td><span class="label label-default" style="font-size:12px;">숨김</span></td>
			                        	</c:otherwise>
			                        </c:choose>
			                        <c:choose>
			                        	<c:when test="${popup.popupCookie == 'Y' }">
											<td><span class="label label-success" style="font-size:12px;">활성화</span></td>
			                        	</c:when>
			                        	<c:otherwise>
											<td><span class="label label-default" style="font-size:12px;">비활성화</span></td>
			                        	</c:otherwise>
			                        </c:choose>
									<td><fmt:formatDate pattern = "yyyy-MM-dd" value="${popup.regDate}"/></td>
			                        <td><button type="button" onclick="onclickUpdate(${popup.code});" class="btn btn-primary btn-xs">상세보기</button></td>
			                    </tr>
							</c:forEach>
						</form>
					<br>
					</table>

					<button type="button" onclick="selectDelete();" class="btn btn-danger btn-sm">
						<i class="fa fa-minus-square"></i> 선택삭제
					</button>
					<button type="button" onclick="onclickInsert()" class="btn btn-primary btn-sm">
						<i class="fa fa-plus-square"></i> 팝업 등록
					</button>

					<div style="text-align: right;">
						<!--<? echo $data['page'];?>-->
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
			<div class="modal-content" style="width: 900px;">
				<form name="form_register" method="post" action="${pageContext.request.contextPath}/admin/popup/popup_process?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
					<input type="hidden" name="mode" id="mode"> 
					<input type="hidden" name="code" value="0">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabelPortfolio">팝업 관리</h4>
					</div>
					<div class="modal-body">

						<h4>
							<p class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 팝업 <span id="popup_sub_title">등록</span>
							</p>
						</h4>
						<table class="table table-bordered">
							<tr>
								<td class="menu">다국어 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><select name="locale" class="form-control input-sm" style="width: 100px;">
										<option value="ko">한국어</option>
										<option value="en">ENG</option>
										<option value="zh">中国</option>
										<option value="vn">Tiếng việt</option>
								</select></td>
							</tr>
							<tr>
								<td class="menu">기간 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><span style="float: left; width: 15%;"><input type="text" name="start_date" id="datepicker3" readonly placeholder="시작일" class="form-control input-sm"></span> <span style="float: left; line-height: 2.0;">&nbsp; ~ &nbsp;</span><span style="float: left; width: 15%;"><input type="text" name="end_date" id="datepicker4" readonly placeholder="종료일" class="form-control input-sm"></span></td>
							</tr>
							<tr>
								<td class="menu">제목 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><span style="float: left; width: 80%;"><input type="text" name="title" class="form-control input-sm"></span></td>
							</tr>
							<tr>
								<td class="menu">위치</td>
								<td align="left"><span style="float: left; line-height: 2.0;">가로 : &nbsp;</span><span style="float: left; width: 8%;"><input type="text" name="leftPosition" onkeyup="this.value=checkNum(this.value)" value="" class="form-control input-sm"></span>&nbsp;<span style="line-height: 2.0;">px</span> <span style="float: left; line-height: 2.0;">&nbsp;px &nbsp;세로 : &nbsp;</span><span style="float: left; width: 8%;"><input type="text" name="topPosition" onkeyup="this.value=checkNum(this.value)" value="" class="form-control input-sm"></span></td>
							</tr>
							<tr>
								<td class="menu">크기 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><span style="float: left; line-height: 2.0;">가로 : &nbsp;</span><span style="float: left; width: 8%;"><input type="text" name="width" onkeyup="this.value=checkNum(this.value)" value="" class="form-control input-sm"></span>&nbsp;<span style="line-height: 2.0;">px</span> <span style="float: left; line-height: 2.0;">&nbsp;px &nbsp;세로 : &nbsp;</span><span style="float: left; width: 8%;"><input type="text" name="height" onkeyup="this.value=checkNum(this.value)" value="" class="form-control input-sm"></span></td>
							</tr>
							<tr>
								<td class="menu">노출</td>
								<td align="left"><input type="radio" name="display" id="display_y" value="Y" checked>보임&nbsp;&nbsp; <input type="radio" name="display" id="display_n" value="N">숨김</td>
							</tr>
							<tr>
								<td class="menu">하루동안 열지않기</td>
								<td align="left"><input type="radio" name="popupCookie" id="popup_cookie_y" value="Y" checked>활성화&nbsp;&nbsp; <input type="radio" name="popupCookie" id="popup_cookie_n" value="N">비활성화</td>
							</tr>
							<tr>
								<td class="menu">동영상 url</td>
								<td align="left"><input type="text" name="url" placeholder="https://youtu.be/Z2rLoGY-Hew" class="form-control input-sm"></td>
							</tr>
							<tr>
								<td class="menu">내용 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><textarea name="content" id="content" rows="10" cols="50"></textarea></td>
							</tr>
						</table>

					</div>
					<div class="modal-footer">
						<button type="button" onclick="register()" class="btn btn-primary">확인</button>
						&nbsp;&nbsp;&nbsp;
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="list_file_tag" class="sr-only">
		<input type="file" name="file[]" class="form-control input-sm" style="width: 100%; display: inline; margin-bottom: 10px;">
	</div>

	<script src="//mir9.co.kr/resource/js/ckeditor4.7.2/ckeditor.js"></script>
</div>
<!-- /.content-wrapper -->

<script>
if (window.CKEDITOR) {  // CKEDITOR loading 여부 체크 (Web 버젼에서만 사용)
    var objEditor = CKEDITOR.replace('content', {
        height: 500,
        extraPlugins : 'tableresize',
        extraPlugins: 'codemirror',
        filebrowserUploadUrl: '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
        filebrowserImageUploadUrl: '/daemon/ckeditor_upload.php?command=QuickUpload&type=Images',
        fillEmptyBlocks : true
    });
    CKEDITOR.on('dialogDefinition', function (ev) {
        var dialogName = ev.data.name;
        var dialog = ev.data.definition.dialog;
        var dialogDefinition = ev.data.definition;

        if (dialogName == 'image') {
            dialog.on('show', function (obj) {
                this.selectPage('Upload'); //업로드텝으로 시작
            });
            dialogDefinition.removeContents('advanced'); // 자세히탭 제거
            dialogDefinition.removeContents('Link'); // 링크탭 제거
        }
    });
    CKEDITOR.config.allowedContent = true;
    CKEDITOR.config.codemirror = {
        // Set this to the theme you wish to use (codemirror themes)
        theme: '3024-night',

        // Whether or not to automatically format code should be done when the editor is loaded
        autoFormatOnStart: false,
    };
}
$.fn.modal.Constructor.prototype.enforceFocus = function () {   // bootstrap & ckEdiotr 소스 방지 코드
    modal_this = this
    $(document).on('focusin.modal', function (e) {
        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select') && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
        }
    })
}
function register() {
    if(form_register.start_date.value == '') { alert('시작일이 입력되지 않았습니다.'); form_register.start_date.focus(); return false;}
    if(form_register.end_date.value == '') { alert('종료일이 입력되지 않았습니다.'); form_register.end_date.focus(); return false;}
    if(form_register.title.value == '') { alert('제목이 입력되지 않았습니다.'); form_register.title.focus(); return false;}
    if(form_register.leftPosition.value == '') { alert('위치(가로)가 입력되지 않았습니다.'); form_register.left_position.focus(); return false;}
    if(form_register.topPosition.value == '') { alert('위치(세로)가 입력되지 않았습니다.'); form_register.top_position.focus(); return false;}
    if(form_register.width.value == '') { alert('크기(가로)가 입력되지 않았습니다.'); form_register.width.focus(); return false;}
    if(form_register.height.value == '') { alert('크기(세로)가 입력되지 않았습니다.'); form_register.height.focus(); return false;}
    if (objEditor.getData().length < 1) {
        alert('내용이 입력되지 않았습니다.');
        objEditor.focus();
        return false;
    }
    form_register.target = 'iframe_process';
    form_register.submit();
}
function setData(code) {
	$.ajax({
		url:'${pageContext.request.contextPath}/admin/popup/getPopup',
		type:'post',
		dataType:'json',
		headers: {
            "${_csrf.headerName}" : "${_csrf.token}"
        },
		data:{
			method:'UtilPopup.info',
            code:code,
		},
		success(data){
			var startDate = new Date(data.startDate);
			var endDate = new Date(data.endDate);
			var startDateStr = "";
			startDateStr += startDate.getFullYear() + "-";
			startDateStr += (startDate.getMonth() + 1) + "-";
			startDateStr += startDate.getDate();
			var endDateStr = "";
			endDateStr += endDate.getFullYear() + "-";
			endDateStr += (endDate.getMonth() + 1) + "-";
			endDateStr += endDate.getDate();
            $('form[name="form_register"] #mode').val('update');
			$('[name=code]').val(data.code);
            $('[name=url]').val(data.url);
            $('[name=start_date]').val(startDateStr);
            $('[name=end_date]').val(endDateStr);
			$('[name=leftPosition]').val(data.leftPosition);
			$('[name=topPosition]').val(data.topPosition);
            $('[name=width]').val(data.width);
			$('[name=height]').val(data.height);
            $('[name=title]').val(data.title);
            $('[name=locale]').val(data.locale);
			$('#display_'+data.display).prop('checked', true);
            $('#popupCookie_'+data.popupCookie).prop('checked', true);
            $('#popup_sub_title').text('수정');
            $('#display_reply').css('display','');
            objEditor.setData(data.content);
		},
		error:console.log
	});
}
function onclickInsert() {
    $('#modalContent').modal('show');
    form_register.reset();
    $('#board_sub_title').text('등록');
    $('form[name="form_register"] #mode').val('insert');
    objEditor.setData('');
}
function onclickUpdate(code) {
    $('#modalContent').modal({backdrop:'static', show:true});
    setData(code);
}
$(function() {
    $("#datepicker1,#datepicker2,#datepicker3,#datepicker4").datepicker({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNames: ['일','월','화','수','목','금','토'],
        dayNamesShort: ['일','월','화','수','목','금','토'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        showMonthAfterYear: true,
        yearSuffix: '년'
    });
});
$(document).ready(function() {
    $('#keyword').keydown(function(event) {
        if(event.keyCode == 13) {
            form_search.submit();
        }
    });
});

</script>
<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>