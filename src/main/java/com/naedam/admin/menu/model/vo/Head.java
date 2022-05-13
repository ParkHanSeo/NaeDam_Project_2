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
public class Head implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int headNo;
	private String title;
	private String status;
	private String content;
	
	
}
