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
public class ProductDetail implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int productNo;
	private String imgUrl;
	private String categoryName;
	private String productName;
	private String modelName;
	private String listTitle;
	private int salePrice;
	private Date regDate;
	private String status;
	private int categoryNo;
	
	

}
