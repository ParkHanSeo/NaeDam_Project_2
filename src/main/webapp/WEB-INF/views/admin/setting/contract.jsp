<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="약관" name="title" />
</jsp:include>


<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	<h1>
		약관 <small>contract list</small>
	</h1>

	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li>설정</li>
		<li class="active">약관</li>
	</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body">

					<div class="col-xs-12" style="padding: 0 0 5px 0;">
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

					<form name="form_register" method="post" action="${pageContext.request.contextPath }/admin/contract/updateContract?${_csrf.parameterName}=${_csrf.token}">
						<input type="hidden" name="mode" value="contract"> 
						<input type="hidden" name="locale" value="ko">
						<table class="table table-bordered">
							<tr>
								<td class="menu">이용약관</td>
								<td align="left"><textarea name="provision" rows="10" style="width: 100%;"></textarea></td>
							</tr>
							<tr>
								<td class="menu">개인정보 취급방침</td>
								<td align="left"><textarea name="privacy" rows="10" style="width: 100%;"></textarea></td>
							</tr>
							<tr>
								<td class="menu">이메일 무단수집 거부</td>
								<td align="left"><textarea name="email" rows="10" style="width: 100%;"></textarea></td>
							</tr>
							<tr>
								<td class="menu">개인정보 수집·이용 동의(게시판 전용)</td>
								<td align="left"><textarea name="personal" rows="10" style="width: 100%;"></textarea></td>
							</tr>
							<!--    // 추가 약관 (필요하면 커멘트 제거 하고 사용할것)
                <tr>
                    <td class="menu">고유식별정보처리</td>
                    <td align="left"><textarea name="distinguish" rows="10" style="width:100%;"></textarea></td>
                </tr>
-->
						</table>
					</form>

					<br>
					<div align="center">
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
	<!-- /.row --> </section>
</div>
<!-- /.content-wrapper -->

<script>
	function register() {
		if (form_register.privacy.value == '') {
			alert('개인정보 취급방침이 입력되지 않았습니다.');
			form_register.privacy.focus();
			return false;
		}
		if (form_register.provision.value == '') {
			alert('이용약관이 입력되지 않았습니다.');
			form_register.provision.focus();
			return false;
		}
		form_register.target = 'iframe_process';
		form_register.submit();
		alert("약관이 수정되었습니다.")
	}
	function setData() {
		// 정보
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/contract/getContract',
			type : 'post',
			dataType : 'json',
			headers: {
                "${_csrf.headerName}" : "${_csrf.token}"
            },
			data : {
				method : 'Setting.getContract',
				locale : $('[name=locale]').val()
			},
			success(data) {
				
				$('[name=provision]').val(data.provision);
				$('[name=privacy]').val(data.privacy);
				$('[name=email]').val(data.email);
				$('[name=distinguish]').val(data.distinguish);
				$('[name=personal]').val(data.personal); 
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus);
				// $('#content').val(errorThrown);
			}
		});
	}
	function setLocale(locale) {
		$('button[id^=locale_]').attr('class', 'btn btn-default');
		$('#locale_' + locale).attr('class', 'btn btn-primary');
		$('[name=locale]').val(locale);
		setData();
	}
	setData('ko')
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>