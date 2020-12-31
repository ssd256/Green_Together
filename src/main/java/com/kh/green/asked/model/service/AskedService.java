package com.kh.green.asked.model.service;

import java.util.ArrayList;

import com.kh.green.common.PageInfo;
import com.kh.green.question.model.vo.Question;
import com.kh.green.question.model.vo.Reply;
import com.kh.green.shares.model.vo.SearchCondition;

public interface AskedService {

	ArrayList<Question> selectList(String categoryTab, PageInfo pi);

	int insertBoard(Question q);

	int insertAsked(Question q);

	int getListCount();

	Question selectAsked(int bNo);

	int updateBoard(Question q);
	
	int updateAsked(Question q);

	int deleteBoard(int bNo);

	
	//댓글부분
	ArrayList<Reply> selectReplyList(int bNo);
	
	int insertReply(Reply r);
	
	int updateReply(Reply r);

	int deleteReply(Reply r);

	int selectCountReply(int bNo);

	int getSearchResultListCount(SearchCondition sc);

	ArrayList<Question> selectSearchAskedList(SearchCondition sc, PageInfo pi);

}
