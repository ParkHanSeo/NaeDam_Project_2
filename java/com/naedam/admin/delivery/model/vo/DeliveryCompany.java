package com.naedam.admin.delivery.model.vo;

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
public class DeliveryCompany implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int deliComNo;
	private String deliComName;
	private String traceUrl;
	private String showYn;
	private Date regDate;

}
