<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
	<jsp:param value="상품 관리" name="title" />
</jsp:include>
<!-- content-wrapper -->
<div class="content-wrapper" style="min-height: 868px;">
	<section class="content-header">
	    <h1>
	    메타 관리
	    <small>meta</small>
	    </h1>
	
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li>메뉴 관리</li>
	        <li class="active">메타 관리</li>
	    </ol>
	</section>
	
	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
	
	                <div class="col-xs-8">
	                <p class="text-light-blue">
	                <i class="fa fa-fw fa-info-circle"></i> 모든 페이지 공통으로 들어가는 메타 태그 입니다.
	                <small> (메뉴 관리에서 각 페이지별로 별도의 메타 태그를 만들수도 있습니다.)</small>
	                </p>
	                </div>
	
	                <div class="col-xs-4" style="padding-bottom:5px">
	                <div class="btn-group pull-right">
	      <button type="button" id="locale_ko" onclick="setLocale('ko')" class="btn btn-primary"><i class="fa fa-globe" aria-hidden="true"></i> 한국어</button>      <button type="button" id="locale_en" onclick="setLocale('en')" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> ENG</button>      <button type="button" id="locale_zh" onclick="setLocale('zh')" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> 中国</button>      <button type="button" id="locale_vn" onclick="setLocale('vn')" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> Tiếng việt</button>                </div>
	                </div>
	
	                <table class="table table-bordered">
	                <form name="form_register" method="post" action="/admin/menu/menuProcess?${_csrf.parameterName}=${_csrf.token}">
	                <input type="hidden" name="mode" value="update">
	                <input type="hidden" name="part" value="meta">
	                <tbody><tr>
	                    <td class="menu">title</td>
	                    <td align="left"><input type="text" name="meta_title" value="" class="form-control input-sm"></td>
	                </tr>
	                <tr>
	                    <td class="menu">description</td>
	                    <td align="left"><input type="text" name="meta_description" value="" class="form-control input-sm"></td>
	                </tr>
	                </form>
	                </tbody></table>
	
	                <br>
	                <div align="center">
	                <button type="button" onclick="register();" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 확인</button>
	                </div>
	
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section>
</div><!-- /.content-wrapper -->


<script>
        function register() {
            if(form_register.meta_title.value == '') { alert('title 값이 입력되지 않았습니다.'); form_register.meta_title.focus(); return false;}
            if(form_register.meta_description.value == '') { alert('description 값이 입력되지 않았습니다.'); form_register.meta_description.focus(); return false;}
            form_register.target = 'iframe_process';
            alert("메타 정보가 수정 되었습니다.")
            form_register.submit();
        }
        function setData() {
            // 정보
            $.ajax({
            	url:'/admin/menu/json/getMeta?${_csrf.parameterName}=${_csrf.token}',
                type:'post',
                dataType:'json',
                data:{
                    method : 'menu.getMeta',
                    locale : $('[name=locale]').val()
                },
                success:function(data, textStatus, jqXHR){
                    var json_data = data;
                    // console.log(json_data);
                    //$('[name=meta_title]').val(json_data.meta_title[$('[name=locale]').val()]);
                    //$('[name=meta_description]').val(json_data.meta_description[$('[name=locale]').val()]);
                    $('[name=meta_title]').val(json_data.meta_title);
                    $('[name=meta_description]').val(json_data.meta_description);
                },
                error:function(jqXHR, textStatus, errorThrown){
                    console.log(textStatus);
                    // $('#content').val(errorThrown);
                }
            });
        }
        function setLocale(locale) {
            $('button[id^=locale_]').attr('class', 'btn btn-default');
            $('#locale_'+locale).attr('class', 'btn btn-primary');
            $('[name=locale]').val(locale);
            setData();
        }
        // 기본 국문 정보 가져오기
        setData();
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>