package com.naedam.admin.popup.model.vo;

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
public class Popup implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int code;
	private Date startDate;
	private Date endDate;
	private String title;
	private int leftPosition;
	private int topPosition;
	private int width;
	private int height;
	private String display;
	private String popupCookie;
	private String url;
	private String locale;
	private String content;
	private Date regDate;

}
