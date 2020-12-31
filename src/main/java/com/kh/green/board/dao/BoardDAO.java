package com.kh.green.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.green.board.model.vo.Board;
import com.kh.green.board.model.vo.Files;

@Repository("bDAO")
public class BoardDAO {

	public int insertFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.insert("boardMapper.insertFiles", f);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}

	public Board selectImageBoard(SqlSessionTemplate sqlSession, String string) {
		return (Board)sqlSession.selectOne("boardMapper.selectImageBoard", string);
	}

	public Files selectImageFiles(SqlSessionTemplate sqlSession, int getbNo) {
		return (Files)sqlSession.selectOne("boardMapper.selectImageFiles", getbNo);
	}

	public int getImageListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getImageListCount");
	}

	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}

	public int updateFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.update("boardMapper.updateFiles", f);
	}

}
