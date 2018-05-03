package com.security.gurume365.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.security.gurume365.dao.FloorDAO;
import com.security.gurume365.dao.Res_tableDAO;
import com.security.gurume365.dao.ReservationDAO;
import com.security.gurume365.vo.FloorLayout;
import com.security.gurume365.vo.FloorTable;
import com.security.gurume365.vo.Member;
import com.security.gurume365.vo.Res_table;
import com.security.gurume365.vo.Reservations;

@Controller
public class ReservationController {

	@Autowired
	FloorDAO floorDAO;
	
	@Autowired
	ReservationDAO reservationDAO;
	
	@Autowired
	Res_tableDAO res_tableDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@RequestMapping(value="/reservation/reservation", method = RequestMethod.GET)
	public String reservation(int shop_no, int budjet, Model model){
		
		model.addAttribute("budjet", budjet);
		model.addAttribute("shop_no", shop_no);
		System.out.println(budjet);
		return "reservation/reservation";
	}
	
	@RequestMapping(value="/reservation/reservationPermit", method = RequestMethod.GET)
	public String reservationTable(int shop_no, int budjet, String datetimepicker, String person, String content, Model model, String ppno, String ttno){
		System.out.println(person+datetimepicker+content);
		String[] tno = ttno.split("");
		String[] pno = ppno.split("");
		for(int i=0; i<tno.length; i++){
			System.out.println(tno[i]+" : "+pno[i]);
		}
		System.out.println(ppno+"  "+ttno);
		model.addAttribute("no", shop_no);
		model.addAttribute("p", person);
		model.addAttribute("d", datetimepicker);
		model.addAttribute("c", content);
		model.addAttribute("pp",ppno);
		model.addAttribute("tt",ttno);
		model.addAttribute("budjet", budjet);
		
		return "reservation/reservationPermit";
	}
	
	@RequestMapping(value = "/reservation/floor", method = RequestMethod.GET)
	public String floor_pop(Locale locale, int shop_no, int budjet, String datetimepicker, String person, String content, Model model) {
		model.addAttribute("p", person);
		model.addAttribute("d", datetimepicker);
		model.addAttribute("c", content);
		model.addAttribute("shop_no", shop_no);
		model.addAttribute("budjet", budjet);
		return "reservation/reservationFloor";
	}
	
	@RequestMapping(value = "/reservation/noshowPermit", method = RequestMethod.GET)
	public String noshowPermit(int seq_res, int budjet, Model model){
		model.addAttribute("no", seq_res);
		model.addAttribute("budjet", budjet);
		return "reservation/noshowPermit";
	}
	@RequestMapping(value = "/reservation/noshowComplement", method = RequestMethod.GET)
	public String noshowComplement(UsernamePasswordAuthenticationToken token, Locale locale, int no) {
		logger.info("에약 완료 페이지"+no);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
		Member user = (Member) authentication.getPrincipal();
		String id = user.getId();
		Reservations res = reservationDAO.getReservation(no);
		res.setId(id);
		res.setSituation(1);
		reservationDAO.noshowChange(res);
		logger.info("에약 완료 페이지"+res);
		
		return "reservation/reservationComplete";
	}
	
