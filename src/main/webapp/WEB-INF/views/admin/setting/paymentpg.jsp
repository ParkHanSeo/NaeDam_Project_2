<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="결제 PG 설정" name="title"/>
</jsp:include>


<!-- content-wrapper -->
<div class="content-wrapper">
<section class="content-header">
    <h1>
    결제PG 설정
    <small>Billing PG</small>
    </h1>

    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li>설정</li>
        <li class="active">결제PG 설정</li>
    </ol>
</section>

<section class="content">
<div class="row">
    <div class="col-xs-12">
        <div class="box">
            <div class="box-body">
                <form:form name="form_register" method="post" action="${pageContext.request.contextPath }/admin/setting/updatePaymentPG">
                <input type="hidden" name="method" value="updatePaymentPG">
					<input type="hidden" name="moduleVersionIni" value="" />
					<input type="hidden" name="moduleVersionXpay" value="" />
					<input type="hidden" name="moduleVersionKcp" value="" />
					<input type="hidden" name="tsvUrl" value="${naverShopping.tsvUrl == null ? '' : naverShopping.tsvUrl }" />
					<input type="hidden" name="productDbUrl" value="${naverShopping.productDbUrl == null ? '' : naverShopping.productDbUrl }" />

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 기본 설정</p></h4>
                <table class="table table-bordered">
                <tbody>
                <tr>
                    <td class="menu">국내/해외 여부</td>
                    <td align="left">
                    <input type="checkbox" name="isDomestic" value='Y' onchange="checkGubun(this.value);" ${pg.isDomestic == 'Y' ? 'checked' : '' }>국내&nbsp;&nbsp;
                    <input type="checkbox" name="isForeigne" value='Y' onchange="checkGubun(this.value);" ${pg.isForeigne == 'Y' ? 'checked' : '' }>해외
                    </td>
                </tr>
                <tr id="display_pg" style="display:none;">
                    <td class="menu">국내 카드PG사</td>
                    <td align="left">
                    <input type="radio" name="cardPg" value="ini" onchange="checkCardPGType(this.value);" ${pg.cardPg == 'ini' ? 'checked' : '' }>KG 이니시스&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="cardPg" value="xpay" onchange="checkCardPGType(this.value);" ${pg.cardPg == 'xpay' ? 'checked' : '' }>LG 유플러스&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="cardPg" value="kcp" onchange="checkCardPGType(this.value);" ${pg.cardPg == 'kcp' ? 'checked' : '' }>NHN KCP
                    </td>
                </tr>
				<tr id="display_ease_pg" style="display:none;">
                    <td class="menu">국내 간편결제</td>
                    <td align="left">
                    <input type="checkbox" name="naverpayUse" id="naverpay_use" value='Y' onchange="checkEasyPGNaver(this.checked);" ${pg.naverpayUse == 'Y' ? 'checked' : '' }> <label for="naverpay_use">네이버페이</label> &nbsp;&nbsp;
					<!-- <input type="checkbox" name="kakaopay_use" id="kakaopay_use" value='y' onchange="checkEasyPGKakao(this.checked);"> <label for="kakaopay_use">카카오페이</label> &nbsp;&nbsp; -->
                    </td>
                </tr>
                </tbody>
                </table>
                <br>
                
                <span id="display_ini_title" style="display:none;"><h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> KG 이니시스 일반결제 설정</p></h4></span>
                <table class="table table-bordered" id="display_ini" style="display:none;">
                <tbody>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    <input type="checkbox" name="useIni" value='Y' >사용함
                    </td>
                </tr>
                <tr>
                    <td class="menu">PG사 모듈 버전</td>
                    <td align="left" id="module_version_ini"></td>
                </tr>
                <tr>
                    <td class="menu">결제수단 설정</td>
                    <td align="left">
	                    <input type="checkbox" name="useCreditIni" value='Y'>신용카드&nbsp;&nbsp;
	                    <input type="checkbox" name="useBankIni" value='Y'>계좌이체&nbsp;&nbsp;
	                    <input type="checkbox" name="useVBankIni" value='Y'>가상계좌
                    </td>
                </tr>
                <tr>
                    <td class="menu">사용 모드</td>
                    <td align="left">
                        <input class="pgMode" type="radio" id="pg_mode1_ini" name="pgModeIni" value="1">TEST 모드&nbsp;&nbsp;&nbsp;&nbsp;
                        <input class="pgMode" type="radio" id="pg_mode2_ini" name="pgModeIni" value="2">REAL 모드
                    </td>
                </tr>
                <tr>
                    <td class="menu">상점 ID</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="storeIdIni" value="" class="form-control input-sm" style="width:300px;"></span>
                    </td>
                </tr>
                <tr>
                    <td class="menu">Sign Key</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="signKey" value="" class="form-control input-sm" style="width:300px;"></span>
                    </td>
                </tr>
                <tr>
                    <td class="menu">Upload Key File</td>
                    <td align="left">
                        <span style="float:left;"> <input type="file" name="file1" class="form-control input-sm" style="width:100%; display:inline;"></span>
                        <span style="line-height:2.0;"><small class="text-black"> &nbsp;&nbsp;압축파일 형식(zip)의 Key File을 업로드해 주세요. </small></span>
                    </td>
                </tr>
                </tbody>
                </table>

                <span id="display_xpay_title" style="display:none;"><h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> LG 유플러스 일반결제 설정</p></h4></span>
                <table class="table table-bordered" id="display_xpay" style="display:none;">
                <tbody>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    <input type="checkbox" name="useXpay" value='Y'>사용함
                    </td>
                </tr>
                <tr>
                    <td class="menu">PG사 모듈 버전</td>
                    <td align="left" id="module_version_xpay"></td>
                </tr>
                <tr>
                    <td class="menu">결제수단 설정</td>
                    <td align="left">
                    <input type="checkbox" name="useCreditXpay" value='Y'>신용카드&nbsp;&nbsp;
                    <input type="checkbox" name="useBankXpay" value='Y'>계좌이체&nbsp;&nbsp;
                    <input type="checkbox" name="useVBankXpay" value='Y'>가상계좌
                    </td>
                </tr>
                <tr>
                    <td class="menu">사용 모드</td>
                    <td align="left">

                        <input type="radio" class="pgMode" id="pg_mode1_xpay" name="pgModeXpay" value="1" >TEST 모드&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" class="pgMode" id="pg_mode2_xpay" name="pgModeXpay" value="2" >REAL 모드
                    </td>
                </tr>
                <tr>
                    <td class="menu">LG 유플러스 상점 ID</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" id="storeIdXpay" name="storeId" value="INIpayTest" class="form-control input-sm" style="width:300px;"></span>
                    </td>
                </tr>
                <tr>
                    <td class="menu">LG 유플러스 mertkey</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="mertKey" value="SU5JTElURV9UUklQTEVERVNfS0VZU1RS" class="form-control input-sm" style="width:300px;"></span>
                    </td>
                </tr>
                </tbody>
                </table>

                <span id="display_kcp_title" style="display:none;"><h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> NHN KCP 일반결제 설정</p></h4></span>
                <table class="table table-bordered" id="display_kcp" style="display:none;">
                <tbody>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    <input type="checkbox" name="useKcp" value='Y'>사용함
                    </td>
                </tr>
                <tr>
                    <td class="menu">PG사 모듈 버전</td>
                    <td align="left" id="module_version_kcp"></td>
                </tr>
                <tr>
                    <td class="menu">결제수단 설정</td>
                    <td align="left">
                    <input type="checkbox" name="useCreditKcp" value='Y'>신용카드&nbsp;&nbsp;
                    <input type="checkbox" name="useBankKcp" value='Y'>계좌이체&nbsp;&nbsp;
                    <input type="checkbox" name="useVBankKcp" value='Y'>가상계좌
                    </td>
                </tr>
                <tr>
                    <td class="menu">사용 모드</td>
                    <td align="left">
                        <input type="radio" class="pgMode" id="pg_mode1_kcp" name="pgModeKcp" value="1" >TEST 모드&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" class="pgMode" id="pg_mode2_kcp" name="pgModeKcp" value="2" >REAL 모드
                    </td>
                </tr>
                <tr>
                    <td class="menu">사이트코드(site_cd)</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="siteCd" value="" class="form-control input-sm" style="width:300px;"></span>
                    </td>
                </tr>
                <tr>
                    <td class="menu">사이트키(site_key)</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="siteKey" value="" class="form-control input-sm" style="width:300px;"></span>
                    </td>
                </tr>
                </tbody>
                </table>

				<span id="display_naverpay_title" style="display:none;"><h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 네이버페이 설정</p></h4></span>
                <table class="table table-bordered" id="display_naverpay" style="display:none;">
                <tbody>
                <tr>
                    <td class="menu">가맹점 ID</td>
                    <td align="left">
                        <input type="text" name="storeIdNaver" value="" class="form-control input-sm" style="width:300px;" />
						<a href="https://admin.pay.naver.com/" target="_blank">네이버페이 센터 바로가기 &gt;</a>
                    </td>
                </tr>
                <tr>
                    <td class="menu">가맹점 인증키</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="storeKeyNaver" value="" class="form-control input-sm" style="width:300px;" /></span>
                    </td>
                </tr>
				<tr>
                    <td class="menu">버튼 인증키</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="btnKey" value="" class="form-control input-sm" style="width:300px;" /></span>
                    </td>
                </tr>
				<tr>
                    <td class="menu">사용 모드</td>
                    <td align="left">
                        <input type="radio" name="pgModeNaver" id="naverpay_mode1" value="1" > <label for="naverpay_mode1">TEST 모드</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="pgModeNaver" id="naverpay_mode2" value="2" > <label for="naverpay_mode2">REAL 모드</label>
                    </td>
                </tr>
				</tbody>
                </table>

				<span id="display_kakaopay_title" style="display:none;"><h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 카카오페이 설정</p></h4></span>
                <table class="table table-bordered" id="display_kakaopay" style="display:none;">
                <tbody>
                <tr>
                    <td class="menu">가맹점 ID</td>
                    <td align="left">
                        <input type="text" name="kakaopay_cid" value="" class="form-control input-sm" style="width:300px;" />
						<a href="https://with.kakao.com/kakaopay/index" target="_blank">카카오페이 제휴신청 바로가기 &gt;</a><br />
						<a href="https://pg.kakao.com/" target="_blank">카카오페이 파트너 어드민 바로가기 &gt;</a>
                    </td>
                </tr>
                <tr>
                    <td class="menu">가맹점 인증키</td>
                    <td align="left">
                        <input type="text" name="kakaopay_apikey" value="" class="form-control input-sm" style="width:300px;" />

                    </td>
                </tr>
				<tr>
                    <td class="menu">사용 모드</td>
                    <td align="left">
                        <input type="radio" name="kakaopay_mode" id="kakaopay_mode1" value="t"  checked=checked> <label for="kakaopay_mode1">TEST 모드</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="kakaopay_mode" id="kakaopay_mode2" value="s" > <label for="kakaopay_mode2">REAL 모드</label>
                    </td>
                </tr>
				</tbody>
                </table>

                <span id="display_exim_title" style="display:none;"><h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> EXIMBAY 설정(해외결제)</p></h4></span>
                <table class="table table-bordered" id="display_exim" style="display:none;">
                <tbody>
                <tr>
                    <td class="menu">사용 여부</td>
                    <td align="left">
                    <input type="checkbox" name="useEximbay" value='Y' >사용함
                    </td>
                </tr>
                <tr>
                    <td class="menu">PG사 모듈 버전</td>
                    <td id="module_version_eximbay" align="left"></td>
                </tr>
                <tr>
                    <td class="menu">결제수단 설정</td>
                    <td align="left">
                    <input type="checkbox" name="useCreditEximbay" value='Y' >CreditCard&nbsp;&nbsp;
                    <input type="checkbox" name="usePaypal" value='Y'>Paypal&nbsp;&nbsp;
                    <input type="checkbox" name="useUnion" value='Y' >UnionPay&nbsp;&nbsp;
                    <input type="checkbox" name="useAli" value='Y' >Alipay
                    </td>
                </tr>
                <tr>
                    <td class="menu">사용 모드</td>
                    <td align="left">
                        <input type="radio" id="pg_mode1_eximbay" name="pgModeEximbay" value="1" >TEST 모드&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" id="pg_mode2_eximbay" name="pgModeEximbay" value="2" >REAL 모드
                    </td>
                </tr>
                <tr>
                    <td class="menu">mid</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="mid" value="" class="form-control input-sm" style="width:300px;"></span>
                    </td>
                </tr>
                <tr>
                    <td class="menu">Secret Key</td>
                    <td align="left">
                        <span style="float:left;"><input type="text" name="secretKey" value="" class="form-control input-sm" style="width:300px;"></span>
                    </td>
                </tr>
                </tbody>
                </table>

                <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 네이버 쇼핑 연동</p></h4>
                <table class="table table-bordered">
                <tbody>
                <tr>
                    <td class="menu">tsv파일 실행주소</td>
                    <td align="left">
                    ${naverShopping.tsvUrl == null ? '' : naverShopping.tsvUrl }
                    </td>
                </tr>
                <tr>
                    <td class="menu">상품 DB URL</td>
                    <td align="left">
                     ${naverShopping.productDbUrl == null ? '' : naverShopping.productDbUrl }
                    </td>
                </tr>
                <tr>
                    <td class="menu">네이버 쇼핑파트너존</td>
                    <td align="left">
                    1. 입점 신청 : <a href="https://join.shopping.naver.com" target="_blank">입점신청 바로가기</a><br>
                    2. 위 실행주소를 복사후에 <a href="https://adcenter.shopping.naver.com/member/login/form.nhn?targetUrl=%2Fmain.nhn" target="_blank">[상품 DB URL 등록하기]</a>에서 등록하세요.<br>
                    </td>
                </tr>
                </tbody>
                </table>

                <div style="text-align:center; padding:20px 0px 0 0px"><button type="button" onclick="register()" class="btn btn-primary">확인</button></div>
                </form:form>

                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col-xs-12 -->
    </div><!-- /.row -->
