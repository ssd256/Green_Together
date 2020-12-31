package com.kh.green.volunteer.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.green.common.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.product.model.vo.Product;
import com.kh.green.volunteer.model.vo.Participation;
import com.kh.green.volunteer.model.vo.Volunteer;
import com.kh.green.volunteer.model.vo.VolunteerReview;

@Repository("vDAO")
public class VolunteerDAO {

	// 봉사활동 등록(관리자)
	public int insertVolunteer(SqlSessionTemplate sqlSession, Volunteer v) {
		return sqlSession.insert("volunteerMapper.insertVolunteer", v);
	}

	// 봉사활동 리스트 페이징
	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("volunteerMapper.getListCount");
	}
	
	public int getListCountOption(SqlSessionTemplate sqlSession, String input) {
		return sqlSession.selectOne("volunteerMapper.getListCountOption", input);
	}

	public ArrayList<Volunteer> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("volunteerMapper.selectList", null, rowBounds);
	}

	public ArrayList<Volunteer> selectOptionList(SqlSessionTemplate sqlSession, PageInfo pi, String input) {
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("volunteerMapper.selectOptionList", input, rowBounds);
	}

	public Volunteer vDetail(SqlSessionTemplate sqlSession, String input) {
		return (Volunteer)sqlSession.selectOne("volunteerMapper.vDetail", input);
	}

	public int volunteerDelete(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("volunteerMapper.deleteVolunteer", bNo);
	}

	public int volunteerUpdate(SqlSessionTemplate sqlSession, Volunteer v) {
		return sqlSession.update("volunteerMapper.updateVolunteer", v);
	}

	public int boardUpdate(SqlSessionTemplate sqlSession, Volunteer v) {
		return sqlSession.update("volunteerMapper.updateBoard", v);
	}

	public int volunteerAppUpdate(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("volunteerMapper.vAppUpdate", bNo);
	}

	public int participationInsert(SqlSessionTemplate sqlSession, Participation p) {
		return sqlSession.insert("volunteerMapper.participationInsert", p);
	}

	public Participation participationSelect(SqlSessionTemplate sqlSession, Participation p) {
		return (Participation)sqlSession.selectOne("volunteerMapper.participationSelect", p);
	}

	public int volunteerAppDeCountUpdate(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("volunteerMapper.vAppDecountUpdate", bNo);
	}

	public int participationStatus(SqlSessionTemplate sqlSession, Participation p) {
		return sqlSession.update("volunteerMapper.participationStatus", p);
	}

	public Volunteer volunteerDetailStandard(SqlSessionTemplate sqlSession, int bNo) {
		return (Volunteer)sqlSession.selectOne("volunteerMapper.volunteerDetailStandard", bNo);
	}

	public ArrayList<Volunteer> selectCurrentList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("volunteerMapper.selectCurrentList");
	}

	public Participation participationYN(SqlSessionTemplate sqlSession, Participation p) {
		return (Participation)sqlSession.selectOne("volunteerMapper.participationYN", p);
	}

	public int participationStatusY(SqlSessionTemplate sqlSession, Participation p) {
		return sqlSession.update("volunteerMapper.participationStatusY", p);
	}

	public ArrayList<Participation> volunteerEndList(SqlSessionTemplate sqlSession, String loginUserId) {
		return (ArrayList)sqlSession.selectList("volunteerMapper.volunteerEndList", loginUserId);
	}

	public Volunteer volunteerDetail(SqlSessionTemplate sqlSession, int bNo) {
		return (Volunteer)sqlSession.selectOne("volunteerMapper.mVolunteerDetail", bNo);
	}

	public int vrInsert(SqlSessionTemplate sqlSession, VolunteerReview vr) {
		return sqlSession.insert("volunteerMapper.vrInsert", vr);
	}

	public int insertFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.update("volunteerMapper.insertAllFiles", f);
	}

	public int updateVRStatus(SqlSessionTemplate sqlSession, VolunteerReview vr) {
		return sqlSession.update("volunteerMapper.updateVRStatus", vr);
	}

	public VolunteerReview vReviewDetail(SqlSessionTemplate sqlSession, VolunteerReview vr) {
		return (VolunteerReview)sqlSession.selectOne("volunteerMapper.vReviewDetail", vr);
	}

	public ArrayList<Files> selectFile(SqlSessionTemplate sqlSession, int vrNo) {
		return (ArrayList)sqlSession.selectList("volunteerMapper.selectFile", vrNo);
	}

	public int vrUpdate(SqlSessionTemplate sqlSession, VolunteerReview vr) {
		return sqlSession.update("volunteerMapper.vrUpdate", vr);
	}

	public int updateFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.update("volunteerMapper.updateFiles", f);
	}

	public int vrinsertFiles(SqlSessionTemplate sqlSession, Files f) {
		return sqlSession.update("volunteerMapper.vrinsertAllFiles", f);
	}

	public Files fileBNoSelect(SqlSessionTemplate sqlSession, VolunteerReview vr) {
		return (Files)sqlSession.selectOne("volunteerMapper.fileBNoSelect", vr);
	}

	public int vrDelete(SqlSessionTemplate sqlSession, int vrNo) {
		return sqlSession.update("volunteerMapper.vrDelete", vrNo);
	}

	public int vrFilesDelete(SqlSessionTemplate sqlSession, int vrNo) {
		return sqlSession.update("volunteerMapper.vrFilesDelete", vrNo);
	}

	public int pVrStatusUpdate(SqlSessionTemplate sqlSession, Participation p) {
		return sqlSession.update("volunteerMapper.pVrStatusUpdate", p);
	}

	public ArrayList<Volunteer> selectVRList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("volunteerMapper.selectVRList", null, rowBounds);
	}

	public ArrayList<VolunteerReview> vrListSelect(SqlSessionTemplate sqlSession, int bNo) {
		return (ArrayList)sqlSession.selectList("volunteerMapper.vrListSelect", bNo);
	}

	public VolunteerReview vReviewDetailList(SqlSessionTemplate sqlSession, int vrNo) {
		return (VolunteerReview)sqlSession.selectOne("volunteerMapper.vReviewDetailList", vrNo);
	}

	public int vrBoardDelete(SqlSessionTemplate sqlSession, int vrNo) {
		return sqlSession.update("volunteerMapper.vrBoardDelete", vrNo);
	}

	public int updateVolunteerCount(SqlSessionTemplate sqlSession, VolunteerReview vr) {
		return sqlSession.update("volunteerMapper.updateVolunteerCount", vr);
	}

	public int updateVolunteerCountDelete(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("volunteerMapper.updateVolunteerCountDelete", bNo);
	}

	public Volunteer volunteerDetailvr(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("volunteerMapper.volunteerDetailvr", bNo);
	}

	public int getListSearchCount(SqlSessionTemplate sqlSession, String keywordInput) {
		return sqlSession.selectOne("volunteerMapper.getListSearchCount", keywordInput);
	}

	public ArrayList<Volunteer> selectSearchVRList(SqlSessionTemplate sqlSession, String keywordInput, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("volunteerMapper.selectSearchVRList", keywordInput, rowBounds);
	}

	public Volunteer volunteerDetailKeywordvr(SqlSessionTemplate sqlSession, String input) {
		return sqlSession.selectOne("volunteerMapper.volunteerDetailKeywordvr", input);
	}

	public int getVRListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("volunteerMapper.getVRListCount");
	}

}
