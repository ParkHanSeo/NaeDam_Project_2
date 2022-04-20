<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml" lang="ko"><head>
    <title>MIR9 SHOP</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no, target-densitydpi=medium-dpi">
    <meta name="author" content="�Ƹ��ٿ">
    <meta name="keywords" content="�Ƹ��ٿ">
    <meta name="description" content="�Ƹ��ٿ� ���� �غ��� ���ֵ��� ��ģ ����� �Ǻθ� ���� �ð�">
    <meta property="og:title" content="�Ƹ��ٿ">
    <meta property="og:url" content="http://demoshop.mir9.kr">
    <meta property="og:image" content="http://demoshop.mir9.kr/user/meta_logo.jpg?dummy=1650343822">
    <meta property="og:description" content="�Ƹ��ٿ� ���� �غ��� ���ֵ��� ��ģ ����� �Ǻθ� ���� �ð�">
    <meta name="twitter:card" content="summary">
    <meta name="twitter:title" content="�Ƹ��ٿ">
    <meta name="twitter:url" content="http://demoshop.mir9.kr">
    <meta name="twitter:image" content="http://demoshop.mir9.kr/user/meta_logo.jpg?dummy=1650343822">
    <meta name="twitter:description" content="�Ƹ��ٿ� ���� �غ��� ���ֵ��� ��ģ ����� �Ǻθ� ���� �ð�">
    <link rel="canonical" href="http://demoshop.mir9.kr/index.php?tpf=admin/menu/tree&amp;menu=category">
    <link rel="shortcut icon" href="/user/favicon">
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script type="text/javascript" async="" src="https://www.google-analytics.com/analytics.js"></script><script async="" src="https://www.googletagmanager.com/gtag/js?id=UA-142394166-1"></script>
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', 'UA-142394166-1');
</script>
    <link rel="stylesheet" type="text/css" href="/html/css/common.css">
    <link rel="stylesheet" type="text/css" href="/html/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/html/css/board.min.css">
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/html/js/html5shiv.js"></script>
    <script type="text/javascript" src="/html/js/IE9.js"></script>
    <![endif]-->
    <script src="/html/js/common.js" type="text/javascript"></script>
    <script src="//mir9.co.kr/resource/js/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.min.js" type="text/javascript"></script>
</head>

<body>
<iframe name="iframe_process" width="0" height="0" frameborder="0" style="display:none;"></iframe>
<script src="/html/js/common.js" type="text/javascript"></script>
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

<script language="JavaScript" src="/html/js/tree.js"></script>
<script>
var tree_tpl = {
	'target'  : '_blank',	// name of the frame links will be opened in
							// other possible values are: _blank, _parent, _search, _self and _top

	'icon_e'  : '/img/tree/empty.gif',	// empty image
	'icon_l'  : '/img/tree/line.gif',	// vertical line

	'icon_32' : '/img/tree/base.gif',   // root leaf icon normal
	'icon_36' : '/img/tree/base.gif',   // root leaf icon selected

	'icon_48' : '/img/tree/base.gif',   // root icon normal
	'icon_52' : '/img/tree/base.gif',   // root icon selected
	'icon_56' : '/img/tree/base.gif',   // root icon opened
	'icon_60' : '/img/tree/base.gif',   // root icon selected

	'icon_16' : '/img/tree/folder.gif', // node icon normal
	'icon_20' : '/img/tree/folderopen.gif', // node icon selected
	'icon_24' : '/img/tree/folderopen.gif', // node icon opened
	'icon_28' : '/img/tree/folderopen.gif', // node icon selected opened

	'icon_0'  : '/img/tree/page.gif', // leaf icon normal
	'icon_4'  : '/img/tree/page.gif', // leaf icon selected

	'icon_2'  : '/img/tree/joinbottom.gif', // junction for leaf
	'icon_3'  : '/img/tree/join.gif',       // junction for last leaf
	'icon_18' : '/img/tree/plusbottom.gif', // junction for closed node
	'icon_19' : '/img/tree/plus.gif',       // junctioin for last closed node
	'icon_26' : '/img/tree/minusbottom.gif',// junction for opened node
	'icon_27' : '/img/tree/minus.gif'       // junctioin for last opended node
};

var TREE_ITEMS = [
    ['Home', '?tpf=admin/menu/list_sub',
    ['����������', '?tpf=admin/menu/list_sub&category_code=99'],
	['��ǰ', '?tpf=admin/menu/list_sub&category_code=10',
	['Dental Treats', '?tpf=admin/menu/list_sub&category_code=1010'],
	['Grooming', '?tpf=admin/menu/list_sub&category_code=1011'],
	['�ǰ� ����', '?tpf=admin/menu/list_sub&category_code=1012'],
	['test', '?tpf=admin/menu/list_sub&category_code=1013'],
	],
	['R&D', '?tpf=admin/menu/list_sub&category_code=11',
	['�����å', '?tpf=admin/menu/list_sub&category_code=1110'],
	['�ֿ� Ȱ��', '?tpf=admin/menu/list_sub&category_code=1111'],
	['������ ����', '?tpf=admin/menu/list_sub&category_code=1112'],
	['����', '?tpf=admin/menu/list_sub&category_code=1113'],
	],
	['ȸ��Ұ�', '?tpf=admin/menu/list_sub&category_code=12',
	['ȸ��Ұ�', '?tpf=admin/menu/list_sub&category_code=1210'],
	['����', '?tpf=admin/menu/list_sub&category_code=1211'],
	['���� ����', '?tpf=admin/menu/list_sub&category_code=1212'],
	['�����ϱ�', '?tpf=admin/menu/list_sub&category_code=1213'],
	],
	['Ŀ�´�Ƽ', '?tpf=admin/menu/list_sub&category_code=13',
	['��������', '?tpf=admin/menu/list_sub&category_code=1310'],
	['�����ϴ� ����', '?tpf=admin/menu/list_sub&category_code=1311'],
	['1:1����', '?tpf=admin/menu/list_sub&category_code=1312'],
	['����ı�', '?tpf=admin/menu/list_sub&category_code=1313'],
	['�̿���', '?tpf=admin/menu/list_sub&category_code=1314'],
	['�������� ��޹�ħ', '?tpf=admin/menu/list_sub&category_code=1315'],
	],
	    ]
	];
</script>

</body></html>