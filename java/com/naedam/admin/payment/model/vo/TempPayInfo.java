package com.naedam.admin.payment.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TempPayInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int amount;
	private String imp_uid;
	private String merchant_uid;
	private String buyer_addr;
	private String buyer_name;
	private String buyer_postcode;
	private String buyer_tel;
	private double cancel_amount;
	private String cancel_reason;
	private double cancel_at;
	private String name;
	private double paid_at;
	private String pay_method;
}
