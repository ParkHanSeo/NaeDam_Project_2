package com.naedam.admin.map.model.vo;

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
public class Maps implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int mapNo;
	private String mapTitle;
	private int mapApiNo;
	private String address;
	private String mapApiName;
	private String apiKey;
	private double latitude;
	private double longitude;
	private String width;
	private String height;
	private int zoomLevel;
	private String popupInfo;
	private String connectingAddr;
	private Date regDate;

}
