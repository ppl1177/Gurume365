package com.security.gurume365.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.security.gurume365.mapper.UsersMapper;
import com.security.gurume365.vo.Users;

@Repository
public class UsersDAO {
	//
	@Autowired
	SqlSession sqlSession;
	
	public void insertUsers(Users users){
		UsersMapper usersMapper = sqlSession.getMapper(UsersMapper.class);
		try{
			usersMapper.insertUsers(users);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int updateUsers(Users users) {
		UsersMapper userMapper=sqlSession.getMapper(UsersMapper.class);
		int result=0;
		try {
			System.out.println("DAO 작동1");
			result=userMapper.updateUsers(users);
			System.out.println("DAO 작동2");
			System.out.println(users+"From DAO");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public Users selectUsers(String id){
		UsersMapper mapper = sqlSession.getMapper(UsersMapper.class);
		Users users = new Users();
		try{
			users = mapper.selectUsers(id);
		}catch(Exception e){
			e.printStackTrace();
		}
		return users;
	}
	
	public int permitUsers(String id, String token){
		int result = 0;
		UsersMapper mapper = sqlSession.getMapper(UsersMapper.class);
		try{
			result = mapper.permitUsers(id, token);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public void restrictUsers(Users users) {
		UsersMapper mapper = sqlSession.getMapper(UsersMapper.class);
		try{
			mapper.restrictUsers(users);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
