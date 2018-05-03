package com.security.gurume365.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.security.gurume365.mapper.StoreMapper;
import com.security.gurume365.vo.Reservations;
import com.security.gurume365.vo.Store;

@Repository
public class StoreDAO {

	@Autowired
	SqlSession sqlsession;
	
	public void insertStore(Store store) {
		
		StoreMapper storemapper = sqlsession.getMapper(StoreMapper.class);
		try {
			storemapper.insertStore(store);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Store> selectStoreFromCname(String companyName){
		ArrayList<Store> list = new ArrayList<Store>();
		try{
			StoreMapper mapper =sqlsession.getMapper(StoreMapper.class);
			list = mapper.selectStoreFromCname(companyName);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Store> loadMyStore(String id) {
		ArrayList<Store> result = null;
		try {
			StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
			result = mapper.loadMyStore(id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int selectShopNo(String companyName){
		int result = 0;
		try{
			StoreMapper mapper =sqlsession.getMapper(StoreMapper.class);
			result = mapper.selectShopNo(companyName);
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
	
	public Store selectStore(int shopNo){
		
		StoreMapper mapper = sqlsession.getMapper(StoreMapper.class);
		Store store = null;
		
		try {
			store = mapper.selectStore(shopNo);
			mapper.upHitsStore(shopNo);
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return store;
	}
	
	public ArrayList<Store> storeList(){
		StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
		ArrayList<Store>slist=new ArrayList<>();
		try {
			slist=mapper.storeList();
		}catch(Exception e) {
			e.printStackTrace();
		}	
		return slist;
	}
	
	public ArrayList<Store> gradeList(){
		StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
		ArrayList<Store>slist=new ArrayList<>();
		try {
			slist=mapper.gradeList();
		}catch(Exception e) {
			e.printStackTrace();
		}	
		return slist;	
	}
	
	public ArrayList<Store> hitsList(){
		StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
		ArrayList<Store>slist=new ArrayList<>();
		try {
			slist=mapper.hitsList();
		}catch(Exception e) {
			e.printStackTrace();
		}	
		return slist;	
	}
	
	public ArrayList<Store> resList(){
		StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
		ArrayList<Store>slist=new ArrayList<>();
		try {
			slist=mapper.hitsList();
		}catch(Exception e) {
			e.printStackTrace();
		}	
		return slist;	
	}
	
	public ArrayList<String> getCategories() {
		ArrayList<String> result = null;
		
		try {
			StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
			result = mapper.getCategories();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;	
	}
	public int addStore(Store store) {
		int result = 0;
		try {
			StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
			result = mapper.insertStore(store);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int deleteStore(Store store) {
		int result = 0;
		try {
			StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
			result = mapper.deleteStore(store);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public void upHitsStore(int shopNo){
		StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
		try{
			mapper.upHitsStore(shopNo);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int getHits(int shopNo) {
		int result = 0;
		try {
			StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
			result = mapper.getHits(shopNo);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String getCompanyNo(int shopNo) {
		String result = "";
		try {
			StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
			result = mapper.getCompanyNo(shopNo);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int editSetStore(Store store) {
		int result = 0;
		try {
			StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
			result = mapper.editSetStore(store);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public ArrayList<Store> searchList(HashMap<String, String> map){
		ArrayList<Store> list = null;
		StoreMapper mapper=sqlsession.getMapper(StoreMapper.class);
		try{
			list = mapper.searchList(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public int noShowNum(){
		int numResult = 0;
		
		StoreMapper mapper = sqlsession.getMapper(StoreMapper.class);
		
		try{
			numResult = mapper.noShowNum();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return numResult;
	}
	
	public ArrayList<Store> selectAllnoShow(int startRecord, int countPerPage){
		
		ArrayList<Store> storeList = null;
		
		StoreMapper mapper = sqlsession.getMapper(StoreMapper.class);
		
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		try {
			storeList = mapper.selectAllnoShow(rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return storeList;
	}
	public ArrayList<Reservations> selectAllnoShow2(int startRecord, int countPerPage){
		
		ArrayList<Reservations> resList = null;
		
		StoreMapper mapper = sqlsession.getMapper(StoreMapper.class);
		
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		try {
			resList = mapper.selectAllnoShow2(rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resList;
	}
}
	

