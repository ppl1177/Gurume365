package com.security.gurume365.controller;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.security.gurume365.dao.RestaurantsDAO;
import com.security.gurume365.dao.ReviewDAO;
import com.security.gurume365.dao.StoreDAO;
import com.security.gurume365.util.FileService;
import com.security.gurume365.vo.Member;
import com.security.gurume365.vo.Restaurants;
import com.security.gurume365.vo.Review;
import com.security.gurume365.vo.Store;

@Controller
public class ReviewController {
	//@Resource(name = "uploadPath2")
	//private String uploadPath2;
	final String uploadPath = "/photofile";	//파일 업로드 경로
	final String concatSignal = "%(&*%";
	
	@Autowired
	StoreDAO dao;
	@Autowired
	ReviewDAO reviewDao;
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@RequestMapping(value = "/review/review", method = RequestMethod.GET)
	public String review(HttpSession session, Model model) {
		
		logger.info("리뷰페이지 진입");
		
		return "review/review";
	}

	@ResponseBody
	@RequestMapping(value = "/review/search", method = RequestMethod.GET)
	public ArrayList<Store> reviewSearch(String companyName, String text) {
		logger.info("review ajax 입장" + text);

		ArrayList<Store> list = new ArrayList<>();
		list = dao.selectStoreFromCname(text);
		
		logger.info("리스트확인 : " + list);
		return list;
	}
	
