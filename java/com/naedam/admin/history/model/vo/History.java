package com.naedam.admin.history.model.vo;

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
public class History implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int historyNo;
	private Date historyDate;
	private String content;
	private String imgUrl;

}
