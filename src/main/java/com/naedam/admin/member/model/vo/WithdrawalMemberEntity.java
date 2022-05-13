package com.naedam.admin.member.model.vo;

import java.util.Date;
import java.util.List;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class WithdrawalMemberEntity extends Member {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int addressZipcode; 
	private String addressMain;
	private String addressSub;
	private String memberMemoContent;
	
	public WithdrawalMemberEntity(int memberNo, String firstName, String lastName, String email, String phone,
			Date regDate, String status, String id, String password, String profileImg, Date updateDate, Date loginDate,
			List<SimpleGrantedAuthority> authorities,
			int addressZipcode,
			String addressMain,
			String addressSub,
			String memberMemoContent,
			String reason,
			Date withdrawalDate) {
		
		super(memberNo, firstName, lastName, email, phone, regDate, status, id, password, profileImg, updateDate, loginDate,
				withdrawalDate, reason, authorities);
		
		this.addressZipcode = addressZipcode;
		this.addressMain = addressMain;
		this.addressSub = addressSub;
		this.memberMemoContent = memberMemoContent;
	}
	
	

}