	@RequestMapping(value = "/store/loadFloor", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> loadFloor2(int shopNo, String datetime) {
		
		
		HashMap<String, Object> jsonMap = new HashMap<>();
		try {
			
			
			ArrayList<FloorTable> tables = new ArrayList<>();
			int floorNo = 1;		
			/* 가게 번호와 플로어 번호를 받아와서 해당 플로어 레이아웃을 반환
			 * */
			// 플로어 레이아웃: 기능 축소로 사용하지 않는 데이터 / 더미테이터
			FloorLayout floor = new FloorLayout(floorNo, shopNo, 10, 10);
			// 사용자 ID로 유효성 검사 필요
			tables = floorDAO.loadTables(shopNo, floorNo);
			
			// reservations를 받아와서 시간을 비교 후 테이블 예약여부를 같이 보내준다.
			// 그 가게의 모든 예약을 불러옴
			System.out.println("???"+datetime);
			
			if(tables==null) {
				
			}
			else {
				String[] dtime = datetime.split(" ");
				String[] ddateArr = dtime[0].split("/");
				String[] dtimeArr = dtime[1].split(":");
				ArrayList<Reservations> rList = reservationDAO.storeReservation(shopNo);
				ArrayList<Res_table> allList = new ArrayList<>();
				for (Reservations res : rList) {
					// 받은 시간이랑 res에서 가져온 시간이랑 비교
					System.out.println(res);
					String time = res.getDatetime();
					String[] ttime = time.split(" ");
					String[] dateArr = ttime[0].split("/");
					String[] timeArr = ttime[1].split(":");
					if(ddateArr[0].equals(dateArr[0])&&ddateArr[1].equals(dateArr[1])&&ddateArr[2].equals(dateArr[2])){
						if(Integer.parseInt(dtimeArr[0]) == Integer.parseInt(timeArr[0])-1||Integer.parseInt(dtimeArr[0]) == Integer.parseInt(timeArr[0])||Integer.parseInt(dtimeArr[0]) == Integer.parseInt(timeArr[0])+1){
							// 예약 있음
							int resNo = res.getSeqRes();
							ArrayList<Res_table> rtList = res_tableDAO.resTableList(resNo);
							for(Res_table r: rtList){
								allList.add(r);
							}
						}
					}
					
				}
				jsonMap.put("tableReservation", allList);
				logger.info("테이블 로드");
				logger.info("" + tables);
				jsonMap.put("floorInfo", floor);
				jsonMap.put("tablesInfo", tables);
			}
			/*
			if(user.getDivision()!=1) {
				logger.info("사업자가 아닙니다.");
				return null;
			}
			else {
				ArrayList<FloorTable> tables = new ArrayList<>();
				int floorNo = 1;		
				 가게 번호와 플로어 번호를 받아와서 해당 플로어 레이아웃을 반환
				 * 
				// 플로어 레이아웃: 기능 축소로 사용하지 않는 데이터 / 더미테이터
				FloorLayout floor = new FloorLayout(floorNo, shopNo, 10, 10);
				// 사용자 ID로 유효성 검사 필요
				tables = floorDAO.loadTables(shopNo, floorNo);
				if(tables==null) {
					
				}
				else {
					logger.info("테이블 로드");
					logger.info("" + tables);
					jsonMap.put("floorInfo", floor);
					jsonMap.put("tablesInfo", tables);
				}
			}
			*/
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return jsonMap;
	}
	
	
	@RequestMapping(value = "/reservation/reservationComplete", method = RequestMethod.GET)
	public String reservationComplete(UsernamePasswordAuthenticationToken token, Locale locale, String shop_no, String datetimepicker, String person, String content, Model model, String ppno, String ttno) {
		logger.info("에약 완료 페이지"+shop_no);
		/*String[] tno = ttno.split("");
		String[] pno = ppno.split("");
		for(int i=0; i<tno.length; i++){
			System.out.println(tno[i]+" : "+pno[i]);
		}*/
		
		// 결제가 완료되면 이 페이지로
		
		
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
			Member user = (Member) authentication.getPrincipal();
			Reservations reservations = new Reservations();
			reservations.setContent(content);
			reservations.setDatetime(datetimepicker);
			reservations.setFloorNo(1);
			reservations.setPerson(Integer.parseInt(person));
			reservations.setShopNo(Integer.parseInt(shop_no));
			reservations.setId(user.getId());
			reservationDAO.insertReservation(reservations);
			System.out.println(reservations);
			int seqRes = reservations.getSeqRes();
			String[] tno = ttno.split("");
			String[] pno = ppno.split("");
			for(int i=0; i<tno.length; i++){
				//다시 셀렉트를 해와서 넣기 ㄱㄱㄱ
				Res_table res_table = new Res_table();
				res_table.setSeqRes(seqRes);
				res_table.setPersonTable(Integer.parseInt(pno[i]));
				res_table.setTableNo(Integer.parseInt(tno[i]));
				res_tableDAO.insertResTable(res_table);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "reservation/reservationComplete";
	}
	
	@RequestMapping(value = "/reservation/getMyResList", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<HashMap<String, Object>> getMyResList() {
		ArrayList<HashMap<String, Object>> resultList = null;
		Member user = null;
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
			user = (Member) authentication.getPrincipal();
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		resultList = reservationDAO.getMyResList(user.getId());
		logger.info("예약리스트맵:" + resultList);
		
		
		return resultList;
	}
	@RequestMapping(value="/reservation/resList",method=RequestMethod.POST)
	@ResponseBody
	public ArrayList<Reservations> resList(int shopNo){
		ArrayList<Reservations> list = reservationDAO.storeReservation(shopNo);
		return list;
	}
	
	@RequestMapping(value="/reservation/resSetNoshow",method=RequestMethod.POST)
	@ResponseBody
	public void setNoshow(int seqRes){
		reservationDAO.resSetNoshow(seqRes);
	}
	@RequestMapping(value="/reservation/resSetVisit",method=RequestMethod.POST)
	@ResponseBody
	public void setVisit(int seqRes){
		reservationDAO.resSetVisit(seqRes);
	}
}
