<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
    <title>MIR9 SHOP</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="format-detection" content="telephone=no">

    <link rel="canonical" href="http://demoshop.mir9.kr/index.php?tpf=admin/product/tree&menu=list">
    <!-- Global site tag (gtag.js) - Google Analytics -->
	<script async="true" src="https://www.googletagmanager.com/gtag/js?id=UA-142394166-1"></script>
	
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css"  />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/board.min.css" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/html/js/html5shiv.js"></script>
    <script type="text/javascript" src="/html/js/IE9.js"></script>
    <![endif]-->
    <script src="${pageContext.request.contextPath }/resources/js/common.js"></script>
    <script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.min.js" type="text/javascript"></script>
<script>
window.dataLayer = window.dataLayer || [];

function gtag(){
	dataLayer.push(arguments);
}
	gtag('js', new Date());
	gtag('config', 'UA-142394166-1');

</script>



</head>

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

<body>
<script src="${pageContext.request.contextPath }/resources/js/common.js" type="text/javascript"></script>
<script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.js" type="text/javascript"></script>



<script lang="JavaScript" src="${pageContext.request.contextPath }/resources/js/tree.js"></script>
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

var TREE_ITEMS = [
	${result}
];

</script>

<script lang="JavaScript">
<!--
function initMenu() {
trees[0].tmB(1);trees[0].tmB(2);trees[0].tmB(3);trees[0].tmB(4);trees[0].tmB(5);}
new tree (TREE_ITEMS, tree_tpl);
initMenu();
//-->
</script>
</body>
</html>