	@RequestMapping(value = "review/recentReview", method=RequestMethod.GET)
	public String recentReview(Model model){
		logger.info("RECENTREVIEW에서 받음");
		ArrayList<Review> list = new ArrayList();
		try{
		list = reviewDao.selectReviewFive();
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("list",list);
		logger.info("리센트 리뷰로 이동");
		return "banner/recentReview";
	}
	@ResponseBody
	@RequestMapping(value = "/review/submitAction", method = RequestMethod.POST)
	public Review submitAction(MultipartHttpServletRequest request, HttpServletResponse response) {
	
		logger.info("submitAction 입장");
		String storeName =  request.getParameter("searchName");
		String reviewText = request.getParameter("reviewText");
		String starValue = request.getParameter("starValue");
		
		int star = 0;
		
		if (starValue.equals("star_0")){star = 0;}
		else if(starValue.equals("star_1")){star = 1;}
		else if(starValue.equals("star_2")){star =2;}
		else if(starValue.equals("star_3")){star =3;}
		else if(starValue.equals("star_4")){star =4;}
		else if(starValue.equals("star_5")){star= 5;}
		
			
		ArrayList<MultipartFile> list = new ArrayList<>();
		Review review = new Review();
		Iterator<String> itr = request.getFileNames();

		// 만약 itr에 hasNext는 가져올 데이터가 있는지 확인을 한다
		if (itr.hasNext()) {
			// itr에 next는 실제 값을 가져온다.
			// itr에 첫번째 값을 가져온 mpf
			MultipartFile mpf = request.getFile(itr.next());
			// 첫번째 파일을 리스트에 넣었다.
			list.add(mpf);
			// 두개 모두 제대로 가져왔다.
			try {
				// 만약 mpf가 비어있지 않다면 가지고 온다.
				while (!mpf.isEmpty()) {
					if (!itr.hasNext())
						break;
					mpf = request.getFile(itr.next());
					list.add(mpf);
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
		String path = request.getSession().getServletContext().getRealPath("/resources/photofile");
		String savedfiles ="";
		String originalFileNames = "";	
		// 포토 값이 담겨있다.
		for (int i = 0; i < list.size(); i++) {
			//String contentType = list.get(i).getContentType();
					
			String savedfile = FileService.saveFile(list.get(i), uploadPath);
			String savedfile2 = FileService.saveFile(list.get(i), path);
			
			String originalFileName = list.get(i).getOriginalFilename();
		
			savedfiles += concatSignal;
			savedfiles += savedfile;
			
			originalFileNames += concatSignal;
			originalFileNames += originalFileName;
		
		} 
			//----------------DAO 값 넣기------------------
			int shopNo = dao.selectShopNo(storeName);
			Date d = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA); 
			String date = formatter.format(d);
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			Member user = (Member) auth.getPrincipal();
			String id = user.getId();
			
			review.setId(id);
			review.setCompanyName(storeName);
			review.setReviewText(reviewText);
			review.setStarScore(star);
			review.setInputdate(date);
			review.setShopNo(shopNo);
			review.setOriginalfile(originalFileNames);
			review.setSavedfile(savedfiles);
			try{
			reviewDao.insertReview(review);
			}catch(Exception e){
				e.printStackTrace();
			}
			System.out.println("저 장 된  s 파 일 이 름 :  " + savedfiles);
			System.out.println("저 장 된  o 파 일 이 름 :  " + originalFileNames);
		return review;
	}
	
	//수정//////////////////////////필요
	@RequestMapping(value = "review/reviewComplete", method=RequestMethod.GET)
	public String reviewComplete(String searchName, Model model){
		//이름에 해당하는 식당 리뷰 확인 페이지로 이동
		logger.info("해당  리뷰로 이동" + searchName);
		Review review = reviewDao.companyReview(searchName);
		model.addAttribute("review", review);
		return "forward:store/shopInfo?shopNo="+review.getShopNo();
	}
	
	@ResponseBody
	@RequestMapping(value = "review/realtimeReview", method=RequestMethod.POST)
	public HashMap<String,Object> realtimeReview(Model model){
		logger.info("리얼타임뷰 진입");
		//이름에 해당하는 식당 리뷰 확인 페이지로 이동
		ArrayList<Review> reviewList = new ArrayList<Review>(); 
		
		//날짜와 시간을 나눠 담을  리스트
		ArrayList<String> tokenList = new ArrayList<String>();
		
		Date d = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA); 
		String date = formatter.format(d);
		StringTokenizer str = new StringTokenizer(date, " ");
		
		//리스트[1] : yyyy-MM-dd 리스트[2] : HH:mm:ss
		while(str.hasMoreTokens()){
			tokenList.add(str.nextToken());
		}
		
		String yearMonthDay = tokenList.get(0);
		String hourMinSec = tokenList.get(1);
		
		logger.info("년원일" + yearMonthDay);
		logger.info("시분초" + hourMinSec);
		reviewList = reviewDao.selectReviewFromDate();
		logger.info("리뷰리스트" + reviewList);
		
		//vo 추가해서 카테고리 받아오기
		
		model.addAttribute("yearMonthDay", yearMonthDay);
		model.addAttribute("hourMinSec", hourMinSec);
		model.addAttribute("reviewList",reviewList);
		
		//HaspMap으로 값 넘겨주기
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("yearMonthDay", yearMonthDay);
		map.put("hourMinSec", hourMinSec);
		map.put("reviewList", reviewList);
		logger.info("실시간 리뷰 확인" + reviewList);	
		return map;
	}
	
	@RequestMapping(value = "review/download", method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse response, String origin , String saved){
		logger.info("#### 다운로드 컨토롤러 진입 ####");
		try {
			response.setHeader("Content-Disposition", " attachment;filename="+ URLEncoder.encode(origin, "UTF-8"));
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String fullPath = uploadPath + "/" + saved;
		//서버의 파일을 읽을 입력 스트림과 클라이언트에게 전달할 출력스트림
		FileInputStream filein = null;
		ServletOutputStream fileout = null;
		
		try {
			filein = new FileInputStream(fullPath);
			fileout = response.getOutputStream();
			
			//Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein, fileout);
			
			filein.close();
			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "review/getMyReview", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<HashMap<String, Object>> getMyReview() {
		ArrayList<HashMap<String, Object>> list = null;
		Member user = null;
		try {
			logger.info("리뷰 불러오기 컨트롤러");
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
			user = (Member) authentication.getPrincipal();
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("리뷰 불러오기 DAO로 이행");
		list = reviewDao.getMyReview(user.getId());
		return list;
	}
	@ResponseBody
	@RequestMapping(value = "/review/submitAction2", method = RequestMethod.POST)
	public Review submitAction2(HttpSession session, MultipartHttpServletRequest request, HttpServletResponse response) {
	
		logger.info("submitAction 입장");
		String storeName =  (String)session.getAttribute("storeName");
		logger.info((storeName));
		String reviewText = request.getParameter("reviewText");
		String starValue = request.getParameter("starValue");
		
		int star = 0;
		
		if (starValue.equals("star_0")){star = 0;}
		else if(starValue.equals("star_1")){star = 1;}
		else if(starValue.equals("star_2")){star =2;}
		else if(starValue.equals("star_3")){star =3;}
		else if(starValue.equals("star_4")){star =4;}
		else if(starValue.equals("star_5")){star= 5;}
		
			
		ArrayList<MultipartFile> list = new ArrayList<>();
		Review review = new Review();
		Iterator<String> itr = request.getFileNames();

		// 만약 itr에 hasNext는 가져올 데이터가 있는지 확인을 한다
		if (itr.hasNext()) {
			// itr에 next는 실제 값을 가져온다.
			// itr에 첫번째 값을 가져온 mpf
			MultipartFile mpf = request.getFile(itr.next());
			// 첫번째 파일을 리스트에 넣었다.
			list.add(mpf);
			// 두개 모두 제대로 가져왔다.
			try {
				// 만약 mpf가 비어있지 않다면 가지고 온다.
				while (!mpf.isEmpty()) {
					if (!itr.hasNext())
						break;
					mpf = request.getFile(itr.next());
					list.add(mpf);
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
		String path = request.getSession().getServletContext().getRealPath("/resources/photofile");
		String savedfiles ="";
		String originalFileNames = "";	
		// 포토 값이 담겨있다.
		for (int i = 0; i < list.size(); i++) {
			//String contentType = list.get(i).getContentType();
					
			String savedfile = FileService.saveFile(list.get(i), uploadPath);
			String savedfile2 = FileService.saveFile(list.get(i), path);
			
			String originalFileName = list.get(i).getOriginalFilename();
		
			savedfiles += concatSignal;
			savedfiles += savedfile;
			
			originalFileNames += concatSignal;
			originalFileNames += originalFileName;
		
		} 
			//----------------DAO 값 넣기------------------
			int shopNo = dao.selectShopNo(storeName);
			Date d = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA); 
			String date = formatter.format(d);
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			Member user = (Member) auth.getPrincipal();
			String id = user.getId();
			
			review.setId(id);
			review.setCompanyName(storeName);
			review.setReviewText(reviewText);
			review.setStarScore(star);
			review.setInputdate(date);
			review.setShopNo(shopNo);
			review.setOriginalfile(originalFileNames);
			review.setSavedfile(savedfiles);
			try{
			reviewDao.insertReview(review);
			}catch(Exception e){
				e.printStackTrace();
			}
			System.out.println("저 장 된  s 파 일 이 름 :  " + savedfiles);
			System.out.println("저 장 된  o 파 일 이 름 :  " + originalFileNames);
		return review;
	}
}
