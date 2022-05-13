<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>Kakao 지도 시작하기</title>
</head>
<body>
	<div id="map" style="width:500px;height:400px;"></div>
	<input type="text" id="addr" />
	<br />
	<p>위도 : </p><input type="text" id="a" />
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a565ef86e588dc8b9bc46dd5db0fb88&libraries=services"></script>
<script>
$('#addr').keyup((e)=>{
// 주소로 좌표를 검색합니다
var addr = $('#addr').val()
var geocoder = new kakao.maps.services.Geocoder();

geocoder.addressSearch(addr, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		console.log(coords, typeof coords);
	}
    console.log(status)
});
});
</script>
</html>