</section>
</div><!-- /.content-wrapper -->

<script>
function checkGubun() {
    var form = document.form_register;
	if ((form.isDomestic.checked == true) && (form.isForeigne.checked == true)) { // 국내/해외
		getCardPgInfo('eximbay');
		$('#display_pg').show();

		$('#display_exim_title').show();
		$('#display_exim').show();

		$('#display_ease_pg').show();
    }else if (form.isDomestic.checked == true) {  // 국내
		$('#display_pg').show();
		$('#display_ease_pg').show();

		$('#display_exim_title').hide();
		$('#display_exim').hide();

	}else if (form.isForeigne.checked == true) { // 해외
		getCardPgInfo('eximbay');
		$('#display_pg').hide();

		$('#display_ini_title').hide();
		$('#display_ini').hide();
		$('#display_xpay_title').hide();
		$('#display_xpay').hide();
		$('#display_kcp_title').hide();
		$('#display_kcp').hide();
		$('#display_exim_title').show();
		$('#display_exim').show();

		$('#display_ease_pg').hide();
		hideNaverPay();
		hideKakaoPay();
    }else{
		$('#display_pg').hide();
		$('#display_ease_pg').hide();

		$('#display_ini_title').hide();
		$('#display_ini').hide();
		$('#display_xpay_title').hide();
		$('#display_xpay').hide();
		$('#display_kcp_title').hide();
		$('#display_kcp').hide();
		$('#display_exim_title').hide();
		$('#display_exim').hide();
	}
}

