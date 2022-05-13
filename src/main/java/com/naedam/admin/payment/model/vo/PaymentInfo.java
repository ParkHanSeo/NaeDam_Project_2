package com.naedam.admin.payment.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class PaymentInfo implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int amount;
	private String impUid;
	private long merchantUid;
	private String buyerAddr;
	private String buyerName;
	private String buyerPostcode;
	private String buyerTel;
	private int cancelAmount;
	private String cancelHistory;
	private String cancelReason;
	private Date cancelAt;
	private String name;
	private Date paidAt;
	private String payMethod;
	private String status;
	

}
