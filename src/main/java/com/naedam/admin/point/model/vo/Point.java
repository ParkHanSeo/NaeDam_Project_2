package com.naedam.admin.point.model.vo;

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
public class Point implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int pointNo;
	private String pointUseType;
	private String pointName;
	

}
