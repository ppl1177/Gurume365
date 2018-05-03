package com.security.gurume365.vo;

public class Res_table {

	private int tableNo;
	private int personTable;
	private int seqRes;
	
	
	
	public Res_table() {
		super();
		// TODO Auto-generated constructor stub
	}



	public Res_table(int tableNo, int personTable, int seqRes) {
		super();
		this.tableNo = tableNo;
		this.personTable = personTable;
		this.seqRes = seqRes;
	}



	public int getTableNo() {
		return tableNo;
	}



	public void setTableNo(int tableNo) {
		this.tableNo = tableNo;
	}



	public int getPersonTable() {
		return personTable;
	}



	public void setPersonTable(int personTable) {
		this.personTable = personTable;
	}



	public int getSeqRes() {
		return seqRes;
	}



	public void setSeqRes(int seqRes) {
		this.seqRes = seqRes;
	}



	@Override
	public String toString() {
		return "Res_table [tableNo=" + tableNo + ", personTable=" + personTable + ", seqRes=" + seqRes + "]";
	}
	
	
}