function checkCardPGType(type) {
    if (type == 'ini') { // KG 이니시스
    	getCardPgInfo(type);
    	
		$('#display_ini_title').show();
		$('#display_ini').show();
		$('#display_xpay_title').hide();
		$('#display_xpay').hide();
		$('#display_kcp_title').hide();
		$('#display_kcp').hide();
		
		

	}else if (type == 'xpay') {   // LG 유플러스
		getCardPgInfo(type);
		$('#display_ini_title').hide();
		$('#display_ini').hide();
		$('#display_xpay_title').show();
		$('#display_xpay').show();
		$('#display_kcp_title').hide();
		$('#display_kcp').hide();


    }else if (type == 'kcp') {  // NHN KCP
    	getCardPgInfo(type);
		$('#display_ini_title').hide();
		$('#display_ini').hide();
        $('input[name=\'shop_id_ini\']').attr('value','');
        $('input[name=\'shop_key_ini\']').attr('value','');
		$('#display_xpay_title').hide();
		$('#display_xpay').hide();
		$('#display_kcp_title').show();
		$('#display_kcp').show();


	}
}

function checkEasyPGNaver(useYn){
	if(useYn == true || useYn == 'Y'){
		getCardPgInfo('naverpay');
		$('#display_naverpay_title').show();
		$('#display_naverpay').show();
	}else{
		hideNaverPay();
	}
}

