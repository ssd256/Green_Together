package com.kh.green.asked.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.green.common.PageInfo;
import com.kh.green.question.model.vo.Question;
import com.kh.green.question.model.vo.Reply;
import com.kh.green.shares.model.vo.SearchCondition;

@Repository("aDAO")
public class AskedDAO {
	
	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("askedMapper.getListCount");
	}
	
	public ArrayList<Question> selectList(SqlSessionTemplate sqlSession, PageInfo pi, String categoryTab ) {
	  int offset=(pi.getCurrentPage() - 1) * pi.getBoardLimit(); RowBounds
	 rowBounds = new RowBounds(offset, pi.getBoardLimit());
	 
	 return (ArrayList)sqlSession.selectList("askedMapper.selectList", categoryTab, rowBounds); 
	}
	
	public int insertBoard(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.insert("askedMapper.insertBoard", q);
	}

	public int insertAsked(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.insert("askedMapper.insertAsked", q);
	}

	public Question selectAsked(SqlSessionTemplate sqlSession, int bNo) {
		return (Question)sqlSession.selectOne("askedMapper.selectAsked", bNo);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.update("askedMapper.updateBoard", q);
	}

	public int updateAsked(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.update("askedMapper.updateAsked", q);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("askedMapper.deleteBoard", bNo);
	}


	
	//댓글 부분	
	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlSession, int bNo) {
		return (ArrayList)sqlSession.selectList("askedMapper.selectReplyList", bNo);
	}
	
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("askedMapper.insertReply", r);
	}

	public int updateReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.update("askedMapper.updateReply", r);
	}
	
	public int deleteReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.update("askedMapper.deleteReply", r);
	}

	public int selectReplyCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("askedMapper.selectReplyCount", bNo);
	}

	public int getSearchResultListCount(SqlSessionTemplate sqlSession, SearchCondition sc) {
		return sqlSession.selectOne("askedMapper.selectSearchResultCount", sc);
	}

	public ArrayList<Question> selectSearchAskedList(SqlSessionTemplate sqlSession, SearchCondition sc, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("askedMapper.selectSearchAskedList", sc, rowBounds);
	}
	

}
