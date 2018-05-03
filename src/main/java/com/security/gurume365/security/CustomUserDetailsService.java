package com.security.gurume365.security;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.security.gurume365.dao.UsersDAO;
import com.security.gurume365.mapper.UsersMapper;
import com.security.gurume365.vo.Member;
import com.security.gurume365.vo.Users;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	static final Logger logger = LoggerFactory.getLogger(CustomUserDetailsService.class);
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public Member loadUserByUsername(String username) throws UsernameNotFoundException {
		// 디비에서 유저정보를 불러오는 메소드. 이것을 AutenticationProvider에서 인증을 통함
		WebApplicationContext ctx = ContextLoader.getCurrentWebApplicationContext();
		sqlSession = (SqlSession) ctx.getBean("sqlSession");
		
		logger.info("로드유저바이유저네임"+ username);
		Users userInfo = null;
		Member memberInfo = null;
		
		try {
			logger.info("UserInfo" +userInfo);
			UsersMapper mapper = sqlSession.getMapper(UsersMapper.class);
			userInfo = mapper.selectUsers(username);
			
			logger.info("로드유저바이유저네임"+ userInfo);
			memberInfo = new Member(userInfo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberInfo;
	}
}
