package com.kh.green.board.model.service;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.green.board.dao.BoardDAO;
import com.kh.green.board.model.service.BoardService;
import com.kh.green.board.model.vo.Board;
import com.kh.green.board.model.vo.Files;

@Service("bService")
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private BoardDAO bDAO;
	
	@Override
	public int insertFiles(Files f) {
		return bDAO.insertFiles(sqlSession, f);
	}

	@Override
	public int insertBoard(Board b) {
		return bDAO.insertBoard(sqlSession, b);
	}

	@Override
	public Board selectImageBoard(String string) {
		return bDAO.selectImageBoard(sqlSession, string);
	}

	@Override
	public Files selectImageFiles(int getbNo) {
		return bDAO.selectImageFiles(sqlSession, getbNo);
	}

	@Override
	public int getImageListCount() {
		return bDAO.getImageListCount(sqlSession);
	}

	@Override
	public int updateBoard(Board b) {
		return bDAO.updateBoard(sqlSession, b);
	}

	@Override
	public int updateFiles(Files f) {
		return bDAO.updateFiles(sqlSession, f);
	}

}
