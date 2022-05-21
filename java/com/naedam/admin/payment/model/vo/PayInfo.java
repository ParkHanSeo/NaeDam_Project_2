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
public class PayInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int payInfoNo;
	private String payType;
	private int payAmt;
	private String payDepositor;
	private Date payDate;
	private int memberNo;
	private String impUid;
	private int amount;
	private long orderNo;

}
