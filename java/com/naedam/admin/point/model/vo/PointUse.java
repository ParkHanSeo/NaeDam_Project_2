package com.naedam.admin.point.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class PointUse implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int pointUseNo;
	private int pointUnit;
	private int pointLimitUsePoint;
	private int pointLimitUseAmount;
	private int pointLimitUseDay;
}
