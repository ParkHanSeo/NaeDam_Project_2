package com.naedam.admin.coupon.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

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
	public String coupon_process(HttpServletRequest request, Coupon coupon, RedirectAttributes redirectAttr) {
		String mode = request.getParameter("mode");
		String msg = null;
		int result = 0;
		
		
		log.debug("mode = {}",mode);
		if(mode.equals("insertCoupon")) {
			if(request.getParameter("expiryType").equals("fix")) {
				coupon.setExpiryStartDate(stringToDate(request.getParameter("expiry_start_date")));
				coupon.setExpiryEndDate(stringToDate(request.getParameter("expiry_end_date")));
			}
			result = couponService.insertCoupon(coupon);
		}else if(mode.equals("updateCoupon")) {
			if(request.getParameter("expiryType").equals("fix")) {
				coupon.setExpiryStartDate(stringToDate(request.getParameter("expiry_start_date")));
				coupon.setExpiryEndDate(stringToDate(request.getParameter("expiry_end_date")));
			}
			result = couponService.updateCoupon(coupon);
			if(result > 0) msg = "쿠폰 정보가 수정되었습니다.";
			
		}else if(mode.equals("deleteCoupon")) {
			List<String> couponNoList = Arrays.asList(request.getParameterValues("list[]"));
			for(String couponNo : couponNoList) {
				result = couponService.deleteCoupon(Integer.parseInt(couponNo));
			}
			if(result > 0) msg = "쿠폰이 삭제되었습니다.";
		}
		redirectAttr.addFlashAttribute("msg", msg);
		return "redirect:/admin/setting/coupon";
	}
	
	private Date stringToDate(String dateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		try {
			date = sdf.parse(dateStr);
		} catch (ParseException e) {}
		return date;
	}
}
