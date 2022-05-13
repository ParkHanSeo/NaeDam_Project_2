<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="임원 관리" name="title"/>
</jsp:include>

<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>

<!-- content-wrapper -->
<div class="content-wrapper">
<section class="content-header">
    <h1>
    임원 리스트 관리
    <small>commissioner list</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Setting</li>
        <li class="active">전문위원 리스트 관리</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <label style="margin-top:5px;" id="countContainer">총 ${resultStaffList.size()} 건</label>
                    <div class="box-tools pull-right" style="margin-bottom:5px;">
                    <input type="hidden" name="tpf" value="admin/setting/staff">
                        <div class="has-feedback">
                        <span>
                        <input type="text" name="keyword" id="keyword" value="" class="form-control input-sm" placeholder="검색"/>
                        <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </span>
                        </div>
                    </div>
                    <div class="box-tools pull-right" style="margin-bottom:5px;">
                        <div class="has-feedback">
                        <select name="type" class="form-control input-sm">
	     					<option value="staff_name">이름</option>      
	     					<option value="staff_position">직책</option>                        
     					</select>
                        </div>
                    </div>
                    <form name="form_list" method="POST" action="${pageContext.request.contextPath}/admin/setting/staff_delete.do?${_csrf.parameterName}=${_csrf.token}">
			            <input type="hidden" name="mode" id="mode">
	                    <table class="table table-bordered table-hover checkbox-group">
				            <thead>
			                    <tr>
			                        <td style="width: 30px;"><input type="checkbox" name="select_all" id="checkAll" /></td>
			                        <td style="width:60px;">NO</td>
			                        <td style="width:100px;">이미지</td>
			                        <td style="width:146px;">이름</td>
			                        <td>직책</td>
			                        <td style="width:140px;">등록일</td>
			                        <td style="width:80px;">
			                        <i onclick="change('down');" class="fa fa-fw fa-arrow-circle-down cp" style="cursor:pointer;"></i>
			                        <!-- <i onclick="changeOrder('down','staff','?tpf=admin/setting/staff');" class="fa fa-fw fa-arrow-circle-down cp" style="cursor:pointer;"></i> -->
			                        <i onclick="change('up');" class="fa fa-fw fa-arrow-circle-up cp" style="cursor:pointer;"></i>
			                        </td>
			                        <td style="width:80px;">명령</td>
			                    </tr>
		                    </thead>
		                    <tbody id="tbody">
		                    	<c:forEach items="${resultStaffList}" var="staff">
									<tr>
				                        <td style="width:30px;"><input type="checkbox" class="member-is-checked" name="staffNo" value="${staff.staffNo}" data-target="${staff.staffNo}" /></td>
				                        <td style="width:60px;">${staff.rowNum}</td>
				                        <td style="width:100px;"><img src="${staff.imgUrl}" width="144"></td>
				                        <td style="width:146px;">${staff.staffName}</td>
				                        <td>${staff.staffPosition}</td>
				                        <td style="width:140px;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${staff.regDate}" /></td>
				                        <td><input type="radio" class="radio-is-checked" name="order_code" value="${staff.staffNo}" data-target="${staff.staffNo}" /></td>
				                        <td style="width:80px;"><button type="button" value="${staff.staffNo}" class="btn btn-primary btn-xs detailBtn">상세보기</button></td>
				                    </tr>
		                    	</c:forEach>
		                    </tbody>
	                    </table>
                    </form>
                    <br>
                    <button type="button" id="staffListDeleteBtn" class="btn btn-danger btn-sm"><i class="fa fa-minus-square"></i> 선택삭제</button>
                    <button type="button" onclick="onclickInsert()"  class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 임원 등록</button>

                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>

