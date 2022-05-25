package com.naedam.admin.order.model.vo;

import java.io.Serializable;

public class OrderExcelForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int rowNum;
	private long orderNo;
	private String productName;
	private String name;
	private String phone;
	private int payAmt;
	private String paytype;
	private String bankName;
	private String accountInfoOwner;
	private String receiver;
	private String receiverPhone;
	private String shippingAddress;
	private String memo;
	private String statusName;
	
	
}
