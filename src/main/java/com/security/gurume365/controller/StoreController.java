package com.security.gurume365.controller;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.socket.WebSocketSession;

import com.security.gurume365.dao.ReviewDAO;
import com.security.gurume365.dao.StoreDAO;
import com.security.gurume365.dao.UsersDAO;
import com.security.gurume365.util.FileService;
import com.security.gurume365.util.PageNavigator;
import com.security.gurume365.vo.Member;
import com.security.gurume365.vo.Reservations;
import com.security.gurume365.vo.Review;
import com.security.gurume365.vo.Store;
import com.security.gurume365.vo.Users;

@Controller
public class StoreController {
	
	@Autowired
	UsersDAO usersDAO;
	@Autowired
	StoreDAO storeDAO;
	@Autowired
	ReviewDAO reviewDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(StoreController.class);
	
	final int countPerPage = 5;
	
	final int pagePerGroup = 5;
		
	// 지역정보 세션 값 zone;
		@RequestMapping(value = "/store/storeMain", method = RequestMethod.GET)
		public String storeMain(HttpSession session, Locale locale, Model model, String selector) {
			ArrayList<Review> list = new ArrayList<>();
			logger.info("상점 상세 페이지 이동 완료");
			//HashMap<String,ArrayList<String>> map = new HashMap();
			ArrayList<String> orilist = new ArrayList<>();
			ArrayList<String> savedlist = new ArrayList<>();
			list = reviewDAO.selectReviewBest();
			
			for (int i=0; i<list.size(); i++){
				logger.info("list original " +list.get(i).getOriginalfile());
				logger.info("list saved " +list.get(i).getSavedfile());
				//리스트의 컨캣 수정해서 올바른 값으로 바꿔주기
				list.get(i).setOriginalfile(list.get(i).getOriginalfile().replace("%(&*%", ""));
				list.get(i).setSavedfile(list.get(i).getSavedfile().replace("%(&*%", ""));
				//바뀐 값 확인
				logger.info("list original2@@" +list.get(i).getOriginalfile());
				logger.info("list saved2@@" +list.get(i).getSavedfile());
			}
			
			logger.info("리스트" + list);
			
			model.addAttribute("list",list);
			
			logger.info("데이터1"+selector);
			session.setAttribute("zone", selector);
			return "store/storeMain";
		}
	// 노쇼, 음식 종류, 추천테마 정보를 갖고 있는 세션 값 thema
	   @RequestMapping(value = "/store/thema", method = RequestMethod.GET)
	   public String thema(HttpSession session, Locale locale, Model model, String selector) {
	      session.setAttribute("thema", selector);
	      logger.info("셀렉터 값 : "+selector);
	      logger.info("상점 상세 페이지 이동 완료");
	      //테마 리스트의 경우 스토어 리스트로 바로 가지 않고 하나를 더 거친다.
	      if (selector.equals("thema")){
	         logger.info("테마리스트로 갑니다");
	         return "store/themaList";
	      //노쇼리스트로 갈 경우 바로 스토어 리스트로 진입하게 된다.
	      }else if (selector.equals("noshow")){
	         logger.info("노쇼리스트로 갑니다");
	         ArrayList<Store> list = null;
	         try{
	        	 list = storeDAO.storeList();
	        	 
	         }catch(Exception e){
	        	 e.printStackTrace();
	         }
	         model.addAttribute("noshow", "noshow");
	         model.addAttribute("list", list);
	         model.addAttribute("num", list.size());
	         return "store/storeList";
	      //푸드리스트로 갈 경우 바로 스토어 리스트로 가지 않고 하나를 더 거친다.
	      }else if (selector.equals("food")){
	         logger.info("푸드리스트로 갑니다");
	         return "store/foodList";
	      }
	      return "store/themaList";
	   }
	//상품 정보 리스트에 가기전에 세션값을 지워주고, 모델에 담아 전달해준다.
	@RequestMapping(value= "/store/storeList", method = RequestMethod.GET)
	public String storeList(String food, HttpSession session, Model model){
		logger.info("상품 정보 리스트에 가기");
		//모델에 값 전달
		model.addAttribute("zone", session.getAttribute("zone"));
		model.addAttribute("thema", session.getAttribute("thema"));
		model.addAttribute("food", food);
		
		return "store/storeList";
	}
	//음식 종류별 레스토랑으로 들어왔을 경우 여기서 선택된 음식 정보를 받는다.
	@RequestMapping(value= "/store/foodList", method = RequestMethod.GET)
	public String foodList(String food){
		logger.info("[푸드리스트]셀렉터 값" + food);
		
		return "forward:storeList";
	}
	
