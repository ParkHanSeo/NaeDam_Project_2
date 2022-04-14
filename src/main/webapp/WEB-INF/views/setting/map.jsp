<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="약도 관리" name="title" />
</jsp:include>


<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	<h1>
		약도 관리 <small>map list</small>
	</h1>

	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li>약도 관리</li>
		<li class="active">약도 리스트</li>
	</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">
					<label style="margin-top: 5px;">총 ${mapList.size()} 건</label>

					<form name="form_list" method="post" action="${pageContext.request.contextPath }/map/map_process?${_csrf.parameterName}=${_csrf.token}">
						<input type="hidden" name="mode" id="mode">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<td style="width: 30px;"><input type="checkbox" name="select_all" onclick="selectAllCheckBox( 'form_list')"; /></td>
									<td style="width: 60px;">NO</td>
									<td>제목</td>
									<td style="width: 200px;">연결주소</td>
									<td style="width: 100px;">API 종류</td>
									<td style="width: 160px;">좌표</td>
									<td style="width: 120px;">지도 확대 레벨</td>
									<td style="width: 120px;">팝업 정보</td>
									<td style="width: 120px;">등록일</td>
									<td style="width: 150px;">명령</td>
								</tr>
							</thead>
							<c:forEach var="map" items="${mapList }">
								<tr>
									<td><input type="checkbox" name="list[]" value="${map.mapNo } }" /></td>
									<td>${map.mapNo }</td>
									<td align="left">${map.mapTitle }</td>
									<td align="left">${map.connectingAddr }</td>
									<td>${map.mapApiName }</td>
									<td>${map.latitude },${map.longitude }</td>
									<td>${map.zoomLevel }</td>
									<td>${map.popupInfo }</td>
									<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${map.regDate}" /></td>
									<td>
										<button type="button" onclick="_onclickView('map',1);" class="btn btn-success btn-xs">바로가기</button>
										<button type="button" onclick="onclickUpdate(${map.mapNo});" class="btn btn-primary btn-xs">상세보기</button>
									</td>
								</tr>
							</c:forEach>

						</table>
					</form>
					<br>

					<button type="button" onclick="selectDelete();" class="btn btn-danger btn-sm">
						<i class="fa fa-minus-square"></i> 선택삭제
					</button>
					<button type="button" onclick="onclickInsert()" class="btn btn-primary btn-sm">
						<i class="fa fa-plus-square"></i> 약도 생성
					</button>

				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
		</div>
		<!-- /.col-xs-12 -->
	</div>
	<!-- /.row --> </section>

	<div class="modal fade" id="modalRegister" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog" style="width: 600px;">
			<div class="modal-content">
				<form name="form" method="post" action="${pageContext.request.contextPath }/map/map_process?${_csrf.parameterName}=${_csrf.token}">
					<input type="hidden" name="mode" id="mode"> 
					<input type="hidden" name="mapNo">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title">약도 등록</h4>
					</div>
					<div class="modal-body">

						<h4>
							<p class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 약도 정보
							</p>
						</h4>
						<table class="table table-bordered">
							<tr>
								<td class="menu">제목 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="text" name="mapTitle" class="form-control input-sm"></td>
							</tr>
							<tr>
								<td class="menu">API 종류 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left">
									<select name="mapApiNo" class="form-control input-sm" style="width: 100px;">
										<c:forEach var="api" items="${apiList }">
											<option value="${api.mapApiNo }">${api.mapApiName }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td class="menu">API key <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="text" name="apiKey" class="form-control input-sm"></td>
							</tr>
							<tr>
								<td class="menu">주소</td>
								<td align="left"><input type="text" name="address" placeholder="주소를 입력하세요" class="form-control input-sm" style="width: 82%; margin-right: 5px; float: left">
									<button type="button" onclick="getCoord()" class="btn btn-primary btn-xs">좌표확인</button></td>
							</tr>
							<tr>
								<td class="menu">좌표 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left">
									<input type="text" name="latitude" placeholder="lat" class="form-control input-sm" style="width: 48%; margin-right: 10px; float: left"> 
									<input type="text" name="longitude" placeholder="lng" class="form-control input-sm" style="width: 48%; float: left">
								</td>
							</tr>
							<tr>
								<td class="menu">지도크기 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left"><input type="text" name="width" placeholder="width" class="form-control input-sm" style="width: 48%; margin-right: 10px; float: left"> <input type="text" name="height" placeholder="height" class="form-control input-sm" style="width: 48%; float: left"></td>
							</tr>
							<tr>
								<td class="menu">지도 확대 레벨 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
								<td align="left">
									<select name="zoomLevel" class="form-control input-sm" style="width: 100px;">
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="menu">팝업 정보</td>
								<td align="left">
									<textarea name="popupInfo" rows="4" style="width: 160px; float: left; margin-right: 5px;" class="form-control input-sm" placeholder="금천구 가산동 미르나인"></textarea> ※ 선택사항<br>입력시 팝업정보 창 표출
								</td>
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
</div>
<!-- /.content-wrapper -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a565ef86e588dc8b9bc46dd5db0fb88&libraries=services"></script>
<script>

