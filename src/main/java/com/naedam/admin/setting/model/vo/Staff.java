package com.naedam.admin.setting.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Staff implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int staffNo;
	private String staffName;
	private String staffPosition;
	private String staffCareer;
	private String staffProfile;
	private String imgUrl;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date regDate;
	private int rowNum;
	private int rowOrder;
	
	private String direction;
}
