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
public class SnsSetting implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int snsSettingNo;
	private String mode;
	private String noneMemberUse;
	private String kakaoUse;
	private String kakaoSnsKey;
	private String naverUse;
	private String naverSnsId;
	private String naverSnsKey;
	private String googleUse;
	private String googleSnsId;
	private String googleSnsKey;
	private String facebookUse;
	private String facebookSnsId;
	private String facebookSnsKey;
	private String twitterUse;
	private String twitterSnsId;
	private String twitterSnsKey;
	
}
