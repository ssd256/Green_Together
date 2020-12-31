package com.kh.green.asked.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.green.asked.model.dao.AskedDAO;
import com.kh.green.common.PageInfo;
import com.kh.green.question.model.vo.Question;
import com.kh.green.question.model.vo.Reply;
import com.kh.green.shares.model.vo.SearchCondition;

@Service("aService")
public class AskedServiceImpl implements AskedService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private AskedDAO aDAO;

	@Override
	public int getListCount() {
		return aDAO.getListCount(sqlSession);
	}
	
	 @Override 
	 public ArrayList<Question> selectList(String categoryTab, PageInfo pi) {
		return aDAO.selectList(sqlSession, pi, categoryTab); 
	 }
	 

	@Override
	public int insertBoard(Question q) {
		return aDAO.insertBoard(sqlSession, q);
	}

	@Override
	public int insertAsked(Question q) {
		return aDAO.insertAsked(sqlSession, q);
	}

	@Override
	public Question selectAsked(int bNo) {
		return aDAO.selectAsked(sqlSession, bNo);
	}

	@Override
	public int updateBoard(Question q) {
		return aDAO.updateBoard(sqlSession, q);

	}
	
	
	 @Override 
	 public int updateAsked(Question q) { 
		 return aDAO.updateAsked(sqlSession, q); 
	 }

	@Override
	public int deleteBoard(int bNo) {
		return aDAO.deleteBoard(sqlSession, bNo);
	}

	
	//댓글부분
	@Override
	public ArrayList<Reply> selectReplyList(int bNo) {
		return aDAO.selectReplyList(sqlSession, bNo);
	}
	
	@Override
	public int insertReply(Reply r) {
		return aDAO.insertReply(sqlSession, r);
	}

	@Override
	public int updateReply(Reply r) {
		return aDAO.updateReply(sqlSession, r);
	}
	
	@Override
	public int deleteReply(Reply r) {
		return aDAO.deleteReply(sqlSession, r);
	}

	@Override
	public int selectCountReply(int bNo) {
		return aDAO.selectReplyCount(sqlSession, bNo);
	}


	@Override
	public int getSearchResultListCount(SearchCondition sc) {
		return aDAO.getSearchResultListCount(sqlSession, sc);
	}

	@Override
	public ArrayList<Question> selectSearchAskedList(SearchCondition sc, PageInfo pi) {
		return aDAO.selectSearchAskedList(sqlSession, sc, pi);
	}

}
