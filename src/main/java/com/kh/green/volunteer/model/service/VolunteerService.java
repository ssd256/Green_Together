package com.kh.green.volunteer.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.green.common.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.product.model.vo.Product;
import com.kh.green.volunteer.model.vo.Participation;
import com.kh.green.volunteer.model.vo.Volunteer;
import com.kh.green.volunteer.model.vo.VolunteerReview;
@Service("vService")
public interface VolunteerService {

	int insertVolunteer(Volunteer v);

	int getListCount();

	ArrayList<Volunteer> selectList(PageInfo pi);

	ArrayList<Volunteer> selectOptionList(PageInfo pi, String input);

	Volunteer volunteerDetailView(String input);

	int volunteerDelete(int bNo);

	int volunteerUpdate(Volunteer v);

	int volunteerAppUpdate(int bNo, int appNo);

	int participationInsert(Participation p);

	Participation participationSelect(Participation p);

	int participationStatus(Participation p);

	int getListCountOption(String input);

	Volunteer volunteerDetailStandard(int bNo);

	ArrayList<Volunteer> selectCurrentList();

	Participation participationYN(Participation p);

	int participationStatusY(Participation p);

	ArrayList<Participation> volunteerEndList(String loginUserId);

	Volunteer volunteerDetail(int bNo);

	int vrInsert(VolunteerReview vr);

	int insertFiles(Files f);

	int updateVRStatus(VolunteerReview vr);

	VolunteerReview vReviewDetail(VolunteerReview vr);

	ArrayList<Files> selectFiles(int vrNo);

	int vrUpdate(VolunteerReview vr);

	int updateFiles(Files f);

	int vrinsertFiles(Files f);

	Files fileBNoSelect(VolunteerReview vr);

	int vrDelete(int vrNo);

	int vrFilesDelete(int vrNo);

	int pVrStatusUpdate(Participation p);

	ArrayList<Volunteer> selectVRList(PageInfo pi);

	ArrayList<VolunteerReview> vrListSelect(int bNo);

	VolunteerReview vReviewDetailList(int vrNo);

	int vrBoardDelete(int vrNo);

	int updateVolunteerCount(VolunteerReview vr);

	int updateVolunteerCountDelete(int bNo);

	Volunteer volunteerDetailvr(int bNo);

	int getListSearchCount(String keywordInput);

	ArrayList<Volunteer> selectSearchVRList(String keywordInput, PageInfo pi);

	Volunteer volunteerDetailKeywordvr(String input);

	int getVRListCount();


}
