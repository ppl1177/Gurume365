package com.security.gurume365.vo;
/**
 * 리뷰 정보 VO
 */
public class Review {
	/**
	 * 업로드 된 파일을 지정된 경로에 저장하고, 저장된 파일명을 리턴
	 * {@value} companyName 레스토랑 검색 이름
	 * {@value} reviewText 리뷰 내용
	 * {@value} starScore 별점
	 * {@value} originalfile 첨부파일명 (원래 이름)
	 * {@value} savedfile 첨부파일명 (실제 저장된 이름)
	 * {@value} inputdate 작성 날짜, 시간
	 * {@value} name 작성자
	 * {@value} shopNo 레스토랑 키
	 * {@value} replyNo 리뷰 키 시퀀스생성
	 */
	private String companyName;
	private String reviewText;
	private int starScore;
	private String originalfile;			
	private String savedfile;
	private String inputdate;
	private String id;
	private int shopNo;
	private int replyNo;
	private String category;
	private String picture;
	
	
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Review(String companyName, String reviewText, int starScore, String originalfile, String savedfile,
			String inputdate, String id, int shopNo, int replyNo, String category, String picture) {
		super();
		this.companyName = companyName;
		this.reviewText = reviewText;
		this.starScore = starScore;
		this.originalfile = originalfile;
		this.savedfile = savedfile;
		this.inputdate = inputdate;
		this.id = id;
		this.shopNo = shopNo;
		this.replyNo = replyNo;
		this.category = category;
		this.picture = picture;
	}


	@Override
	public String toString() {
		return "Review [companyName=" + companyName + ", reviewText=" + reviewText + ", starScore=" + starScore
				+ ", originalfile=" + originalfile + ", savedfile=" + savedfile + ", inputdate=" + inputdate + ", id="
				+ id + ", shopNo=" + shopNo + ", replyNo=" + replyNo + ", category=" + category + ", picture=" + picture
				+ "]";
	}


	public String getCompanyName() {
		return companyName;
	}


	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}


	public String getReviewText() {
		return reviewText;
	}


	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}


	public int getStarScore() {
		return starScore;
	}


	public void setStarScore(int starScore) {
		this.starScore = starScore;
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


	public String getInputdate() {
		return inputdate;
	}


	public void setInputdate(String inputdate) {
		this.inputdate = inputdate;
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


	public int getReplyNo() {
		return replyNo;
	}


	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public String getPicture() {
		return picture;
	}


	public void setPicture(String picture) {
		this.picture = picture;
	}


	public Review(String companyName2, String reviewText2, int i, String originalFileName, String savedfile2,
			Object inputdate2, String id2, int shopNo2) {
		// TODO Auto-generated constructor stub
	}

	
	
	
	
	
	
}
