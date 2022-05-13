package com.naedam.admin.menu.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MenuCategory implements Serializable {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int menuCategoryNo;
	private String menuCategoryName;
	private int originNo;
	private int ord;
	private int layer;
	private String menuCategoryType;
	private String status;
}
