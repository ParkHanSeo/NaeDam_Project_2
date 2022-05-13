package com.naedam.admin.community.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.naedam.admin.order.model.vo.OrderInfo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MsgInfo implements Serializable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long orderNo;
	private String statusName;
	private Date orderDate;
	private String firstName;
	private String lastName;
	private String email;
	private String phone;
	private String imgUrl;
	private String productName;
	private int salePrice;
	private int orderAmt;
	private int payAmount;
	private String receiver;
	private String receiverEmail;
	private String receiverPhone;
	private String shippingAddress;
	private String memo;
	private String payType;
	private String payMethod;
	private String account;
	private String bankName;
	private String owner;
	private String buyerName;
	private Date paidAt;
	
}
