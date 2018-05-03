package com.security.gurume365.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;


//로그인을 시도하는 유저의 비밀번호가 일치하는지를 비교해서 인증에 성공하게 되면 
//Authentication 객체를 리턴해주는 것을 구현해야하는 인터페이스
public interface AuthenticationManager {
	
	Authentication authenticate(Authentication authentication) throws AuthenticationException;

}
