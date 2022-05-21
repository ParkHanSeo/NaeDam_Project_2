package com.naedam.admin.member.model.vo;

import java.util.Date;
import java.util.List;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class WithdrawalMember extends Member {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String address;	
	private String name;
	
	public WithdrawalMember(int memberNo, String firstName, String lastName, String email, String phone, Date regDate,
			String status, String id, String password, String profileImg, Date updateDate, Date loginDate,
			List<SimpleGrantedAuthority> authorities, Date withdrawalDate, String reason,
			String address,
			String name) {
		
		super(memberNo, firstName, lastName, email, phone, regDate, status, id, password, profileImg, updateDate, loginDate,
				withdrawalDate, reason, authorities);
		
		this.address = address;
		this.name = name;
	}

	
}
