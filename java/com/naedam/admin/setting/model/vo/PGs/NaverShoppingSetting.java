package com.naedam.admin.setting.model.vo.PGs;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class NaverShoppingSetting implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String tsvUrl;
	private String productDbUrl;

}
