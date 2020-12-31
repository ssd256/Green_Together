package com.kh.green.volunteer.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.kh.green.common.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.product.model.vo.Product;
import com.kh.green.volunteer.model.dao.VolunteerDAO;
import com.kh.green.volunteer.model.vo.Participation;
import com.kh.green.volunteer.model.vo.Volunteer;
import com.kh.green.volunteer.model.vo.VolunteerReview;

@Repository
public class VolunteerServiceImpl implements VolunteerService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private VolunteerDAO vDAO;

	
	@Override	// 봉사활동 등록(관리자)
	public int insertVolunteer(Volunteer v) {
		return vDAO.insertVolunteer(sqlSession, v);
	}


	@Override // 봉사활동 리스트 페이징
	public int getListCount() {
		return vDAO.getListCount(sqlSession);
	}
	
	@Override // 봉사활동 옵션을 눌렀을 때 리스트 페이징
	public int getListCountOption(String input) {
		return vDAO.getListCountOption(sqlSession, input);
	}


	@Override
	public ArrayList<Volunteer> selectList(PageInfo pi) {
		return vDAO.selectList(sqlSession, pi);
	}


	@Override
	public ArrayList<Volunteer> selectOptionList(PageInfo pi, String input) {
		return vDAO.selectOptionList(sqlSession, pi, input);
	}


	@Override
	public Volunteer volunteerDetailView(String input) {
		return vDAO.vDetail(sqlSession, input);
	}


	@Override
	public int volunteerDelete(int bNo) {
		return vDAO.volunteerDelete(sqlSession, bNo);
	}


	@Override
	public int volunteerUpdate(Volunteer v) {
		int result1 = vDAO.boardUpdate(sqlSession, v);
		int result2 = vDAO.volunteerUpdate(sqlSession, v);
		
		if(result1 > 0 && result2 >0) {
			return result1;
		} else {
			return 0;
		}
	}


	@Override
	public int volunteerAppUpdate(int bNo, int appNo) {
		if(appNo == 1) {
			return vDAO.volunteerAppUpdate(sqlSession, bNo);
		} else {
			return vDAO.volunteerAppDeCountUpdate(sqlSession, bNo);
		}
	}


	@Override
	public int participationInsert(Participation p) {
		return vDAO.participationInsert(sqlSession, p);
	}


	@Override
	public Participation participationSelect(Participation p) {
		return vDAO.participationSelect(sqlSession, p);
	}


	@Override
	public int participationStatus(Participation p) {
		// TODO Auto-generated method stub
		return vDAO.participationStatus(sqlSession, p);
	}


	@Override
	public Volunteer volunteerDetailStandard(int bNo) {
		return vDAO.volunteerDetailStandard(sqlSession, bNo);
	}


	@Override
	public ArrayList<Volunteer> selectCurrentList() {
		return vDAO.selectCurrentList(sqlSession);
	}


	@Override
	public Participation participationYN(Participation p) {
		return vDAO.participationYN(sqlSession, p);
	}


	@Override
	public int participationStatusY(Participation p) {
		return vDAO.participationStatusY(sqlSession, p);
	}


	@Override
	public ArrayList<Participation> volunteerEndList(String loginUserId) {
		return vDAO.volunteerEndList(sqlSession, loginUserId);
	}


	@Override
	public Volunteer volunteerDetail(int bNo) {
		return vDAO.volunteerDetail(sqlSession, bNo);
	}


	@Override
	public int vrInsert(VolunteerReview vr) {
		return vDAO.vrInsert(sqlSession, vr);
	}


	@Override
	public int insertFiles(Files f) {
		return vDAO.insertFiles(sqlSession, f);
	}


	@Override
	public int updateVRStatus(VolunteerReview vr) {
		return vDAO.updateVRStatus(sqlSession, vr);
	}


	@Override
	public VolunteerReview vReviewDetail(VolunteerReview vr) {
		return vDAO.vReviewDetail(sqlSession, vr);
	}


	@Override
	public ArrayList<Files> selectFiles(int vrNo) {
		return vDAO.selectFile(sqlSession, vrNo);
	}


	@Override
	public int vrUpdate(VolunteerReview vr) {
		return vDAO.vrUpdate(sqlSession, vr);
	}


	@Override
	public int updateFiles(Files f) {
		return vDAO.updateFiles(sqlSession, f);
	}


	@Override
	public int vrinsertFiles(Files f) {
		return vDAO.vrinsertFiles(sqlSession, f);
	}


	@Override
	public Files fileBNoSelect(VolunteerReview vr) {
		return vDAO.fileBNoSelect(sqlSession, vr);
	}


	@Override
	public int vrDelete(int vrNo) {
		return vDAO.vrDelete(sqlSession, vrNo);
	}


	@Override
	public int vrFilesDelete(int vrNo) {
		return vDAO.vrFilesDelete(sqlSession, vrNo);
	}


	@Override
	public int pVrStatusUpdate(Participation p) {
		return vDAO.pVrStatusUpdate(sqlSession, p);
	}

	@Override
	public ArrayList<Volunteer> selectVRList(PageInfo pi) {
		return vDAO.selectVRList(sqlSession, pi);
	}


	@Override
	public ArrayList<VolunteerReview> vrListSelect(int bNo) {
		return vDAO.vrListSelect(sqlSession, bNo);
	}


	@Override
	public VolunteerReview vReviewDetailList(int vrNo) {
		return vDAO.vReviewDetailList(sqlSession, vrNo);
	}


	@Override
	public int vrBoardDelete(int vrNo) {
		return vDAO.vrBoardDelete(sqlSession, vrNo);
	}


	@Override
	public int updateVolunteerCount(VolunteerReview vr) {
		return vDAO.updateVolunteerCount(sqlSession, vr);
	}


	@Override
	public int updateVolunteerCountDelete(int bNo) {
		return vDAO.updateVolunteerCountDelete(sqlSession, bNo);
	}


	@Override
	public Volunteer volunteerDetailvr(int bNo) {
		return vDAO.volunteerDetailvr(sqlSession, bNo);
	}


	@Override
	public int getListSearchCount(String keywordInput) {
		return vDAO.getListSearchCount(sqlSession, keywordInput);
	}


	@Override
	public ArrayList<Volunteer> selectSearchVRList(String keywordInput, PageInfo pi) {
		return vDAO.selectSearchVRList(sqlSession, keywordInput, pi);
	}


	@Override
	public Volunteer volunteerDetailKeywordvr(String input) {
		return vDAO.volunteerDetailKeywordvr(sqlSession, input);
	}


	@Override
	public int getVRListCount() {
		return vDAO.getVRListCount(sqlSession);
	}



}
