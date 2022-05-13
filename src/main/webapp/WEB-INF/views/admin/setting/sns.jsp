<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="SNS연동 설정" name="title"/>
</jsp:include>

<!-- content-wrapper -->
<div class="content-wrapper" style="min-height: 1015.14px;">
<section class="content-header">
    <h1>
    SNS연동 설정
    <small>sns integration</small>
    </h1>

    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li>설정</li>
        <li class="active">SNS연동 설정</li>
    </ol>
</section>

<section class="content">
<div class="row">
    <div class="col-xs-12">
        <div class="box">
            <div class="box-body">
                <form name="form_register" method="post" action="/admin/setting/updateSnsSetting?${_csrf.parameterName}=${_csrf.token}">
                <input type="hidden" name="mode" value="updateSNS">

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 비회원 로그인</p></h4>
                <table class="table table-bordered">
                <tbody>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    <input type="radio" name="noneMemberUse" value="y" <c:if test="${snsSetting.noneMemberUse == 'y'}">checked="checked"</c:if>>사용&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="noneMemberUse" value="n" <c:if test="${snsSetting.noneMemberUse == 'n'}">checked="checked"</c:if>>사용안함
                    </td>
                </tr>
                </tbody>
                </table>

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 카카오 계정 로그인</p></h4>
                <table class="table table-bordered">
                <tbody>
                <tr>
                    <td class="menu">카카오 가입/인증</td>
                    <td align="left">
                    <a href="https://developers.kakao.com" target="_blank">카카오 가입/인증하기</a>&nbsp;&nbsp;
                    (승인된 리디렉션 URI &nbsp; : &nbsp; http://홈페이지주소/member/callback_kakao.php)
                    </td>
                </tr>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    	<input type="radio" name="kakaoUse" value="y" onchange="checkUse(this.value);" <c:if test="${snsSetting.kakaoUse == 'y'}">checked="checked"</c:if>>사용&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="radio" name="kakaoUse" value="n" onchange="checkUse(this.value);" <c:if test="${snsSetting.kakaoUse == 'n'}">checked="checked"</c:if>>사용안함
                    </td>
                </tr>
                <tr id="display_kakao" style="">
                    <td class="menu">REST API Key</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="kakaoSnsKey" value="${snsSetting.kakaoSnsKey}" class="form-control input-sm" style="width:500px;"></span>
                    </td>
                </tr>
                </tbody>
                </table>

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 네이버 로그인</p></h4>
                <table class="table table-bordered">
                <tbody>
                <tr>
                    <td class="menu">네이버 가입/인증</td>
                    <td align="left">
                    <a href="https://developers.naver.com" target="_blank">네이버 가입/인증하기</a>&nbsp;&nbsp;
                    (승인된 리디렉션 URI &nbsp; : &nbsp; http://홈페이지주소/member/callback_naver.php)
                    </td>
                </tr>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    <input type="radio" name="naverUse" value="y" onchange="checkUse(this.value);" <c:if test="${snsSetting.naverUse == 'y'}">checked="checked"</c:if>>사용&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="naverUse" value="n" onchange="checkUse(this.value);" <c:if test="${snsSetting.naverUse == 'n'}">checked="checked"</c:if>>사용안함
                    </td>
                </tr>
                <tr id="display_naver" style="">
                    <td class="menu">Client ID</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="naverSnsId" value="${snsSetting.naverSnsId}" class="form-control input-sm" style="width:500px;"></span>
                    </td>
                </tr>
                <tr id="display_naver1" style="">
                    <td class="menu">Client Secret</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="naverSnsKey" value="${snsSetting.naverSnsKey}" class="form-control input-sm" style="width:500px;"></span>
                    </td>
                </tr>
                </tbody>
                </table>

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 구글 로그인</p></h4>
                <table class="table table-bordered">
                <tbody>
                <tr>
                    <td class="menu">구글 가입/인증</td>
                    <td align="left">
                    <a href="https://console.developers.google.com" target="_blank">구글 가입/인증하기</a>&nbsp;&nbsp;
                    (승인된 리디렉션 URI &nbsp; : &nbsp; http://홈페이지주소/member/callback_google.php)
                    </td>
                </tr>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    <input type="radio" name="googleUse" value="y" onchange="checkUse(this.value);" <c:if test="${snsSetting.googleUse == 'y'}">checked="checked"</c:if>>사용&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="googleUse" value="n" onchange="checkUse(this.value);" <c:if test="${snsSetting.googleUse == 'n'}">checked="checked"</c:if>>사용안함
                    </td>
                </tr>
                <tr id="display_google" style="">
                    <td class="menu">Client ID</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="googleSnsId" value="${snsSetting.googleSnsId}" class="form-control input-sm" style="width:500px;"></span>
                    </td>
                </tr>
                <tr id="display_google1" style="">
                    <td class="menu">Client Secret</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="googleSnsKey" value="${snsSetting.googleSnsKey}" class="form-control input-sm" style="width:500px;"></span>
                    </td>
                </tr>
                </tbody>
                </table>

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 페이스북 로그인</p></h4>
                <table class="table table-bordered">
                <tbody>
                <tr>
                    <td class="menu">페이스북 가입/인증</td>
                    <td align="left">
                    <a href="https://developers.facebook.com" target="_blank">페이스북 가입/인증하기</a>&nbsp;&nbsp;
                    (승인된 리디렉션 URI &nbsp; : &nbsp; http://홈페이지주소/member/callback_facebook.php)
                    </td>
                </tr>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    <input type="radio" name="facebookUse" value="y" onchange="checkUse(this.value);" <c:if test="${snsSetting.facebookUse == 'y'}">checked="checked"</c:if>>사용&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="facebookUse" value="n" onchange="checkUse(this.value);" <c:if test="${snsSetting.facebookUse == 'n'}">checked="checked"</c:if>>사용안함
                    </td>
                </tr>
                <tr id="display_facebook" style="">
                    <td class="menu">App ID</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="facebookSnsId" value="${snsSetting.facebookSnsId}" class="form-control input-sm" style="width:500px;"></span>
                    </td>
                </tr>
                <tr id="display_facebook1" style="">
                    <td class="menu">App Secret</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="facebookSnsKey" value="${snsSetting.facebookSnsKey}" class="form-control input-sm" style="width:500px;"></span>
                    </td>
                </tr>
                </tbody>
                </table>

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 트위터 로그인</p></h4>
                <table class="table table-bordered">
                <tbody>
                <tr>
                    <td class="menu">트위터 가입/인증</td>
                    <td align="left">
                    <a href="https://apps.twitter.com/" target="_blank">트위터 가입/인증하기</a>&nbsp;&nbsp;
                    (승인된 리디렉션 URI &nbsp; : &nbsp; http://홈페이지주소/member/callback_twitter.php)
                    </td>
                </tr>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    <input type="radio" name="twitterUse" value="y" onchange="checkUse(this.value);" <c:if test="${snsSetting.twitterUse == 'y'}">checked="checked"</c:if>>사용&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="twitterUse" value="n" onchange="checkUse(this.value);" <c:if test="${snsSetting.twitterUse == 'n'}">checked="checked"</c:if>>사용안함
                    </td>
                </tr>
                <tr id="display_twitter" style="">
                    <td class="menu">API key</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="twitterSnsId" value="${snsSetting.twitterSnsId}" class="form-control input-sm" style="width:500px;"></span>
                    </td>
                </tr>
                <tr id="display_twitter1" style="">
                    <td class="menu">API secret key</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="twitterSnsKey" value="${snsSetting.twitterSnsKey}" class="form-control input-sm" style="width:500px;"></span>
                    </td>
                </tr>
                </tbody>
                </table>

                <div style="text-align:center; padding:20px 0px 0 0px"><button type="button" onclick="register()" class="btn btn-primary">확인</button></div>
                </form>

                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>
</div><!-- /.content-wrapper -->

<script>
		function checkUse() {

            var form = document.form_register;
			if (form.kakaoUse[0].checked == true) {
				$('#display_kakao').show();
            }else if (form.kakaoUse[1].checked == true) {
				$('#display_kakao').hide();
			}

			if (form.naverUse[0].checked == true) {
				$('#display_naver').show();
				$('#display_naver1').show();
            }else if (form.naverUse[1].checked == true) {
				$('#display_naver').hide();
				$('#display_naver1').hide();
			}

			if (form.googleUse[0].checked == true) {
				$('#display_google').show();
				$('#display_google1').show();
            }else if (form.googleUse[1].checked == true) {
				$('#display_google').hide();
				$('#display_google1').hide();
			}

			if (form.facebookUse[0].checked == true) {
				$('#display_facebook').show();
				$('#display_facebook1').show();
            }else if (form.facebookUse[1].checked == true) {
				$('#display_facebook').hide();
				$('#display_facebook1').hide();
			}

			if (form.twitterUse[0].checked == true) {
				$('#display_twitter').show();
				$('#display_twitter1').show();
            }else if (form.twitterUse[1].checked == true) {
				$('#display_twitter').hide();
				$('#display_twitter1').hide();
			}
		}

        function register() {
            form_register.target = 'iframe_process';
            alert("SNS연동 설정이 수정 되었습니다.");
            form_register.submit();
        }

        $(document).ready(function(){
            checkUse();
        });
        
</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>