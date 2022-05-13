package com.naedam.admin.member.model.vo;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Member implements Serializable, UserDetails {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int memberNo;
	private String firstName;
	private String lastName;
	private String email;
	private String phone;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy/MM/dd HH:mm", timezone="Asia/Seoul")
	private Date regDate;
	private String status; // 회원 활성화 여부
	private String id;
	private String password;
	private String profileImg;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy/MM/dd HH:mm", timezone="Asia/Seoul")
	private Date updateDate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy/MM/dd HH:mm", timezone="Asia/Seoul")
	private Date loginDate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy/MM/dd HH:mm", timezone="Asia/Seoul")
	private Date withdrawalDate;
	private String reason;
	//private String name;
	
	/**
	 * 회원권한리스트
	 * SimpleGrantedAuthority
	 *  - GrantedAuthority의 구현클래스로 문자열로 된 권한정보를 생성자의 인자로 받는다.
	 */
	private List<SimpleGrantedAuthority> authorities;
	
	// 계정이 갖고있는 권한 목록은 리턴
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}
	
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return id;
	}
	
	// 계정이 만료되지 않았는지 리턴(true : 만료 안됨)
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	
	// 계정이 잠겨있는지 않았는지 리턴(true : 잠기지 않음)
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	
	// 비밀번호가 만료되지 않았는지 리턴(true : 만료 안됨)
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	
	// 계정이 활성화(사용가능)인지 리턴(true : 활성화)
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
}
