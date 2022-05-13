package com.naedam.admin.community.model.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.naedam.admin.community.model.dao.CommunityDao;
import com.naedam.admin.community.model.vo.Email;
import com.naedam.admin.community.model.vo.EmailSetting;
import com.naedam.admin.community.model.vo.MsgInfo;
import com.naedam.admin.community.model.vo.Review;
import com.naedam.admin.community.model.vo.ReviewImg;
import com.naedam.admin.community.model.vo.Sms;
import com.naedam.admin.community.model.vo.SmsSetting;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	private CommunityDao communityDao;
	
	// JsonParser
	private JsonParser parser = new JsonParser();

	// 리뷰 조회 + 검색
	@Override
	public List<Review> reviewList(Map<Object, String> param) {
		return communityDao.reviewList(param);
	}

	// 모달 정보
	@Override
	public List<Review> reviewModal(int reviewCode) {
		return communityDao.reviewModal(reviewCode);
	}

	// 모달 이미지
	@Override
	public List<ReviewImg> reviewImgModal(int reviewCode) {
		return communityDao.reviewImgModal(reviewCode);
	}

	// 카테고리 조회
	@Override
	public int selectCategory(String reviewCode) {
		return communityDao.selectCategory(reviewCode);
	}	
	
	// 이미지 삭제
	@Override
	public int imgDelete(String reviewCode) {
		return communityDao.imgDelete(reviewCode);
	}	
	
	// 리뷰 삭제
	@Override
	public int selectDelete(String reviewCode) {
		return communityDao.selectDelete(reviewCode);
	}
	
	// v_msg_info 조회
	@Override
	public MsgInfo selectMsgInfo(long orderNo) {
		return communityDao.selectMsgInfo(orderNo);
	}
	
	// sms 특정 설정값 조회
	@Override
	public List<SmsSetting> smsCheck(String templateId) {
		return communityDao.smsCheck(templateId);
	}

	// email 특정 설정값 조회
	@Override
	public List<EmailSetting> emailCheck(String templateId) {
		return communityDao.emailCheck(templateId);
	}	
	
	// sms 자동 발송 여부 수정
	@Override
	public int smsAutoSend(HashMap<String, String> param) {
		return communityDao.smsAutoSend(param);
	}
	
	// email 자동 발송 여부 수정
	@Override
	public int mailAutoSend(HashMap<String, String> param) {
		return communityDao.mailAutoSend(param);
	}

	// sms 조회
	@Override
	public List<SmsSetting> selectSmsSetting() {
		return communityDao.selectSmsSetting();
	}
	
	@Override
	public List<Sms> selectSmsList(HashMap<String, Object> param) {
		return communityDao.selectSmsList(param);
	}

	// email 조회
	@Override
	public List<EmailSetting> selectEmailSetting() {
		return communityDao.selectEmailSetting();
	}	
	
	@Override
	public List<Email> selectEmailList(HashMap<String, Object> param) {
		return communityDao.selectEmailList(param);
	}

	// sms 기본 문구 + 저장 문구
	@Override
	public HashMap<String, Object> loadSms(String smsKey, String smsSecret, int category) {
		
		HashMap<String, Object> loadSms = new HashMap<>();
		String getUrl = "https://api-sms.cloud.toast.com/sms/v3.0/appKeys/" + smsKey + "/templates?categoryId=" + category + "&pageSize=24";

		// get 요청
		String result = getRequest(getUrl, smsSecret);
				
		// JSON>body>data
		JsonElement element = parser.parse(result);
		JsonObject bodyElement = element.getAsJsonObject().get("body").getAsJsonObject();
		JsonArray data = bodyElement.getAsJsonObject().get("data").getAsJsonArray();

		// templateId, body 값을 담을 List 선언
		List<String> templateId = new ArrayList<>();
		List<String> body = new ArrayList<>();;
		
		for(int i = 0; i < data.size(); i++) {
			templateId.add((data.getAsJsonArray().get(i).getAsJsonObject()).get("templateId").getAsString());
		}
		for(int i = 0; i < data.size(); i++) {
			body.add((data.getAsJsonArray().get(i).getAsJsonObject()).get("body").getAsString());			
		}
		
		loadSms.put("templateId", templateId);
		loadSms.put("body", body);

		return loadSms;
	}
		
	// sms 문구 수정
	@Override
	public int modifySms(String smsKey, String smsSecret, String code, String content) {
		
		int result = 0;
		String codeMod = code.concat("_mod");
		String putUrl = "https://api-sms.cloud.toast.com/sms/v3.0/appKeys/" + smsKey + "/templates/" + codeMod;

		// data
		JsonObject json = new JsonObject();
		json.addProperty("templateName", codeMod); // 템플릿ID
		json.addProperty("sendNo", "01042026201"); // 발신 번호
		json.addProperty("sendType", "0"); // 발송 유형
		json.addProperty("body", content); // 문구 내용
		json.addProperty("useYn", "Y"); // 사용 유무

		// put 요청
		String result2 = putRequest(putUrl, smsSecret, json);
		
		// JSON>header>resultMessage
		JsonElement element = parser.parse(result2);
		JsonObject header = element.getAsJsonObject().get("header").getAsJsonObject();
		String str = header.getAsJsonObject().get("resultMessage").getAsString();

		if(str.equals("success")) {
			result = 1;
		}
			
		return result;
	}
	
	// mail 기본 문구 + 저장 문구	
	@Override
	public HashMap<String, Object> loadEmail(String mailKey, String mailSecret, String templateId, int category) {
		
		HashMap<String, Object> loadEail = new HashMap<>();
		if(category != 48300) { // 수정 문구
			templateId = templateId.concat("_mod");
		}
		String getUrl = "https://api-mail.cloud.toast.com/email/v2.0/appKeys/" + mailKey + "/templates/" + templateId + "?categoryId=" + category;

		// get 요청
		String result = getRequest(getUrl, mailSecret);

		// JSON>body>data>title, body
		JsonElement element = parser.parse(result);
		JsonObject bodyElement = element.getAsJsonObject().get("body").getAsJsonObject();
		JsonObject data = bodyElement.getAsJsonObject().get("data").getAsJsonObject();
		 
		String title = (data.getAsJsonObject().getAsJsonObject()).get("title").getAsString();
		String body = (data.getAsJsonObject().getAsJsonObject()).get("body").getAsString();

		loadEail.put("title", title);
		loadEail.put("content", body);

		return loadEail;
	}

	// mail 문구 수정
	@Override
	public int modifyMail(String mailKey, String mailSecret, String templateId, String title, String content) {
	
		int result = 0;
		String template = templateId.concat("_mod");
		String putUrl = "https://api-mail.cloud.toast.com/email/v2.0/appKeys/" + mailKey + "/templates/" + template;

		// data
		JsonObject json = new JsonObject();
		json.addProperty("templateName", template); // 템플릿ID
		json.addProperty("useYn", "Y"); // 사용 유무
		json.addProperty("title", title); // 발송 제목
		json.addProperty("body", content); // 문구 내용
		
		// put 요청
		String result2 = putRequest(putUrl, mailSecret, json);
		
		// JSON>header>resultMessage
		JsonElement element = parser.parse(result2);
		JsonObject header = element.getAsJsonObject().get("header").getAsJsonObject();
		String str = header.getAsJsonObject().get("resultMessage").getAsString();

		if(str.equals("success")) {
			result = 1;
		}	
		
		return result;
	}

	// 조건별 sms 발송
	@Override
	public int sendSms(String smsKey, String smsSecret, HashMap<String, Object> param) {

		int result = 0;
		String template = (String) param.get("templateId");
		String postUrl = "https://api-sms.cloud.toast.com/sms/v3.0/appKeys/" + smsKey +  "/sender/sms";

		// 조건별 치환문구
		JSONObject templateParameter = new JSONObject(); 
		templateParameter.put("shop_name", "ND이커머스"); //  => 수정 필요
		if(template.contains("point")) { // 적립금
			templateParameter.put("user_name", param.get("userName")); 
			templateParameter.put("point", param.get("point")); 
			templateParameter.put("point_type", param.get("pointType")); 
		}
		else if(template.contains("coupon")) { // 쿠폰
			templateParameter.put("user_name", param.get("userName")); 
			templateParameter.put("coupon_name", param.get("couponName")); 
		}
		else if(template.contains("join") || template.contains("findid")) { // 회원가입, 아이디 찾기
			templateParameter.put("user_name", (String) param.get("name")); 
			templateParameter.put("user_id", (String) param.get("userId"));
		}
		else if(template.contains("findpw")) { // 임시 비밀번호
			templateParameter.put("user_id", (String) param.get("name")); 
			templateParameter.put("tmp_password", (String) param.get("tmpPwd"));
		}
		else { // 주문 관련
			templateParameter.put("order_name", (String) param.get("name")); 
			templateParameter.put("order_number", (long) param.get("orderNo"));
		}
		
		// 수신자 -> 배열 형태
		JSONArray recipientList = new JSONArray(); 
		JSONObject recip = new JSONObject();
		if(template.contains("join") || template.contains("find") 
				|| template.contains("point") || template.contains("coupon")) {
			recip.put("recipientNo", param.get("phone"));
		}
		else {
			recip.put("recipientNo", param.get("receiverPhone"));
		}
		recip.put("templateParameter", templateParameter);
		
		recipientList.add(recip); // 수신자 정보 배열에 담기
		
		// data
		JSONObject json = new JSONObject();
		json.put("templateId", template); // 템플릿ID
		json.put("sendNo", "01042026201"); // 발송 번호 => 등록한 발신 번호로 수정 필요
		json.put("recipientList", recipientList); // 수신자 정보
			
		// post 요청
		String str = postRequest(postUrl, smsSecret, json);

		// JSON>body>data>requestId
		JsonElement element = parser.parse(str);
		JsonObject bodyElement = element.getAsJsonObject().get("body").getAsJsonObject();
		JsonObject data = bodyElement.getAsJsonObject().get("data").getAsJsonObject();	
		String requestId = data.getAsJsonObject().get("requestId").getAsString();
		
		// requestId를 이용해서 전달한 내용 조회 및 DB에 저장
		// 발송 메시지 상세 조회
		String getUrl = "https://api-sms.cloud.toast.com/sms/v3.0/appKeys/" + smsKey + "/sender/sms?pageSize=1000&requestId=" + requestId;
		
		String result2 = getRequest(getUrl, smsSecret);
		
		// JSON>body>data>messageType, recipientNo, templateId, body, requestDate
		JsonElement element2 = parser.parse(result2);
		JsonObject bodyElement2 = element2.getAsJsonObject().get("body").getAsJsonObject();
		int total = bodyElement2.getAsJsonObject().get("totalCount").getAsInt(); // 총 개수
		JsonArray data2 = bodyElement2.getAsJsonObject().get("data").getAsJsonArray();
		String type = (data2.get(0).getAsJsonObject()).get("messageType").getAsString(); // 발송 타입

		List<String> phone = new ArrayList<>();
		List<String> title = new ArrayList<>();
		List<String> content = new ArrayList<>();
		List<String> requestDate = new ArrayList<>();
		
		// 데이터 가공
		for(int i = 0; i < total; i++) {
			String pStr = (data2.get(i).getAsJsonObject()).get("recipientNo").getAsString();
			String pForm = pStr.substring(0, 3) + "-" + pStr.substring(3, 7) + "-" + pStr.substring(7);

			phone.add(i, pForm);
			content.add(i, (data2.get(i).getAsJsonObject()).get("body").getAsString());
			requestDate.add(i, (data2.get(i).getAsJsonObject()).get("requestDate").getAsString());

			String temStr = (data2.get(i).getAsJsonObject()).get("templateId").getAsString();
			String templateId = temStr.substring(0, temStr.lastIndexOf("_"));

			List<SmsSetting> smsSet = communityDao.smsCheck(templateId);
			title.add(i, smsSet.get(i).getTemplateName());
		}

		// 조회한 데이터 넘겨서 db에 저장하기
		int insert = 0;
		
		HashMap<String, Object> param2 = new HashMap<String, Object>();
		String pStr = json.getString("sendNo");
		String pForm = pStr.substring(0, 3) + "-" + pStr.substring(3, 7) + "-" + pStr.substring(7);

		for(int i = 0; i < total; i++) {
			param2.put("type", type);
			param2.put("send", pForm);
			param2.put("requestId", requestId);
			param2.put("phone", phone.get(i));
			param2.put("title", title.get(i));
			param2.put("content", content.get(i));
			param2.put("date", requestDate.get(i));
			
			insert += communityDao.insertSms(param2);
		}
		
		if(insert > 0) {
			result = 1;
		}

		return result;
	}

	// 조건별 mail 발송
	@Override
	public int sendEmail(String mailKey, String mailSecret, HashMap<String, Object> param) {
		
		int result = 0;
		String template = (String) param.get("templateId");
		String postUrl = "https://api-mail.cloud.toast.com/email/v2.0/appKeys/" + mailKey +  "/sender/mail";

		// 조건별 치환문구
		JSONObject templateParameter = new JSONObject(); 
		templateParameter.put("shop_name", "ND이커머스"); // => 수정 필요 
		if(template.contains("point")) { // 적립금
			templateParameter.put("user_name", param.get("userName"));
			templateParameter.put("point", param.get("point"));
			templateParameter.put("point_type", param.get("pointType"));
		}
		else if(template.contains("coupon")) { // 쿠폰 
			templateParameter.put("user_name", param.get("userName"));
			templateParameter.put("coupon_name", param.get("couponName"));
			templateParameter.put("date", param.get("date"));
		}
		else if(template.contains("join") || template.contains("findid")) { // 회원가입, 아이디 찾기
			templateParameter.put("user_name", param.get("userName"));
			templateParameter.put("user_id", param.get("userId"));
		}
		else if(template.contains("findpw")) { // 임시 비밀번호 
			templateParameter.put("user_name", param.get("userName"));
			templateParameter.put("user_id", param.get("userId"));
			templateParameter.put("tmp_password", param.get("tmpPwd"));
		}
		else { // 주문 관련
			templateParameter.put("payment_status", param.get("statusName")); 
			templateParameter.put("order_number", param.get("orderNo")); 
			templateParameter.put("order_date", param.get("orderDate")); 
			templateParameter.put("order_first_name", param.get("firstName")); 
			templateParameter.put("order_name", param.get("lastName")); 
			templateParameter.put("order_email", param.get("email")); 
			templateParameter.put("order_mobile", param.get("phone")); 
			templateParameter.put("order_list", param.get("productName")); // + 옵션 정보 추가 
			templateParameter.put("receiver_first_name", ((String) param.get("receiver")).substring(1)); 
			templateParameter.put("receiver_name", ((String) param.get("receiver")).substring(0, 1)); 
			templateParameter.put("receiver_email", param.get("email")); 
			templateParameter.put("receiver_mobile", param.get("receiverPhone")); 
			templateParameter.put("receiver_addr", param.get("shippingAddress")); 
			templateParameter.put("request_message", param.get("memo")); 
			templateParameter.put("payment_info", param.get("payInfo")); 
		}
		
		// 수신자 정보 => 배열 형태
		JSONArray receiverList = new JSONArray();
		JSONObject recip = new JSONObject();
		if(template.contains("join") || template.contains("find") 
				|| template.contains("point") || template.contains("coupon")) {
			recip.put("receiveMailAddr", param.get("email"));
		}
		else {
			recip.put("receiveMailAddr", param.get("receiverEmail"));
		}
		recip.put("receiveType", "MRT0");
		
		receiverList.add(recip); // 수신자 정보 배열에 담기
		
		// data
		JSONObject json = new JSONObject();
		json.put("templateId", template); // 템플릿ID
		json.put("templateParameter", templateParameter); // 치환
		json.put("receiverList", receiverList); // 수신자 정보
		
		// post 요청
		String str = postRequest(postUrl, mailSecret, json);
		
		// Json>element>body>data>requestId
		JsonElement element = parser.parse(str);
		JsonObject bodyElement = element.getAsJsonObject().get("body").getAsJsonObject();
		JsonObject data = bodyElement.getAsJsonObject().get("data").getAsJsonObject();
		String requestId = data.getAsJsonObject().get("requestId").getAsString();
		JsonArray arr = data.getAsJsonObject().get("results").getAsJsonArray();
		
		// requestId를 이용해서 전달한 내용 조회 및 DB에 저장
		// 발송 메시지 상세 조회
		for(int j = 0; j < arr.size(); j++) {
			int mailSeq = j;
			String getUrl = "https://api-mail.cloud.toast.com/email/v2.0/appKeys/" + mailKey + "/sender/mail/" + requestId + "/" + mailSeq + "?pageSize=1000";
			
			String result2 = getRequest(getUrl, mailSecret);
			
			// JSON>body>data>mailStatusCode, title, body, requestDate
			JsonElement element2 = parser.parse(result2);
			JsonObject bodyElement2 = element2.getAsJsonObject().get("body").getAsJsonObject();
			JsonObject data2 = bodyElement2.getAsJsonObject().get("data").getAsJsonObject();
			String sendEmail = data2.getAsJsonObject().get("senderAddress").getAsString();
			
			// JSON>body>data>receiverList>receiveMailAddr
			JsonArray receiver = data2.getAsJsonObject().get("receiverList").getAsJsonArray();
			
			List<String> email = new ArrayList<>();
			List<String> title = new ArrayList<>();
			List<String> content = new ArrayList<>();
			List<String> requestDate = new ArrayList<>();
			
			// content
			String contentStr = "";
			if(template.contains("point")) { // 적립금
				contentStr = "적립금 " + templateParameter.get("point_type") + " : 적립금 " + templateParameter.get("point") + ", 종류 " + templateParameter.get("point_type");
			}
			else if(template.contains("coupon")) { // 쿠폰
				contentStr = "쿠폰 발급 : 쿠폰명 " + templateParameter.get("coupon_name") + ", 유효기간 " + templateParameter.get("date");
			}
			else if(template.contains("join") || template.contains("findid")) { // 회원가입, 아이디 찾기
				contentStr = "회원 정보 : 회원명 " + templateParameter.get("user_name") + ", 아이디 " + templateParameter.get("user_id");
			}
			else if(template.contains("findpw")) { // 임시 비밀번호
				contentStr = "회원 정보 : 아이디 " + templateParameter.get("user_id") + ", 임시 비밀번호 " + templateParameter.get("tmp_password");
			}
			else { // 주문 관련
				contentStr = "주문 정보 : 상태 " + templateParameter.get("payment_status") + ", 주문 번호 " + templateParameter.get("order_number") + ", 주문 일자 " + templateParameter.get("order_date") + "\n";
				contentStr += "주문자 정보 : 이름 " + templateParameter.get("order_name") + templateParameter.get("order_first_name")  + ", 이메일 " + templateParameter.get("order_email")  + ", 휴대폰 번호 " + templateParameter.get("order_mobile") + ", 주문 상품 " + templateParameter.get("order_list") + "\n";
				contentStr += "받는사람 정보 : 이름 " + param.get("receiver") + ", 이메일 " + templateParameter.get("receiver_email") + ", 휴대폰 번호 " + templateParameter.get("receiver_mobile") + ", 주소 " + templateParameter.get("receiver_addr") + ", 배송 메시지 " + templateParameter.get("request_message") + "\n";
				contentStr += "결제 정보 : " + templateParameter.get("payment_info");
			}
			
			for(int i = 0; i < receiver.size(); i++) {
				email.add(i, (receiver.get(i).getAsJsonObject()).get("receiveMailAddr").getAsString());
				title.add(i, data2.getAsJsonObject().get("title").getAsString());
				content.add(i, contentStr);
				requestDate.add(i, data2.getAsJsonObject().get("requestDate").getAsString());
			}
			
			// 조회한 데이터 넘겨서 db에 저장하기
			int insert = 0;
			
			HashMap<String, Object> param2 = new HashMap<String, Object>();
			
			for(int i = 0; i < receiver.size(); i++) {
				param2.put("send", sendEmail);
				param2.put("requestId", requestId);
				param2.put("email", email.get(i));
				param2.put("title", title.get(i));
				param2.put("content", content.get(i));
				param2.put("date", requestDate.get(i));
				
				insert += communityDao.insertEmail(param2);
			}
			
			if(insert > 0) {
				result = 1;
			}
		}
			
		return result;
	}
	
	// get 요청
	public String getRequest(String url, String secret) {
		
		String line = ""; 
		String result = "";
		
		try {
			// url
			URL get = new URL(url);
			HttpURLConnection getConn = (HttpURLConnection) get.openConnection();	
			
			// method
			getConn.setRequestMethod("GET");
			
			// headers
			getConn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
			getConn.setRequestProperty("X-Secret-Key", secret);
			
			// 결과값 받기
			BufferedReader br = new BufferedReader(new InputStreamReader(getConn.getInputStream(), "UTF-8"));
			while((line = br.readLine()) != null) {
				result += line;
			}
			br.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		return result;
	}
	
	// post 요청
	public String postRequest(String url, String secret, JSONObject json) {
		
		String line = "";
		String result = "";
		
		try {
			// url
			URL post = new URL(url);
			HttpURLConnection postConn = (HttpURLConnection) post.openConnection();
			
			// method
			postConn.setRequestMethod("POST");
			
			// header
			postConn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
			postConn.setRequestProperty("X-Secret-Key", secret);
			
			// doOutput : OutputStream으로 데이터를 넘겨주겠다
			postConn.setDoOutput(true);
			
			// 데이터 전송
			OutputStreamWriter os = new OutputStreamWriter(postConn.getOutputStream());
			os.write(json.toString());
			os.flush();
			os.close();
			
			// 응답 데이터 반환
			BufferedReader br = new BufferedReader(new InputStreamReader(postConn.getInputStream(), "UTF-8"));
			while((line = br.readLine()) != null) {
				result += line;
			}
			br.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// put 요청
	public String putRequest(String url, String secret, JsonObject json) {
		
		String line = "";
		String result = "";
		
		try {
			URL put = new URL(url); 
			HttpURLConnection putConn = (HttpURLConnection) put.openConnection(); 
			
			// method
			putConn.setRequestMethod("PUT");
			
			// header
			putConn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
			putConn.setRequestProperty("X-Secret-Key", secret);
			
			// doOutput : OutputStream으로 데이터를 넘겨주겠다
			putConn.setDoOutput(true);
			
			// 데이터 전송 준비
			OutputStreamWriter os = new OutputStreamWriter(putConn.getOutputStream());
			os.write(json.toString());
			os.flush();
			os.close();

			// 응답 데이터 반환
			BufferedReader br = new BufferedReader(new InputStreamReader(putConn.getInputStream(), "UTF-8"));
			while((line = br.readLine()) != null) {
				result += line;
			}
			br.close();
			
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}		

}
