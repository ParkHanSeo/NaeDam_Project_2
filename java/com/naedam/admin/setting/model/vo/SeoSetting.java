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
public class SeoSetting implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String naverFileName;
	private String googleFileName;
	private String bingFileName;
	private String siteMapFileName;
	
	private String robots;
	private String richSnippet;
	
}
