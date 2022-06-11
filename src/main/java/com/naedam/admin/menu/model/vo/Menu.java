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
public class Menu implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	

	private int code; 
	private int category_code;
	private int revision_code;
	private String title; 
	private String content;
	private String is_outer_link; 
	private String target; 
	private String url; 
	private String status; 
	private int menu_head_code;	
	private String menuDate;
	private String is_meta;	
	private String meta_title;
	private String meta_description;
	private int menuAsc;
	private int originNo;
	private int ord;
	
	
	
	
	
	
}
