<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="기본 설정" name="title" />
</jsp:include>


<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	<h1>
		기본 설정 <small>setting</small>
	</h1>

	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li>기본 설정</li>
		<li class="active">기본정보 관리</li>
	</ol>
	</section>

	<section class="content">
	<div class="row">
		<div>
			<div class="box">
				<div class="box-body">

					<form name="form_register" method="post" action="?tpf=admin/setting/process" enctype="multipart/form-data">
						<div class="col-md-6">
							<input type="hidden" name="mode" value="info">
							<table class="table table-bordered">
								<tr>
									<td class="menu">대표 이메일</td>
									<td align="left">
										<input type="text" name="email" value="${adminSetting.email }" class="form-control input-sm" style="width: 80%; display: inline;"> 
										<br> ※ 각종 메일 수신에 사용됩니다.
									</td>
								</tr>
								<tr>
									<td class="menu">대표 휴대폰 번호</td>
									<td align="left">
										<input type="text" name="mobile1" value="${fn:substring(adminSetting.phone,0,3) }" onkeyup="this.value=checkNum(this.value)" class="form-control input-sm" style="width: 60px; display: inline;" maxlength="3">
										  - 
										 <input type="text" name="mobile2" value="${fn:substring(adminSetting.phone,3,7) }" onkeyup="this.value=checkNum(this.value)" class="form-control input-sm" style="width: 60px; display: inline;" maxlength="4">
										  - 
										 <input type="text" name="mobile3" value="${fn:substring(adminSetting.phone,7,13) }" onkeyup="this.value=checkNum(this.value)" class="form-control input-sm" style="width: 60px; display: inline;" maxlength="4"> <br> ※ SMS 알림 수신에 사용됩니다.</td>
								</tr>
								<tr>
									<td class="menu">발신자 번호</td>
									<td align="left">
										<input type="text" name="tel1" value="${fn:substring(adminSetting.callerId,0,3) }" onkeyup="this.value=checkNum(this.value)" class="form-control input-sm" style="width: 60px; display: inline;" maxlength="3">
										 - 
										<input type="text" name="tel2" value="${fn:substring(adminSetting.callerId,3,7) }" onkeyup="this.value=checkNum(this.value)" class="form-control input-sm" style="width: 60px; display: inline;" maxlength="4">
										 - 
										<input type="text" name="tel3" value="${fn:substring(adminSetting.callerId,7,13) }" onkeyup="this.value=checkNum(this.value)" class="form-control input-sm" style="width: 60px; display: inline;" maxlength="4"> 
										<br> ※ SMS 알림 발송시 발신자 번호로 사용 됩니다. <small class="text-red">(발신번호를 미르나인 담당자에게 알려주기 바랍니다.)</small>
									</td>
								</tr>
								<tr>
									<td class="menu">썸네일 이미지</td>
									<td align="left"><input type="file" name="file1" class="form-control input-sm" style="width: 80%; display: inline;">
										<button type="button" onclick="winOpen('${pageContext.request.contextPath}/setting/img_view?type=thumb');" class="btn btn-success btn-xs">보기</button> <br> ※ 350 * 285 사이즈로 등록해 주세요 (카카오톡등 메신저 url 노출시 보여지는 이미지 입니다)</td>
								</tr>
								<tr>
									<td class="menu">파비콘 이미지</td>
									<td align="left"><input type="file" name="file2" class="form-control input-sm" style="width: 80%; display: inline;">
										<button type="button" onclick="winOpen('${pageContext.request.contextPath}/setting/img_view?type=favicon');" class="btn btn-success btn-xs">보기</button> <br> ※ 16 * 16 사이즈로 등록해 주세요 (확장자 : <span style="color: red">.ico .png</span>)</td>
								</tr>
								<tr>
									<td class="menu">회원 등급별 할인율</td>
									<td align="left">
										<input type="checkbox" name="is_member_discount" value="Y" ${adminSetting.isDiscount == 'Y' ? 'checked' : '' }> 사용하기
										<br> ※ 회원 관리 > 등급 관리에서 등급별 세부 할인율을 설정 할수 있습니다.
									</td>
								</tr>
								<tr>
									<td class="menu">연혁 레이아웃<br> 설정
									</td>
									<td align="left">
										<div>
											<span style="float: left; width: 200px; text-align: center;"> 
												<img src="/img/skin/history_type1.PNG" style="width: 200px; cursor: pointer;" onclick="viewSkinPreview(this)" /><br /> 
												<input type="radio" name="skin" value="1" ${adminSetting.historyLayoutNo == 1 ? 'checked' : '' } /> dispay 1
											</span> 
											<span style="float: left; width: 200px; text-align: center;"> 
												<img src="/img/skin/history_type2.PNG" style="width: 200px; cursor: pointer;" onclick="viewSkinPreview(this)" /><br /> 
												<input type="radio" name="skin" value="2" ${adminSetting.historyLayoutNo == 2 ? 'checked' : '' } /> display 2
											</span>
										</div>
										<div align="left" style="margin-top: 20px; width: 100%; height: 40%; float: left;">
											<select name="historyViewType" class="form-control input-sm" style="width: 300px;">
												<option value="1" ${adminSetting.historyViewType == 1 ? 'selected' : '' }>연혁 - 2019/05/28</option>
												<option value="2" ${adminSetting.historyViewType == 2 ? 'selected' : '' }>연혁 - May. 2019</option>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<td class="menu">교환/반품/배송안내 설정</td>
									<td align="left">
										<button type="button" onclick="onclickInsert();" class="btn btn-primary btn-sm">
											<i class="fa fa-plus-square"></i> 설정 등록
										</button> ※ 상품 상세보기 하단 텝부분에 안내문구로 표출됩니다.
									</td>
								</tr>
							</table>
						</div>

						<div class="col-md-6">
							<table class="table table-bordered">
								<tr>
									<td class="menu">디폴트 언어</td>
									<td align="left">
										<select name="default_locale" class="form-control input-sm" style="width: 150px;">
											<c:forEach var="locale" items="${localeList }">
												<option value="${locale.localeCode }" ${locale.isDefault == 'Y' ? 'selected' : ''  }>${locale.localeName }</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td class="menu">다국어 선택</td>
									<td align="left">
										<c:forEach var="locale" items="${localeList }">
											<input type="checkbox" name="locale_list[]" value="${locale.localeCode }" ${locale.isChoosen == 'Y' ? 'checked' : '' } /> ${locale.localeName }<br> 
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="menu">관리자 메뉴<br>표출 설정
									</td>
									<td align="left">
										<c:forEach var="menu" items="${adminMenuList }">
											<input type="checkbox" name="admin_menu_list[]" value="${menu.menuNo }" ${menu.status == 'Y' ? 'checked' : '' } /> ${menu.menuName }<br> 
										</c:forEach>
									</td>
								</tr>
							</table>
					</form>
				</div>

				<div align="center" class="col-md-12">
					<button type="button" onclick="register();" class="btn btn-primary btn-sm">
						<i class="fa fa-plus-square"></i> 확인
					</button>
				</div>

			</div>
			<!-- /.box-body -->
		</div>
		<!-- /.box -->
	</div>
	<!-- /.col-xs-12 -->
