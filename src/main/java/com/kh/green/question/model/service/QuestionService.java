package com.kh.green.question.model.service;

import java.util.ArrayList;

import com.kh.green.common.PageInfo;
import com.kh.green.question.model.vo.Question;

public interface QuestionService {

	int getListCount();
	
	ArrayList<Question> selectList(String categoryTab, PageInfo pi);

//	ArrayList<Question> selectList(String categoryTab);
	
	int insertBoard(Question q);
	
	int insertQuestion(Question q);

	Question selectQuestion(int bNo);

	int updateBoard(Question q);

	int deleteBoard(int bNo);





}
