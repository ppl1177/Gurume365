package com.security.gurume365.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.security.gurume365.vo.FloorLayout;
import com.security.gurume365.vo.FloorTable;

public interface FloorMapper {
	
	public FloorLayout loadFloor(@Param("shop_no")int shop_no, @Param("floor_no")int floor_no);
	
	public ArrayList<FloorTable> loadTables(@Param("shop_no")int shop_no, @Param("floor_no")int floor_no);
	
	public int deleteAllTables(@Param("id")String id, @Param("shop_no")int shop_no, @Param("floor_no")int floor_no);
	
	public int saveFloorTables(FloorTable table);
	
}