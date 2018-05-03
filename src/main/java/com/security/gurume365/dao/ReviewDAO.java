package com.security.gurume365.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.security.gurume365.mapper.ReviewMapper;
import com.security.gurume365.vo.Review;

@Repository
public class ReviewDAO {
	@Autowired
	SqlSession sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(ReviewDAO.class);
	
	public void insertReview(Review review){

		ReviewMapper mapper =sqlSession.getMapper(ReviewMapper.class);
		try{
			logger.info("INSERT REVIEW DAO 진입");
			int result = mapper.insertReview(review);
			if(result == 1){
				logger.info("INSERT REVIEW DAO INSERT 성공");
					
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public ArrayList<Review> selectReviewFromDate(){
		ArrayList<Review> list = new ArrayList<Review>();
		ReviewMapper mapper =sqlSession.getMapper(ReviewMapper.class);
		try{
			logger.info("SELECT REVIEW DAO 진입");
			list = mapper.selectReviewFromDate();
		}catch(Exception e){
			e.printStackTrace();
		}
	return list;
	}
	
	public ArrayList<Review> selectReviewBest(){
		ArrayList<Review> list = new ArrayList<Review>();
		ReviewMapper mapper =sqlSession.getMapper(ReviewMapper.class);
		try{
			logger.info("SELECT REVIEW BEST 진입");
			list = mapper.selectReviewBest();
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<HashMap<String, Object>> getMyReview(String id) {
		ArrayList<HashMap<String, Object>> list = null;
		logger.info("리뷰 불러오기 dao 진입");
		try{
			ReviewMapper mapper =sqlSession.getMapper(ReviewMapper.class);
			logger.info("SELECT REVIEW BEST 진입");
			list = mapper.getMyReview(id);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	public ArrayList<Review> selectReviewFive(){
		ArrayList<Review> list = new ArrayList<Review>();
		ReviewMapper mapper =sqlSession.getMapper(ReviewMapper.class);
		try{
			logger.info("SELECT REVIEW 5 진입");
			list = mapper.selectReviewFive();
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	
	public Review recentReview(int shopNo){
		Review review = null;
		ReviewMapper mapper =sqlSession.getMapper(ReviewMapper.class);
		try{
			review = mapper.recentReview(shopNo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return review;
	}
	
	public Review companyReview(String companyName){
		Review review = null;
		ReviewMapper mapper =sqlSession.getMapper(ReviewMapper.class);
		try{
			review = mapper.companyReview(companyName);
		}catch(Exception e){
			e.printStackTrace();
		}
		return review;
	}
}
