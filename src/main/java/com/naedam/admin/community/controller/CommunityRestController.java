package com.naedam.admin.community.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.naedam.admin.community.model.service.CommunityService;
import com.naedam.admin.community.model.vo.EmailSetting;
import com.naedam.admin.community.model.vo.MsgInfo;
import com.naedam.admin.community.model.vo.Review;
import com.naedam.admin.community.model.vo.ReviewImg;
import com.naedam.admin.community.model.vo.SmsSetting;
import com.naedam.admin.coupon.model.service.CouponService;
import com.naedam.admin.coupon.model.vo.Coupon;
import com.naedam.admin.member.model.service.MemberService;
import com.naedam.admin.member.model.vo.Member;

@RestController
@RequestMapping("/admin/comm")
public class CommunityRestController {
	
	@Autowired
	private CommunityService communityService;
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private CouponService couponService;
	
	// MAIL 인증키
	private static String mailKey = "s3b1XpsH6BR8yT4S";
	private static String mailSecret = "phiu4e0M";
	
	// SMS 인증키
	private static String smsKey = "cuyb2ATgfZrgb0LF";
	private static String smsSecret = "3VxajYQb";
	
	// JsonParser
	private JsonParser parser = new JsonParser();
	
	// 리뷰 모달창 조회
	@GetMapping("/review_modal")
	public Map<Object, Object> commReviewModal(int reviewCode) {
		
		List<Review> review = communityService.reviewModal(reviewCode);
		List<ReviewImg> reviewImg  = communityService.reviewImgModal(reviewCode);

		Map<Object, Object> result = new HashMap<>();
		result.put("review", review);
		result.put("reviewImg", reviewImg);
		
		return result;
	}
	
	// sms 문구 수정
	@PostMapping("/sms")
	public int modifySms(
			@RequestBody String jsonStr) {

		// 필요 변수 선언
		List<String> code = new ArrayList<>();
		List<String> templateId = new ArrayList<>();
		List<String> is_send = new ArrayList<>();
		List<String> is_send_admin = new ArrayList<>();
		List<String> content = new ArrayList<>();
		int result1 = 0;
		int result2 = 0;
		
		// JsonParser
		JsonElement element = parser.parse(jsonStr);
		JsonArray codeArr = element.getAsJsonObject().get("code").getAsJsonArray();
		
		// 값 담기
		for(int i = 0; i < codeArr.size(); i++) {
			code.add((element.getAsJsonObject().get("code").getAsJsonArray()).get(i).getAsString());
			content.add((element.getAsJsonObject().get("content").getAsJsonArray()).get(i).getAsString());
			
			if(i == 0 || i%2 == 0) {
				templateId.add((element.getAsJsonObject().get("code").getAsJsonArray()).get(i).getAsString());
				is_send.add((element.getAsJsonObject().get("is_send").getAsJsonArray()).get(i).getAsString());
			}
			else {
				is_send_admin.add((element.getAsJsonObject().get("is_send").getAsJsonArray()).get(i).getAsString());
			}
		}
		
		// sms 정보 업데이트
		for(int i = 0; i < code.size(); i++) {
			result1 += communityService.modifySms(smsKey, smsSecret, code.get(i), content.get(i));
		}

		// sms 자동 발송 여부
		HashMap<String, String> param = new HashMap<>();
		
		for (int i = 0; i < is_send_admin.size(); i++) {
			param.put("templateId", templateId.get(i));
			param.put("send", is_send.get(i));
			param.put("sendAdmin", is_send_admin.get(i));

			result2 += communityService.smsAutoSend(param);
		}

		return (result1 * result2);
	}
	
	// mail 모달창 기본 문구 조회
	@GetMapping("/email_origin")
	public HashMap<String, Object> commEmailOrigin(String templateId) {

		// templateId 전달
		int category = 48300;
		HashMap<String, Object> originMail = communityService.loadEmail(mailKey, mailSecret, templateId, category);

		return originMail;
	}	
	
	// mail 모달창 저장 문구 조회
	@GetMapping("/email_modal")
	public HashMap<String, Object> commEmailModal(String templateId) {

		// templateId 전달
		int category = 49064;
		HashMap<String, Object> savedMail = communityService.loadEmail(mailKey, mailSecret, templateId, category);

		return savedMail;
	}
	
