package com.naedam.admin.community.model.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.community.model.dao.CommunityDao;
import com.naedam.admin.community.model.vo.Email;
import com.naedam.admin.community.model.vo.EmailSetting;
import com.naedam.admin.community.model.vo.MsgInfo;
import com.naedam.admin.community.model.vo.Review;
import com.naedam.admin.community.model.vo.ReviewImg;
import com.naedam.admin.community.model.vo.Sms;
import com.naedam.admin.community.model.vo.SmsSetting;
import com.naedam.admin.coupon.model.dao.CouponDao;
import com.naedam.admin.coupon.model.vo.Coupon;
import com.naedam.admin.coupon.model.vo.MemberCoupon;
import com.naedam.admin.member.model.dao.MemberDao;
import com.naedam.admin.member.model.vo.Member;
import com.naedam.admin.point.model.dao.PointDao;
import com.naedam.admin.point.model.vo.MemberPoint;

@Service
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	private CommunityDao communityDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private PointDao pointDao;

	@Autowired
	private CouponDao couponDao;
	
	// SMS 인증키
	private static String smsKey = "cuyb2ATgfZrgb0LF";
	private static String smsSecret = "3VxajYQb";	
	
	// MAIL 인증키
	private static String mailKey = "s3b1XpsH6BR8yT4S";
	private static String mailSecret = "phiu4e0M";
		
	// JsonParser
	private JsonParser parser = new JsonParser();

	/**
	 * 공통 : 목록 + 검색 + 페이징
	 */
	@Override
	public Map<String, Object> selectCommunityList(
			String mode, int cPage, String field, String keyword, HttpServletRequest request){
		// 선언
		int total = 0; // 목록 개수	
		List<Object> commList = new ArrayList<>(); // 목록 조회
		Map<String, Object> param = makePageParam(cPage, field, keyword); // 공통 조회 param

		// 맵핑에 따른 결과값
		if(mode.equals("smsList")) { // SMS 목록
			total = communityDao.totalSmsCount(param);
			commList = communityDao.selectSmsList(param);
		}
		else if(mode.equals("emailList")) { // Email 목록
			total = communityDao.totalEmailCount(param); 
			commList = communityDao.selectEmailList(param); 
		}
		else if(mode.equals("review")) { // 후기 목록
			total = communityDao.totalReviewCount(param);
			commList = communityDao.reviewList(param);
		}
		
		// 페이징
		String uri = request.getRequestURI();
		if((field != null && field != "") && (keyword != null && keyword != "")) {
			uri += "?field=" + field + "&keyword=" + keyword; // 검색 조건 쿼리스트링 처리
		}
		String pagebar = Mir9Utils.getPagebar(cPage, Integer.parseInt(param.get("limit").toString()), total, uri);
		
		Map<String, Object> listParam = new HashMap<>();
		listParam.put("commList", commList);
		listParam.put("total", total);
		listParam.put("param", param);
		listParam.put("pagebar", pagebar);
		
		return listParam;
	}
		
	/**
	 * ajax 요청
	 */
	@Override
	public Map<String, Object> load(
			String mode, Map<String, Object> param) {
		// 선언
		int res = 0;
		Map<String, Object> setMod = new HashMap<>();
		List<String> codeList = new ArrayList<>();
		List<String> temList = new ArrayList<>();
		List<String> sendList = new ArrayList<>();
		List<String> sendAdminList = new ArrayList<>();
		List<String> contentList = new ArrayList<>();
		
		// json
		JsonObject json = new JsonObject();
		if(param.get("jsonStr") != null && param.get("jsonStr") != "") {
			json = (JsonObject) parser.parse(param.get("jsonStr").toString());
		}
		
		// 맵핑에 따른 결과값
		Map<String, Object> result = new HashMap<>();
		if(mode.equals("charge")) { // SMS 이용 요금
			String id = (String) param.get("id");
			String memPhone = memberDao.getPhoneById(id);
			String phone = memPhone.substring(0, 3) + "-" + memPhone.substring(3, 7) + "-" + memPhone.substring(7);
			int sendCount = communityDao.countBySendPhone(phone);
			result.put("sendCount", sendCount);
		}
		else if(mode.equals("smsAutoSendCheck")) { // SMS 자동발송
			List<Object> smsSetting = communityDao.selectSmsSetting();
			result.put("smsSetting", smsSetting);
		}
		else if(mode.equals("originSms")) { // SMS 기본문구
			int category = 81149; // 기본 카테고리 => 수정 필요
			result.put("originSms", loadSms(category));
		}
		else if(mode.equals("savedSms")) { // SMS 저장문구
			int category = 81150; // 저장 카테고리 => 수정 필요 
			result.put("savedSms", loadSms(category));
		}
		else if(mode.equals("smsSettingModify")) { // SMS 설정 저장
			JsonElement element = parser.parse(param.get("jsonStr").toString());
			JsonArray code = element.getAsJsonObject().get("code").getAsJsonArray();
			JsonArray templateId = element.getAsJsonObject().get("templateId").getAsJsonArray();
			JsonArray isSend = element.getAsJsonObject().get("isSend").getAsJsonArray();
			JsonArray content = element.getAsJsonObject().get("content").getAsJsonArray();

			// list로 가공
			for(int i = 0; i < code.size(); i ++) {
				codeList.add(code.get(i).getAsString());
			}
			for(int i = 0; i < templateId.size(); i++) {
				if(i == 0 || i%2 == 0) {
					sendList.add(isSend.get(i).getAsString());
				}
				else {
					sendAdminList.add(isSend.get(i).getAsString());
				}
				temList.add(templateId.get(i).getAsString());
				contentList.add(content.get(i).getAsString());
				res += modifySms(temList.get(i), contentList.get(i));
			}

			// 자동발송 여부 수정
			for(int i = 0; i < codeList.size(); i++) {
				setMod.put("templateId", codeList.get(i));
				setMod.put("send", sendList.get(i));
				setMod.put("sendAdmin", sendAdminList.get(i));
				res += communityDao.smsAutoSend(setMod);
			}
			if(res > 0) {
				result.put("modify", "success");
			}
		}
		else if(mode.equals("emailAutoSendCheck")) { // Email 자동발송
			List<Object> emailSetting = communityDao.selectEmailSetting();
			result.put("emailSetting", emailSetting);
		}
		else if(mode.equals("originEmail")) { // Email 기본문구
			int category = 48300; // 기본 카테고리 => 수정 필요
			String templateId = ((List<String>) param.get("templateId")).get(0);
			result.put("originEmail", loadEmail(templateId, category));
		}
		else if(mode.equals("savedEmail")) { // Email 저장문구
			int category = 49064; // 저장 카테고리 => 수정 필요
			String templateId = ((List<String>) param.get("templateId")).get(0);
			result.put("savedEmail", loadEmail(templateId, category));
		}
		else if(mode.equals("emailModalModify")) { // Email 발송문구 수정
			JsonElement element = parser.parse(param.get("jsonStr").toString());
			String tempateId = element.getAsJsonObject().get("templateId").getAsString();
			String title = element.getAsJsonObject().get("title").getAsString();
			String content = element.getAsJsonObject().get("content").getAsString();
			result.put("emailModalModify", modifyMail(tempateId, title, content));
		}
		else if(mode.equals("emailSettingModify")) { // Email 설정 저장
			// email_setting 수정
			JsonElement element = parser.parse(param.get("jsonStr").toString());
			JsonArray code = element.getAsJsonObject().get("code").getAsJsonArray();
			JsonArray isSend = element.getAsJsonObject().get("isSend").getAsJsonArray();
			
			// list로 가공
			for(int i = 0; i < code.size(); i ++) {
				codeList.add(code.get(i).getAsString());
			}
			for(int i = 0; i < isSend.size(); i++) {
				if(i == 0 || i%2 == 0) {
					sendList.add(isSend.get(i).getAsString());
				}
				else {
					sendAdminList.add(isSend.get(i).getAsString());
				}
			}

			// 자동발송 여부 수정
			for(int i = 0; i < codeList.size(); i++) {
				setMod.put("templateId", codeList.get(i));
				setMod.put("send", sendList.get(i));
				setMod.put("sendAdmin", sendAdminList.get(i));
				res += communityDao.emailAutoSend(setMod);
			}
			if(res > 0) {
				result.put("modify", "success");
			}
		}
		else if(mode.equals("reviewModal")) { // 후기 상세보기
			int reviewCode = (int) param.get("reviewCode");
			List<Review> review = communityDao.reviewModal(reviewCode);
			List<ReviewImg> reviewImg = communityDao.reviewImgModal(reviewCode);
			result.put("review", review);
			result.put("reviewImg", reviewImg);
		}
		return result;
	}
	
	/**
	 * 메시지 발송 템플릿명
	 * @param mode
	 * @param element
	 * @return
	 */
	public String getTemplateId(String mode, JsonElement element) {
		String templateId = mode;
		if(mode.equals("order")) {
			int statusNo = element.getAsJsonObject().get("statusNo").getAsInt();
			switch(statusNo) {
				case 1 : templateId="order"; break; 
				case 2 : templateId="pay_done"; break; 
				case 3 : templateId="delivery_ready"; break; 
				case 4 : templateId="delivery_ing"; break; 
				case 5 : templateId="delivery_done"; break; 
				case 6 : templateId="order_cancel"; break; 
				case 7 : templateId="refund"; break; 
			}
		}
		return templateId;
	}
	
	/**
	 * 메시지 발송
	 */
	@Override
	public Map<String, Object> send(String mode, String jsonStr) {
		// 선언
		int res = 0;
		int sms = 0;
		int email = 0;
		String str = "";
		String smsSend = "";
		String emailSend = "";
		List<String> name = new ArrayList<>();
		List<Member> member = new ArrayList<>(); 
		List<String> codeList = new ArrayList<>();
		
		// json
		JsonObject json = new JsonObject();
		JsonElement element = parser.parse(jsonStr);
		
		// 적립금과 쿠폰일 경우 데이터
		if(mode.equals("point") || mode.equals("coupon")) {
			// memberCode 값 분리
			str = element.getAsJsonObject().get("memberCode").getAsString();
			codeList = Arrays.asList(str.split(","));
			
			// 회원 이름 조회
			for(int i = 0; i < codeList.size(); i++) {
				member.addAll(memberDao.selectMemberInfo(codeList.get(i)));
				name.add((member.get(i).getLastName()).concat(member.get(i).getFirstName()));
			}
			
			// 메시지 발송 선택 여부 조회
			smsSend = element.getAsJsonObject().get("smsCheck").getAsString();
			emailSend = element.getAsJsonObject().get("emailCheck").getAsString();
		}
		
		// 자동발송 여부 조회
		String templateId = getTemplateId(mode, element);
		List<SmsSetting> smsAutoChecked = communityDao.smsAutoChecked(templateId);
		List<EmailSetting> emailAutoChecked = communityDao.emailAutoChecked(templateId);
		
		// 맵핑에 따른 결과값
		Map<String, Object> result = new HashMap<>();
		if(mode.equals("join")) {
			
		}
		else if(mode.equals("findid")) {
			
		}
		else if(mode.equals("findpw")) {
			
		}
		else if(mode.equals("order")) {
			// 주문 정보 조회
			Long orderNo = element.getAsJsonObject().get("orderNo").getAsLong();
			MsgInfo msgInfo = communityDao.selectMsgInfo(orderNo);	

			// 데이터 가공
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String orderDate = format.format(msgInfo.getOrderDate());
			String paidAt = format.format(msgInfo.getPaidAt());
			String memo = msgInfo.getMemo();
			if(memo == null) { memo = " ";}
			String pay = "결제 금액 " + msgInfo.getPayAmount() + "원, 결제 방법 " + msgInfo.getPayType();
			pay += ", 계좌번호 " + msgInfo.getAccount() + ", 은행명 " + msgInfo.getBankName();
			pay += ", 예금주 " + msgInfo.getOwner() + ", 입금자명 " + msgInfo.getBuyerName() + ", 입금일 " + paidAt;
		
			// 주문 sms 발송
			if((smsAutoChecked.get(0).getTemplateId()).equals(templateId)) {
				JsonObject tem = new JsonObject();
				tem.addProperty("shop_name", "ND이커머스"); //  => 수정 필요
				tem.addProperty("order_name", msgInfo.getReceiver()); 
				tem.addProperty("order_number", msgInfo.getOrderNo());
				
				JsonArray recipientList = new JsonArray();
				JsonObject recip = new JsonObject();
				recip.addProperty("recipientNo", msgInfo.getReceiverPhone());
				recip.add("templateParameter", tem);
				recipientList.add(recip); 
				
				json = new JsonObject();
				json.addProperty("templateId", templateId.concat("_mod")); 
				json.add("recipientList", recipientList);
				sms = sendSms(json);
				
				if(smsAutoChecked.get(0).getIsSendAdmin().equals("y")) {
					json.addProperty("templateId", templateId.concat("_admin_mod"));
					json.add("recipientList", recipientList);
					sms = sendSms(json);
				}
			}
			
			// 주문 email 발송
			if((emailAutoChecked.get(0).getTemplateId()).equals(templateId)) {
				JsonObject tem = new JsonObject(); 
				tem.addProperty("shop_name", "ND이커머스"); // => 수정 필요 
				tem.addProperty("payment_status", msgInfo.getStatusName()); 
				tem.addProperty("order_number", msgInfo.getOrderNo()); 
				tem.addProperty("order_date", orderDate); 
				tem.addProperty("order_first_name", msgInfo.getFirstName()); 
				tem.addProperty("order_name", msgInfo.getLastName()); 
				tem.addProperty("order_email", msgInfo.getEmail()); 
				tem.addProperty("order_mobile", msgInfo.getPhone()); 
				tem.addProperty("order_list", msgInfo.getProductName()); // + 옵션 정보 추가 
				tem.addProperty("receiver_first_name", (msgInfo.getReceiver()).substring(1)); 
				tem.addProperty("receiver_name", (msgInfo.getReceiver()).substring(0, 1)); 
				tem.addProperty("receiver_email", msgInfo.getReceiverEmail()); 
				tem.addProperty("receiver_mobile", msgInfo.getReceiverPhone()); 
				tem.addProperty("receiver_addr", msgInfo.getShippingAddress()); 
				tem.addProperty("request_message", memo); 
				tem.addProperty("payment_info", pay); 
			
				JsonArray receiverList = new JsonArray(); 
				JsonObject recip = new JsonObject();
				recip.addProperty("receiveMailAddr", msgInfo.getReceiverEmail());
				recip.addProperty("receiveType", "MRT0");
				receiverList.add(recip); 
				
				json = new JsonObject(); 
				json.addProperty("templateId", templateId.concat("_mod"));
				json.add("templateParameter", tem); 
				json.add("receiverList", receiverList);
				email = sendEmail(json);

				if(emailAutoChecked.get(0).getIsSendAdmin().equals("y")) {
					json.addProperty("templateId", templateId.concat("_admin_mod"));
					json.add("templateParameter", tem); 
					json.add("receiverList", receiverList);
					email = sendEmail(json);
				}
			}
			
			if(sms > 0 || email > 0) {
				result.put("sendOrder", "success");
			}
		}
		else if(mode.equals("point")) {
			String pointVal = element.getAsJsonObject().get("point").getAsString();
			String content = element.getAsJsonObject().get("content").getAsString();
			String typeCode = element.getAsJsonObject().get("type").getAsString();
			String type = "";
			if(typeCode.equals("+")) {
				type = "지급";
			}
			else if(typeCode.equals("-")) {
				type = "차감";
			}
			
			// 적립금 sms 발송
			if(smsSend.equals("y")) {
				for(int i = 0; i < name.size(); i++) {
					JsonObject tem = new JsonObject();
					tem.addProperty("shop_name", "ND이커머스"); // => 수정 필요
					tem.addProperty("user_name", name.get(i));
					tem.addProperty("point", pointVal);
					tem.addProperty("point_type", type);

					JsonArray recipientList = new JsonArray();
					JsonObject recip = new JsonObject();
					recip.addProperty("recipientNo",  member.get(i).getPhone()); 
					recip.add("templateParameter", tem);
					recipientList.add(recip);
					
					json = new JsonObject();
					json.addProperty("templateId", templateId.concat("_mod"));
					json.add("recipientList", recipientList);
					sms = sendSms(json);
					
					if((smsAutoChecked.get(0).getIsSendAdmin()).equals("y")) {
						json.addProperty("templateId", templateId.concat("_admin_mod"));
						json.add("recipientList", recipientList);
						sms = sendSms(json);
					}
				}
			}
			
			// 적립금 email 발송 
			if(emailSend.equals("y")) {
				for(int i = 0; i < name.size(); i++) {
					JsonObject tem = new JsonObject();
					tem.addProperty("shop_name", "ND이커머스"); // => 수정 필요
					tem.addProperty("user_name", name.get(i));
					tem.addProperty("point", pointVal);
					tem.addProperty("point_type", type);

					JsonArray receiverList = new JsonArray();
					JsonObject recip = new JsonObject();
					recip.addProperty("receiveMailAddr", member.get(i).getEmail());
					recip.addProperty("receiveType", "MRT0");
					receiverList.add(recip);
					
					json = new JsonObject();
					json.addProperty("templateId", templateId.concat("_mod"));
					json.add("templateParameter", tem);
					json.add("receiverList", receiverList);
					email = sendEmail(json);
					
					if((emailAutoChecked.get(0).getIsSendAdmin()).equals("y")) {
						json.addProperty("templateId", templateId.concat("_admin_mod"));
						json.add("templateParameter", tem);
						json.add("receiverList", receiverList);
						email = sendEmail(json);
					}
				}
			}
			
			// 회원 적립금 지급 및 차감 
			if(mode.equals("point")) {
				int point = Integer.parseInt(pointVal.replace(",", ""));
				if(typeCode.equals("-")) { // 차감일 경우, 음수로 변환
					point *= -1;
				}
				
				MemberPoint memberPoint = new MemberPoint();
				memberPoint.setPointAmount(point);
				memberPoint.setPointTitle(content);
				
				for(String memberNo : codeList) {
					memberPoint.setMemberNo(Integer.parseInt(memberNo));
					res = pointDao.insertMemberPoint(memberPoint);
				}
			}
			
			if((sms > 0 || email > 0) && res != 0) {
				result.put("sendPoint", "success");
			}
		}
		else if(mode.equals("coupon")) {
			String code = element.getAsJsonObject().get("couponCode").getAsString();
			List<Coupon> coupon = couponDao.getCoupon(code);
			String couponName = coupon.get(0).getCouponName();
			String expirDate = "";
			if(coupon.get(0).getExpiryType().equals("unlimited")) {
				expirDate = "제한 없음";
			}
			else {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				expirDate = format.format(coupon.get(0).getExpiryEndDate()); // 쿠폰 만료일
			}

			// 쿠폰 sms 발송 
			if(smsSend.equals("y")) {
				for(int i = 0; i < name.size(); i++) {
					JsonObject tem = new JsonObject();
					tem.addProperty("shop_name", "ND이커머스"); // => 수정 필요
					tem.addProperty("user_name", name.get(i));
					tem.addProperty("coupon_name", couponName);
					
					JsonArray recipientList = new JsonArray();
					JsonObject recip = new JsonObject();
					recip.addProperty("recipientNo", member.get(i).getPhone());
					recip.add("templateParameter", tem);
					recipientList.add(recip);
		
					json = new JsonObject();
					json.addProperty("templateId", templateId.concat("_mod"));
					json.add("recipientList", recipientList);
					sms = sendSms(json);
					
					if((smsAutoChecked.get(0).getIsSendAdmin()).equals("y")) {
						json.addProperty("templateId", templateId.concat("_admin_mod"));
						json.add("recipientList", recipientList);
						sms = sendSms(json);
					}
				}
			}	
			
			// 쿠폰 email 발송 
			if(emailSend.equals("y")) {
				for(int i = 0; i < name.size(); i++) {
					JsonObject tem = new JsonObject();
					tem.addProperty("shop_name", "ND이커머스"); // => 수정 필요
					tem.addProperty("user_name", name.get(i));
					tem.addProperty("coupon_name", couponName);
					tem.addProperty("date", expirDate);
		
					JsonArray receiverList = new JsonArray();
					JsonObject recip = new JsonObject();
					recip.addProperty("receiveMailAddr", member.get(i).getEmail()); 
					recip.addProperty("receiveType", "MRT0");
					receiverList.add(recip);
					
					json = new JsonObject();
					json.addProperty("templateId", templateId.concat("_mod"));
					json.add("templateParameter", tem);
					json.add("receiverList", receiverList);
					email = sendEmail(json);
					
					if((emailAutoChecked.get(0).getIsSendAdmin()).equals("y")) {
						json.addProperty("templateId", templateId.concat("_admin_mod"));
						json.add("templateParameter", tem);
						json.add("receiverList", receiverList);
						email = sendEmail(json);
					}
				}
			}
			
			// 쿠폰 지급 등록
			if(mode.equals("coupon")) {
				for(String memberNo : codeList) {
					MemberCoupon memberCoupon = new MemberCoupon(0, Integer.parseInt(memberNo), Integer.parseInt(code), null);
					res = couponDao.insertMemberCoupon(memberCoupon);
				}
			}
			
			if((sms > 0 || email > 0) && res != 0) {
				result.put("sendCoupon", "success");
			}
		}
		return result;
	}
	
	
	/**
	 * 후기 삭제
	 */
	@Override
	public String selectDelete(HttpServletRequest request) {
		int result = 0;
		String msg = "";
		List<String> selectedCode = Arrays.asList(request.getParameterValues("list[]"));
		
		for(String reviewCode : selectedCode) {
			int categoryNo = communityDao.selectCategory(reviewCode);
			if(categoryNo == 1) { // 포토 상품평의 경우
				result += communityDao.imgDelete(reviewCode);
			}
			result += communityDao.selectDelete(reviewCode);
		}
		
		if(result > 0) {
			msg = "후기를 성공적으로 삭제했습니다.";
		}
		else {
			msg = "선택한 후기를 삭제할 수 없습니다.\n관리자에게 문의하세요.";
		}
		return msg;
	}	
	
	/**
	 * 공통 : param
	 * @param cPage			: 현재 페이지
	 * @param field			: 검색 필드명
	 * @param keyword		: 검색 키워드
	 * @return
	 */
	public Map<String, Object> makePageParam(int cPage, String field, String keyword) {
		int limit = 15;
		int startRow = (cPage - 1) * limit + 1;
		int endRow = startRow + limit -1;
	
		Map<String, Object> param = new HashMap<>();
		param.put("field", field);
		param.put("keyword", keyword);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		param.put("limit", limit);
		
		return param;
	}
	
	/**
	 * SMS 템플릿 문구 조회
	 * @param category		: 카테고리 번호
	 * @return
	 */
	public Map<String, Object> loadSms(int category) {
		// url
		String getUrl = "https://api-sms.cloud.toast.com/sms/v3.0/appKeys/" + smsKey + "/templates?categoryId=" + category + "&pageSize=24";

		// get 요청 : JSON>body>data
		JsonElement element = parser.parse(getRequest(getUrl, smsSecret));
		JsonObject bodyElement = element.getAsJsonObject().get("body").getAsJsonObject();
		JsonArray data = bodyElement.getAsJsonObject().get("data").getAsJsonArray();

		// templateId, content
		List<String> templateId = new ArrayList<>();
		List<String> content = new ArrayList<>();
		for(int i = 0; i < data.size(); i++) {
			templateId.add((data.getAsJsonArray().get(i).getAsJsonObject()).get("templateId").getAsString());
			content.add((data.getAsJsonArray().get(i).getAsJsonObject()).get("body").getAsString());			
		}

		Map<String, Object> loadSms = new HashMap<>();
		loadSms.put("templateId", templateId);
		loadSms.put("content", content);
		
		return loadSms;
	}
	
	/**
	 * Email 템플릿 문구 조회
	 * @param templateId	: 템플릿명
	 * @param category		: 카테고리 번호
	 * @return
	 */
	public Map<String, Object> loadEmail(String templateId, int category) {
		// url
		String getUrl = "https://api-mail.cloud.toast.com/email/v2.0/appKeys/" + mailKey + "/templates/" + templateId + "?categoryId=" + category;

		// get 요청 : JSON>body>data>title, body
		JsonElement element = parser.parse(getRequest(getUrl, mailSecret));
		JsonObject bodyElement = element.getAsJsonObject().get("body").getAsJsonObject();
		JsonObject data = bodyElement.getAsJsonObject().get("data").getAsJsonObject();
		 
		String title = (data.getAsJsonObject().getAsJsonObject()).get("title").getAsString();
		String body = (data.getAsJsonObject().getAsJsonObject()).get("body").getAsString();

		Map<String, Object> loadEmail = new HashMap<>();
		loadEmail.put("title", title);
		loadEmail.put("content", body);

		return loadEmail;
	}
	
	/**
	 * SMS 템플릿 문구 수정
	 * @param templateId	: 템플릿명
	 * @param content		: 수정 문구
	 * @return
	 */
	public int modifySms(String templateId, String content) {
		int result = 0;
		String putUrl = "https://api-sms.cloud.toast.com/sms/v3.0/appKeys/" + smsKey + "/templates/" + templateId;
		
		// data
		JsonObject json = new JsonObject();
		json.addProperty("templateName", templateId); // 템플릿ID
		json.addProperty("sendNo", "01042026201"); // 발신 번호 => 수정 필요
		json.addProperty("sendType", "0"); // 발송 유형
		json.addProperty("body", content); // 문구 내용
		json.addProperty("useYn", "Y"); // 사용 유무

		// put 요청 : JSON>header>resultMessage
		JsonElement element = parser.parse(putRequest(putUrl, smsSecret, json));
		JsonObject header = element.getAsJsonObject().get("header").getAsJsonObject();
		String str = header.getAsJsonObject().get("resultMessage").getAsString();

		if(str.equals("success")) {
			result = 1;
		}
		return result;
	}

	/**
	 * Email 템플릿 문구 수정
	 * @param templateId	: 템플릿명
	 * @param title			: 수정 제목
	 * @param content		: 수정 문구
	 * @return
	 */
	public int modifyMail(String templateId, String title, String content) {
		int result = 0;
		String putUrl = "https://api-mail.cloud.toast.com/email/v2.0/appKeys/" + mailKey + "/templates/" + templateId;

		// data
		JsonObject json = new JsonObject();
		json.addProperty("templateName", templateId); // 템플릿ID
		json.addProperty("useYn", "Y"); // 사용 유무
		json.addProperty("title", title); // 발송 제목
		json.addProperty("body", content); // 문구 내용

		// put 요청 : JSON>header>resultMessage
		JsonElement element = parser.parse(putRequest(putUrl, mailSecret, json));
		JsonObject header = element.getAsJsonObject().get("header").getAsJsonObject();
		String str = header.getAsJsonObject().get("resultMessage").getAsString();

		if(str.equals("success")) {
			result = 1;
		}	
		return result;
	}
	
	/**
	 * 공통 : SMS 발송
	 * @param json
	 * @return
	 */
	public int sendSms(JsonObject json) {
		int result = 0;
		int insert = 0;

		// post 요청 : JSON>body>data>requestId
		String postUrl = "https://api-sms.cloud.toast.com/sms/v3.0/appKeys/" + smsKey +  "/sender/sms";
		JsonElement element = parser.parse(postRequest(postUrl, smsSecret, json));
		JsonObject bodyElement = element.getAsJsonObject().get("body").getAsJsonObject();
		JsonObject data = bodyElement.getAsJsonObject().get("data").getAsJsonObject();	
		String requestId = data.getAsJsonObject().get("requestId").getAsString();
		
		// get 요청 : JSON>body>data>messageType, recipientNo, templateId, body, requestDate
		String getUrl = "https://api-sms.cloud.toast.com/sms/v3.0/appKeys/" + smsKey + "/sender/sms?pageSize=1000&requestId=" + requestId;
		JsonElement element2 = parser.parse(getRequest(getUrl, smsSecret));
		JsonObject bodyElement2 = element2.getAsJsonObject().get("body").getAsJsonObject();
		int total = bodyElement2.getAsJsonObject().get("totalCount").getAsInt(); // 총 개수
		JsonArray data2 = bodyElement2.getAsJsonObject().get("data").getAsJsonArray();
		String type = (data2.get(0).getAsJsonObject()).get("messageType").getAsString(); // 발송 타입

		List<String> send = new ArrayList<>();
		List<String> phone = new ArrayList<>();
		List<String> title = new ArrayList<>();
		List<String> content = new ArrayList<>();
		List<String> requestDate = new ArrayList<>();
		
		// 데이터 가공
		for(int i = 0; i < total; i++) {
			String sendStr = (data2.get(i).getAsJsonObject()).get("sendNo").getAsString();
			String recipStr = (data2.get(i).getAsJsonObject()).get("recipientNo").getAsString();
			String sendForm = sendStr.substring(0, 3) + "-" + sendStr.substring(3, 7) + "-" + sendStr.substring(7);
			String recipForm = recipStr.substring(0, 3) + "-" + recipStr.substring(3, 7) + "-" + recipStr.substring(7);

			send.add(i, sendForm);
			phone.add(i, recipForm);
			content.add(i, (data2.get(i).getAsJsonObject()).get("body").getAsString());
			requestDate.add(i, (data2.get(i).getAsJsonObject()).get("requestDate").getAsString());

			String temStr = (data2.get(i).getAsJsonObject()).get("templateId").getAsString();
			String templateId = temStr.substring(0, temStr.lastIndexOf("_"));

			List<SmsSetting> smsSet = communityDao.smsAutoChecked(templateId);
			title.add(i, smsSet.get(i).getTemplateName());
		}

		// 조회한 데이터 넘겨서 db에 저장하기
		HashMap<String, Object> param2 = new HashMap<String, Object>();
		for(int i = 0; i < total; i++) {
			param2.put("type", type);
			param2.put("send", send.get(i));
			param2.put("requestId", requestId);
			param2.put("phone", phone.get(i));
			param2.put("title", title.get(i));
			param2.put("content", content.get(i));
			param2.put("date", requestDate.get(i));
			
			insert = communityDao.insertSms(param2);
		}
		
		if(insert > 0) {
			result = 1;
		}
		return result;
	}

	/**
	 * 공통 : Email 발송
	 * @param json
	 * @return
	 */
	public int sendEmail(JsonObject json) {
		int result = 0;
		int insert = 0;
		int mailSeq = 0;
		String template = json.getAsJsonObject().get("templateId").getAsString();
		
		// post 요청 : Json>element>body>data>requestId
		String postUrl = "https://api-mail.cloud.toast.com/email/v2.0/appKeys/" + mailKey +  "/sender/mail";
		JsonElement element = parser.parse(postRequest(postUrl, mailSecret, json));
		JsonObject bodyElement = element.getAsJsonObject().get("body").getAsJsonObject();
		JsonObject data = bodyElement.getAsJsonObject().get("data").getAsJsonObject();
		String requestId = data.getAsJsonObject().get("requestId").getAsString();
		JsonArray arr = data.getAsJsonObject().get("results").getAsJsonArray();
		
		// 발송 메시지 상세 조회
		for(int j = 0; j < arr.size(); j++) {
			// get 요청 : JSON>body>data>mailStatusCode, title, body, requestDate
			mailSeq = j;
			String getUrl = "https://api-mail.cloud.toast.com/email/v2.0/appKeys/" + mailKey + "/sender/mail/" + requestId + "/" + mailSeq + "?pageSize=1000";
			JsonElement element2 = parser.parse(getRequest(getUrl, mailSecret));
			JsonObject bodyElement2 = element2.getAsJsonObject().get("body").getAsJsonObject();
			JsonObject data2 = bodyElement2.getAsJsonObject().get("data").getAsJsonObject();
			String sendEmail = data2.getAsJsonObject().get("senderAddress").getAsString();
			JsonObject tem = json.getAsJsonObject().get("templateParameter").getAsJsonObject();
			
			// JSON>body>data>receiverList>receiveMailAddr
			JsonArray receiver = data2.getAsJsonObject().get("receiverList").getAsJsonArray();
		
			// content
			String contentStr = "";
			if(template.contains("point")) { // 적립금
				contentStr = "적립금 " + tem.getAsJsonObject().get("point_type").getAsString() + " : 적립금 " 
							+ tem.getAsJsonObject().get("point").getAsString() + "원, 종류 " 
							+ tem.getAsJsonObject().get("point_type").getAsString();
			}
			else if(template.contains("coupon")) { // 쿠폰
				contentStr = "쿠폰 발급 : 쿠폰명 " + tem.getAsJsonObject().get("coupon_name").getAsString() + ", 유효기간 " 
							+ tem.getAsJsonObject().get("date").getAsString();
			}
			else if(template.contains("join") || template.contains("findid")) { // 회원가입, 아이디 찾기
				contentStr = "회원 정보 : 회원명 " + tem.getAsJsonObject().get("user_name").getAsString() + ", 아이디 " 
							+ tem.getAsJsonObject().get("user_id").getAsString();
			}
			else if(template.contains("findpw")) { // 임시 비밀번호
				contentStr = "회원 정보 : 아이디 " + tem.getAsJsonObject().get("user_id").getAsString() + ", 임시 비밀번호 " 
							+ tem.getAsJsonObject().get("tmp_password").getAsString();
			}
			else { // 주문 관련
				contentStr = "주문 정보 : 상태 " + tem.get("payment_status").getAsString() + ", 주문 번호 " 
							+ tem.getAsJsonObject().get("order_number").getAsString() + ", 주문 일자 " 
							+ tem.getAsJsonObject().get("order_date").getAsString() + "\n주문자 정보 : 이름 " 
							+ tem.getAsJsonObject().get("order_name").getAsString() 
							+ tem.getAsJsonObject().get("order_first_name").getAsString()  + ", 이메일 " 
							+ tem.getAsJsonObject().get("order_email").getAsString()  + ", 휴대폰 번호 " 
							+ tem.getAsJsonObject().get("order_mobile").getAsString() + ", 주문 상품 " 
							+ tem.getAsJsonObject().get("order_list").getAsString() + "\n받는사람 정보 : 이름 " 
							+ tem.getAsJsonObject().get("receiver_name").getAsString() 
							+ tem.getAsJsonObject().get("receiver_first_name").getAsString() + ", 이메일 " 
							+ tem.getAsJsonObject().get("receiver_email").getAsString() + ", 휴대폰 번호 " 
							+ tem.getAsJsonObject().get("receiver_mobile").getAsString() + ", 주소 " 
							+ tem.getAsJsonObject().get("receiver_addr").getAsString() + ", 배송 메시지 " 
							+ tem.getAsJsonObject().get("request_message").getAsString() + "\n결제 정보 : " 
							+ tem.getAsJsonObject().get("payment_info").getAsString();
			}
			
			// 저장할 데이터
			List<String> email = new ArrayList<>();
			List<String> title = new ArrayList<>();
			List<String> content = new ArrayList<>();
			List<String> requestDate = new ArrayList<>();
			
			for(int i = 0; i < receiver.size(); i++) {
				email.add(i, (receiver.getAsJsonArray().get(i).getAsJsonObject()).get("receiveMailAddr").getAsString());
				title.add(i, data2.getAsJsonObject().get("title").getAsString());
				content.add(i, contentStr);
				requestDate.add(i, data2.getAsJsonObject().get("requestDate").getAsString());
			}
			
			// 조회한 데이터 넘겨서 db에 저장하기
			HashMap<String, Object> param2 = new HashMap<String, Object>();
			for(int i = 0; i < receiver.size(); i++) {
				param2.put("send", sendEmail);
				param2.put("requestId", requestId);
				param2.put("email", email.get(i));
				param2.put("title", title.get(i));
				param2.put("content", content.get(i));
				param2.put("date", requestDate.get(i));

				insert = communityDao.insertEmail(param2);
			}
		}
		
		if(insert > 0) {
			result = 1;
		}
		return result;
	}
	
	/**
	 * 공통 : GET 요청
	 * @param url			
	 * @param secret
	 * @return
	 */
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
			getConn.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
			getConn.setRequestProperty("X-Secret-Key", secret);
			
			// 결과값 받기
			BufferedReader br = new BufferedReader(new InputStreamReader(getConn.getInputStream(), "UTF-8"));
			while((line = br.readLine()) != null) {
				result += line;
			}
			br.close();

			int responseCode = getConn.getResponseCode();
			System.out.println(responseCode);
			
			getConn.disconnect();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		return result;
	}
	
	/**
	 * 공통 : POST 요청
	 * @param url
	 * @param secret
	 * @param json
	 * @return
	 */
	public String postRequest(String url, String secret, JsonObject json) { 
		String line = "";
		String result = "";

		try {
			// url
			URL post = new URL(url);
			HttpURLConnection postConn = (HttpURLConnection) post.openConnection();
			
			// method
			postConn.setRequestMethod("POST");
			
			// header
			postConn.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
			postConn.setRequestProperty("X-Secret-Key", secret);
			
			// doOutput : OutputStream으로 데이터를 넘겨주겠다
			postConn.setDoInput(true);
			postConn.setDoOutput(true);
			
			// 데이터 전송 준비
			OutputStreamWriter os = new OutputStreamWriter(postConn.getOutputStream(), "UTF-8");
			os.write(json.toString());
			os.flush();
			os.close();
			
			int responseCode = postConn.getResponseCode();
			System.out.println(responseCode);
			
			// 응답 데이터 반환
			BufferedReader br = new BufferedReader(new InputStreamReader(postConn.getInputStream(), "UTF-8"));
			while((line = br.readLine()) != null) {
				result += line;
			}
			br.close();
			
			postConn.disconnect();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 공통 : PUT 요청
	 * @param url
	 * @param secret
	 * @param json
	 * @return
	 */
	public String putRequest(String url, String secret, JsonObject json) {
		String result = "";
		
		try {
			// url
			URL put = new URL(url); 
			HttpURLConnection putConn = (HttpURLConnection) put.openConnection(); 
			
			// method
			putConn.setRequestMethod("PUT");
			
			// header
			putConn.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
			putConn.setRequestProperty("X-Secret-Key", secret);
			
			// doOutput : OutputStream으로 데이터를 넘겨주겠다
			putConn.setDoOutput(true);
			
			// 데이터 전송 준비
			OutputStreamWriter os = new OutputStreamWriter(putConn.getOutputStream(), "UTF-8");
			os.write(json.toString());
			os.flush();
			os.close();
			
			int responseCode = putConn.getResponseCode();
			System.out.println(responseCode);
			
			// 응답 데이터 반환
			result = getRequest(url, secret);
			
			putConn.disconnect();
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
