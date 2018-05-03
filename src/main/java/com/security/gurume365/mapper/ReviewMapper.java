package com.security.gurume365.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.security.gurume365.vo.Review;

public interface ReviewMapper {

	public int insertReview(Review review);
	
	public ArrayList<Review> selectReviewFromDate();
	
	public ArrayList<Review> selectReviewBest();
	
	public ArrayList<HashMap<String, Object>> getMyReview(String id);
	
	public ArrayList<Review> selectReviewFive();
	
	public Review recentReview(int shopNo);
	
	public Review companyReview(String companyName);
}
