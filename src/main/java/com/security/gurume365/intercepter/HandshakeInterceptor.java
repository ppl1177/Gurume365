package com.security.gurume365.intercepter;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.messaging.simp.user.SimpUserRegistry;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.security.gurume365.security.AuthenticationManager;
import com.security.gurume365.vo.Member;


@Component
public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor {
	
	private static final Logger logger = LoggerFactory.getLogger(HandshakeInterceptor.class);
	
	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		
		
		logger.info("***** Before Handshake *****");
	
		
		if(request instanceof ServletServerHttpRequest){
			ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
			
			//getSession안에 true를 함으로서 principal을 사용할수 있게 됨, 시큐리티 필수!!!!!!
			HttpSession session = servletRequest.getServletRequest().getSession(true);
			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			Member user = (Member) auth.getPrincipal();
			

			attributes.put("user", user);
		}
		
		logger.info("attr : {}" , attributes);
		
		return super.beforeHandshake(request, response, wsHandler, attributes);
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception ex) {
		logger.info("***** After Handshake *****");

		
		super.afterHandshake(request, response, wsHandler, ex);
	}

	
}
