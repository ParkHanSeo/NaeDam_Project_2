package com.naedam.admin.board.model.vo;

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
public class BoardOption implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int optionNo;			//기타옵션 번호
	private Board optionBoard;			//board의 데이터 FK
	private String optionNotice;	//공지기능
	private String optionComment;	//댓글
	private String optionSecret;	//비밀글
	private String optionAnswer;	//답변기능
	private String optionCaptcha;	//도용방지문자
	private String optionMass;		//대용량 업로드
	private String optionOrder;	//순서변경
	private String optionAddinfo;	//추가정보
	private String optionPopup;	//상세보기(팝업)
	
	//private String optionCategory;	//기타옵션 종류
}
