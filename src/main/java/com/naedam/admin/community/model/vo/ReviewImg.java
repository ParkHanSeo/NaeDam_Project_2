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
public class ReviewImg implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int reviewImgNo;
	private int reviewCode;
	private String originName;
	private String reviewImgUrl;
	
}
