package com.naedam.admin.community.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Sms implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	private int smsCode;
	private String receiveCode;
	private String sendPhone;
	private String requestId;
	private String receivePhone; 
	private String receiveTitle;
	private String receiveContent;
	private float smsPoint; // default 9.9
	private Date receiveDate;
	
	private String reDate;

}
