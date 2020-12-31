package com.kh.green.question.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.green.common.PageInfo;
import com.kh.green.question.model.vo.Question;

@Repository("qDAO")
public class QuestionDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("questionMapper.getListCount");
	}
	
	public ArrayList<Question> selectList(SqlSessionTemplate sqlSession, String categoryTab, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("questionMapper.selectList", categoryTab, rowBounds);
	}

//	public ArrayList<Question> selectList(SqlSessionTemplate sqlSession, String categoryTab) {
//		return (ArrayList)sqlSession.selectList("questionMapper.selectList2", categoryTab);
//	}
	
	public int insertBoard(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.insert("questionMapper.insertBoard", q);
	}
	
	public int insertQuestion(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.insert("questionMapper.insertQuestion", q);
	}

	public Question selectQuestion(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("questionMapper.selectQuestion", bNo);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.update("questionMapper.updateBoard", q);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("questionMapper.deleteBoard", bNo);
	}





}
