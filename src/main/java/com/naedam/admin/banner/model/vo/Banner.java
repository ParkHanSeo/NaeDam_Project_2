package com.naedam.admin.banner.model.vo;

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
public class Banner implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int bannerNo;
	private int categoryNo;
	private String categoryName;
	private String imgUrl;
	private String bannerName;
	private String linkUrl;
	private Date regDate;
	private String status;
	private int targetNo;
	private String tag;

}
