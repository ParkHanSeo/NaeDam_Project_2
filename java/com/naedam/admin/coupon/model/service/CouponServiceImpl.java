package com.naedam.admin.coupon.model.service;

import java.util.List;

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

	@Override
	public int insertMemberCoupon(MemberCoupon memberCoupon) {
		// TODO Auto-generated method stub
		return couponDao.insertMemberCoupon(memberCoupon);
	}
	
	@Override
	public List<Coupon> getCoupon(String code) {
		return couponDao.getCoupon(code);
	}	
	
}
