package com.security.gurume365.vo;

public class Store {

	private String id;
	private String companyName;
	private String companyNo;
	private String address1;
	private String address2;
	private String phone;
	private int shopNo;
	private String category;
	private String timeOfOpen;
	private String shopInfo;
	private int budjet;
	private String comment;
	private String grade;
	private int hits;
	private String originalfile;
	private String savedfile;
	private String holiday;
	
	public Store() {
		super();
	}

	public Store(String id, String companyName, String companyNo, String address1, String address2, String phone,
			int shopNo, String category, String timeOfOpen, String shopInfo, int budjet, String comment, String grade,
			int hits, String originalfile, String savedfile, String holiday) {
		super();
		this.id = id;
		this.companyName = companyName;
		this.companyNo = companyNo;
		this.address1 = address1;
		this.address2 = address2;
		this.phone = phone;
		this.shopNo = shopNo;
		this.category = category;
		this.timeOfOpen = timeOfOpen;
		this.shopInfo = shopInfo;
		this.budjet = budjet;
		this.comment = comment;
		this.grade = grade;
		this.hits = hits;
		this.originalfile = originalfile;
		this.savedfile = savedfile;
		this.holiday = holiday;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyNo() {
		return companyNo;
	}

	public void setCompanyNo(String companyNo) {
		this.companyNo = companyNo;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
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

	public int getBudjet() {
		return budjet;
	}

	public void setBudjet(int budjet) {
		this.budjet = budjet;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	public String getOriginalfile() {
		return originalfile;
	}

	public void setOriginalfile(String originalfile) {
		this.originalfile = originalfile;
	}

	public String getSavedfile() {
		return savedfile;
	}

	public void setSavedfile(String savedfile) {
		this.savedfile = savedfile;
	}

	public String getHoliday() {
		return holiday;
	}

	public void setHoliday(String holiday) {
		this.holiday = holiday;
	}

	@Override
	public String toString() {
		return "Store [id=" + id + ", companyName=" + companyName + ", companyNo=" + companyNo + ", address1="
				+ address1 + ", address2=" + address2 + ", phone=" + phone + ", shopNo=" + shopNo + ", category="
				+ category + ", timeOfOpen=" + timeOfOpen + ", shopInfo=" + shopInfo + ", budjet=" + budjet
				+ ", comment=" + comment + ", grade=" + grade + ", hits=" + hits + ", originalfile=" + originalfile
				+ ", savedfile=" + savedfile + ", holiday=" + holiday + "]";
	}
	
}
