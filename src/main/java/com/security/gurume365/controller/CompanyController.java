package com.security.gurume365.controller;

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
public class CompanyController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	
	@RequestMapping(value="/join/joinInfoPage",method=RequestMethod.GET)
	public String joinInfoPage(){
		return "join/joinInfoPage";
	}
	@RequestMapping(value="/join/userMyPage", method=RequestMethod.GET)
	public String joinMyPage(Model model, Authentication auth) {
		
		try {
			auth = SecurityContextHolder.getContext().getAuthentication();
			Member user = (Member) auth.getPrincipal();
			model.addAttribute("user", user);
			model.addAttribute("id", user.getId());
			model.addAttribute("name", user.getName());
			model.addAttribute("birth", user.getDate_of_birth());
			model.addAttribute("phone", user.getPhone());
			logger.info(""+user.getId());
			logger.info(""+user.getDate_of_birth());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "join/userMyPage";
	}
	
	
	@RequestMapping(value="/join/jusoPopup",method=RequestMethod.GET)
	public String jusoPopup(){
		return "join/jusoPopup";
	}
	@RequestMapping(value="/join/joinInfoRes",method=RequestMethod.GET)
	public String joinInfoRes(int shopNo, Model model){
		model.addAttribute("shopNo", shopNo);
		return "join/joinInfoRes";
	}
	@RequestMapping(value="/join/jusoPopup",method=RequestMethod.POST)
	public String jusoPopup(Model model,String addrDetail,String roadAddrPart1){
		model.addAttribute("address", addrDetail);
		model.addAttribute("address2", roadAddrPart1);
		return "join/jusoData";
	}
	
	@RequestMapping(value="/join/companyInfo", method=RequestMethod.GET)
	public String companyInfoPage() {
		
		return "join/companyInfo";
	}
}
