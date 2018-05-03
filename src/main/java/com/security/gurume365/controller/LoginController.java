package com.security.gurume365.controller;

import java.io.UnsupportedEncodingException;
import java.util.Locale;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.security.gurume365.MailHandler;
import com.security.gurume365.dao.UsersDAO;
import com.security.gurume365.vo.Member;
import com.security.gurume365.vo.Users;

@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	UsersDAO usersDAO;
	
	@Inject
	private JavaMailSender mailSender;
	

	@RequestMapping(value = "/login/loginForm", method = RequestMethod.GET)
	public String loginFor(Locale locale, Model model) {
		logger.info("Welcome Login Form!");
		
		return "login/loginForm";
	}
	@RequestMapping(value = "/loginInfo", method = RequestMethod.GET)
	public String loginInfo(Locale locale, Model model, Authentication auth) {
		return "home";
	}
	
	@RequestMapping(value = "/login/accessDenied", method = RequestMethod.GET)
	public String accessDenied(Locale locale, Model model) {
		logger.info("Welcome Access Denied!");
		
		return "login/accessDenied";
	}
	
	
	@RequestMapping(value="/join/joinPermission",method=RequestMethod.GET)
	public String joinPermission(Locale locale, Model model){
		logger.info("Welcome JoinPermission");
		return "join/joinPermission";
	}
	
	
	
	@RequestMapping(value="/join/joinPermitBanner",method=RequestMethod.GET)
	public String joinPermit(Locale locale, Model model){
		logger.info("Welcome JoinPermit");
		return "join/joinPermit";
	}
	
	@RequestMapping(value="/join/joinForm",method=RequestMethod.GET)
	public String joinForm(Locale locale){
		logger.info("Welcome JoinForm");
		return "join/joinForm";
	}
	

	@RequestMapping(value="/join/insertUsers",method=RequestMethod.POST)
	@ResponseBody
	public void insertUsers(Users users) throws MessagingException, UnsupportedEncodingException{
		StringBuffer buffer = new StringBuffer();
		for(int i=0; i<=8; i++){
			int n = (int)(Math.random()*10);
			buffer.append(n);
		}
		String token = buffer.toString();
		System.out.println(users.getId());
		users.setPermitToken(token);
		
		usersDAO.insertUsers(users);
		
		String title = "GURUME365 ";
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject(title);
		sendMail.setText(new StringBuffer().append("<img src='https://image.ibb.co/jg0aMx/gurume.jpg' alt='gurume' border='0' /><br><h1>메일 인증</h1>")
				.append("<h3>보안토큰 번호:"+token+"</h3>")
				.append("<br><a href='http://203.233.199.169:8888/gurume365/'")
				.append("' target='_blank'>구루메 홈페이지 가기</a>").toString());
		sendMail.setFrom(title, title);
		sendMail.setTo(users.getId());
		sendMail.send();
	}
	
	@RequestMapping(value="/join/joinComplement",method=RequestMethod.GET)
	public String joinComplement(){
		return "join/joinComplement";
	}
	
	/*@RequestMapping(value="/join/joinPermit",method=RequestMethod.GET)
	public String joinPermit(String id){
		Users users = usersDAO.selectUsers(id);
		if(users.getPermit().equals("N")&&users!=null){
			usersDAO.permitUsers(users);
		}
		
		return "join/joinPermitComplement";
	}*/
	
	@RequestMapping(value="/join/updateUsers", method=RequestMethod.POST)
	public String updateUsers(@ModelAttribute("user")Users user,Model model,Authentication auth) {
		
		int result=0;
		user.setId(((Member)auth.getPrincipal()).getId());
		result=usersDAO.updateUsers(user);
		System.out.println(user+"From Controller");
		if(result!=1) {
			model.addAttribute("error", "수정 실패");
			return "join/joinInfoPage";
		}	
		return "redirect:/";
	}
	
	@RequestMapping(value="/join/withdrawPage", method=RequestMethod.GET)
	public String withdrawPage(Authentication auth, Model model) {
		auth = SecurityContextHolder.getContext().getAuthentication();
		Member user = (Member) auth.getPrincipal();
		model.addAttribute("user", user);
		model.addAttribute("userId", user.getId());
		model.addAttribute("phone", user.getPhone());
		model.addAttribute("pw", user.getPw());
		return "join/withdrawPage";
	}
	
	@RequestMapping(value="/join/myReservation", method=RequestMethod.GET)
	public String myReservationPage(Model model,Authentication auth) {
		
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
		
		return "join/myReservation";
	}
	
	@RequestMapping(value="join/myReview", method=RequestMethod.GET)
	public String myReview(Model model,Authentication auth) {
		
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
		
		return "join/myReview";
	}
	@RequestMapping(value="join/joinPermitComplement", method=RequestMethod.GET)
	public String joinPermitComplement(Model model,Authentication auth) {
		
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
		
		return "join/joinPermitComplement";
	}
	
	@RequestMapping(value="/join/restrictUsers", method=RequestMethod.POST)
	public String restrictUsers(@ModelAttribute("user")Users user,Model model,Authentication auth) {
		
		user.setId(((Member)auth.getPrincipal()).getId());
		usersDAO.restrictUsers(user);
		
		System.out.println("유저 접근 제한");
	 
		return "redirect:/logout";
	}
	
	// permit user
	@RequestMapping(value="join/permitCheck",method=RequestMethod.POST)
	@ResponseBody
	public int permitCheck(String permitToken){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String id = ((Member)auth.getPrincipal()).getId();
		int result = 0;
		logger.info("token:" + permitToken);
		result = usersDAO.permitUsers(id, permitToken);
		
		return result;
	}
	
	
	/*@RequestMapping(value="/join/idCheck",method=RequestMethod.POST)
	@ResponseBody
	public String idCheck(Model model, String id){
		Users users = usersDAO.selectUsers(id);
		if(users==null){
			return "Y";
		}else{
			return "N";
		}
	}*/
}
