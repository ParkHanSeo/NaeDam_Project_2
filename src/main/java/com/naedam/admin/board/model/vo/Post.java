package com.naedam.admin.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.naedam.admin.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Post implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int postNo;				//게시글번호
	private Board postBoard;		//board의 데이터
	private String postTitle;		//게시판종류제목
	private String postContents;	//게시판종류내용
	private String postDate;		//게시판종류작성일자
	private String postThombnail;	//게시판종류섬네일
	private int postNotice;			//게시판 공지
	private int postOriginNo;		//계층형 쿼리를 위한 postNo
	private int postOrd;			//계층형 쿼리 1
	private int postLayer;			//계층형 쿼리 2 답글의 답글
	private int postAsc;			//순서변경
	private int postViewCount;		//게시판종류 본횟수
	private int postDownloadCount;  //다운로드수
	private Member postMember;		//회원데이터
	private String postMemberName;
	
}
