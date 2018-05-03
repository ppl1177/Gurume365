package com.security.gurume365.vo;

public class FloorTable {
	int shopNo;
	int floorNo;
	int posX, posY;
	double tableLength, tableWidth;
	String tableShape;
	int degree;
	int personMin, personMax;
	int tableNo;
	String currentsit;
	
	public FloorTable() {
		super();
	}
	
	public FloorTable(int shopNo, int floorNo, int posX, int posY, double tableLength, double tableWidth,
			String tableShape, int degree, int personMin, int personMax, int tableNo, String currentsit) {
		super();
		this.shopNo = shopNo;
		this.floorNo = floorNo;
		this.posX = posX;
		this.posY = posY;
		this.tableLength = tableLength;
		this.tableWidth = tableWidth;
		this.tableShape = tableShape;
		this.degree = degree;
		this.personMin = personMin;
		this.personMax = personMax;
		this.tableNo = tableNo;
		this.currentsit = currentsit;
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

	public int getPosX() {
		return posX;
	}

	public void setPosX(int posX) {
		this.posX = posX;
	}

	public int getPosY() {
		return posY;
	}

	public void setPosY(int posY) {
		this.posY = posY;
	}

	public double getTableLength() {
		return tableLength;
	}

	public void setTableLength(double tableLength) {
		this.tableLength = tableLength;
	}

	public double getTableWidth() {
		return tableWidth;
	}

	public void setTableWidth(double tableWidth) {
		this.tableWidth = tableWidth;
	}

	public String getTableShape() {
		return tableShape;
	}

	public void setTableShape(String tableShape) {
		this.tableShape = tableShape;
	}

	public int getDegree() {
		return degree;
	}

	public void setDegree(int degree) {
		this.degree = degree;
	}

	public int getPersonMin() {
		return personMin;
	}

	public void setPersonMin(int personMin) {
		this.personMin = personMin;
	}

	public int getPersonMax() {
		return personMax;
	}

	public void setPersonMax(int personMax) {
		this.personMax = personMax;
	}

	public int getTableNo() {
		return tableNo;
	}

	public void setTableNo(int tableNo) {
		this.tableNo = tableNo;
	}

	public String getCurrentsit() {
		return currentsit;
	}

	public void setCurrentsit(String currentsit) {
		this.currentsit = currentsit;
	}

	@Override
	public String toString() {
		return "FloorTable [shopNo=" + shopNo + ", floorNo=" + floorNo + ", posX=" + posX + ", posY=" + posY
				+ ", tableLength=" + tableLength + ", tableWidth=" + tableWidth + ", tableShape=" + tableShape
				+ ", degree=" + degree + ", personMin=" + personMin + ", personMax=" + personMax + ", tableNo="
				+ tableNo + ", currentsit=" + currentsit + "]";
	}
	
	
	
	
	
}
