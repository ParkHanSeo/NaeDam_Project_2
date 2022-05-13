package com.naedam.admin.payment.model.service;

import java.util.List;
import java.util.Map;

import com.naedam.admin.payment.model.vo.PaymentInfo;


public interface PaymentService {

	int insertPaymentInfo(Map<String, Object> param);

	List<PaymentInfo> selectPaymentInfoList();

	int selectTodayPaidCnt();

	int selectTodayPayReadyCnt();

	int selectTotalSaleAmountMonth();

	int selectTotalCancelAmountMonth();

	int selectMonthCancelCnt();
	
}

