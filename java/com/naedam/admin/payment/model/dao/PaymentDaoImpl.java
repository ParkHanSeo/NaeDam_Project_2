package com.naedam.admin.payment.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.payment.model.vo.PaymentInfo;

@Repository
public class PaymentDaoImpl implements PaymentDao {
	@Autowired
	private SqlSession session;

	@Override
	public int insertPaymentInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.insert("payment.insertPaymentInfo", param);
	}

	@Override
	public List<PaymentInfo> selectPaymentInfoList() {
		// TODO Auto-generated method stub
		return session.selectList("payment.selectPaymentInfoList");
	}

	@Override
	public int selectTodayPaidCnt() {
		// TODO Auto-generated method stub
		return session.selectOne("payment.selectTodayPaidCnt");
	}

	@Override
	public int selectTodayPayReadyCnt() {
		// TODO Auto-generated method stub
		return session.selectOne("payment.selectTodayPayReadyCnt");
	}

	@Override
	public int selectTotalSaleAmountMonth() {
		// TODO Auto-generated method stub
		return session.selectOne("payment.selectTotalSaleAmountMonth");
	}

	@Override
	public int selectTotalCancelAmountMonth() {
		// TODO Auto-generated method stub
		return session.selectOne("payment.selectTotalCancelAmountMonth");
	}

	@Override
	public int selectMonthCancelCnt() {
		// TODO Auto-generated method stub
		return session.selectOne("payment.selectMonthCancelCnt");
	}
	
	
}
