package com.naedam.admin.member.model.vo;

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
public class MemberListExcelForm implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String id;
	private String memberName;
	private String phone;
	private String email;
	private String totalAddress;
	private String memo;
	private String grade;
	private String status;
	private Date loginDate;
	private Date updateDate;
	private Date regDate;
}
