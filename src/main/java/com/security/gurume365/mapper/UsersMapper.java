package com.security.gurume365.mapper;

import org.apache.ibatis.annotations.Param;

import com.security.gurume365.vo.Users;

public interface UsersMapper {
	public void insertUsers(Users users);
	public Users selectUsers(String id);
	public int permitUsers(@Param("id")String id, @Param("token")String token);
	public int updateUsers(Users users);
	public void restrictUsers(Users users);
}
