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
public class BillingPgSetting implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String isDomestic;
	private String isForeigne;
	private String cardPg;
	private String naverpayUse;

}
