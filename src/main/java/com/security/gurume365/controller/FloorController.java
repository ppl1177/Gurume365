package com.security.gurume365.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.security.gurume365.dao.FloorDAO;
import com.security.gurume365.vo.FloorLayout;
import com.security.gurume365.vo.FloorTable;
import com.security.gurume365.vo.Member;
import com.security.gurume365.vo.Users;


@Controller
public class FloorController {
	
	@Autowired
	FloorDAO floorDAO;

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@RequestMapping(value = "/floor/floor_edit", method = RequestMethod.GET)
	public String home(Locale locale, Model model, int shopNo) {
		
		model.addAttribute("currentShopNo", shopNo);
		logger.info("" + shopNo);
		return "floor/floor_edit";
	}
	
	
/*	@RequestMapping(value = "/floor/setFloorSize", method = RequestMethod.POST)
	@ResponseBody
	public int setFloorSize(float floorH, float floorW, int floor_no, HttpSession session) {
		int shop_no;
		
		Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
		shop_no = restaurant.shop_no; 
		
		session.setAttribute("floor_H", floorH);
		session.setAttribute("floor_W", floorW);
		
		
		return 1;
		
	}
	
	@RequestMapping(value = "/floor/getFloorSize", method = RequestMethod.GET)
	@ResponseBody
	public int getFloorSize(HttpSession session) {
		int shop_no;
		Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
		shop_no = restaurant.shop_no; 
		플로어 탭 추가 시에 모든 플로어 정보 불러 올 수 있도록 shop_no를 받아 쿼리
		 * 플로어 객체의 리스트로 반환
		 
		
		float floorH = 10, floorW = 10;
		
		
		return 1;
		
	}
	
	
	@RequestMapping(value = "/floor/createTableLayout", method = RequestMethod.GET)
	@ResponseBody
	public String getValidTableNo(HttpSession session) {
		String tableNo = "02";
		
		return tableNo;
	}*/
	
	@RequestMapping(value = "/floor/saveFloorLayout", method = RequestMethod.POST)
	@ResponseBody
	public int saveFloor(String jsonData, int floorNo, double floorH, double floorW, HttpSession session, int shopNo) {
		
		int result = 0;
		
		
		
				FloorLayout floor = new FloorLayout();
				floor.setFloorNo(floorNo);
				floor.setShopNo(shopNo); 
				floor.setFloorHeight(floorH);
				floor.setFloorWidth(floorW);
				
				ArrayList<FloorTable> tables = new ArrayList<>();
				
				String jsonStr = jsonData.replace("\"", "");
				jsonStr = jsonStr.replace("[", "");
				jsonStr = jsonStr.replace("]", "");
				logger.info("" + jsonStr.length());
				if(jsonStr.length()!=0) {
					ArrayList<String> strList = new ArrayList<String>(Arrays.asList(jsonStr.split(",")));
					for(String str : strList) {
						FloorTable table = new FloorTable();
						table.setShopNo(floor.getShopNo());
						table.setFloorNo(floor.getFloorNo());
						table.setPosX((int)Double.parseDouble(str.split("/")[0]));
						table.setPosY((int)Double.parseDouble(str.split("/")[1]));
						table.setTableLength(Integer.parseInt(str.split("/")[2]));
						table.setTableWidth(Integer.parseInt(str.split("/")[3]));
						table.setTableShape(str.split("/")[4]);
						table.setDegree((int)Double.parseDouble(str.split("/")[5]));
						table.setPersonMin(Integer.parseInt(str.split("/")[6]));
						table.setPersonMax(Integer.parseInt(str.split("/")[7]));
						table.setTableNo(Integer.parseInt(str.split("/")[8].replaceAll("draggable-table", "")));
						table.setCurrentsit("empty");
						tables.add(table);
						logger.info(table + "");
									
				}
				
				
				for(FloorTable t : tables) {
					logger.info("그것! : " + t);
					
				}
				/*플로어/테이블 DAO 핸들링*/
				
				result = floorDAO.saveFloorTables(tables);
			}
		
		
		
		
		return result;
	}
	
	
	@RequestMapping(value = "/floor/loadFloor", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> loadFloor(UsernamePasswordAuthenticationToken token, int shopNo) {
		
		HashMap<String, Object> jsonMap = new HashMap<>();
		
		
		ArrayList<FloorTable> tables = new ArrayList<>();
		int floorNo = 1;		
		/* 가게 번호와 플로어 번호를 받아와서 해당 플로어 레이아웃을 반환
		 * */
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
		
		
		return jsonMap;
	}
	
	

	@RequestMapping(value = "/floor/floor_pop", method = RequestMethod.GET)
	public String floor_pop(Locale locale, Model model, int shopNo) {
		model.addAttribute("shopNo", shopNo);
		
		return "floor/floor-popup";
	}

	
	
}


/*
 * 
 * 1. 레이아웃/뷰 구성
 * 2. 플로어 사이즈 입력, 영역 설정
 * 3. 테이블 아이콘 프리셋, 화면 영역과 실제 플로어 사이즈 스케일에 따라...
 * 4. 테이블 아이콘을 플로어 영역으로 끌어다 넣으면 그 위치(좌표) 받아오기
 * 5. 
 * 
 * 테이블 위치가 음수나 100이상이 되지 않게 하기
 * 
 * 
 * */

