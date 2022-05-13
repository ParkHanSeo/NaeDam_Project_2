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
	    하단 관리
	    <small>bottom</small>
	    </h1>
	
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li>메뉴 관리</li>
	        <li class="active">하단 관리</li>
	    </ol>
	</section>
	
	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
	
	                <div class="col-xs-8">
	                <p class="text-light-blue">
	                <i class="fa fa-fw fa-info-circle"></i> 모든 페이지 공통으로 들어가는 하단 카피라이터 입니다.
	                </p>
	                </div>
	
	                <div class="col-xs-4" style="padding-bottom:5px">
	                <div class="btn-group pull-right">
	      <button type="button" id="locale_ko" onclick="setLocale('ko')" class="btn btn-primary"><i class="fa fa-globe" aria-hidden="true"></i> 한국어</button>      <button type="button" id="locale_en" onclick="setLocale('en')" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> ENG</button>      <button type="button" id="locale_zh" onclick="setLocale('zh')" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> 中国</button>      <button type="button" id="locale_vn" onclick="setLocale('vn')" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> Tiếng việt</button>                </div>
	                </div>
	
	                <table class="table table-bordered">
	                <form name="form_register" method="post" action="/admin/bottom/updateBottom?${_csrf.parameterName}=${_csrf.token}">
	                <input type="hidden" name="mode" value="makeBottom">
	                <input type="hidden" name="locale" value="ko">
	                <tbody><tr>
	                    <td>
	                    	<textarea name="content" id="content-editor" rows="10" cols="80" "></textarea>
	                    </td>
	                </tr>
	                
	                </tbody>
	                </table>
	                </form>
	
	                <br>
	                <div align="center">
	                    <button type="button" onclick="register();" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 확인</button>
	                     
	                </div>
	
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section>
	
	<div class="modal fade" id="modalCopyFooter" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:400px;">
	        <div class="modal-content">
	            <form name="formCopyFooter" method="post" action="?tpf=admin/menu/process">
	            <input type="hidden" name="mode" id="mode" value="copyFooter">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabelPortfolio">푸터 복사</h4>
	            </div>
	            <div class="modal-body">
	
	            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 푸터 <span id="board_sub_title">복사</span></p></h4>
	            <table class="table table-bordered">
	            <tbody><tr>
	                <td class="menu">언어</td>
	                <td align="left">
	                <select name="menu_locale" id="menu_locale" class="form-control input-sm">
	                    <option value="">선택</option>
	      <option value="en">ENG</option>      <option value="zh">中国</option>      <option value="vn">Tiếng việt</option>                </select>
	                </td>
	            </tr>
	            </tbody></table>
	            </div>
	
	            <div class="modal-footer">
	                <button type="button" onclick="registerCopyFooter()" class="btn btn-primary">확인</button>                  
	            </div>
	            </form>
	        </div>
	    </div>
	</div>
	
	<script src="//mir9.co.kr/resource/js/ckeditor4.7.2/ckeditor.js"></script>
</div><!-- /.content-wrapper -->
	
	
	
	
<script>
        if (window.CKEDITOR) {  // CKEDITOR loading 여부 체크 (Web 버젼에서만 사용)
            var objEditor = CKEDITOR.replace('content-editor', {
                height: 400,
                extraPlugins : 'tableresize',
                extraPlugins: 'codemirror',
                removeButtons: 'Source',
                filebrowserUploadUrl: '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
                filebrowserImageUploadUrl: '/daemon/ckeditor_upload.php?command=QuickUpload&type=Images',
                contentsCss : ['/html/css/common.css','/html/css/style.css']
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
            CKEDITOR.config.startupMode = 'source';
            CKEDITOR.config.codemirror = {
                // Set this to the theme you wish to use (codemirror themes)
                theme: '3024-night',
                // Whether or not to automatically format code should be done when the editor is loaded
                autoFormatOnStart: false
            };
        }
        function register() {
            if (objEditor.getData().length < 1) {
                alert('내용이 입력되지 않았습니다.');
                objEditor.focus();
                return false;
            }
            form_register.target = 'iframe_process';
            alert("하단 정보가 수정 되었습니다.")
            form_register.submit();
        }
        function setData() {
            // 정보
            $.ajax({
            	url:'/admin/bottom/json/getBottom?${_csrf.parameterName}=${_csrf.token}',
                type:'post',
                dataType:'json',
                data:{
                    method : 'menu.getBottom',
                    locale : $('[name=locale]').val()
                },
                success:function(data, textStatus, jqXHR){
                	
                    var json_data = data;
                    // console.log(json_data.content[$('[name=locale]').val()]);
                    if (json_data.content[$('[name=locale]').val()] != null) var content = json_data.content[$('[name=locale]').val()];
                    else var content = '';

                    setTimeout(function(){
                        objEditor.setData('\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n');
                    }, 200);
                    setTimeout(function(){
                        objEditor.setData(data.content);
                    }, 200);
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
        // 푸터 복사
        function onclickCopyFooter() {
            parent.$('#modalCopyFooter').modal({backdrop:'static', show:true});
        }
        function registerCopyFooter() {
            if(formCopyFooter.menu_locale.value == '') { alert('언어가 선택되지 않았습니다.'); formCopyFooter.menu_locale.focus(); return false;}
            formCopyFooter.target = 'iframe_process';
            formCopyFooter.submit();            
        }
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>