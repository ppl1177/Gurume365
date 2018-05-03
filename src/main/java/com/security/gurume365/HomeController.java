package com.security.gurume365;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.security.gurume365.vo.Member;

@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home!");
		
		return "home";
	}
	
	@RequestMapping(value = "/intro/introduction", method = RequestMethod.GET)
	public String introduction(Locale locale, Model model) {
		logger.info("Welcome Introduction!");
		
		return "intro/introduction";
	}
}
