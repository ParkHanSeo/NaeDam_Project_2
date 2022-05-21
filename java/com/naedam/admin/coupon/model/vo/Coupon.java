package com.naedam.admin.coupon.model.vo;

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
public class Coupon implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int couponNo;
	private String couponName;
	private String provideType;
	private String benefitType;
	private String discountType;
	private int discount;
	private int useLimit;
	private int useMax;
	private String expiryType;
	private Date expiryStartDate;
	private Date expiryEndDate;
	private String couponStatus;
	private Date regDate;
	

}