function hideNaverPay(){
	$('#display_naverpay_title').hide();
	$('#display_naverpay').hide();

}

function checkEasyPGKakao(useYn){
	if(useYn == true || useYn == 'y'){
		$('#display_kakaopay_title').show();
		$('#display_kakaopay').show();
	}else{
		hideKakaoPay();
	}
}

function hideKakaoPay(){
}

function register() {

    var form = document.form_register;
	if ((form.isDomestic.checked == false) && (form.isForeigne.checked == false)) { alert('국내/해외 여부가 선택되지 않았습니다.'); form.isDomestic.focus(); return false;}
    if (form.isDomestic.checked == true){
        if(!$('input:radio[name=\'cardPg\']').is(':checked')) { alert('국내 카드PG사를 체크하세요.'); return false;}
    }

	if (form.isDomestic.checked == true) {   // 국내
        var radioArr = $('input[name=cardPg]:radio');
        if (radioArr[0].checked == true){       // KG 이니시스
            if(!$('input:checkbox[name=\'useIni\']').is(':checked')) { alert('사용여부를 선택하세요.'); return false;}
            if(!$('input:checkbox[name=\'useCreditIni\']').is(':checked') && !$('input:checkbox[name=\'useBankIni\']').is(':checked') && !$('input:checkbox[name=\'useVBankIni\']').is(':checked')) { alert('결제수단을 선택하세요.'); return false;}
        }else if (radioArr[1].checked == true){     // LG 유플러스
            if(!$('input:checkbox[name=\'useXpay\']').is(':checked')) { alert('사용여부를 선택하세요.'); return false;}
            if(!$('input:checkbox[name=\'useCreditXpay\']').is(':checked') && !$('input:checkbox[name=\'useBankXpay\']').is(':checked') && !$('input:checkbox[name=\'useVBankXpay\']').is(':checked')) { alert('결제수단을 선택하세요.'); return false;}
        }else if (radioArr[2].checked == true){     // NHN KCP
            if(!$('input:checkbox[name=\'useKcp\']').is(':checked')) { alert('사용여부를 선택하세요.'); return false;}
            if(!$('input:checkbox[name=\'useCreditKcp\']').is(':checked') && !$('input:checkbox[name=\'useBankKcp\']').is(':checked') && !$('input:checkbox[name=\'useVBankKcp\']').is(':checked')) { alert('결제수단을 선택하세요.'); return false;}
        }
        if(!$('.pgMode').is(':checked')) { alert('사용모드를 체크하세요.'); return false;}
    }

	if (form.isForeigne.checked == true) {   //해외
        if(!$('input:checkbox[name=\'useEximbay\']').is(':checked')) { alert('사용여부를 선택하세요.'); return false;}
        if(!$('input:checkbox[name=\'useCreditEximbay\']').is(':checked') && !$('input:checkbox[name=\'usePaypal\']').is(':checked') && !$('input:checkbox[name=\'useUnion\']').is(':checked') && !$('input:checkbox[name=\'useAli\']').is(':checked')) { alert('결제수단을 선택하세요.'); return false;}
        if(!$('input:radio[name=\'pgModeEximbay\']').is(':checked')) { alert('사용모드를 체크하세요.'); return false;}
    }

	if (form.naverpayUse.checked == true){
        if(form.storeIdNaver.value == '') { alert('네이버페이 가맹점 ID를 입력해주세요.');  form.storeIdNaver.focus(); return false;}
		if(form.storeKeyNaver.value == '') { alert('네이버페이 가맹점 인증키를 입력해주세요.');  form.storeKeyNaver.focus(); return false;}
		if(form.btnKey.value == '') { alert('네이버페이 버튼 인증키를 입력해주세요.');  form.btnKey.focus(); return false;}
    }

	form_register.target = 'iframe_process';
    form_register.submit();
}

