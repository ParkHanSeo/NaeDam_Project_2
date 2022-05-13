<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="SEO 설정" name="title" />
</jsp:include>


<!-- content-wrapper -->
<div class="content-wrapper">
	<section class="content-header">
	<h1>
		SEO 설정 <small>seo</small>
	</h1>

	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li>기본 설정</li>
		<li class="active">SEO 설정</li>
	</ol>
	</section>

	<section class="content">
	<div class="row">
		<div>
			<div class="box">
				<div class="box-body">

					<form:form name="form_register" method="post" action="${pageContext.request.contextPath }/admin/setting/seo_process?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
						<div class="col-md-6">
							<input type="hidden" name="mode" value="updateSEO">
							<table class="table table-bordered">
								<tr>
									<td class="menu">Webmaster 파일</td>
									<td align="left"><span style="display: inline-block; margin-bottom: 10px; width: 50px;">Naver</span> <input type="file" name="webmaster_naver" class="form-control input-sm" style="width: 75%; display: inline;"> <br> <span style="display: inline-block; margin-bottom: 10px; width: 50px;">Google</span> <input type="file" name="webmaster_google" class="form-control input-sm" style="width: 75%; display: inline;"> <br> <span style="display: inline-block; width: 50px;">Bing</span> <input type="file" name="webmaster_bing" class="form-control input-sm" style="width: 75%; display: inline;"> 
										<br> ※ 파일명 : <span style="color: red">${seo.googleFileName == null ? '' : seo.googleFileName + '/' } ${seo.naverFileName == null ? '' : seo.naverFileName}/${seo.bingFileName == null ? '' : seo.bingFileName } </span></td>
								</tr>
								<tr>
									<td class="menu">Sitemap</td>
									<td align="left"><input type="file" name="sitemap" class="form-control input-sm" style="width: 80%; display: inline;"> 
										<br> ※ 파일명 : <span style="color: red">${seo.siteMapFileName == null ? '' : seo.siteMapFileName} <a href="http://localhost:8080/mir9/sitemap.xml" target="_new">[사이트맵 추출하기 바로가기]</a></span></td>
								</tr>
								<tr>
									<td class="menu">Robots</td>
									<td align="left"><textarea name="robots" rows="4" style="width: 100%;">${seo.robots }</textarea></td>
								</tr>
							</table>
						</div>

						<div class="col-md-6">
							<table class="table table-bordered">
								<tr>
									<td class="menu">전환추적 태그<br>or<br>Rich Snippet
									</td>
									<td align="left">
										<textarea name="richSnippet" rows="20" style="width: 100%;">${seo.richSnippet }</textarea> 
										<br> ※ Google, naver 등의 전환추적 태그나 Rich Snippet 스크립트를 넣어주세요
									</td>
								</tr>
							</table>
						</div>
					</form:form>

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
	<!-- /.row --> </section>

	<form name="form_fileDelete" method="post" action="?tpf=admin/setting/seo_process" enctype="multipart/form-data">
		<input type="hidden" name="mode" value="deleteSEO"> <input type="hidden" name="name"> <input type="hidden" name="category">
	</form>
</div>
<!-- /.content-wrapper -->
<script>
        function register() {
            form_register.target = 'iframe_process';
            form_register.submit();
        }
        function deleteFile(category, targetFile) {
            form_fileDelete.category.value = category;
            form_fileDelete.name.value = targetFile;
            form_fileDelete.target = 'iframe_process';
            form_fileDelete.submit();
        }
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>