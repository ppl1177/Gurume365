package com.security.gurume365.vo;

public class Reservations {
	private String id;
	private int shopNo;
	private int floorNo;
	private int seqRes;
	private String datetime;
	private int person;
	private String content;
	private int situation;
	public Reservations() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Reservations(String id, int shopNo, int floorNo, int seqRes, String datetime, int person, String content,
			int situation) {
		super();
		this.id = id;
		this.shopNo = shopNo;
		this.floorNo = floorNo;
		this.seqRes = seqRes;
		this.datetime = datetime;
		this.person = person;
		this.content = content;
		this.situation = situation;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getShopNo() {
		return shopNo;
	}
	public void setShopNo(int shopNo) {
		this.shopNo = shopNo;
	}
	public int getFloorNo() {
		return floorNo;
	}
	public void setFloorNo(int floorNo) {
		this.floorNo = floorNo;
	}
	public int getSeqRes() {
		return seqRes;
	}
	public void setSeqRes(int seqRes) {
		this.seqRes = seqRes;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	public int getPerson() {
		return person;
	}
	public void setPerson(int person) {
		this.person = person;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getSituation() {
		return situation;
	}
	public void setSituation(int situation) {
		this.situation = situation;
	}
	@Override
	public String toString() {
		return "Reservations [id=" + id + ", shopNo=" + shopNo + ", floorNo=" + floorNo + ", seqRes=" + seqRes
				+ ", datetime=" + datetime + ", person=" + person + ", content=" + content + ", situation=" + situation
				+ "]";
	}
	
	
	
	
}
