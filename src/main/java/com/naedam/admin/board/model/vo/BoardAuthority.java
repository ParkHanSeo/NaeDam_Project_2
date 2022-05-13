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
public class BoardAuthority implements Serializable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int authorityNo;		//권한 번호
	private Board authorityBoard; //board의 데이터
	private String authorityList;	//리스트 권한 설정
	private String authorityView;	//보기 권한 설정
	private String authorityWrite;	//쓰기 권한 설정
	private String authorityUpdate; //수정 권한 설정
	private String authorityDelete; //삭제 권한 설정
	private String authorityAnswer; //답변 권한 설정
	private String authorityNotice; //공지 권한 설정
	private String authorityComment;//댓글 권한 설정
	
}
