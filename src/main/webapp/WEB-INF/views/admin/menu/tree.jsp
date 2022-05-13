<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko"><head>
    <title>MIR9 SHOP</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no, target-densitydpi=medium-dpi">
    <meta name="author" content="아름다운맘">
    <meta name="keywords" content="아름다운맘">
    <meta name="description" content="아름다운 맘이 준비한 한주동안 지친 당신의 피부를 위한 시간">
    <meta property="og:title" content="아름다운맘">
    <meta property="og:url" content="http://demoshop.mir9.kr">
    <meta property="og:image" content="http://demoshop.mir9.kr/user/meta_logo.jpg?dummy=1650512783">
    <meta property="og:description" content="아름다운 맘이 준비한 한주동안 지친 당신의 피부를 위한 시간">
    <meta name="twitter:card" content="summary">
    <meta name="twitter:title" content="아름다운맘">
    <meta name="twitter:url" content="http://demoshop.mir9.kr">
    <meta name="twitter:image" content="http://demoshop.mir9.kr/user/meta_logo.jpg?dummy=1650512783">
    <meta name="twitter:description" content="아름다운 맘이 준비한 한주동안 지친 당신의 피부를 위한 시간">
    <link rel="canonical" href="http://demoshop.mir9.kr/index.php?tpf=admin/menu/tree&amp;menu=category">
    <link rel="shortcut icon" href="/user/favicon">
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script type="text/javascript" async="" src="https://www.google-analytics.com/analytics.js"></script><script async="" src="https://www.googletagmanager.com/gtag/js?id=UA-142394166-1"></script>
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', 'UA-142394166-1');

function displayTree(code){
	
	var tree = document.getElementById("i_div"+code+"");
	if(tree.style.display == 'none'){
		tree.style.display = 'block';
		$("img[name='j_img"+code+"']").attr("src", "${pageContext.request.contextPath}/resources/imgs/tree/plusbottom.gif")
	}else{
		tree.style.display = 'none';
		$("img[name='j_img"+code+"']").attr("src", "${pageContext.request.contextPath}/resources/imgs/tree/minusbottom.gif")
	}
	
}
</script>

    <!--[if lt IE 9]>
    <script type="text/javascript" src="/html/js/html5shiv.js"></script>
    <script type="text/javascript" src="/html/js/IE9.js"></script>
    <![endif]-->
    
    <script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.min.js" type="text/javascript"></script>
</head>

<body>
<iframe name="iframe_process" width="0" height="0" frameborder="0" style="display:none;"></iframe>

<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.js" type="text/javascript"></script>
<style>
table td {
    font-size:10pt;
    line-height:3.4mm;
    color:#656565;
}
a:link, a:visited, a:hover, a, active, a:focus {
    color:#656565;
    text-decoration:none;
}
</style>

<script language="JavaScript" src="${pageContext.request.contextPath }/resources/js/tree.js"></script>
<script>
var tree_tpl = {
	'target'  : '_blank',	// name of the frame links will be opened in
							// other possible values are: _blank, _parent, _search, _self and _top

	'icon_e'  : '${pageContext.request.contextPath}/resources/imgs/tree/empty.gif',	// empty image
	'icon_l'  : '${pageContext.request.contextPath}/resources/imgs/tree/line.gif',	// vertical line

	'icon_32' : '${pageContext.request.contextPath}/resources/imgs/tree/base.gif',   // root leaf icon normal
	'icon_36' : '${pageContext.request.contextPath}/resources/imgs/tree/base.gif',   // root leaf icon selected

	'icon_48' : '${pageContext.request.contextPath}/resources/imgs/tree/base.gif',   // root icon normal
	'icon_52' : '${pageContext.request.contextPath}/resources/imgs/tree/base.gif',   // root icon selected
	'icon_56' : '${pageContext.request.contextPath}/resources/imgs/tree/base.gif',   // root icon opened
	'icon_60' : '${pageContext.request.contextPath}/resources/imgs/tree/base.gif',   // root icon selected

	'icon_16' : '${pageContext.request.contextPath}/resources/imgs/tree/folder.gif', // node icon normal
	'icon_20' : '${pageContext.request.contextPath}/resources/imgs/tree/folderopen.gif', // node icon selected
	'icon_24' : '${pageContext.request.contextPath}/resources/imgs/tree/folderopen.gif', // node icon opened
	'icon_28' : '${pageContext.request.contextPath}/resources/imgs/tree/folderopen.gif', // node icon selected opened

	'icon_0'  : '${pageContext.request.contextPath}/resources/imgs/tree/page.gif', // leaf icon normal
	'icon_4'  : '${pageContext.request.contextPath}/resources/imgs/tree/page.gif', // leaf icon selected

	'icon_2'  : '${pageContext.request.contextPath}/resources/imgs/tree/joinbottom.gif', // junction for leaf
	'icon_3'  : '${pageContext.request.contextPath}/resources/imgs/tree/join.gif',       // junction for last leaf
	'icon_18' : '${pageContext.request.contextPath}/resources/imgs/tree/plusbottom.gif', // junction for closed node
	'icon_19' : '${pageContext.request.contextPath}/resources/imgs/tree/plus.gif',       // junctioin for last closed node
	'icon_26' : '${pageContext.request.contextPath}/resources/imgs/tree/minusbottom.gif',// junction for opened node
	'icon_27' : '${pageContext.request.contextPath}/resources/imgs/tree/minus.gif'       // junctioin for last opended node
};


