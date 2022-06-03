package com.naedam.admin.coupon.model.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.naedam.admin.coupon.model.vo.Coupon;
import com.naedam.admin.coupon.model.vo.MemberCoupon;

public interface CouponService {
	
	Map<String, Object> couponProcess(Map<String, Object> map) throws Exception;
	
	Coupon selectOneCouponByCouponNo(int couponNo);

	int insertCoupon(Coupon coupon);

	int updateCoupon(Coupon coupon);

	int deleteCoupon(int couponNo);

	List<Coupon> selectCouponList();

}
