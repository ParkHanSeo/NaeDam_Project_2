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
public class ProductExcelForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String categoryName;
	private String modelName;
	private String productName;
	private String listTitle;
	private String simpleDis;
	private int retailPrice;
	private int salePrice;
	private String optionName;
	private String detailDis;
	private String productNew;
	private String productBest;
	private String productEvent;
	private String langType;
	private String isSoldOut;
	private String status;
	private Date regDate;

}
