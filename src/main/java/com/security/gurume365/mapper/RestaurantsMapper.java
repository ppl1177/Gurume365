package com.security.gurume365.mapper;

import java.util.ArrayList;

import com.security.gurume365.vo.Restaurants;

public interface RestaurantsMapper {

	public ArrayList<Restaurants> selectRestaurants(String companyName);
	public int selectShopNo(String companyName);
}
