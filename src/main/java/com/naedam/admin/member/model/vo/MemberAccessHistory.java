package com.naedam.admin.member.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberAccessHistory implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int accessHistoryNo;
	private String accessHistoryId;
	private String accessHistoryName;
	private String accessHistoryIp;
	private String accessHistoryStatus;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy/MM/dd HH:mm", timezone="Asia/Seoul")
	private Date loginDate;
	private int memberNo;
	
}
