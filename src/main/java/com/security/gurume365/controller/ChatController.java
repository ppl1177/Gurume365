package com.security.gurume365.controller;

import java.time.LocalDateTime;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.security.gurume365.domain.Message;
import com.security.gurume365.vo.Member;




@Controller
public class ChatController {
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
		
	//멀티 채팅방
		@MessageMapping("/chat/{roomName}")				// stompClient.send("/chat", ...)의 첫번째 파라미터와 동일
		@SendTo("/subscribe/chat/{roomName}")				//	stompClient.subscribe("/subscribe/chat", ...)의 첫번쨰 파라미터와 동일
		public Message sendChatMessage(@DestinationVariable("roomName") String roomName,
				Message message, SimpMessageHeaderAccessor headerAccessor){
			logger.info("채팅 컨트롤러 시작");
			//인터셉터에서 등록해두었던 사용자 정보 가져오기
			Member userObject = (Member)headerAccessor.getSessionAttributes().get("user");
			
			message.setId(userObject.getId());
			message.setUsername(userObject.getName());
			message.setChatdate(LocalDateTime.now());
			
			logger.info("채팅 컨트롤러 종료");
			return message;
		}
		
		@RequestMapping(value = "/multiChatRoom", method = RequestMethod.GET)
	      public String multiChatRoom(String roomName, Model model) {
	      model.addAttribute("roomName",roomName);
	      return "chat/multiChatRoom";
	      }
		
}
