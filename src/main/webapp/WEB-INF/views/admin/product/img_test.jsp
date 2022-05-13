<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/admin/common/header.jsp">
<jsp:param value="주문후기 관리" name="title"/>
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- content-wrapper -->
<div class="content-wrapper">
    <!-- 
       [ imgur API ]
       == 참고
      https://marshallku.com/web/tips/imgur-api%EB%A1%9C-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EC%97%85%EB%A1%9C%EB%93%9C%ED%95%98%EA%B8%B0
       https://shlee0882.tistory.com/220
       https://apidocs.imgur.com/
       https://stackoverflow.com/questions/60809635/how-to-upload-an-image-to-imgbb-api-using-javascript-in-a-firefox-addon

      == 
       Client ID : efc5bc0d8dd28e8
      Client secret : 82019ad0a4f83c68d0f1cfcb84c091c7f9430362
      access token : 71da0e09f93e0101e62b99b774764574209fc9aa
      refresh token : c2e6a1d0de89fcaeb29e9c59facc99b420a30f6e
      콜백 url : https://www.getpostman.com/oauth2/callback
      
      == 오류 발생 
      POST https://api.imgur.com/3/image 429
      Imgur is temporarily over capacity. Please try again later.
      -> 인증? 문제 발생 
      
      [ imgbb API ]
      == 참고
      https://mchch.tistory.com/220?category=896023
      https://jade-kim.github.io/web/base64-url-encoding-decoding/
      https://intunknown.tistory.com/518
      
      == 
      key : f84bfb11eb3ee5eedb859de8b49fdff1
      url : https://api.imgbb.com/1/upload
      
      == 문제?
      a태그 href 속성 값에 imgbb에서 받은 url을 넣으면 다운로드가 안 되고 링크 이동함
      href 속성 값을 #으로 두면 다운로드는 되지만 이미지가 아닌 해당 html이 다운됨
      -> a태그의 href 속성 값을 데이터url로 지정했음
      -> img태그의 src 속성 값은 imgbb에서 받은 url로 지정했음
      -> 정상적으로 다운로드 됨 
    -->

   <input type="file" id="file" accept="image/*">
   <button type="button" onclick="delUrl();">삭제</button>
   <p>
      <a id="dImg" href="" download>
         <img id="imgPreview" src="" name="" style="width:100px; cursor:pointer;">
      </a>
      <input type="hidden" id="deleteUrl">
   </p>

   <script>
      // 확인하기
      // 1. 데이터url로 이미지 다운로드 되는지 확인 -> 확인
      // 2. 데이터url로 imgbb에 업로드 되는지 보기 -> 확인
      // 3. imgbb url을 가져와서 다운로드 되는지 보기 -> 확인 
      // => a태그의 경우 href값을 데이터url로 지정해야만 다운로드 진행됨
      // => 대신 img태그의 src값을 imgbb에서 가져온 url로 지정함
      
      // 데이터url 테스트 
      // 파일 변경 시 업로드 후 이미지 미리보기
      $("#file").change(function(){
         // 이미지 미리보기
         readImage();
         
          // 이미지 업로드
          var file = document.getElementById("file");
         var imgPreview = document.getElementById("imgPreview");
         var a = document.getElementById("dImg");
         var form = new FormData();
         form.append("image", file.files[0]);

         var settings = {
           "url": "https://api.imgbb.com/1/upload?key=f84bfb11eb3ee5eedb859de8b49fdff1",
           "method": "POST",
           "timeout": 0,
           "processData": false,
           "mimeType": "multipart/form-data",
           "contentType": false,
           "data": form
         };
         
         // 이미지 업로드 -> 확인
         $.ajax(settings).done(function (response) {
           // console.log("response" + response);
           
           var imgbb = JSON.parse(response);
           // console.log("imgbb : " + imgbb);
           
           // 이미지 조회 및 다운로드
           var url = imgbb.data.thumb.url;
           var name = imgbb.data.thumb.filename;
           var delUrl = imgbb.data.delete_url;
           console.log("url : " + url);
           console.log("name : " + name);
           console.log("delUrl : " + delUrl);
           
           a.download = name;
           imgPreview.src = url; // imgbb url
           imgPreview.name = name;
           $("#deleteUrl").attr("value", delUrl);

         });
         
      });
      
      // url 삭제 -> 구현 미완료
      // 실행 시 다음과 같은 오류 발생
      // Access to XMLHttpRequest at 'https://ibb.co/dgTSDcV/311630dc095c38617d665ebddc326793' 
      // from origin 'http://localhost:8089' has been blocked by CORS policy: 
      // No 'Access-Control-Allow-Origin' header is present on the requested resource.
      // GET https://ibb.co/dgTSDcV/311630dc095c38617d665ebddc326793 net::ERR_FAILED 200
      function delUrl() {
         var deleteUrl = $("#deleteUrl").val();
         console.log("삭제 deleteUrl : " + deleteUrl);
         
         var imgPreview = document.getElementById("imgPreview");
         var a = document.getElementById("dImg");
         
         if(deleteUrl != "" && deleteUrl != null) {
            var settings = {
              "url": deleteUrl,
              "timeout": 0,
              "processData": false,
              "contentType": false
            };
            
            $.ajax(settings).done(function (response) {
               console.log("이미지를 삭제했습니다.");
            });
         }
         else {
            console.log("삭제할 이미지가 없습니다.");
         }
      }
   
      // 데이터url
      function readImage() {
         if (document.getElementById("file").files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                  var imgPreview = document.getElementById("imgPreview");
                  imgPreview.src = e.target.result;
                  // console.log("imgPreview src : " + imgPreview.src);
                  var a = document.getElementById("dImg");
                  // 데이터 url 다운로드 -> 확인 
                  a.href = e.target.result;
            };
            reader.readAsDataURL(document.getElementById("file").files[0]);
         }
      }   
      
      /*
      // review.jsp 내용 성공...!!
      function toDataURL(imgUrl, callback) {
           var xhr = new XMLHttpRequest();
           xhr.onload = function() {
             var reader = new FileReader();
             reader.onloadend = function() {
               callback(reader.result);
             }
             reader.readAsDataURL(xhr.response);
           };
           xhr.open('GET', imgUrl);
           xhr.responseType = 'blob';
           xhr.send();
      }
      
      toDataURL(imgUrl, function(dataUrl){
         console.log("result : " + dataUrl); 
         // 데이터 url -> 이 값이 aTag.href에 들어가면 됨...
      });
      
      */      

   </script>

<jsp:include page="/WEB-INF/views/admin/common/footer.jsp"></jsp:include>