<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
    <div class="modal-dialog" style="width:650px;">
        <div class="modal-content">
            <form
            	name="staffEnrollFrm" 
            	method="POST"
            	action="${pageContext.request.contextPath}/admin/setting/staff_process.do?${_csrf.parameterName}=${_csrf.token}" 
            	enctype="multipart/form-data">
            <input type="hidden" name="imgUrl" />
            <input type="hidden" name="mode" id="mode" value="insert" />
            <input type="hidden" name="staffNo" id="staffNo" value="0">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabelPortfolio">임원 관리</h4>
            </div>
                <div class="modal-body">

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 임원 <span id="board_sub_title">등록</span></p></h4>
                <table class="table table-bordered">
                    <tr>
                        <td class="menu">이름 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                        <td align="left"><input type="text" name="staffName" id="staffName" value="" class="form-control input-sm" style="width:50%;"></td>
                    </tr>
                    <tr>
                        <td class="menu">직책 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                        <td align="left"><input type="text" name="staffPosition" id="staffPosition" value="" class="form-control input-sm" style="width:50%;"></td>
                    </tr>
                    <tr>
                        <td class="menu">Career <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                        <td align="left">
                        <textarea name="staffCareer" id="staffCareer" rows="4" class="form-control input-sm"></textarea>
                        <div style="font-weight:normal">※ 리스트는 Enter기준으로 구분됩니다.</div>
                        </td>
                    </tr>
                    <tr>
                        <td class="menu">Profile <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                        <td align="left">
                        <textarea name="staffProfile" id="staffProfile" rows="4" class="form-control input-sm"></textarea>
                        <div style="font-weight:normal">※ 리스트는 Enter기준으로 구분됩니다.</div>
                        </td>
                    </tr>
                    <tr>
                        <td class="menu">파일 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                        <td align="left">
                        <input type="file" name="file" id="file" class="form-control input-sm" style="width:80%; display:inline;">
                        <span id="display_file" style="display:none;">
	                        <button type="button" id="windowBtn" onclick="" class="btn btn-success btn-xs">보기</button>
	                        <button type="button" id="deleteBtn" onclick="" class="btn btn-danger btn-xs">삭제</button>
                        </span>
                        </td>
                    </tr>
                </table>

                </div>
                <div class="modal-footer">
                    <button type="button" id="btnRegister" onclick="register()" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
                    <button type="button" id="btnUpdate" onclick="update()" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
                </div>
            </form>
        </div>
    </div>
</div>
</div><!-- /.content-wrapper -->

<script>
// 등록 모달창
function onclickInsert(){
	console.log("등록(onclickInsert())");
	$("#btnUpdate").hide();
	$("#btnRegister").show();
	staffEnrollFrm.reset();
	$("#modalContent").modal();	
}

// 등록(확인)
function register(){
	var staffName = $("#staffName").val();
	var staffPosition = $("#staffPosition").val();
	var staffCareer = $("#staffCareer").val();
	var staffProfile = $("#staffProfile").val();
	var file = $("#file").val();
	console.log("staffName = " + staffName);
	console.log("staffPosition = " + staffPosition);
	console.log("staffCareer = " + staffCareer);
	console.log("staffProfile = " + staffProfile);
	console.log("file = " + file);
	
	// 이름 공란 확인
	if(staffName == ''){
		alert("이름이 입력되지 않았습니다.");
		$("#staffName").focus();
		return false;
	}
	// 직책 공란 확인
	if(staffPosition == ''){
		alert("직책이 입력되지 않았습니다.");
		$("#staffPosition").focus();
		return false;
	}
	// Career 공란 확인
	if(staffCareer == ''){
		alert("Career가 입력되지 않았습니다.");
		$("#staffCareer").focus();
		return false;
	}
	// Profile 공란 확인
	if(staffProfile == ''){
		alert("Profile가 입력되지 않았습니다.");
		$("#staffProfile").focus();
		return false;
	}
	// 첨부파일 확인
	if(staffEnrollFrm.mode.value == 'insert') {
		if(staffEnrollFrm.file.value == '') {
			alert("파일이 입력되지 않았습니다.");
			staffEnrollFrm.file.focus();
		}
	}
	if($('[name=imgUrl]').val() == '')
		return false;
	
	$(window).unbind("beforeunload");
	$(document.staffEnrollFrm).submit();
}

// 이미지 업로드
$("input[type=file]").change(function(e){
	var file = e.target;
	console.log("file = " + file);
	var form = new FormData();
	console.log("form = " + form);
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
		console.log("response" + response);
		  
		var imgbb = JSON.parse(response);
		console.log("imgbb : " + imgbb);
		  
		// 이미지 조회 및 다운로드
		var url = imgbb.data.thumb.url;
		var name = imgbb.data.thumb.filename;
		console.log("url : " + url);
		console.log("name : " + name);
	
		$('[name=imgUrl]').val(url);
	
		});
});

