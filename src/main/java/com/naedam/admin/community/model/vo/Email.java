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
public class Email implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	private int emailCode;
	private String receiveCode; 
	private String sendEmail;
	private String requestId;
	private String receiveEmail; 
	private String receiveTitle;
	private String receiveContent;
	private float emailPoint; // default 0.5
	private Date receiveDate;

	private String reDate;
}
