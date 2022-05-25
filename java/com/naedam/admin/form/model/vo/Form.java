package com.naedam.admin.form.model.vo;

import java.io.Serializable;

import com.naedam.admin.board.model.vo.Board;
import com.naedam.admin.board.model.vo.BoardAuthority;
import com.naedam.admin.board.model.vo.BoardOption;
import com.naedam.admin.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Form implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int formNo;					//primary 번호
	private String title;				//폼메일 제목
	private String receive_email;		//수신메일 주소
	private String is_captcha;			//보안코드 사용유무
	private String is_agree;			//개인정보 수집이용 동의 의무
	private String agree_content;		//이건 뭐야
	private String formDate;			//폼메일 등록일자
	private String html_design_list;	//리스트 폼
	private String html_design_write;	//쓰기 폼
	
}
