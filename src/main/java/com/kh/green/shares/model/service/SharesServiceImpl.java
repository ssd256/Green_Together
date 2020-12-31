package com.kh.green.shares.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.green.common.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.shares.model.dao.SharesDAO;
import com.kh.green.shares.model.vo.Apply;
import com.kh.green.shares.model.vo.Comments;
import com.kh.green.shares.model.vo.SearchCondition;
import com.kh.green.shares.model.vo.Shares;
//import com.kh.green.shares.model.vo.SharesSearch;


@Service("sService")
public class SharesServiceImpl implements SharesService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private SharesDAO sDAO;
	
	@Override
	public int getListCount() {
		return sDAO.getListCount(sqlSession);
	}
	
	@Override
	public ArrayList selectTList(int i, PageInfo pi) {
		ArrayList list = null;
		
		if(i == 1) {
			list = sDAO.selectSList(sqlSession, pi);
		} else {
			list = sDAO.selectFList(sqlSession, pi);
		}
		
		return list;
	}
	
	@Override
	public int insertShares(Shares s) {
		int result1 = sDAO.insertThBoard(sqlSession, s);
		int result2 = sDAO.insertShares(sqlSession, s);
		
		if(result1 > 0 && result2 > 0) {
			return result1;
		} else {
			return 0;
		}
	}
	
	@Override
	public int insertFiles(Files f) {
		return sDAO.insertFiles(sqlSession, f);
	}
	
	@Override
	public int insertThumbnail(Shares s, ArrayList<Files> fileList) { //X
		
		int result1 = sDAO.insertThBoard(sqlSession, s);
		int result2 = sDAO.insertShares(sqlSession, s);
		int result3 = sDAO.insertFiles(sqlSession, fileList);
		
		
		if(result1 > 0 && result2 > 0 && result3 > 0) {
			return result1;
		} else {
			return 0;
		}
		
	}
	
	@Override
	public Shares selectBoard(int bNo) {
		return sDAO.selectBoard(sqlSession, bNo);
	}
	
	@Override
	public ArrayList<Files> selectFiles(int bNo) {
		return sDAO.selectFile(sqlSession, bNo);
	}
	
	@Override
	public int insertReply(Comments r) {
		return sDAO.insertReply(sqlSession, r);
	}
	
	@Override
	public ArrayList<Comments> selectReplyList(int bNo) {
		return sDAO.selectReplyList(sqlSession, bNo);
	}
	
	
	
	
	@Override
	public int updateShares(Shares s) {
		
		int result1 = sDAO.updateThBoard(sqlSession, s);
		int result2 = sDAO.updateShares(sqlSession, s);
		
		if(result1 > 0 && result2 > 0) {
			return result1;
		} else {
			return 0;
		}
		
	}
	
	
	@Override
	public int updateFiles(Files f) {
		return sDAO.updateFiles(sqlSession, f);
	}
	
	
	
	
	
	
	
	@Override
	public int updateThumbnail(int bNo, Shares s, ArrayList<Files> fileList) {
		int result1 = sDAO.updateThBoard(sqlSession, bNo, s);
		int result2 = sDAO.updateShares(sqlSession, bNo, s);
//		int result3 = sDAO.updateFiles(sqlSession, bNo, fileList);
		
		
//		if(result1 > 0 && result2 > 0 && result3 > 0) {
		if(result1 > 0 && result2 > 0) {
			return result1;
		} else {
			return 0;
		}
	}
	
	
	
	
	@Override
	public int insertApply(Apply a) {
		return sDAO.insertApply(sqlSession, a);
	}
	
	
	
	@Override
	public int updateApplyShares(int bNo) {
		return sDAO.updateApplyShares(sqlSession, bNo);
	}
	
	
	@Override
	public int deleteApply(Apply a) {
		return sDAO.deleteApply(sqlSession, a);
	}
	
	@Override
	public int updateApplyDeleteShares(int bNo) {
		return sDAO.updateApplyDeleteShares(sqlSession, bNo);
	}
	
	
	
	
	
	@Override
	public int deleteBoard(int bNo) {
		return sDAO.deleteBoard(sqlSession, bNo);
	}
	
//	@Override
//	public int getSharesListCount(SharesSearch ss) {
//		return sDAO.getSharesListCount(sqlSession, ss);
//	}
//	
//	@Override
//	public ArrayList selectSTList(int i, PageInfo pi, SharesSearch ss) {
//		ArrayList list = null;
//		
//		if(i == 1) {
//			list = sDAO.selectSearchSList(sqlSession, pi, ss);
//		} else {
//			list = sDAO.selectSearchFList(sqlSession, pi, ss);
//		}
//		
//		return list;
//	}
	
	@Override
	public int getSearchResultListCount(SearchCondition sc) {
		return sDAO.getSearchResultListCount(sqlSession,sc);
	}

	@Override
	public ArrayList<Shares> selectSearchTList(SearchCondition sc, PageInfo pi) {
		return sDAO.selectSearchTList(sqlSession, sc, pi);
	}
	
	@Override
	public ArrayList<Files> selectSearchFList(SearchCondition sc, PageInfo pi) {
		return sDAO.selectSearchFList(sqlSession, sc, pi);
	}
	
	@Override
	public Apply selectApply(Shares shares) {
		return sDAO.selectApply(sqlSession, shares);
	}
	
	@Override
	public ArrayList<Shares> sharesCurrentList() {
		return sDAO.sharesCurrentList(sqlSession);
	}
	
	@Override
	public int commentsDelete(Comments c) {
		return sDAO.commentsDelete(sqlSession, c);
	}
	
	@Override
	public int modifyComments(Comments c) {
		return sDAO.modifyComments(sqlSession, c);
	}
	
}
