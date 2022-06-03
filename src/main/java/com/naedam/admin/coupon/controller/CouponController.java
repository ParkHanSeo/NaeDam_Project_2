package com.naedam.admin.coupon.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naedam.admin.coupon.model.service.CouponService;
import com.naedam.admin.coupon.model.vo.Coupon;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/coupon")
@Slf4j
public class CouponController {
	@Autowired
	private CouponService couponService;
	
	@PostMapping("/getCoupon")
	@ResponseBody
	public Coupon getCoupon(int couponNo) {
		Coupon coupon = couponService.selectOneCouponByCouponNo(couponNo);
		
		return coupon;
	}
	
	@PostMapping("/coupon_process")
	public String coupon_process(HttpServletRequest request, Coupon coupon, RedirectAttributes redirectAttr) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("mode", request.getParameter("mode"));
		map.put("coupon", coupon);
		map.put("expiryType", request.getParameter("expiryType"));
		map.put("request", request);
		Map<String, Object> resultMap = couponService.couponProcess(map);
		redirectAttr.addFlashAttribute("msg", (String)resultMap.get("msg"));
		return "redirect:/admin/setting/coupon";
	}

}
