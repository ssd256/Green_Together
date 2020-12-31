package com.kh.green.shares.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.green.common.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.shares.model.vo.Apply;
import com.kh.green.shares.model.vo.Comments;
import com.kh.green.shares.model.vo.SearchCondition;
import com.kh.green.shares.model.vo.Shares;
//import com.kh.green.shares.model.vo.SharesSearch;

@Repository("sDAO")
public class SharesDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("sharesMapper.getListCount");
	}

	public ArrayList selectSList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("sharesMapper.selectSList", null, rowBounds);
	}

	public ArrayList selectFList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("sharesMapper.selectFList", null, rowBounds);
	}

	public int insertThBoard(SqlSessionTemplate sqlSession, Shares s) {
		return sqlSession.insert("sharesMapper.insertThBoard", s);
	}
	
	public int insertShares(SqlSessionTemplate sqlSession, Shares s) {
		return sqlSession.insert("sharesMapper.insertShares", s);
	}

	public int insertFiles(SqlSessionTemplate sqlSession, ArrayList<Files> fileList) {
		return sqlSession.update("sharesMapper.insertFiles", fileList); //사용안함
	}

	public int insertFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.update("sharesMapper.insertAllFiles", f);
	}

	public Shares selectBoard(SqlSessionTemplate sqlSession, int bNo) {
		return (Shares)sqlSession.selectOne("sharesMapper.selectBoard", bNo);
	}

	public ArrayList<Files> selectFile(SqlSessionTemplate sqlSession, int bNo) {
		return (ArrayList)sqlSession.selectList("sharesMapper.selectFile", bNo);
	}

	public int insertReply(SqlSessionTemplate sqlSession, Comments r) {
		return sqlSession.insert("sharesMapper.insertReply", r);
	}

	public ArrayList<Comments> selectReplyList(SqlSessionTemplate sqlSession, int bNo) {
		return (ArrayList)sqlSession.selectList("sharesMapper.selectReplyList", bNo);
	}

	public int updateThBoard(SqlSessionTemplate sqlSession, int bNo, Shares s) {
		// TODO Auto-generated method stub
		return sqlSession.insert("sharesMapper.updateThBoard", s);
	}

	public int updateShares(SqlSessionTemplate sqlSession, int bNo, Shares s) {
		// TODO Auto-generated method stub
		return sqlSession.insert("sharesMapper.updateShares", s);
	}

	public int updateFiles(SqlSessionTemplate sqlSession, int bNo, ArrayList<Files> fileList) {
		// TODO Auto-generated method stub
		return sqlSession.update("sharesMapper.insertFiles", fileList);
	}

	public int insertApply(SqlSessionTemplate sqlSession, Apply a) {
		return sqlSession.insert("sharesMapper.insertApply", a);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("questionMapper.deleteBoard", bNo);
	}

	public int getSearchResultListCount(SqlSessionTemplate sqlSession, SearchCondition sc) {
		return sqlSession.selectOne("sharesMapper.selectSearchResultCount", sc);
	}

	public ArrayList<Shares> selectSearchTList(SqlSessionTemplate sqlSession, SearchCondition sc, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("sharesMapper.selectSearchTList", sc, rowBounds);
	}

	public ArrayList<Files> selectSearchFList(SqlSessionTemplate sqlSession, SearchCondition sc, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("sharesMapper.selectSearchFList", sc, rowBounds);
	}

	public Apply selectApply(SqlSessionTemplate sqlSession, Shares shares) {
		return (Apply)sqlSession.selectOne("sharesMapper.selectApply", shares);
	}

	
	
	
	
	
	public int updateThBoard(SqlSessionTemplate sqlSession, Shares s) {
		return sqlSession.update("sharesMapper.updateAllBoard", s);
	}
	
	public int updateShares(SqlSessionTemplate sqlSession, Shares s) {
		return sqlSession.update("sharesMapper.updateAllShares", s);
	}

	public int updateFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.update("sharesMapper.updateAllFiles", f);
	}

	public int updateApplyShares(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("sharesMapper.updateApplyShares", bNo);
	}
	
	

	public int deleteApply(SqlSessionTemplate sqlSession, Apply a) {
		return sqlSession.delete("sharesMapper.deleteApply", a);
	}

	public int updateApplyDeleteShares(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("sharesMapper.updateApplyDeleteShares", bNo);
	}

	public ArrayList<Shares> sharesCurrentList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("sharesMapper.sharesCurrentList");
	}

	public int commentsDelete(SqlSessionTemplate sqlSession, Comments c) {
		return sqlSession.delete("sharesMapper.commentsDelete", c);
	}

	public int modifyComments(SqlSessionTemplate sqlSession, Comments c) {
		return sqlSession.update("sharesMapper.modifyComments", c);
	}



//	public int getSharesListCount(SqlSessionTemplate sqlSession, SharesSearch ss) {
//		return sqlSession.selectOne("sharesMapper.getSharesListCount");
//	}
//
//	public ArrayList selectSearchSList(SqlSessionTemplate sqlSession, PageInfo pi, SharesSearch ss) {
//		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
//		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
//		
//		return (ArrayList)sqlSession.selectList("sharesMapper.selectSearchSList", ss, rowBounds);
//	}
//
//	public ArrayList selectSearchFList(SqlSessionTemplate sqlSession, PageInfo pi, SharesSearch ss) {
//		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
//		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
//		
//		return (ArrayList)sqlSession.selectList("sharesMapper.selectSearchFList", ss, rowBounds);
//	}





}
