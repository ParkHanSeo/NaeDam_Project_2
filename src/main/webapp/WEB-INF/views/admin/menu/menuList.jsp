<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AdminLTE 2 | list_sub</title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/dist/css/AdminLTE.min.css">
<link href="//mir9.co.kr/resource/css/admin.css" rel="stylesheet" type="text/css" />
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<!-- Google Font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<style>
.modal-open {
    overflow: hidden;
}
</style>
<body class="hold-transition login-page">
<!-- content-wrapper -->
<iframe name="iframe_process" width="0" height="0" frameborder="0"></iframe>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <p class="text-light-blue"><i class="fa fa-fw fa-list-ul"></i> <a href="?tpf=admin/menu/list_sub&amp;print_data_count=9999">ROOT</a> </p>

                    <table class="table table-bordered table-hover">
	                    <form name="form_list" method="post" action="?tpf=admin/menu/process"></form>
			            <input type="hidden" name="mode" id="mode">
			            <input type="hidden" name="code" id="ordCode" value="${menu.code}">
	                    <thead>
		                    <tr>
		                        <td style="width:30px;">
		                      		<div class="allCheck">
										<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck"></label>
											<script>
												$("#allCheck").click(function() {
													var chk = $("#allCheck").prop("checked");
													if (chk) {
														$('.code').prop("checked", true);
													} else {
														$('.code').prop("checked", false);
													}
												});
											</script>
									</div>
		                        </td>
		                        <td>메뉴명</td>
		                        <td>url</td>
		                        <td style="width:55px;">상태</td>
		                        <td style="width:60px;">
		                            <i onclick="changeOrder('down','menu','?tpf=admin/menu/list_sub&amp;category_code=','');" class="fa fa-fw fa-arrow-circle-down cp" style="cursor:pointer"></i>
		                            <i onclick="changeOrder('up','menu','?tpf=admin/menu/list_sub&amp;category_code=','');" class="fa fa-fw fa-arrow-circle-up cp" style="cursor:pointer"></i>
		                        </td>
		                        <td style="width:220px;">명령</td>
		                    </tr>
	                    </thead>
	      				<c:if test="${list != null || list != ''}">
	      				<tbody>
	      				  <c:forEach var="menu" items="${list}">
		      				<tr>
		      					<input type="hidden" name="code" value="">
		                        <td>
			                        <div>
			                        	<input type="checkbox" class="code" name="code"  value="${menu.code}" />
			                        	<script>
											$(".code").click(function() {
												$("#allCheck").prop("checked", false);
											});
										</script>
									</div>
		                        </td>
		                        <td style="font-weight:bold;">${menu.title}</td>
		                        <td align="left" style="font-weight:bold;">${menu.url}</td>
		                        <td>
		                        	<c:if test="${menu.status == 'y'}">
		                        		<button type="button" class="btn btn-success btn-xs">보임</button>
		                        	</c:if>
		                        	<c:if test="${menu.status == 'n'}">
		                        		<button type="button" class="btn btn-success btn-xs">숨김</button>
		                        	</c:if>		                        	
		                        </td>
		                        <td>
		                        	<input type="radio" name="order_code" value="1" disabled="">
		                        </td>
		                        <td>
		                            <button type="button" onclick="onclickRevision(${menu.code});" class="btn btn-warning btn-xs">리비젼보기</button>
		                            <button type="button" onclick="onclickView('${menu.url}');" class="btn btn-success btn-xs">바로가기</button>
		                            <button type="button" onclick="onclickUpdate(${menu.code});" class="btn btn-primary btn-xs">수정하기</button>
		                        </td>
		                    </tr>			                
		                   </c:forEach>               
	                    </tbody>   
	                    </c:if>
	      				<c:if test="${list[0] == null || list[0] == ''}">	                     
						<tbody>		                    
		                    <tr>
			                	<td colspan="10"><br>등록된 자료가 없습니다.<br><br>
			                	</td>
			                </tr>
			            </tbody>
			            </c:if>                 
                    </table>
                    <br>

                    <button type="button" onclick="updateChoiceMenu();" class="btn btn-danger btn-sm"><i class="fa fa-minus-square" aria-hidden="true"></i> 선택삭제</button>
                    <button type="button" onclick="onclickInsert(${menu.code}, ${menu.ord});" class="btn btn-primary btn-sm"><i class="fa fa-plus-square"></i> 메뉴 등록</button>
                    <div style="float:right; margin-right:12px;">
                        <button type="button" onclick="onclickRevision2();" class="btn btn-warning btn-sm"><i class="fa fa-minus-square"></i> 삭제 리비젼보기</button>
                    </div>
                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>


<!-- jQuery 3 -->
<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/common.js" type="text/javascript" charset="utf-8"></script>

