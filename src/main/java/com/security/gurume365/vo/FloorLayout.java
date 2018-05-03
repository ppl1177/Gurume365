package com.security.gurume365.vo;

public class FloorLayout {
	int floorNo, shopNo;
	double floorHeight, floorWidth;
	
	public FloorLayout() {
		super();
	}
	
	public FloorLayout(int floorNo, int shopNo, double floorHeight, double floorWidth) {
		super();
		this.floorNo = floorNo;
		this.shopNo = shopNo;
		this.floorHeight = floorHeight;
		this.floorWidth = floorWidth;
	}
	public int getFloorNo() {
		return floorNo;
	}
	public void setFloorNo(int floorNo) {
		this.floorNo = floorNo;
	}
	public int getShopNo() {
		return shopNo;
	}
	public void setShopNo(int shopNo) {
		this.shopNo = shopNo;
	}
	public double getFloorHeight() {
		return floorHeight;
	}
	public void setFloorHeight(double floorHeight) {
		this.floorHeight = floorHeight;
	}
	public double getFloorWidth() {
		return floorWidth;
	}
	public void setFloorWidth(double floorWidth) {
		this.floorWidth = floorWidth;
	}
	@Override
	public String toString() {
		return "FloorLayout [floorNo=" + floorNo + ", shopNo=" + shopNo + ", floorHeight=" + floorHeight
				+ ", floorWidth=" + floorWidth + "]";
	}
	
	
	
}
