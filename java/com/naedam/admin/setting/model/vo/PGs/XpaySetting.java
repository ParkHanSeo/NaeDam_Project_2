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
public class XpaySetting implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String useXpay;
	private String moduleVersionXpay;
	private String useCreditXpay;
	private String useBankXpay;
	private String useVBankXpay;
	private int pgModeXpay;
	private String storeIdXpay;
	private String mertKey;
	
}