<script>
        function onclickView(full_url) {
            window.open('/'+full_url, '_blank');
        }
        function onclickInsert(code, ord) {
        	
            parent.$('#modalContent').modal({backdrop:'static', show:true});
            parent.form_register.reset();
            parent.$('#displayMeta').hide();
            parent.objEditor.setData('');
            parent.is_revision = false;
            parent.form_register.mode.value = 'insertMenu';
            //parent.form_register.category_code.value = '';
            parent.$('input:radio[name=icon_code]').attr('checked', false);
            parent.$('#previewLink').hide();
            parent.$('#displayButton').html('저장하기');
            parent.$('input[id="originCode"]').val(code)
            parent.$('input[id="ordCode"]').val(ord)
            
            setTimeout(function(){
                parent.objEditor.setData('\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n');
            }, 200);
            setTimeout(function(){
                parent.objEditor.setData('');
            }, 210);
        }
        function onclickUpdate(code) {
            parent.$('#modalContent2').modal({backdrop:'static', show:true});
            parent.is_revision = false;
            parent.setData(code);
            parent.$('#previewLink').show();
        }
        function onclickRevision(code) {
            parent.$('#modalRevision').modal({backdrop:'static', show:true});
            $.ajax({
                url:'/admin/menu/json/getRevisionList?${_csrf.parameterName}=${_csrf.token}',
                type:'post',
                dataType:'json',
                data:{
                    method : 'menu.getRevisionList',
                    locale : parent.$('[name=locale]').val(),
                    code : code
                },
                success:function(data, textStatus, jqXHR){
                    var json_data = data;
                    var html_tag = '';
                    html_tag += '<table class="table table-bordered">';
                    html_tag += '<tr>';
                    html_tag += '   <td class="menu">리비젼명</td>';
                    html_tag += '   <td class="menu">날짜</td>';
                    html_tag += '   <td class="menu">명령</td>';
                    html_tag += '</tr>';

                    console.log(json_data.list.length)
                    if (json_data.list != null) {
                        parent.$('#revisionTitle').html(json_data.title);
                        $.each(json_data.list, function(index, value) {
                            html_tag += '<tr>';
                            html_tag += '   <td>'+value['title']+'</td>';
                            html_tag += '   <td>'+value['menuDate']+'</td>';
                            html_tag += '   <td>';
                            html_tag += '   <button type="button" onclick="infoRevision('+value['code']+');" class="btn btn-warning btn-xs">보기</button>';
                            html_tag += '   <button type="button" onclick="deleteRevision('+value['code']+',this);" class="btn btn-danger btn-xs">삭제</button>';
                            html_tag += '   </td>';
                            html_tag += '</tr>';
                        });
                    }
                    if(json_data.list.length == 0){
                        parent.$('#revisionTitle').html('');
                        html_tag += '<tr>';
                        html_tag += '   <td colspan="3">등록된 자료가 없습니다.</td>';
                        html_tag += '</tr>';
                    }
                    html_tag += '</table>';
                    parent.$('#htmlTag').html(html_tag);
                },
                error:function(jqXHR, textStatus, errorThrown){
                    console.log(textStatus);
                    // $('#content').val(errorThrown);
                }
            });
        }
        function onclickRevision2() {
            parent.$('#modalRevision').modal({backdrop:'static', show:true});
            $.ajax({
                url:'/admin/menu/json/deleteRevisionList?${_csrf.parameterName}=${_csrf.token}',
                type:'post',
                dataType:'json',
                data:{
                    method : 'menu.deleteRevisionList',
                    locale : parent.$('[name=locale]').val(),
                },
                success:function(data, textStatus, jqXHR){
                    var json_data = data;
                    var html_tag = '';
                    html_tag += '<table class="table table-bordered">';
                    html_tag += '<tr>';
                    html_tag += '   <td class="menu">리비젼명</td>';
                    html_tag += '   <td class="menu">날짜</td>';
                    html_tag += '   <td class="menu">명령</td>';
                    html_tag += '</tr>';

                    console.log(json_data.list.length)
                    if (json_data.list != null) {
                        parent.$('#revisionTitle').html(json_data.title);
                        $.each(json_data.list, function(index, value) {
                        	console.log(value)
                            html_tag += '<tr>';
                            html_tag += '   <td>'+value['title']+'</td>';
                            html_tag += '   <td>'+value['menuDate']+'</td>';
                            html_tag += '   <td>';
                            html_tag += '   <button type="button" onclick="infoRevision('+value['code']+','+value['revision_code']+');" class="btn btn-warning btn-xs">보기</button>';
                            html_tag += '   <button type="button" onclick="deleteRevision('+value['code']+',this);" class="btn btn-danger btn-xs">삭제</button>';
                            html_tag += '   </td>';
                            html_tag += '</tr>';
                        });
                    }
                    if(json_data.list.length == 0){
                        parent.$('#revisionTitle').html('');
                        html_tag += '<tr>';
                        html_tag += '   <td colspan="3">등록된 자료가 없습니다.</td>';
                        html_tag += '</tr>';
                    }
                    html_tag += '</table>';
                    parent.$('#htmlTag').html(html_tag);
                },
                error:function(jqXHR, textStatus, errorThrown){
                    console.log(textStatus);
                    // $('#content').val(errorThrown);
                }
            });
        }
        // 메뉴 복사
        function onclickCopyMenu() {
            parent.$('#modalCopyMenu').modal({backdrop:'static', show:true});
        }
        
        function updateChoiceMenu(code){
        	
        	var menuArr = new Array();
        	
			$("input[class='code']:checked").each(function(){
				menuArr.push($(this).val());
 			});
			
			if(!confirm("해당 자료를 정말 삭제 하시겠습니까?")){
				alert("취소 되었습니다.");
				return;
				
			}else{
	  		$.ajax({
  			 	 url : "/admin/menu/updateChoiceMenu?${_csrf.parameterName}=${_csrf.token}",
	  		  	 type : "POST",
  		  	 	 data : { 
  		  	 		menuArr : menuArr 
  		  	 	 },
    		 	 success : function(result){
    		 		
  		  	 	 }
  		  	 	 
	  		});		
				alert("해당 자료가 삭제 되었습니다.")
				$('#iframe_tree').attr('src', '${pageContext.request.contextPath}/menu/tree');
				$('#iframe_list').attr('src', '${pageContext.request.contextPath}/menu/menuList');
			}
        }
        
        
        
</script>

</body>
</html>