</div>
<!-- /.row -->
</section>

<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	<div class="modal-dialog" style="width: 650px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">연혁 관리</h4>
			</div>
			<div class="modal-body">
				<h4>
					<p class="text-light-blue">
						<i class="fa fa-fw fa-info-circle"></i> 연혁 설정 프리뷰 이미지
					</p>
				</h4>
				<table class="table table-bordered">
					<tr>
						<div id="myModalLabelPortfolioSkinPreviewImage">
							<img style="display: block; margin: 0px auto" />
						</div>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>


<!-- 교환/반품/배송안내  -->
<div class="modal fade" id="modalGuide" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	<div class="modal-dialog" style="width: 70%;">
		<div class="modal-content">
			<form name="form_register2" method="post" onsubmit="return false;" action="?tpf=admin/setting/process">
				<input type="hidden" name="mode" value="updateGuide"> <input type="hidden" name="locale" value="ko">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">교환/반품/배송안내 등록</h4>
				</div>
				<div class="modal-body">
					<div class="row" style="margin: 0">
						<div class="col-xs-4">
							<span style="float: left;"><h4>
									<p class="text-light-blue">
										<i class="fa fa-fw fa-info-circle"></i> 교환/반품/배송안내 등록
									</p>
								</h4></span>
						</div>

						<div class="col-xs-8" style="padding: 0">
							<div class="btn-group pull-right">
								<button type="button" id="locale_ko" onclick="setLocale('ko')" class="btn btn-primary">
									<i class="fa fa-globe" aria-hidden="true"></i> 한국어
								</button>
								<button type="button" id="locale_en" onclick="setLocale('en')" class="btn btn-default">
									<i class="fa fa-globe" aria-hidden="true"></i> ENG
								</button>
								<button type="button" id="locale_zh" onclick="setLocale('zh')" class="btn btn-default">
									<i class="fa fa-globe" aria-hidden="true"></i> 中国
								</button>
								<button type="button" id="locale_vn" onclick="setLocale('vn')" class="btn btn-default">
									<i class="fa fa-globe" aria-hidden="true"></i> Tiếng việt
								</button>
							</div>
						</div>
					</div>

					<table class="table table-bordered">
						<tr>
							<td align="left" colspan="30" style="padding: 0">
								<textarea name="content" id="content" onfocus="javascript:this.value=''" rows="30" cols="80"></textarea>
							</td>
						</tr>
					</table>
			</form>
		</div>

	</div>
	<div class="modal-footer">
		<button type="button" id="displayButton" onclick="register2();" class="btn btn-primary">저장하기</button>
	</div>
</div>
</div>
</div>

<script src="//mir9.co.kr/resource/js/ckeditor4.7.2/ckeditor.js"></script>
</div>
<!-- /.content-wrapper -->


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>