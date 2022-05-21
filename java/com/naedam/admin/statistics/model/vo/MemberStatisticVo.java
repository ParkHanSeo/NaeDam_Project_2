package com.naedam.admin.statistics.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MemberStatisticVo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int ranking;
	private String name;
	private String id;
	private int totalAmount;
	private int totalAmountCancel;
	private int total;
	private int orderCnt;
	private int cancelCnt;
}