//체크박스 전체 선택
$(".checkbox-group").on("click", "#checkAll", ((e)=>{
	let checked = $(e.target).is(":checked");
	console.log("전체 선택 : " + checked);
	
	if(checked){
		$(e.target).parents(".checkbox-group").find("input:checkbox").prop("checked", true);
	} else {
		$(e.target).parents(".checkbox-group").find("input:checkbox").prop("checked", false);
	}
}));
//체크박스 개별 선택
$(document).on("click", ".member-is-checked", function(){
	let isChecked = true;
	console.log("개별 선택 : " + isChecked);
	
	$(".member-is-checked").each((i, item)=>{
		isChecked = isChecked && $(item).is(":checked");
		console.log("i : " + i);
		//console.log(item);
		console.log($(item).is(":checked"));
	});
	
	$("#checkAll").prop("checked", isChecked);	
});
//선택삭제
$(document).on("click", "#staffListDeleteBtn", function(){
	let isChecked = false;
	
	$(".member-is-checked").each((i, item)=>{
		isChecked = isChecked || $(item).is(":checked");
		let target = $(item).data("target");
		console.log("target = ", target); // target = memberNo
		
		if($(item).is(":checked")){
			$(item).after(`<input type="hidden" name="staffNo" value="\${target}"/>`);
		}
	});
	
	var mode = "delete";
	$('[name=mode]').val(mode);
	console.log("mode = " + mode);
	
	if(!isChecked){
		alert("선택된 목록이 없습니다.");
		return;
	}
	
	console.log("클릭");
	console.log($(document.form_list));
	if(confirm("해당 자료를 정말 삭제하시겠습니까?"))
		$(document.form_list).submit();
});
//타입별 검색
$(document).ready(function(){
	// Enter Event
	$("#keyword").keydown(function(keyNum){
		
		var keyword = $('input[name=keyword]').val(); // 검색어
		var type = $('select[name=type]').val(); // 검색 타입
	
		if(keyNum.keyCode == 13){
			console.log("Enter Event! - 타입별 검색");
			console.log("keyword = " + keyword);
			console.log("type = " + type);
			
			const search = {
				"type" : type,
				"keyword" : keyword
			};
			
			$.ajax({
				type : "GET",
				url : `${pageContext.request.contextPath}/setting/staffTypeSearch.do`,
				data : search,
				contentType: "application/json; charset=utf-8",
				success(data){
					console.log("ajaxData = " + JSON.stringify(data));
					
					$("#tbody").html('');
					
					$.each(data.searchStaffList, (k, v) => {
						$("#tbody").append(`
								<tr>
		                        <td style="width:30px;"><input type="checkbox" class="member-is-checked" name="" value="\${v.staffNo}" data-target="\${v.staffNo}" /></td>
		                        <td style="width:60px;">\${v.rowNum}</td>
		                        <td style="width:100px;"><img src="\${v.imgUrl}" width="144"></td>
		                        <td style="width:146px;">\${v.staffName}</td>
		                        <td>\${v.staffPosition}</td>
		                        <td style="width:140px;">\${v.regDate}</td>
		                        <td><input type="radio" name="order_code" value="\${v.staffNo}"/></td>
		                        <td style="width:80px;"><button type="button" value="\${v.staffNo}" class="btn btn-primary btn-xs">상세보기</button></td>
		                    </tr>
								`);
					});
					$("#countContainer").html('');
					$("#countContainer").html(`<label style="margin-top: 5px;">총 \${data["searchStaffCount"]} 건</label>`)
				},
				error : console.log	
			});		
		}
	});
});
// 상세보기
$(document).on("click", ".detailBtn", function(e){
	console.log("해당 no = " + $(e.target).val());
	var staffNo = $(e.target).val();
	console.log("staffNo = " + staffNo);
	$("#btnRegister").hide();
	$("#btnUpdate").show();
	$("#display_file").show();
	$("#modalContent").modal();
	
	const data = {
		staffNo : staffNo	
	};
	
	$.ajax({
		url : `${pageContext.request.contextPath}/setting/staffDetail.do/\${staffNo}`,
		data : data,
		contentType : "application/json; charset=utf-8",
		method : "GET",
		success : function(res) {
			console.log("ajaxData = " + JSON.stringify(res));
			var staff = res.staff;
			
			$("[name=staffName]").val(staff.staffName);
			$("[name=staffPosition]").val(staff.staffPosition);
			$("[name=staffCareer]").val(staff.staffCareer);
			$("[name=staffProfile]").val(staff.staffProfile);
			//$("[name=imgUrl]").val(staff.imgUrl);
			$("[name=staffNo]").val(staff.staffNo);
			$('#windowBtn').attr('onclick', 'openWindow('+ staff.staffNo +');');
			$('#deleteBtn').attr('onclick', 'deleteImg(' + staff.staffNo +');');
			if(staff.imgUrl != null){
				$("#display_file").css("display", "");				
			}
			else {
				$("#display_file").css("display", "none");				
			};
		},
		error : console.log
	});
});
// 이미지 팝업
function openWindow(staffNo){
	var win;
	win = window.open('${pageContext.request.contextPath}/setting/imgView?staffNo='+staffNo, 'imgView', 'scrollbars=no, width=10, height=10, status=no, resizable=no');
}
// 이미지 사이즈 조정
function resizeWindow(win) {
	var wid = win.document.body.offsetWidth + 30;
	var hei = win.document.body.offsetHeight + 40;        //30 과 40은 넉넉하게 하려는 임의의 값임
	win.resizeTo(wid,hei);
}
// 이미지 삭제
function deleteImg(staffNo){
	console.log("staffNo = " + staffNo);
	var result = confirm("정말 삭제하시겠습니까?");
	if(result){
		
		const data = {
				staffNo : staffNo
		}
		
		$.ajax({
			url : `${pageContext.request.contextPath}/setting/deleteImg.do/\${staffNo}`,
			data : data,
			contentType : "application/json; charset=utf-8",
			method : "POST",
			headers: {
	            "${_csrf.headerName}" : "${_csrf.token}"
	        },
			success(data){
				console.log(data);
				alert("해당 파일이 삭제되었습니다.");
				location.reload();
			},
			error : console.log
		});
		$(window).unbind("beforeunload");
	}
		
}
// 상세보기 - 확인(수정)
function update(){
	console.log("상세보기 - 확인");
	var staffName = $("#staffName").val();
	var staffPosition = $("#staffPosition").val();
	var staffCareer = $("#staffCareer").val();
	var staffProfile = $("#staffProfile").val();
	var file = $("#file").val();
	
	// 이름 공란 확인
	if(staffName == ''){
		alert("이름이 입력되지 않았습니다.");
		$("#staffName").focus();
		return false;
	}
	// 직책 공란 확인
	if(staffPosition == ''){
		alert("직책이 입력되지 않았습니다.");
		$("#staffPosition").focus();
		return false;
	}
	// Career 공란 확인
	if(staffCareer == ''){
		alert("Career가 입력되지 않았습니다.");
		$("#staffCareer").focus();
		return false;
	}
	// Profile 공란 확인
	if(staffProfile == ''){
		alert("Profile가 입력되지 않았습니다.");
		$("#staffProfile").focus();
		return false;
	}
	$('form[name="staffEnrollFrm"] #mode').val('update');
	$(window).unbind("beforeunload");
	$(document.staffEnrollFrm).submit();
}