	//샵 기본 정보 페이지로 이동
	@RequestMapping(value="/store/shopInfo", method = RequestMethod.GET)
	public String goShopInfo(UsernamePasswordAuthenticationToken token, Authentication auth,HttpSession session, Model model, int shopNo){
		logger.info("샵정보로 이동");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
		Member user = (Member) authentication.getPrincipal();
		model.addAttribute("loginId", user.getId());
		ArrayList<Review> list = new ArrayList<Review>();
		Store store = null;
		storeDAO.hitsList();
		store = storeDAO.selectStore(shopNo);
		session.setAttribute("storeName", store.getCompanyName());
		model.addAttribute("store", store);
		Review review = reviewDAO.recentReview(shopNo);
		model.addAttribute("review", review);
		logger.info("샵정보"+review);
		try {
			list = reviewDAO.selectReviewFive();
			model.addAttribute("list", list);				
			auth = SecurityContextHolder.getContext().getAuthentication(); 
			//Member user = (Member) auth.getPrincipal();
			logger.info("샵번호 : "+shopNo);
			//model.addAttribute("loginId", user.getId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("가게정보"+store);

		return "store/store";
	}
	
	@RequestMapping(value="/noShow/noShowInfo", method=RequestMethod.GET)
	public String goNoShow(Model model,@RequestParam(value="page", defaultValue="1")int page) {
			//초기값은 서울로 검색
			logger.info("노쇼게시판으로 이동 컨트롤러 시작");
			
			try{
				//전체 글 개수
				int total = storeDAO.noShowNum();
				//페이지 계산 객체
				PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
				//글목록 가져오기
				ArrayList<Store> list = storeDAO.selectAllnoShow(navi.getStartRecord(), navi.getCountPerPage());
				ArrayList<Reservations> list2 = storeDAO.selectAllnoShow2(navi.getStartRecord(), navi.getCountPerPage());
				
				model.addAttribute("list", list);
				model.addAttribute("list2", list2);
				model.addAttribute("total", total);
				model.addAttribute("navi", navi);
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			logger.info("(controller)노쇼게시판 이동 ㄱㄱ");
			
		return "store/noShow";
	}
	
	@RequestMapping(value="/store/shopReview", method = RequestMethod.GET)
	public String goShopReview(Authentication auth, Model model, int shopNo){
		logger.info("샵리뷰로 이동");
		ArrayList<Review> list = new ArrayList<Review>();
		Store store = null;
		
		store = storeDAO.selectStore(shopNo);
		
		model.addAttribute("store", store);
		
		try {
			list = reviewDAO.selectReviewFive();
			model.addAttribute("list", list);				
			
			auth = SecurityContextHolder.getContext().getAuthentication(); 
			Member user = (Member) auth.getPrincipal();
			logger.info("샵번호 : "+shopNo);
			model.addAttribute("loginId", user.getId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("가게정보"+store);

		return "store/storeReview";
	}
	
	@RequestMapping(value="/store/shopImg", method = RequestMethod.GET)
	public String goShopImg(Authentication auth, Model model, int shopNo){
		logger.info("샵이미지로 이동");
		ArrayList<Review> list = new ArrayList<Review>();
		Store store = null;
		
		store = storeDAO.selectStore(shopNo);
		
		model.addAttribute("store", store);
		
		try {
			list = reviewDAO.selectReviewFive();
			model.addAttribute("list", list);				
			
			
			auth = SecurityContextHolder.getContext().getAuthentication(); 
			Member user = (Member) auth.getPrincipal();
			logger.info("샵번호 : "+shopNo);
			model.addAttribute("loginId", user.getId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("가게정보"+store);

		return "store/storeImg";
	}
	
	@RequestMapping(value="/store/shopMenu", method = RequestMethod.GET)
	public String goShopMenu(Authentication auth, Model model, int shopNo){
		logger.info("샵메뉴로 이동");
		ArrayList<Review> list = new ArrayList<Review>();
		
		Store store = null;
		
		
		try {
			auth = SecurityContextHolder.getContext().getAuthentication(); 
			Member user = (Member) auth.getPrincipal();
			logger.info("샵번호 : "+shopNo);
			
			store = storeDAO.selectStore(shopNo);
			list = reviewDAO.selectReviewFive();
			model.addAttribute("list", list);
				
			model.addAttribute("store", store);
			model.addAttribute("loginId", user.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("가게정보 : "+ store);
		logger.info("리스트 : " + list);
		
		return "store/storeMenu";
	}
	@ResponseBody
	@RequestMapping(value= "/store/storeList", method = RequestMethod.POST)
	public ArrayList<Store> storeList(){
		logger.info("리스트");
		ArrayList<Store> storeList = null;
        try{
       	 storeList = storeDAO.storeList();
       	 
        }catch(Exception e){
       	 e.printStackTrace();
        }
		return storeList;
	}
	// 가게 업종 목록 불러오기
		@RequestMapping(value="/store/getCategories", method=RequestMethod.GET)
		@ResponseBody
		public ArrayList<String> getCategories() {
			ArrayList<String> result = null;
			
			result = storeDAO.getCategories();
			
			
			return result;
		}
		// 사업장 추가
		@RequestMapping(value="/store/addStore", method=RequestMethod.POST)
		@ResponseBody
		public int addStore(Store store) {
			int result = 0;
			
			try {
				
				Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
				Member user = (Member) authentication.getPrincipal();
				if(user.getDivision()!=1) {
					logger.info("사업자가 아닙니다.");
					return 0;
				}
				else {
					store.setId(user.getId());
					result = storeDAO.addStore(store);			
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			
			logger.info("가게입력:" + store.toString());
			
			
			
			return result;
		}
		
		
		// 사업장 편집
		@RequestMapping(value="/store/editStore", method=RequestMethod.POST)
		@ResponseBody
		public int editStore(MultipartHttpServletRequest request) {
			
			int result = 0;
			
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
			Member user = (Member) authentication.getPrincipal();
			
			Store store = new Store();

			store.setShopNo(Integer.parseInt(request.getParameter("shopNo")));
			store.setCompanyName(request.getParameter("companyName"));
			store.setAddress1(request.getParameter("address1"));
			store.setAddress2(request.getParameter("address2"));
			store.setPhone(request.getParameter("phone"));
			store.setCategory(request.getParameter("category"));
			store.setTimeOfOpen(request.getParameter("timeOfOpen"));
			store.setShopInfo(request.getParameter("shopInfo"));
			store.setComment(request.getParameter("comment"));
			store.setBudjet(Integer.parseInt(request.getParameter("budjet")));
			store.setHoliday(request.getParameter("holiday"));
			
			store.setId(user.getId());
			logger.info("가게수정:" + store);
			store.setCompanyNo(storeDAO.getCompanyNo(store.getShopNo()));
			store.setHits(storeDAO.getHits(store.getShopNo()));
			
			
			String path = request.getSession().getServletContext().getRealPath("/resources/img");
			
			Iterator<String> itr = request.getFileNames();
			if(itr.hasNext()) {
				MultipartFile mpf = request.getFile(itr.next());
				try {
					if(!mpf.isEmpty()) {
						String savedfile = FileService.saveFile(mpf, path);
						store.setOriginalfile(mpf.getOriginalFilename());
						store.setSavedfile(savedfile);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

				result = storeDAO.editSetStore(store);
				
				if(!mpf.isEmpty()){
					String newFileName = store.getShopNo()+"."+mpf.getOriginalFilename().substring(mpf.getOriginalFilename().lastIndexOf(".")+1);
					try{
						mpf.transferTo(new File(path+newFileName));
					}catch(Exception e){
						e.printStackTrace();
					}
				}
			}
			

			logger.info("test:" + store);
			
			
			
			/*try {
				
				Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
				Member user = (Member) authentication.getPrincipal();
				if(user.getDivision()!=1) {
					logger.info("사업자가 아닙니다.");
					return 0;
				}
				else {
					store.setId(user.getId());
					logger.info("가게수정:" + store);
					store.setCompanyNo(storeDAO.getCompanyNo(store.getShopNo()));
					store.setHits(storeDAO.getHits(store.getShopNo()));
					if(storeDAO.deleteStore(store)!=0) {
						storeDAO.editSetStore(store);
					}
					else {
						result = 0;
					}
					result = storeDAO.editSetStore(store);
					
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}*/
			
			// logger.info(store.toString());
			
			
			
			return result;
		}
		
		
		// 사업장 편집 불러오기
		@RequestMapping(value="/store/loadMyStore", method=RequestMethod.GET)
		@ResponseBody
		public ArrayList<Store> loadMyStore() {
			ArrayList<Store> result = null;
			
			try {
				
				Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
				Member user = (Member) authentication.getPrincipal();
				if(user.getDivision()!=1) {
					logger.info("사업자가 아닙니다.");
					return null;
				}
				else {
					result = storeDAO.loadMyStore(user.getId());
					/*logger.info("" + result);*/
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			
			
			
			
			return result;
		}
		@ResponseBody
		@RequestMapping(value = "store/bestReview", method=RequestMethod.POST)
		public HashMap<String,Object> bestReview(Model model){
			logger.info("베스트리뷰 진입");
			//이름에 해당하는 식당 리뷰 확인 페이지로 이동
			ArrayList<Review> reviewList = new ArrayList<Review>(); 
			reviewList = reviewDAO.selectReviewBest();
			logger.info("리뷰리스트" + reviewList);
			
			model.addAttribute("list",reviewList);
			
			//HaspMap으로 값 넘겨주기
			HashMap<String, Object> map = new HashMap<String,Object>();
			map.put("reviewList", reviewList);
			logger.info("실시간 리뷰 확인" + reviewList);	
			return map;
		}
		
		@ResponseBody
		@RequestMapping(value = "store/recentReview", method=RequestMethod.POST)
		public HashMap<String,Object> recentReview(Model model){
			logger.info("베스트리뷰 진입");
			//이름에 해당하는 식당 리뷰 확인 페이지로 이동
			ArrayList<Review> reviewList = new ArrayList<Review>(); 
			reviewList = reviewDAO.selectReviewFive();
			logger.info("리뷰리스트" + reviewList);
			
			model.addAttribute("list",reviewList);
			
			//HaspMap으로 값 넘겨주기
			HashMap<String, Object> map = new HashMap<String,Object>();
			map.put("reviewList", reviewList);
			logger.info("실시간 리뷰 확인" + reviewList);	
			return map;
		}	
		
}