	// mail 모달창 문구 수정
	@PostMapping("/email_modal")
	public int commEmailModify(@RequestBody String jsonStr) {
		
		// JsonParser
		JsonElement element = parser.parse(jsonStr);
		
		String templateId = element.getAsJsonObject().get("templateId").getAsString();
		String title = element.getAsJsonObject().get("title").getAsString();
		String content = element.getAsJsonObject().get("content").getAsString();
		
		// templateId 전달
		int result = communityService.modifyMail(mailKey, mailSecret, templateId, title, content);

		return result;
	}
	
	// mail 설정 수정
	@PostMapping("/email")
	public int commEmail(
			@RequestBody String jsonStr) {
		
		// 필요 변수 선언
		List<String> templateId = new ArrayList<>();
		List<String> is_send = new ArrayList<>();
		List<String> is_send_admin = new ArrayList<>();
		int result = 0;
		
		// JsonParser
		JsonElement element = parser.parse(jsonStr);
		JsonArray codeArr = element.getAsJsonObject().get("code").getAsJsonArray();
		
		// 값 담기
		for(int i = 0; i < codeArr.size(); i++) {
			if(i == 0 || i%2 == 0) {
				templateId.add((element.getAsJsonObject().get("code").getAsJsonArray()).get(i).getAsString());
				is_send.add((element.getAsJsonObject().get("is_send").getAsJsonArray()).get(i).getAsString());
			}
			else {
				is_send_admin.add((element.getAsJsonObject().get("is_send").getAsJsonArray()).get(i).getAsString());
			}
		}

		// mail 자동 발송 여부
		HashMap<String, String> param = new HashMap<>();
		
		for (int i = 0; i < is_send_admin.size(); i++) {
			param.put("templateId", templateId.get(i));
			param.put("send", is_send.get(i));
			param.put("sendAdmin", is_send_admin.get(i));

			result += communityService.mailAutoSend(param);
		}

		return result;
	}	
	
	// 주문 관련 msg 발송
	@PostMapping("/sendMsg")
	public int sendMsg(String orderNo, int statusNo) {
	
		int result = 0; 
		int sms = 0;
		int email = 0;
		String templateId = "";
		
		// statusNo 값으로 자동 발송 체크여부 확인
		switch(statusNo) {
			case 1 : templateId="order"; break; 
			case 2 : templateId="pay_done"; break; 
			case 3 : templateId="delivery_ready"; break; 
			case 4 : templateId="delivery_ing"; break; 
			case 5 : templateId="delivery_done"; break; 
			case 6 : templateId="order_cancel"; break; 
			case 7 : templateId="refund"; break; 
		}
		
		// 자동 발송 여부 조회
		List<SmsSetting> smsCheck = communityService.smsCheck(templateId);
		List<EmailSetting> emailCheck = communityService.emailCheck(templateId);

		// 주문 정보 조회
		MsgInfo msgInfo = communityService.selectMsgInfo(Long.parseLong(orderNo));	

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String orderDate = format.format(msgInfo.getOrderDate());
		String paidAt = format.format(msgInfo.getPaidAt());
		String memo = msgInfo.getMemo();
		if(memo == null) { // memo 값이 null일 경우
			memo = " ";
		}
		
		String pay = "결제 금액 " + msgInfo.getPayAmount() + "원, 결제 방법 " + msgInfo.getPayType();
		pay += ", 계좌번호 " + msgInfo.getAccount() + ", 은행명 " + msgInfo.getBankName();
		pay += ", 예금주 " + msgInfo.getOwner() + ", 입금자명 " + msgInfo.getBuyerName() + ", 입금일 " + paidAt;
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("orderNo", msgInfo.getOrderNo());
		param.put("statusName", msgInfo.getStatusName());
		param.put("orderDate", orderDate);
		param.put("firstName", msgInfo.getFirstName());
		param.put("lastName", msgInfo.getLastName());
		param.put("name", msgInfo.getLastName().concat(msgInfo.getFirstName()));
		param.put("email", msgInfo.getEmail());
		param.put("phone", msgInfo.getPhone());
		param.put("imgUrl", msgInfo.getImgUrl());
		param.put("productName", msgInfo.getProductName());
		param.put("salePrice", msgInfo.getSalePrice());
		param.put("payAmount", msgInfo.getPayAmount());
		param.put("receiver", msgInfo.getReceiver());
		param.put("receiverEmail", msgInfo.getReceiverEmail());
		param.put("receiverPhone", msgInfo.getReceiverPhone());
		param.put("shippingAddress", msgInfo.getShippingAddress());
		param.put("memo", memo);
		param.put("payType", msgInfo.getPayType());
		param.put("payMethod", msgInfo.getPayMethod());
		param.put("account", msgInfo.getAccount());
		param.put("bankName", msgInfo.getBankName());
		param.put("owner", msgInfo.getOwner());
		param.put("buyerName", msgInfo.getBuyerName());
		param.put("paidAt", paidAt);
		param.put("payInfo", pay);

		// 자동 발송 체크된 경우만 메시지 보내기
		if(smsCheck.get(0).getTemplateId().equals(templateId)) {
			if(smsCheck.get(0).getIsSend().equals("y")) {
				param.put("templateId", templateId.concat("_mod"));
				sms += communityService.sendSms(smsKey, smsSecret, param);
			}
			else if(smsCheck.get(0).getIsSendAdmin().equals("y")) {
				param.put("templateId", templateId.concat("_admin_mod"));
				sms += communityService.sendSms(smsKey, smsSecret, param);
			}
		}
		
		if(emailCheck.get(0).getTemplateId().equals(templateId)) {
			if(emailCheck.get(0).getIsSend().equals("y")) {
				param.put("templateId", templateId.concat("_mod"));
				email += communityService.sendEmail(mailKey, mailSecret, param);
			}
			else if(emailCheck.get(0).getIsSendAdmin().equals("y")) {
				param.put("templateId", templateId.concat("_admin_mod"));
				email += communityService.sendEmail(mailKey, mailSecret, param);
			}
		}
		
		if(sms > 0 || email > 0) {
			result += 1;
		}

		return result;
	}
	
