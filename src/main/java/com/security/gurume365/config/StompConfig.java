package com.security.gurume365.config;

import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.messaging.simp.user.SimpUserRegistry;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketTransportRegistration;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.security.gurume365.intercepter.HandshakeInterceptor;





@Configuration
@EnableWebSocketMessageBroker
public class StompConfig extends AbstractWebSocketMessageBrokerConfigurer {

	@Autowired
	private HandshakeInterceptor handshakeInterceptor;
	@Autowired
	private SimpUserRegistry userRegistry;
	
	
	@Override
	public void configureWebSocketTransport(WebSocketTransportRegistration registration) {
		registration.setSendTimeLimit(15 * 1000).setSendBufferSizeLimit(512 * 1024);
		System.out.println("configureWebSocketTransport :" +registration);
		super.configureWebSocketTransport(registration);
	}

	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		registry.enableSimpleBroker("/subscribe");			// subscribe prefix 설정
		registry.setApplicationDestinationPrefixes("/");		// send prefix 설정
		System.out.println("configureMessageBroker :" +registry);
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/endpoint").withSockJS().setInterceptors(handshakeInterceptor);
		System.out.println("registerStompEndpoints :" +registry);
	}
	@EventListener
	public void onDisconnectEvent(SessionDisconnectEvent event) {
		System.out.println("Client disconnected by:"+ event.getUser());
	}
	@EventListener
	public void onConnectEvent(SessionConnectEvent event){
		userRegistry.getUsers().stream().map(u -> u.getName()).forEach(System.out::println);
		
		System.out.println("Client connected by :"+ event.getUser());
	}
	
	

}
