package com.security.gurume365.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class EventController {

		//샵 기본 정보 페이지로 이동
		@RequestMapping(value="/event/eventInfo", method=RequestMethod.GET)
		public String goEvent() {
				
			return "event/event";
		}
		
		//샵 기본 정보 페이지로 이동
		@RequestMapping(value="/event/event1", method=RequestMethod.GET)
		public String goEvent1() {
				
			return "event/event1";
		}
		//샵 기본 정보 페이지로 이동
		@RequestMapping(value="/event/event2", method=RequestMethod.GET)
		public String goEvent2() {
				
			return "event/event2";
		}
		//샵 기본 정보 페이지로 이동
		@RequestMapping(value="/event/event3", method=RequestMethod.GET)
		public String goEvent3() {
				
			return "event/event3";
			}
}
