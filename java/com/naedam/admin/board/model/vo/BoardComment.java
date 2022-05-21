package com.naedam.admin.board.model.vo;

import java.io.Serializable;

import com.naedam.admin.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BoardComment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int commentNo;
	private String commentContents;
	private String commentData;
	private Member commentMember;
	private Post commentPost;
	private String commentWriter;
	private int commentMemberNo;
	private int commentPostNo;
	
}
