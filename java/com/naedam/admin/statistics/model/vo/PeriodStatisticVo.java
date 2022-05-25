package com.naedam.admin.statistics.model.vo;

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
public class PeriodStatisticVo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Date paidAt;
	private double totalAmount;
	private double totalCancelAmount;
	private int totalSalePrice;
	private int totalDeliFee;
	private int totalCouponAmount;
	private int totalPointAmount;
	private int totalOptionCost;
	private int totalSalePriceCancel;
	private int totalDeliFeeCancel;
	private int totalCouponAmountCancel;
	private int totalPointAmountCancel;
	private int totalOptionCostCancel;
}
