package com.security.gurume365.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
/**
 * 계정을 관리하는 객체를 생성
 * UsersDetails 인터페이스로 implements 받아 세션 정보를 User 클래스에 담아 다닌다.
 * @author Admin
 *
 */
public class Member implements UserDetails  {

	private static final long serialVersionUID = 1L;
	private Users user;
	
	public Member(Users user) { this.user = user; }
	
	public Users getuser() { return user; }
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
	
		return authorities;
	}
	
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return user.getPw();
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return user.getName();
	}
	//계정의 만료: 1) 기간제 계정 2) 패스워드 변경기간이 지남
    //false : 만료되었을 때 처리를 적절히 해주어야 한다.

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	 //인증정보 메서드: 패스워드 처리하기
	
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	//휴면계정인지 아닌지 구분하는 메서드

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
	public String getId() {
		return getuser().getId();
	}
	public String getPw() {
		return getuser().getPw();
	}
	public String getName() {
		return getuser().getName();
	}
	public String getDate_of_birth() {
		return getuser().getDateOfBirth();
	}
	public String getPhone() {
		return getuser().getPhone();
	}
	public String getPermit() {
		return getuser().getPermit();
	}
	public int getDivision() {
		return getuser().getDivision();
	}
	public int getEnabled() {
		return getuser().getEnabled();
	}
}
