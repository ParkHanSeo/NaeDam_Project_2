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
public class KcpSetting implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String useKcp;
	private String moduleVersionKcp;
	private String useCredit;
	private String useBank;
	private String useVBank;
	private int pgMode;
	private String siteCd;
	private String siteKey;
}