	// 회원가입, 아이디 찾기, 비밀번호 찾기 => 프론트단 구현 후
	@PostMapping("/sendRegistMsg")
	public int sendRegistMsg(
			@RequestBody String jsonStr) {
		int result = 0;
		// sms
		// shop_name, user_name
		
		// email
		// shop_name, user_name, user_id
		// + tmp_password
		return result;
	}
	
	// 적립금 관련 msg 발송 
	@PostMapping("/sendPointMsg")
	public int sendPointMsg(
			@RequestBody String jsonStr) {
		
		int result = 0;
		int sms = 0;
		int email = 0;
		
		// JsonParser
		JsonElement element = parser.parse(jsonStr);
		
		// memberCode 값 분리
		String str = element.getAsJsonObject().get("memberCode").getAsString();
		List<String> codeList = Arrays.asList(str.split(","));
		
		// type 설정
		String type = element.getAsJsonObject().get("type").getAsString();
		if(type.equals("+")) {
			type = "지급";
		}
		else if(type.equals("-")) {
			type = "차감";
		}
		
		// 발송 선택 여부
		String smsSend = element.getAsJsonObject().get("smsCheck").getAsString();
		String emailSend = element.getAsJsonObject().get("emailCheck").getAsString();

		// 자동 발송 여부 조회
		String templateId = "point";
		List<SmsSetting> smsCheck = communityService.smsCheck(templateId);
		List<EmailSetting> emailCheck = communityService.emailCheck(templateId);
		
		// memberCode로 회원 이름 조회
		List<Member> member = new ArrayList<>(); 
		for(int i = 0; i < codeList.size(); i++) {
			member.addAll(memberService.selectMemberInfo(codeList.get(i)));
		}

		// param 넘겨서 sms 및 email 발송
		for(int i = 0; i < codeList.size(); i++) {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("userName", member.get(i).getLastName()+member.get(i).getFirstName());
			param.put("phone", member.get(i).getPhone());
			param.put("email", member.get(i).getEmail());
			param.put("point", element.getAsJsonObject().get("point").getAsString());
			param.put("pointType", type);

			// 자동 발송 체크된 경우만 메시지 보내기
			if(smsSend.equals("y")) {
				if(smsCheck.get(0).getIsSend().equals("y")) {
					param.put("templateId", templateId.concat("_mod"));
					sms += communityService.sendSms(smsKey, smsSecret, param);
				}
				else if(smsCheck.get(0).getIsSendAdmin().equals("y")) {
					param.put("templateId", templateId.concat("_admin_mod"));
					sms += communityService.sendSms(smsKey, smsSecret, param);
				}
			}
			
			if(emailSend.equals("y")) {
				if(emailCheck.get(0).getIsSend().equals("y")) {
					param.put("templateId", templateId.concat("_mod"));
					email += communityService.sendEmail(mailKey, mailSecret, param);
				}
				else if(emailCheck.get(0).getIsSendAdmin().equals("y")) {
					param.put("templateId", templateId.concat("_admin_mod"));
					email += communityService.sendEmail(mailKey, mailSecret, param);
				}
			}
		}
		
		if(sms > 0 || email > 0) {
			result += 1;
		}
		
		return result;
	}

