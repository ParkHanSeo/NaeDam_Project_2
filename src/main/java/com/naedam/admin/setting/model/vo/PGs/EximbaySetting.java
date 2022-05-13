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
public class EximbaySetting implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String useEximbay;
	private String moduleVersionEximbay;
	private String useCreditEximbay;
	private String usePaypal;
	private String useUnion;
	private String useAli;
	private int pgModeEximbay;
	private String mid;
	private String secretKey;
}
