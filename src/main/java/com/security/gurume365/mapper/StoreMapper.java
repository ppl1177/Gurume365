package com.security.gurume365.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import com.security.gurume365.vo.Reservations;
import com.security.gurume365.vo.Store;

public interface StoreMapper {

	public int insertStore(Store store);
	
	public ArrayList<Store> storeList();
	
	public ArrayList<Store> gradeList();
	
	public ArrayList<Store> hitsList();
	
	public ArrayList<Store> resList();
	
	public Store selectStore(int shopNo);
	
	public void upHitsStore(int shopNo);
	
	public ArrayList<Store> loadMyStore(String id);
	
	public ArrayList<String> getCategories();
	
	public int deleteStore(Store store);
	
	public int editSetStore(Store store);
	
	public String getCompanyNo(int shopNo);

	public int getHits(int shopNo);
	
	public ArrayList<Store> selectStoreFromCname(String companyName);
	
	public int selectShopNo(String companyName);
	
	public ArrayList<Store> searchList(HashMap<String, String> map);

	public int noShowNum();
	
	public ArrayList<Store> selectAllnoShow(RowBounds rb);
	
	public ArrayList<Reservations> selectAllnoShow2(RowBounds rb);
}
