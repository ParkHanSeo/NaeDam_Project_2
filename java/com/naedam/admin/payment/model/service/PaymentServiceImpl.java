package com.naedam.admin.payment.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.payment.model.dao.PaymentDao;
import com.naedam.admin.payment.model.vo.PaymentInfo;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PaymentServiceImpl implements PaymentService {
	@Autowired
	private PaymentDao paymentDao;
	
	
	
	@Override
	public int insertPaymentInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return paymentDao.insertPaymentInfo(param);
	}



	@Override
	public List<PaymentInfo> selectPaymentInfoList() {
		// TODO Auto-generated method stub
		return paymentDao.selectPaymentInfoList();
	}



	@Override
	public int selectTodayPaidCnt() {
		// TODO Auto-generated method stub
		return paymentDao.selectTodayPaidCnt();
	}



	@Override
	public int selectTodayPayReadyCnt() {
		// TODO Auto-generated method stub
		return paymentDao.selectTodayPayReadyCnt();
	}



	@Override
	public int selectTotalSaleAmountMonth() {
		// TODO Auto-generated method stub
		return paymentDao.selectTotalSaleAmountMonth();
	}



	@Override
	public int selectTotalCancelAmountMonth() {
		// TODO Auto-generated method stub
		return paymentDao.selectTotalCancelAmountMonth();
	}



	@Override
	public int selectMonthCancelCnt() {
		// TODO Auto-generated method stub
		return paymentDao.selectMonthCancelCnt();
	}
	
	

}

