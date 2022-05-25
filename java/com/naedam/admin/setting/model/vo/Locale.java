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
public class Locale implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String localeCode;
	private String localeName;
	private String isDefault;
	private String isChoosen;
	
}