	// 쿠폰 관련 msg 발송
	@PostMapping("/sendCouponMsg")
	public int sendCouponMsg(
			@RequestBody String jsonStr) {

		int result = 0;
		int sms = 0;
		int email = 0;
		
		// JsonParser
		JsonElement element = parser.parse(jsonStr);
		
		// memberCode 값 분리
		String str = element.getAsJsonObject().get("memberCode").getAsString();
		List<String> codeList = Arrays.asList(str.split(","));
		
		// couponCode 넘겨서 쿠폰명, 유효기간 조회해오기
		String code = element.getAsJsonObject().get("couponCode").getAsString();
		List<Coupon> coupon = couponService.getCoupon(code);
		String couponName = coupon.get(0).getCouponName();
		String expirDate = "";
		if(coupon.get(0).getExpiryType().equals("unlimited")) {
			expirDate = "제한 없음";
		}
		else {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			expirDate = format.format(coupon.get(0).getExpiryEndDate());
		}

		// 발송 선택 여부
		String smsSend = element.getAsJsonObject().get("smsCheck").getAsString();
		String emailSend = element.getAsJsonObject().get("emailCheck").getAsString();

		// 자동 발송 여부 조회
		String templateId = "coupon";
		List<SmsSetting> smsCheck = communityService.smsCheck(templateId);
		List<EmailSetting> emailCheck = communityService.emailCheck(templateId);
		
		// memberCode로 회원 이름 조회
		List<Member> member = new ArrayList<>(); 
		for(int i = 0; i < codeList.size(); i++) {
			member.addAll(memberService.selectMemberInfo(codeList.get(i)));
		}

		// param 넘겨서 sms 및 email 발송
		for(int i = 0; i < codeList.size(); i++) {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("userName", member.get(i).getLastName()+member.get(i).getFirstName());
			param.put("phone", member.get(i).getPhone());
			param.put("email", member.get(i).getEmail());
			param.put("couponName", couponName);
			param.put("date", expirDate);

			// 자동 발송 체크된 경우만 메시지 보내기
			if(smsSend.equals("y")) {
				if(smsCheck.get(0).getIsSend().equals("y")) {
					param.put("templateId", templateId.concat("_mod"));
					sms += communityService.sendSms(smsKey, smsSecret, param);
				}
				else if(smsCheck.get(0).getIsSendAdmin().equals("y")) {
					param.put("templateId", templateId.concat("_admin_mod"));
					sms += communityService.sendSms(smsKey, smsSecret, param);
				}
			}
			
			if(emailSend.equals("y")) {
				if(emailCheck.get(0).getIsSend().equals("y")) {
					param.put("templateId", templateId.concat("_mod"));
					email += communityService.sendEmail(mailKey, mailSecret, param);
				}
				else if(emailCheck.get(0).getIsSendAdmin().equals("y")) {
					param.put("templateId", templateId.concat("_admin_mod"));
					email += communityService.sendEmail(mailKey, mailSecret, param);
				}
			}
		}
		
		if(sms > 0 || email > 0) {
			result += 1;
		}
		
		return result;
	}

}
