package com.security.gurume365.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.security.gurume365.mapper.Res_tableMapper;
import com.security.gurume365.vo.Res_table;

@Repository
public class Res_tableDAO {

	@Autowired
	SqlSession sqlSession;
	
	public void insertResTable(Res_table res_table){
		Res_tableMapper mapper = sqlSession.getMapper(Res_tableMapper.class);
		try {
			mapper.insertResTable(res_table);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Res_table> resTableList(int seqRes){
		Res_tableMapper mapper = sqlSession.getMapper(Res_tableMapper.class);
		ArrayList<Res_table> list = null;
		try{
			list = mapper.resTableList(seqRes);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
}
