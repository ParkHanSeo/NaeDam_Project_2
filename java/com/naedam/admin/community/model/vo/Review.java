package com.naedam.admin.community.model.vo;

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
public class Review implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	private int reviewCode; 
	private long orderNo;
	private int memberNo;
	private int productNo; 
	private int reviewCategoryNo; 
	private String reviewTitle;
	private String reviewContent;
	private Date reviewDate; 
	
	private String writer; // 주문자명 
	private String productName; // 제품명
	private String reviewCategoryName; // 후기카테고리명

}