function onclickUpdate(mapNo) {
    $('#modalRegister').modal({backdrop:'static', show:true});
    form.mode.value = 'update';
    setData(mapNo);
}

function setData(mapNo) {
	$.ajax({
		url:'${pageContext.request.contextPath}/map/getMap',
		type:'post',
		dataType:'json',
		headers: {
            "${_csrf.headerName}" : "${_csrf.token}"
        },
		data:{
            mapNo : mapNo
		},
		success(data){
            $('[name=mapNo]').val(data.mapNo);
            $('[name=mapTitle]').val(data.mapTitle);
            $('[name=mapApiNo]').val(data.mapApiNo).prop("selected",true);
            $('[name=apiKey]').val(data.apiKey);
            $('[name=address]').val(data.address);
            //$('[name=agree_content]').val(data.agree_content);
            $('[name=latitude]').val(data.latitude);
            $('[name=longitude]').val(data.longitude);
            $('[name=width]').val(data.width);
            $('[name=height]').val(data.height);
            $('[name=zoomLevel]').val(data.zoomLevel).prop("selected",true);
            $('[name=popupInfo]').val(data.popupInfo);
		},
		error:function(jqXHR, textStatus, errorThrown){
			console.log(textStatus);
			// $('#content').val(errorThrown);
		}
	});
}

//주소 -> 좌표 변환
function getCoord() {   
	var addr = $('[name=addr]').val()
	var geocoder = new kakao.maps.services.Geocoder();

	geocoder.addressSearch(addr, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	        $('[name=lat]').val(coords.La);
	        $('[name=lng]').val(coords.Ma);
	     }else{
	    	 alert("주소지를 다시 확인해주세요.")
	     }
	
	});
}

function onclickInsert(code) {
    $('#modalRegister').modal({backdrop:'static', show:true});
    form.reset();
    form.mode.value = 'insert';
}

function register() {
    if(form.mapTitle.value == '') { alert('제목이 입력되지 않았습니다.'); form.title.focus(); return false;}
    if(form.apiKey.value == '') { alert('API key값이 입력되지 않았습니다.'); form.api_key.focus(); return false;}
    if(form.latitude.value == '') { alert('lat값이 입력되지 않았습니다.'); form.lat.focus(); return false;}
    if(form.longitude.value == '') { alert('lng값이 입력되지 않았습니다.'); form.lng.focus(); return false;}
    if(form.width.value == '') { alert('width값이 입력되지 않았습니다.'); form.width.focus(); return false;}
    if(form.height.value == '') { alert('height값이 입력되지 않았습니다.'); form.height.focus(); return false;}
    form.target = 'iframe_process';
    $('#modalRegister').modal({backdrop:'static', show:false});
    form.submit();
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>