package com.security.gurume365.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.security.gurume365.vo.Reservations;

public interface ReservationMapper {
	public void insertReservation(Reservations reservations);
	public ArrayList<Reservations> storeReservation(int shopNo);
	public ArrayList<HashMap<String, Object>> getMyResList(String id);
	public void resSetNoshow(int seqRes);
	public void resSetVisit(int seqRes);
	public void noshowChange(Reservations reservations);
	public void noshowChange2(Reservations reservations);
	public Reservations getReservation(int seqRes);
}
