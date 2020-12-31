package com.kh.green.shares.model.service;

import java.util.ArrayList;

import com.kh.green.common.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.shares.model.vo.Apply;
import com.kh.green.shares.model.vo.Comments;
import com.kh.green.shares.model.vo.SearchCondition;
import com.kh.green.shares.model.vo.Shares;
//import com.kh.green.shares.model.vo.SharesSearch;

public interface SharesService {

	int getListCount();

	ArrayList selectTList(int i, PageInfo pi);

	int insertThumbnail(Shares s, ArrayList<Files> fileList);

	Shares selectBoard(int bNo);

	ArrayList<Files> selectFiles(int bNo);

	int insertReply(Comments r);

	ArrayList<Comments> selectReplyList(int bId);

	int updateThumbnail(int bNo, Shares s, ArrayList<Files> fileList);

	int insertApply(Apply a);

	int deleteBoard(int bNo);

	int getSearchResultListCount(SearchCondition sc);

	ArrayList<Shares> selectSearchTList(SearchCondition sc, PageInfo pi);

	ArrayList<Files> selectSearchFList(SearchCondition sc, PageInfo pi);

	Apply selectApply(Shares shares);

	int insertShares(Shares s);

	int insertFiles(Files f);

	
	
	int updateShares(Shares s);

	int updateFiles(Files f);

	int updateApplyShares(int bNo);

	int deleteApply(Apply a);

	int updateApplyDeleteShares(int bNo);

	ArrayList<Shares> sharesCurrentList();

	int commentsDelete(Comments c);

	int modifyComments(Comments c);


	
	

//	int getSharesListCount(SharesSearch ss);
//
//	ArrayList selectSTList(int i, PageInfo pi, SharesSearch ss);

}
