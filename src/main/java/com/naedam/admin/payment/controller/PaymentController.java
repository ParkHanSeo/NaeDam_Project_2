package com.naedam.admin.payment.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.order.model.vo.OrderInfo;
import com.naedam.admin.payment.model.service.PaymentService;
import com.naedam.admin.payment.model.vo.PaymentInfo;
import com.naedam.admin.payment.model.vo.TempPayInfo;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/admin/payment")
@Slf4j
public class PaymentController {
	@Autowired
	private PaymentService paymentService;
	
	@PostMapping("/insert")
	@ResponseBody
	public int insert(String jsonStr) {
		Map<String, Object> param = Mir9Utils.parseJsonStr(jsonStr);
		int result = paymentService.insertPaymentInfo(param);
		
		return result;
	}

}
