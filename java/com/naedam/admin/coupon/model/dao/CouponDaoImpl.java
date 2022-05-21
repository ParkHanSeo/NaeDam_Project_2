package com.naedam.admin.coupon.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.coupon.model.vo.Coupon;
import com.naedam.admin.coupon.model.vo.MemberCoupon;

@Repository
public class CouponDaoImpl implements CouponDao {
	@Autowired
	private SqlSession session;

	@Override
	public Coupon selectOneCouponByCouponNo(int couponNo) {
		// TODO Auto-generated method stub
		return session.selectOne("coupon.selectOneCouponByCouponNo", couponNo);
	}

	@Override
	public int insertCoupon(Coupon coupon) {
		// TODO Auto-generated method stub
		return session.insert("coupon.insertCoupon", coupon);
	}

	@Override
	public int updateCoupon(Coupon coupon) {
		// TODO Auto-generated method stub
		return session.update("coupon.updateCoupon", coupon);
	}

	@Override
	public int deleteCoupon(int couponNo) {
		// TODO Auto-generated method stub
		return session.delete("coupon.deleteCoupon", couponNo);
	}

	@Override
	public List<Coupon> selectCouponList() {
		// TODO Auto-generated method stub
		return session.selectList("coupon.selectCouponList");
	}

	@Override
	public int insertMemberCoupon(MemberCoupon memberCoupon) {
		// TODO Auto-generated method stub
		return session.insert("coupon.insertMemberCoupon", memberCoupon);
	}
	
	@Override
	public List<Coupon> getCoupon(String code) {
		return session.selectList("coupon.getCoupon", code);
	}
	
}
