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
public class ReviewCategory implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int reviewCategoryNo;
	private String reviewCategoryName;
	
}
