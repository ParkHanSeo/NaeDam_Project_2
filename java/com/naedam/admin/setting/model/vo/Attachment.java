package com.naedam.admin.setting.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attachment implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int no;
	private int staffNo;
	private String originalFilename;
	private String renamedFilename;
	private Date uploadDate;
	private boolean status; // JdbcType CHAR(1) 'Y', 'N'
}
