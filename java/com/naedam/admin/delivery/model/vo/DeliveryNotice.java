package com.naedam.admin.delivery.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class DeliveryNotice implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String content;
	private String locale;
	
}
