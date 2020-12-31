package com.kh.green.question.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.green.common.PageInfo;
import com.kh.green.question.model.dao.QuestionDAO;
import com.kh.green.question.model.vo.Question;

@Service("qService")
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private QuestionDAO qDAO;
	
	@Override
	public int getListCount() {
		return qDAO.getListCount(sqlSession);
	}
	
	@Override
	public ArrayList<Question> selectList(String categoryTab, PageInfo pi) {
		return qDAO.selectList(sqlSession, categoryTab, pi);
	}
	
//	@Override
//	public ArrayList<Question> selectList(String categoryTab) {
//		return qDAO.selectList(sqlSession, categoryTab);
//	}
	
	@Override
	public int insertBoard(Question q) {
		return qDAO.insertBoard(sqlSession, q);
	}
	
	@Override
	public int insertQuestion(Question q) {
		return qDAO.insertQuestion(sqlSession, q);
	}
	
	@Override
	public Question selectQuestion(int bNo) {
		return qDAO.selectQuestion(sqlSession, bNo);
	}
	
	@Override
	public int updateBoard(Question q) {
		return qDAO.updateBoard(sqlSession, q);
	}
	
	@Override
	public int deleteBoard(int bNo) {
		return qDAO.deleteBoard(sqlSession, bNo);
	}
	
	
	
}
