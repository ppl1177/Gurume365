package com.security.gurume365.dao;

import java.util.ArrayList;


import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.security.gurume365.mapper.RestaurantsMapper;
import com.security.gurume365.mapper.StoreMapper;
import com.security.gurume365.vo.Restaurants;
import com.security.gurume365.vo.Store;

@Repository
public class RestaurantsDAO {
	private static final Logger logger = LoggerFactory.getLogger(RestaurantsDAO.class);
	@Autowired
	SqlSession sqlSession;

	public ArrayList<Store> selectRestaurants(String companyName) {
		logger.info("전체 레스토랑 셀렉트 실행 시작" + companyName);
		StoreMapper mapper = sqlSession.getMapper(StoreMapper.class);
		logger.info("전체 레스토랑 셀렉트 실행1");
		
		ArrayList<Store> list = new ArrayList<>();
		try {
			list = mapper.selectStoreFromCname(companyName);
			logger.info("전체 레스토랑 셀렉트 실행2");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int selectShopNo(String companyName){
		logger.info(" 레스토랑 번호 셀렉트 실행 시작" );
		StoreMapper mapper = sqlSession.getMapper(StoreMapper.class);
		int num = 0;
		try{
			num = mapper.selectShopNo(companyName);
		}catch(Exception e){
			e.printStackTrace();
		}
		return num;
	}
}
