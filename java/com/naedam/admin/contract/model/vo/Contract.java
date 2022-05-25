package com.naedam.admin.contract.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Contract implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int code;
	private String provision;
	private String privacy;
	private String email;
	private String personal;
	private String distinguish;
	private String locale;
}
