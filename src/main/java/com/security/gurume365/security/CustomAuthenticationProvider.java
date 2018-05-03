package com.security.gurume365.security;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.security.gurume365.vo.Member;
import com.security.gurume365.vo.Users;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	static final Logger logger = LoggerFactory.getLogger(CustomAuthenticationProvider.class);

	@Autowired(required = true)
	private CustomUserDetailsService customUserDetailsService;

	public CustomAuthenticationProvider() {
		super();
	}

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// 유저정보 + 아이디 비밀번호 토큰
		UsernamePasswordAuthenticationToken authToken = (UsernamePasswordAuthenticationToken) authentication;
		// UserDetailsService에서 디비를 거쳐서 유저정보를 불러옴
		logger.info("authToken 확인" + authToken + "정보확인?");

		Member userInfo = customUserDetailsService.loadUserByUsername(authToken.getName());
		if (userInfo == null) {
			throw new UsernameNotFoundException(authToken.getName());
		}

		if (!matchPassword(userInfo.getPassword(), authToken.getCredentials())) {
			throw new BadCredentialsException("not matching username or password");
		}
		// 유저가 가진 권한을 읽어온다.
		List<GrantedAuthority> authorities = (List<GrantedAuthority>) userInfo.getAuthorities();
		if (userInfo.getuser().getDivision() == 1) {
			authorities.add(new SimpleGrantedAuthority("ROLE_LICENSEE"));
		}
		// 인증된 유저의 경우 [ROLE_USER / AUTHENTICATED_USER ] 역할 가진다.
		if (userInfo.getuser().getPermit().equals("Y")) {
			authorities.add(new SimpleGrantedAuthority("ROLE_AUTH_USER"));
		}
		if (authToken.getPrincipal().toString().equals("systemadmin")) {
			authorities.add(new SimpleGrantedAuthority("ROLE_SYSTEM"));
		}
		// 권한 바꾸기
		logger.info("authToken 확인 종료 auth 반환" + userInfo + "11 " + authorities);
		return new UsernamePasswordAuthenticationToken(userInfo, null, authorities);
	}

	private boolean matchPassword(String password, Object credentials) {
		return password.equals(credentials);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
}
