package com.naedam.admin.setting.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AdminMenu implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int menuNo;
	private String menuName;
	private String status;
	
}
