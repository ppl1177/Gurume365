package com.security.gurume365.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.security.gurume365.mapper.ReservationMapper;
import com.security.gurume365.vo.Reservations;

@Repository
public class ReservationDAO {

	@Autowired
	SqlSession sqlSession;
	
	public void insertReservation(Reservations reservations){
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		try{
			mapper.insertReservation(reservations);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Reservations> storeReservation(int shopNo){
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		ArrayList<Reservations> list = null;
		try{
			list = mapper.storeReservation(shopNo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	public ArrayList<HashMap<String, Object>> getMyResList(String id) {
		ArrayList<HashMap<String, Object>> list = null;
		try{
			ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
			list = mapper.getMyResList(id);
			int cnt = 0;
			for(HashMap<String, Object> l : list) {
				System.out.println((++cnt) + ":" + l);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public void resSetNoshow(int seqRes){
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		try{
			mapper.resSetNoshow(seqRes);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public void resSetVisit(int seqRes){
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		try{
			mapper.resSetVisit(seqRes);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void noshowChange(Reservations reservations){
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		try{
			mapper.noshowChange(reservations);
			mapper.noshowChange2(reservations);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public Reservations getReservation(int seqRes){
		Reservations res = new Reservations();
		ReservationMapper mapper = sqlSession.getMapper(ReservationMapper.class);
		try{
			res = mapper.getReservation(seqRes);
		}catch(Exception e){
			e.printStackTrace();
		}
		return res;
	}
}