</script>

<table cellpadding="0" cellspacing="0" border="0">
	<tbody>
		<tr>
			<td nowrap="">
				<a href="javascript:parent.list.location.replace('${pageContext.request.contextPath}/menu/menuList');">
					<img src="${pageContext.request.contextPath}/resources/imgs/tree/base.gif" border="0" align="absbottom" name="i_img0_0" class="t0im">Home
				</a>
			</td>
		</tr>
	</tbody>
</table>
<c:forEach var="menu" items="${list}" varStatus="status">
		<table cellpadding="0" cellspacing="0" border="0">
			<tbody>
				<input type="hidden" name="code" value="${menu.code}">
				<input type="hidden" name="originNo" value="${menu.originNo}">
				<c:if test="${menu.code == 1}">
					<tr>
						<td nowrap="">
							<img src="${pageContext.request.contextPath}/resources/imgs/tree/joinbottom.gif" border="0" align="absbottom">
								<a href="javascript:parent.list.location.replace('${pageContext.request.contextPath}/menu/menu2?code=${menu.code}&originNo=${menu.originNo}&ord=${menu.ord}');"class="t0i" id="i_txt0_1">
							<img src="${pageContext.request.contextPath}/resources/imgs/tree/page.gif" border="0" align="absbottom" name="i_img0_1" class="t0im">메인페이지</a>
						</td>
					</tr>
				</c:if>
				<c:if test="${menu.code != 1}">
					<tr>
						<c:if test="${!status.last}">
							<td nowrap="">
								<a>
									<img src="${pageContext.request.contextPath}/resources/imgs/tree/minusbottom.gif" border="0" align="absbottom" name="j_img${menu.code}" onclick="displayTree(${menu.code})">
								</a>
								<a href="javascript:parent.list.location.replace('${pageContext.request.contextPath}/menu/menu2?code=${menu.code}&originNo=${menu.originNo}&ord=${menu.ord}');">
									<img src="${pageContext.request.contextPath}/resources/imgs/tree/folderopen.gif" border="0" align="absbottom" name="i_img0_2" class="t0im">${menu.title}
								</a>
							</td>
						</c:if>
						<c:if test="${status.last}">
							<td nowrap="">
								<a>
									<img src="${pageContext.request.contextPath}/resources/imgs/tree/minus.gif" border="0" align="absbottom" name="j_img${menu.code}" onclick="displayTree(${menu.code})">
								</a>
								<a href="javascript:parent.list.location.replace('${pageContext.request.contextPath}/menu/menu2?code=${menu.code}&originNo=${menu.originNo}&ord=${menu.ord}');">
									<img src="${pageContext.request.contextPath}/resources/imgs/tree/folderopen.gif" border="0" align="absbottom" name="i_img0_2" class="t0im">${menu.title}
								</a>
							</td>
						</c:if>						
					</tr>
				</c:if>
			</tbody>
		</table>
<div id="i_div${menu.code}" style="display: block;">		
		<c:forEach var="menu2" items="${list2}" varStatus="status2">
		  <c:if test="${menu.originNo == menu2.originNo}">
			<div id="i_div0_2" style="display: block;">
				<table cellpadding="0" cellspacing="0" border="0">
					<tbody>
						<tr>
							<c:if test="${!status.last}">
								<td nowrap="">
									<img src="${pageContext.request.contextPath}/resources/imgs/tree/line.gif" border="0" align="absbottom">
									<img src="${pageContext.request.contextPath}/resources/imgs/tree/join.gif" border="0" align="absbottom">
										<a href="javascript:parent.list.location.replace('${pageContext.request.contextPath}/menu/menu2?code=${menu2.code}&originNo=${menu2.originNo}&ord=${menu2.ord}');" >
											<img src="${pageContext.request.contextPath}/resources/imgs/tree/page.gif" border="0" align="absbottom" name="i_img0_3" class="t0im">${menu2.title}
										</a>
								</td>
							</c:if>
							<c:if test="${status.last}">
								<td nowrap="">
									<img src="${pageContext.request.contextPath}/resources/imgs/tree/empty.gif" border="0" align="absbottom">
									<img src="${pageContext.request.contextPath}/resources/imgs/tree/join.gif" border="0" align="absbottom">
										<a href="javascript:parent.list.location.replace('${pageContext.request.contextPath}/menu/menu2?code=${menu2.code}&originNo=${menu2.originNo}&ord=${menu2.ord}');" >
											<img src="${pageContext.request.contextPath}/resources/imgs/tree/page.gif" border="0" align="absbottom" name="i_img0_3" class="t0im">${menu2.title}
										</a>
								</td>
							</c:if>							
						</tr>
					</tbody>
				</table>
			</div>
		  </c:if>
		</c:forEach>
	</div>
</c:forEach>
</body>
</html>