$(document).ready(function(){
    $.ajax({
		url:'${pageContext.request.contextPath}/admin/setting/pg_process',
		type:'post',
		dataType:'json',
		headers: {
            "${_csrf.headerName}" : "${_csrf.token}"
        },
		data:{
			method : 'billing_pg_info'
		},
		success:function(data, textStatus, jqXHR){
            console.log(data)
			var json_data = data
            //console.log(json_data);

			if(json_data.isDomestic=='Y'){
                checkCardPGType(data.cardPg);
				checkEasyPGNaver(data.naverpayUse);
			}
			
			if(json_data.isForeigne=='Y'){
				checkGubun();
			}
		},
		error:function(jqXHR, textStatus, errorThrown){
			console.log(textStatus);
		}
	});
});

function getCardPgInfo(type){
	console.log(type)
	$.ajax({
		url:'${pageContext.request.contextPath}/admin/setting/pg_process',
		type:'post',
		dataType:'json',
		headers: {
            "${_csrf.headerName}" : "${_csrf.token}"
        },
		data:{
           type : type,
           method : 'getCardPgInfo'
		},
		success(data){
			console.log(data)
            if(type == 'ini'){
            	if(data.useIni == 'Y') $("[name=useIni]").prop("checked",true);
            	$('#module_version_ini').text(data.moduleVersionIni);
            	if(data.useCreditIni == 'Y') $("[name=useCreditIni]").prop("checked",true);
            	if(data.useBankIni == 'Y') $("[name=useBankIni]").prop("checked",true);
            	if(data.useVBankIni == 'Y') $("[name=useVBankIni]").prop("checked",true);
            	if(data.pgModeIni == '1'){$('#pg_mode1_ini').prop("checked",true)}else{$('#pg_mode2_ini').prop("checked",true)}
            	$("[name=storeIdIni]").val(data.storeIdIni);
            	$("[name=signKey]").val(data.signKey);
            	$("[name=moduleVersionIni]").val(data.moduleVersionIni);
            	
            }else if(type == 'xpay'){
            	if(data.useXpay == 'Y') $("[name=useXpay]").prop("checked",true);
            	$('#module_version_xpay').text(data.moduleVersionXpay);
            	if(data.useCreditXpay == 'Y') $("[name=useCreditXpay]").prop("checked",true);
            	if(data.useBankXpay == 'Y') $("[name=useBankXpay]").prop("checked",true);
            	if(data.useVBankXpay == 'Y') $("[name=useVBankXpay]").prop("checked",true);
            	if(data.pgModeXpay == '1'){$('#pg_mode1_xpay').prop("checked",true)}else{$('#pg_mode2_xpay').prop("checked",true)}
            	$("[name=storeIdXpay]").val(data.storeIdXpay);
            	$("[name=mertKey]").val(data.mertKey);
            	$("[name=moduleVersionXPay]").val(data.moduleVersionXpay);
            	
            }else if(type == 'kcp'){
            	if(data.useKcp == 'Y') $("[name=useKcp]").prop("checked",true);
            	$('#module_version_kcp').text(data.moduleVersionKcp);
            	if(data.useCreditKcp == 'Y') $("[name=useCreditKcp]").prop("checked",true);
            	if(data.useBankKcp == 'Y') $("[name=useBankKcp]").prop("checked",true);
            	if(data.useVBankKcp == 'Y') $("[name=useVBankKcp]").prop("checked",true);
            	if(data.pgModeKcp == '1'){$('#pg_mode1_kcp').prop("checked",true)}else{$('#pg_mode2_kcp').prop("checked",true)}
            	$("[name=siteCd]").val(data.siteCd);
            	$("[name=siteKey]").val(data.siteKey);
            	$("[name=moduleVersionKcp]").val(data.moduleVersionKcp);
            	
            }else if(type == 'naverpay'){
            	$('[name=storeIdNaver]').val(data.storeIdNaver);
            	$('[name=storeKeyNaver]').val(data.storeKeyNaver);
            	$('[name=btnKey]').val(data.btnKey);
            	if(data.pgModeNaver == '1') $("#naverpay_mode1").prop("checked",true) 
            	else $("#naverpay_mode2").prop("checked",true);
            	
            }else if(type == 'eximbay'){
            	if(data.useEximbay == 'Y') $("[name=useEximbay]").prop("checked",true);
            	$('#module_version_eximbay').text(data.moduleVersion);
            	if(data.useCreditEximbay == 'Y') $("[name=useCreditEximbay]").prop("checked",true);
            	if(data.usePaypal == 'Y') $("[name=usePaypal]").prop("checked",true);
            	if(data.useUnion == 'Y') $("[name=useUnion]").prop("checked",true);
            	if(data.useAli == 'Y') $("[name=useAli]").prop("checked",true);
            	if(data.pgModeEximbay == '1'){$('#pg_mode1_eximbay').prop("checked",true)}else{$('#pg_mode2_eximbay').prop("checked",true)}
            	$("[name=mid]").val(data.mid);
            	$("[name=secretKey]").val(data.secretKey);
            }
		},
		error: console.log
	});
}

</script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>