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
public class KgIniSetting implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String useIni;
	private String moduleVersionIni;
	private String useCreditIni;
	private String useBankIni;
	private String useVBankIni;
	private int pgModeIni;
	private String storeIdIni;
	private String signKey;
	private String keyFile;

}