// 게시물 순서 변경
function change(direction, form_name){
	console.log("direction = " + direction);
	var direction = direction;
	if(!form_name)
		form_name = 'form_list';
	
	var f = eval(form_name);
	console.log("f = " + f);
	var chkRadio = f.order_code;
	console.log("chkRadio = " + chkRadio);
	
	if (!chkRadio) {
		alert('항목이 없습니다.');
		return;
	}
	
	var chkLen = chkRadio.length;
	console.log("chkLen = " + chkLen);
	if (chkLen == undefined) {
		alert('2개 이상의 항목이 있어야만 위치 변경이 가능합니다.');
		return false;
	}
	
	var staffNo = $('input[name=order_code]:checked').val();
	console.log("staffNo = " + staffNo);
	
	
	
	const result = {
		direction : direction,
		staffNo : staffNo
	};
	
	const data = JSON.stringify(result);
	
	if(staffNo != undefined){
		$.ajax({
			url : `${pageContext.request.contextPath}/setting/changeOrder.do`,
			data : data,
			contentType : "application/json; charset=utf-8",
			method : "POST",
			headers: {
	            "${_csrf.headerName}" : "${_csrf.token}"
	        },
			success(data){
	        	console.log("ajaxData = " + JSON.stringify(data));
	        	
	        	$("#tbody").html('');
				
				$.each(data.staffList, (k, v) => {
					$("#tbody").append(`
							<tr>
		                        <td style="width:30px;"><input type="checkbox" class="member-is-checked" name="staffNo" value="\${v.staffNo}" data-target="\${v.staffNo}" /></td>
		                        <td style="width:60px;">\${v.rowNum}</td>
		                        <td style="width:100px;"><img src="\${v.imgUrl}" width="144"></td>
		                        <td style="width:146px;">\${v.staffName}</td>
		                        <td>\${v.staffPosition}</td>
		                        <td style="width:140px;">\${v.regDate}</td>
		                        <td><input type="radio" class="radio-is-checked" name="order_code" value="\${v.staffNo}" data-target="\${v.staffNo}" /></td>
		                        <td style="width:80px;"><button type="button" value="\${v.staffNo}" class="btn btn-primary btn-xs detailBtn">상세보기</button></td>
		                    </tr>
							`);
				});
			},
			error : console.log
		});
	} else {
		alert("1개의 항목을 선택하여야 합니다.");
		return false;
	}
}


</script>



<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>