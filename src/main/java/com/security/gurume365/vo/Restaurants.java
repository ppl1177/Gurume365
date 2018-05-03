package com.security.gurume365.vo;

public class Restaurants {

	private String id;
	private String companyNo;
	private String companyName;
	private String address;
	private String phone;
	private int shopNo;
	private String category;
	private String timeOfOpen;
	private String shopInfo;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCompanyNo() {
		return companyNo;
	}
	public void setCompanyNo(String companyNo) {
		this.companyNo = companyNo;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getShopNo() {
		return shopNo;
	}
	public void setShopNo(int shopNo) {
		this.shopNo = shopNo;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTimeOfOpen() {
		return timeOfOpen;
	}
	public void setTimeOfOpen(String timeOfOpen) {
		this.timeOfOpen = timeOfOpen;
	}
	public String getShopInfo() {
		return shopInfo;
	}
	public void setShopInfo(String shopInfo) {
		this.shopInfo = shopInfo;
	}
	
	@Override
	public String toString() {
		return "Restaurants [id=" + id + ", companyNo=" + companyNo + ", companyName=" + companyName + ", address="
				+ address + ", phone=" + phone + ", shopNo=" + shopNo + ", category=" + category + ", timeOfOpen="
				+ timeOfOpen + ", shopInfo=" + shopInfo + "]";
	}
	
	public Restaurants() {
		super();
		// TODO Auto-generated constructor stub
	}



}
