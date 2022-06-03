package com.naedam.admin.coupon.model.service;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.coupon.model.dao.CouponDao;
import com.naedam.admin.coupon.model.vo.Coupon;
import com.naedam.admin.coupon.model.vo.MemberCoupon;

@Service
public class CouponServiceImpl implements CouponService {
	@Autowired
	private CouponDao couponDao;
	

	@Override
	public Map<String, Object> couponProcess(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<>();
		Coupon coupon = (Coupon) map.get("coupon");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		if("insertCoupon".equals(map.get("mode"))) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(request.getParameter("expiryType").equals("fix")) {
				coupon.setExpiryStartDate((Date) sdf.parse(request.getParameter("expiry_start_date")));
				coupon.setExpiryEndDate((Date) sdf.parse(request.getParameter("expiry_end_date")));
			}
			couponDao.insertCoupon(coupon);
			resultMap.put("msg", "쿠폰 정보가 등록되었습니다.");
		}else if("updateCoupon".equals(map.get("mode"))) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(request.getParameter("expiryType").equals("fix")) {
				coupon.setExpiryStartDate((Date) sdf.parse(request.getParameter("expiry_start_date")));
				coupon.setExpiryEndDate((Date) sdf.parse(request.getParameter("expiry_end_date")));
			}
			couponDao.updateCoupon(coupon);
			resultMap.put("msg", "쿠폰 정보가 수정되었습니다.");
		}else if("deleteCoupon".equals(map.get("mode"))) {
			List<String> couponNoList = Arrays.asList(request.getParameterValues("list[]"));
			for(String couponNo : couponNoList) {
				couponDao.deleteCoupon(Integer.parseInt(couponNo));
			}
			resultMap.put("msg", "쿠폰이 삭제되었습니다.");
		}
		
		return resultMap;
	}	
	
	@Override
	public Coupon selectOneCouponByCouponNo(int couponNo) {
		// TODO Auto-generated method stub
		return couponDao.selectOneCouponByCouponNo(couponNo);
	}

	@Override
	public int insertCoupon(Coupon coupon) {
		// TODO Auto-generated method stub
		return couponDao.insertCoupon(coupon);
	}

	@Override
	public int updateCoupon(Coupon coupon) {
		// TODO Auto-generated method stub
		return couponDao.updateCoupon(coupon);
	}

	@Override
	public int deleteCoupon(int couponNo) {
		// TODO Auto-generated method stub
		return couponDao.deleteCoupon(couponNo);
	}

	@Override
	public List<Coupon> selectCouponList() {
		// TODO Auto-generated method stub
		return couponDao.selectCouponList();
	}


}
