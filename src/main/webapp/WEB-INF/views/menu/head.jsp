<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="상품 관리" name="title" />
</jsp:include>
<!-- content-wrapper -->
<div class="content-wrapper" style="min-height: 868px;">
	<section class="content-header">
	    <h1>
	    헤더 관리
	    <small>head list</small>
	    </h1>
	
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li><a href="#">메뉴 관리</a></li>
	        <li class="active">헤더 관리</li>
	    </ol>
	</section>
	
	<section class="content">
	    <div class="row">
	        <div class="col-xs-12">
	            <div class="box">
	                <div class="box-body">
	                    <table class="table table-bordered table-hover">
	                    <form name="form_list" method="post" action="?tpf=admin/menu/process"></form>
			            <input type="hidden" name="mode" id="mode">
	                    <thead>
	                    <tr>
	                        <td style="width:30px;"><input type="checkbox" name="select_all" onclick="selectAllCheckBox('form_list');"></td>
	                        <td>헤더명</td>
	                        <td style="width:55px;">상태</td>
	                        <td style="width:60px;">
	                        <i onclick="changeOrder('down','menu_head','?tpf=admin/menu/head');" class="fa fa-fw fa-arrow-circle-down cp" style="cursor:pointer"></i>
	                        <i onclick="changeOrder('up','menu_head','?tpf=admin/menu/head');" class="fa fa-fw fa-arrow-circle-up cp" style="cursor:pointer"></i>
	                        </td>
	                        <td style="width:60px;">명령</td>
	                    </tr>
	                    </thead>
	      <tbody><tr>
	                        <td><input type="checkbox" name="list[]" value="40"></td>
	                        <td>ABOUT</td>
	                        <td><button type="button" class="btn btn-success btn-xs">보임</button></td>
	                        <td><input type="radio" name="order_code" value="1"></td>
	                        <td><button type="button" onclick="onclickUpdate(40);" class="btn btn-primary btn-xs">수정하기</button></td>
	                    </tr>      <tr>
	                        <td><input type="checkbox" name="list[]" value="41"></td>
	                        <td>PRODUCTS</td>
	                        <td><button type="button" class="btn btn-success btn-xs">보임</button></td>
	                        <td><input type="radio" name="order_code" value="2"></td>
	                        <td><button type="button" onclick="onclickUpdate(41);" class="btn btn-primary btn-xs">수정하기</button></td>
	                    </tr>      <tr>
	                        <td><input type="checkbox" name="list[]" value="42"></td>
	                        <td>RnD</td>
	                        <td><button type="button" class="btn btn-success btn-xs">보임</button></td>
	                        <td><input type="radio" name="order_code" value="3"></td>
	                        <td><button type="button" onclick="onclickUpdate(42);" class="btn btn-primary btn-xs">수정하기</button></td>
	                    </tr>      <tr>
	                        <td><input type="checkbox" name="list[]" value="43"></td>
	                        <td>company</td>
	                        <td><button type="button" class="btn btn-success btn-xs">보임</button></td>
	                        <td><input type="radio" name="order_code" value="4"></td>
	                        <td><button type="button" onclick="onclickUpdate(43);" class="btn btn-primary btn-xs">수정하기</button></td>
	                    </tr>      <tr>
	                        <td><input type="checkbox" name="list[]" value="44"></td>
	                        <td>contact</td>
	                        <td><button type="button" class="btn btn-success btn-xs">보임</button></td>
	                        <td><input type="radio" name="order_code" value="5"></td>
	                        <td><button type="button" onclick="onclickUpdate(44);" class="btn btn-primary btn-xs">수정하기</button></td>
	                    </tr>                    
	                    </tbody></table>
	                    <br>
	
	                    <button type="button" onclick="selectDelete('deleteHead');" class="btn btn-danger btn-sm"><i class="fa fa-minus-square" aria-hidden="true"></i> 선택삭제</button>
	                    <button type="button" onclick="onclickInsert();" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 헤더 등록</button>
	                    
	                </div><!-- /.box-body -->
	            </div><!-- /.box -->
	        </div><!-- /.col-xs-12 -->
	    </div><!-- /.row -->
	</section>
	
	<div class="modal fade" id="modalContent" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:90%">
	        <div class="modal-content">
	            <form name="form_register" method="post" onsubmit="return false;" action="?tpf=admin/menu/process">
	            <input type="hidden" name="mode" value="insertHead">
	            <input type="hidden" name="code">
	            <input type="hidden" name="locale" value="ko">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title">헤더 등록</h4>
	            </div>
	            <div class="modal-body">
	            <div class="row">
	                <div class="col-xs-4">
	                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 헤더 등록</p></h4>
	                </div>
	
	                <div class="col-xs-8">
	                <div class="btn-group pull-right">
	      <button type="button" id="locale_ko" onclick="setLocale('ko')" class="btn btn-primary"><i class="fa fa-globe" aria-hidden="true"></i> 한국어</button>      <button type="button" id="locale_en" onclick="setLocale('en')" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> ENG</button>      <button type="button" id="locale_zh" onclick="setLocale('zh')" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> 中国</button>      <button type="button" id="locale_vn" onclick="setLocale('vn')" class="btn btn-default"><i class="fa fa-globe" aria-hidden="true"></i> Tiếng việt</button>                </div>
	                </div>
	            </div>
	
	            <table class="table table-bordered">
	            <tbody><tr>
	                <td class="menu">헤더명</td>
	                <td align="left"><input type="text" name="title" class="form-control input-sm"></td>
	            </tr>
	            <tr>
	                <td class="menu">상태</td>
	                <td>
	                <select name="status" class="form-control input-sm" style="width:100px;">
	      <option value="y">보임</option>      <option value="n">숨김</option>                </select>
	                </td>
	            </tr>
	            <tr>
	                <td colspan="2" style="text-align:left">
	                ※ [menu] : 본 태그를 삽입시 각각의 서브페이지의 메뉴명을 표출 해 줍니다.
	                	<textarea name="content" id="content-editor" rows="10" cols="80" "></textarea>
	                </td>
	            </tr>
	            </tbody></table>
	            
	            </div></form>
	
	            </div>
	            <div class="modal-footer">
	            <button type="button" onclick="register();" class="btn btn-primary">저장하기</button>
	            </div>
	        </div>
	    
	</div>
	
	<div class="modal fade" id="modalCopyHeader" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
	    <div class="modal-dialog" style="width:400px;">
	        <div class="modal-content">
	            <form name="formCopyHeader" method="post" action="?tpf=admin/menu/process">
	            <input type="hidden" name="mode" id="mode" value="copyHeader">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabelPortfolio">헤더 복사</h4>
	            </div>
	            <div class="modal-body">
	
	            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 헤더 <span id="board_sub_title">복사</span></p></h4>
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
	            <button type="button" onclick="registerCopyHeader()" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
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
                height: 500,
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
                autoFormatOnStart: false,
            };
        }
        function setLocale(locale) {
            $('button[id^=locale_]').attr('class', 'btn btn-default');
            $('#locale_'+locale).attr('class', 'btn btn-primary');
            $('[name=locale]').val(locale);
            setData($('[name=code]').val());
        }
        function register() {
            if(form_register.title.value == '') { alert('헤더명이 입력되지 않았습니다.'); form_register.title.focus(); return false;}
            form_register.target = 'iframe_process';
            form_register.submit();
        }
        function setData(code) {
            // 정보
            $.ajax({
                url:'http://demoshop.mir9.kr/api/process.php',
                type:'post',
                dataType:'json',
                data:{
                    method : 'UtilMenu.infoHead',
                    locale : $('[name=locale]').val(),
                    code : code
                },
                success:function(data, textStatus, jqXHR){
                    var json_data = data.data;
                    console.log(json_data);
                    $('[name=mode]').val('updateHead');
                    $('[name=code]').val(code);
                    $('[name=title]').val(json_data.title);
                    $('[name=status]').val(json_data.status);
                    if (json_data.content == null) json_data.content = '';

                    setTimeout(function(){
                        parent.objEditor.setData('\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n');
                    }, 200);
                    setTimeout(function(){
                        parent.objEditor.setData(json_data.content);
                    }, 210);
                },
                error:function(jqXHR, textStatus, errorThrown){
                    console.log(textStatus);
                    // $('#content').val(errorThrown);
                }
            });
        }
        function onclickInsert() {
            $('#modalContent').modal('show');
            form_register.reset();
            form_register.mode.value = 'insertHead';
            $('input:radio[name=icon_code]').attr('checked', false);
            objEditor.setData('');

            setTimeout(function(){
                parent.objEditor.setData('\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n');
            }, 200);
            setTimeout(function(){
                parent.objEditor.setData('');
            }, 210);
        }
        function onclickUpdate(code) {
            $('#modalContent').modal({backdrop:'static', show:true});
            setData(code);
        }
        // 헤더 복사
        function onclickCopyHeader() {
            parent.$('#modalCopyHeader').modal({backdrop:'static', show:true});
        }
        function registerCopyHeader() {
            if(formCopyHeader.menu_locale.value == '') { alert('언어가 선택되지 않았습니다.'); formCopyHeader.menu_locale.focus(); return false;}
            formCopyHeader.target = 'iframe_process';
            formCopyHeader.submit();            
        }
</script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>