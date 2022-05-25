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
public class AdminSetting implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String email;
	private String phone;
	private String callerId;
	private String thumbnailImg;
	private String faviconImg;
	private String isDiscount;
	private int historyLayoutNo;
	private int historyViewType;


}
