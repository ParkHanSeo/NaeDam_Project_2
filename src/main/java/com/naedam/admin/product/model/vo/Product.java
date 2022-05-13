package com.naedam.admin.product.model.vo;

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
public class Product implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int productNo;
	private int categoryNo;
	private int optionNo;
	private String modelName;
	private String productName;
	private String listTitle;
	private int retailPrice;
	private int salePrice;
	private String isSoldOut;
	private int individualPoint;
	private String status;
	private String langType;
	private int sellerNo;
	private String productNew;
	private String productBest;
	private String productEvent;
	private Date regDate;
}
