package com.security.gurume365.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.security.gurume365.controller.AdminController;
import com.security.gurume365.mapper.FloorMapper;
import com.security.gurume365.mapper.UsersMapper;
import com.security.gurume365.vo.FloorLayout;
import com.security.gurume365.vo.FloorTable;
import com.security.gurume365.vo.Users;


@Repository
public class FloorDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	SqlSession sqlSession;
	
	/*public int saveFloor(FloorLayout floorLayout) {
		
	}*/
	
	public FloorLayout loadFloor(int shop_no, int floor_no) {
		FloorLayout floor = new FloorLayout();
		FloorLayout floor2 = null;
		floor.setShopNo(shop_no);
		floor.setFloorNo(floor_no);
		logger.info("" + floor);
		try{
			FloorMapper mapper = sqlSession.getMapper(FloorMapper.class);
			floor2 = mapper.loadFloor(shop_no, floor_no);
			logger.info("쉬바앙::" + floor2);
			
		} catch(Exception e) {
			System.out.println("loadFloor 예외 발생");
			e.printStackTrace();
		}	
		
		
		return floor2;
	}
	
	public ArrayList<FloorTable> loadTables(int shop_no, int floor_no) {
		ArrayList<FloorTable> tables = null;
		
		try{
			FloorMapper mapper = sqlSession.getMapper(FloorMapper.class);
			tables = mapper.loadTables(shop_no, floor_no);
			for(FloorTable ft : tables) {
				logger.info(ft.toString());
			}
			
		} catch(Exception e) {
			System.out.println("loadTables 예외 발생");
			e.printStackTrace();
		}	
		
		
		return tables;
	}
	
	
	public int deleteAllTables(String id, int shop_no, int floor_no) {
		int result = 0;
		
		try{
			FloorMapper mapper = sqlSession.getMapper(FloorMapper.class);
			result = mapper.deleteAllTables(id, shop_no, floor_no);
			
		} catch(Exception e) {
			System.out.println("deleteTables 예외 발생");
			e.printStackTrace();
		}	
		
		
		return result;
	}
	
	
	public int saveFloorTables(ArrayList<FloorTable> tables) {
		int result = 1;
		
		try{
			FloorMapper mapper = sqlSession.getMapper(FloorMapper.class);
			for(FloorTable t : tables) {
				if(mapper.saveFloorTables(t) == 0) {
					System.out.println("saveTables 오류 : " + t);
					result = 0;
				}
			}
			
		} catch(Exception e) {
			System.out.println("saveTables 예외 발생");
			e.printStackTrace();
		}	
		
		
		return result;
	}
	
}
