package com.security.gurume365.mapper;

import java.util.ArrayList;

import com.security.gurume365.vo.Res_table;

public interface Res_tableMapper {
	public void insertResTable(Res_table res_table);
	public ArrayList<Res_table> resTableList(int seqRes);
}
