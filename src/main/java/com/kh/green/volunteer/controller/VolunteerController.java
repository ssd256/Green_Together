package com.kh.green.volunteer.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.green.common.BoardException;
import com.kh.green.common.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.common.Pagination;
import com.kh.green.member.model.vo.Member;
import com.kh.green.product.model.exception.ProductException;
import com.kh.green.product.model.vo.Product;
import com.kh.green.question.model.exception.QuestionException;
import com.kh.green.volunteer.model.exception.VolunteerException;
import com.kh.green.volunteer.model.service.VolunteerService;
import com.kh.green.volunteer.model.vo.Participation;
import com.kh.green.volunteer.model.vo.Volunteer;
import com.kh.green.volunteer.model.vo.VolunteerReview;

@Controller
public class VolunteerController {
	
	@Autowired
	private VolunteerService vService;
	
	// 봉사활동 리스트를 눌렀을 때 나오는 첫 화면
	@RequestMapping("vList.vo")
	public ModelAndView volunteerList(@RequestParam(value = "page", required = false) Integer page,
									  @RequestParam(value="categoryTab", required=false) String categoryTab,
									  ModelAndView mv) {
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		int listCount = vService.getListCount(); // 총 게시글 수
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount); // 페이징
		
		ArrayList<Volunteer> vList = null;
		
		vList = vService.selectList(pi);
		if(vList != null) {
			mv.addObject("vList", vList)
			  .addObject("pi", pi)
			  .addObject("category", 1)
			  .setViewName("volunteerList");
		}
		
		return mv;
	}
	
	// 옵션을 눌렀을 때 해당하는 리스트만 가지고 옴
	@RequestMapping("vOption.vo")
	public ModelAndView volunteerOptionList(@RequestParam(value = "page", required = false) Integer page,
											@RequestParam(value ="localInput") String localInput, 
											@RequestParam(value = "statusInput") String statusInput,
											@RequestParam(value = "startInput") String startInput,
											@RequestParam(value = "endInput") String endInput,
											ModelAndView mv) {
		String input = localInput+"@"+statusInput+"#"+startInput+"~"+endInput;
		if(endInput == "") {
			input = localInput+"@"+statusInput+"#"+startInput+"~"+"end없음";
		}
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int listCount = vService.getListCountOption(input); // 옵션에 맞는 페이징
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount); // 페이징
		
		ArrayList<Volunteer> vList = null;
		vList = vService.selectOptionList(pi, input);
		
		if(vList != null) {
			mv.addObject("vList", vList)
			  .addObject("localInput", localInput)
			  .addObject("statusInput", statusInput)
			  .addObject("startInput", startInput)
			  .addObject("endInput", endInput)
			  .addObject("pi", pi)
			  .addObject("category", 2)
			  .setViewName("volunteerList");
		} else {
			throw new VolunteerException("봉사활동 조회에 실패하였습니다.");
		}
		
		return mv;
	}
	
	// 봉사활동 추가 뷰 이동
	@RequestMapping("vinsertView.vo")
	public String volunteerInsert() {
		return "volunteerInsert";
	}
	
	// 봉사활동 추가(데이터 추가)-관리자
	@RequestMapping("vInsert.vo")
	public String insertVolunteer(@ModelAttribute Volunteer v, @RequestParam("address1") String address1,
															   @RequestParam("address2") String address2,
															   @RequestParam("vDay1") String vDay1,
															   @RequestParam("vDay2") String vDay2,
															   @RequestParam("vTime1") String vTime1,
															   @RequestParam("vTime2") String vTime2) {
		v.setvDay(vDay1 + "~" + vDay2);
		v.setvTime(vTime1 + "~" + vTime2);
		v.setvLocation(address1 + "/" + address2);
		
		vService.insertVolunteer(v);
		
		return "redirect:vList.vo";
	}
	
	// 봉사활동 리스트 상세보기
	@RequestMapping("vDetail.vo")
		public ModelAndView volunteerDetailView(@RequestParam("bNo") int bNo,
												@RequestParam(value ="localInput") String localInput, 
												@RequestParam(value = "statusInput") String statusInput,
												@RequestParam(value = "startInput") String startInput,
												@RequestParam(value = "endInput") String endInput,
												@RequestParam(value = "page") String page,
												@ModelAttribute Participation p,
												ModelAndView mv,
												HttpSession session) {
		if(page.equals("")) {
			page = "1";
		}
		int page1 = Integer.parseInt(page);
		int currentPage = page1;
		
		int listCount = vService.getListCount(); // 총 게시글 수
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount); // 페이징
		
		String input = localInput+"@"+statusInput+"#"+startInput+"~"+endInput + "*" + bNo;
		if(endInput == "") {
			input = localInput+"@"+statusInput+"#"+startInput+"~"+"end없음" + "*" + bNo;
		}
		Volunteer v = vService.volunteerDetailView(input);
		Member loginUser = (Member)session.getAttribute("loginUser");
		if(loginUser != null) {
			String loginUserId = loginUser.getUserId();
			p.setmId(loginUserId);
			p = vService.participationSelect(p);
		}
		if(v != null) {
			mv.addObject("v", v)
			  .addObject("p", p)
			  .addObject("localInput", localInput)
			  .addObject("statusInput", statusInput)
			  .addObject("startInput", startInput)
			  .addObject("endInput", endInput)
			  .addObject("pi", pi)
			  .setViewName("volunteerDetail");
		} else {
			throw new BoardException("봉사활동 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	// 봉사활동 삭제
	@RequestMapping("vDelete.vo")
	public String volunteerDelete(@RequestParam("bNo") int bNo) {
		int result = vService.volunteerDelete(bNo);
		
		if(result > 0) {
			return "redirect:vList.vo";
		} else {
			throw new VolunteerException("봉사활동 삭제에 실패하였습니다.");
		}
	}
	
	// 봉사활동 수정 뷰 이동
	@RequestMapping("vUpdateView.vo")
	public ModelAndView volunteerUpdateView(@RequestParam("bNo") int bNo,
											@RequestParam(value ="localInput") String localInput, 
											@RequestParam(value = "statusInput") String statusInput,
											@RequestParam(value = "startInput") String startInput,
											@RequestParam(value = "endInput") String endInput,
											ModelAndView mv) {
		String input = localInput+"@"+statusInput+"#"+startInput+"~"+endInput + "*" + bNo;
		if(endInput == "") {
			input = localInput+"@"+statusInput+"#"+startInput+"~"+"end없음" + "*" + bNo;
		}
		if(localInput == "" && statusInput == "" && startInput == "" && endInput == ""){
			Volunteer v = vService.volunteerDetailStandard(bNo);
			mv.addObject("v", v)
			  .setViewName("volunteerUpdate");
		} else {
			Volunteer v = vService.volunteerDetailView(input);
			mv.addObject("v", v)
			  .addObject("localInput", localInput)
			  .addObject("statusInput", statusInput)
			  .addObject("startInput", startInput)
			  .addObject("endInput", endInput)
			  .setViewName("volunteerUpdate");
		}
		return mv;
	}
	@RequestMapping("vUpdate.vo")
	public ModelAndView volunteerUpdate(@ModelAttribute Volunteer v, 
										@RequestParam("address1") String address1,
										@RequestParam("address2") String address2,
										@RequestParam("vDay1") String vDay1,
										@RequestParam("vDay2") String vDay2,
										@RequestParam("vTime1") String vTime1,
										@RequestParam("vTime2") String vTime2,
										@RequestParam(value ="localInput") String localInput, 
										@RequestParam(value = "statusInput") String statusInput,
										@RequestParam(value = "startInput") String startInput,
										@RequestParam(value = "endInput") String endInput,
										ModelAndView mv) {
		v.setvDay(vDay1 + "~" + vDay2);
		v.setvTime(vTime1 + "~" + vTime2);
		v.setvLocation(address1 + "/" + address2);
		
		int result = vService.volunteerUpdate(v);
		
		if(result > 0) {
			mv.addObject("v", v)
			  .addObject("localInput", localInput)
			  .addObject("statusInput", statusInput)
			  .addObject("startInput", startInput)
			  .addObject("endInput", endInput)
			  .setViewName("volunteerDetail");
		} else {
			throw new VolunteerException("봉사활동 수정에 실패하였습니다.");
		}
		return mv;
	}
	
	// 사용자-봉사활동 신청 누를 경우 신청인원 +1, 취소를 누를 경우 신청인원 -1
	@RequestMapping("vUpdaateApp.vo")
	public ModelAndView volunteerAppUpdate(@ModelAttribute Participation p,
										   @ModelAttribute Volunteer v,
										   @RequestParam("bNo") int bNo,
										   @RequestParam("appNo") int appNo,
										   @RequestParam(value ="localInput") String localInput, 
										   @RequestParam(value = "statusInput") String statusInput,
										   @RequestParam(value = "startInput") String startInput,
										   @RequestParam(value = "endInput") String endInput,
										   ModelAndView mv, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String loginUserId = loginUser.getUserId();
		
		p.setmId(loginUserId);
		int appCount = vService.volunteerAppUpdate(bNo, appNo);
		// appNo가 1일 경우 참가인원 +1, 2일 경우 참가인원 -1
		v.setvApplicant(appCount);
		
		String input = localInput+"@"+statusInput+"#"+startInput+"~"+endInput + "*" + bNo;
		if(endInput == "") {
			input = localInput+"@"+statusInput+"#"+startInput+"~"+"end없음" + "*" + bNo;
		}
		v = vService.volunteerDetailView(input);
		
		if(appNo == 1) { // 신청하기 버튼을 누를 경우 봉사활동 신청자 추가
			Participation pa = vService.participationYN(p);
			if(pa == null) { // 신청내역이 없을 경우 봉사활동 Insert
				p.setmId(loginUserId);
				p.setbNo(bNo);
				int result = vService.participationInsert(p);
				if(result > 0) {
					p = vService.participationSelect(p);
					mv.addObject("p", p)
					  .addObject("v", v)
					  .addObject("localInput", localInput)
					  .addObject("statusInput", statusInput)
					  .addObject("startInput", startInput)
					  .addObject("endInput", endInput)
					  .setViewName("volunteerDetail");
					} else {
						throw new VolunteerException("봉사활동 신청에 실패하였습니다.");
					}
			} else { // 봉사활동 신청내역이 있을 경우 상태 'Y'로 되어있는걸 'N'으로 변경
				int result = vService.participationStatusY(p);
				if(result > 0) {
					p = vService.participationSelect(p);
					mv.addObject("p", p)
					  .addObject("v", v)
					  .addObject("localInput", localInput)
					  .addObject("statusInput", statusInput)
					  .addObject("startInput", startInput)
					  .addObject("endInput", endInput)
					  .setViewName("volunteerDetail");
					} else {
						throw new VolunteerException("봉사활동 신청에 실패하였습니다.");
					}
			}
		} else { // 취소하기 버튼을 누를 경우 봉사활동 상태를 'Y'로 변경
			int result = vService.participationStatus(p);
			if(result > 0) {
				p = vService.participationSelect(p);
				mv.addObject("p", p)
				  .addObject("v", v)
				  .addObject("localInput", localInput)
				  .addObject("statusInput", statusInput)
				  .addObject("startInput", startInput)
				  .addObject("endInput", endInput)
				  .setViewName("volunteerDetail");
			} else {
				throw new VolunteerException("봉사활동 신청취소에 실패하였습니다.");
			}
		}
		return mv;
	}
	
	// 홈에 봉사활동 최신글
	@RequestMapping("vCurrentList.vo")
	public void vCurrentList(HttpServletResponse response) throws JsonIOException, IOException {
		ArrayList<Volunteer> list = vService.selectCurrentList();
		
		response.setContentType("application/json; charset=UTF-8");
		
		new GsonBuilder().setDateFormat("yyyy-MM-dd").create().toJson(list, response.getWriter());
	}
	
	// 봉사활동 후기 게시판 이동
	@RequestMapping("vReview.vo")
	public ModelAndView vReview(ModelAndView mv, @RequestParam(value = "page", required = false) Integer page) {
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		int listCount = vService.getVRListCount(); // 총 게시글 수
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount); // 페이징
		
		ArrayList<Volunteer> vList = null;
		
		vList = vService.selectVRList(pi);
		
		if(vList != null) {
			mv.addObject("vList", vList);
			mv.setViewName("vReview");
			return mv;
		} else {
			throw new VolunteerException("봉사활동 후기 목록 조회에 실패하였습니다.");
		}
	}
	
	@RequestMapping("volunteerEndList.vo")
	public ModelAndView volunteerEndList(@ModelAttribute Participation p,
										 ModelAndView mv, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String loginUserId = loginUser.getUserId();
		
		ArrayList<Participation> pList = null;
		
		pList = vService.volunteerEndList(loginUserId);
		if(pList != null) {
			mv.addObject("pList", pList);
			mv.setViewName("volunteerEndList");
		} else {
			throw new VolunteerException("봉사활동 완료 목록 조회에 실패하였습니다.");
		}
		
		return mv;
	}
	
	@RequestMapping("vReviewInsertForm.vo")
	public ModelAndView vReviewInsertForm(ModelAndView mv,  @RequestParam("bNo") int bNo) {
		Volunteer v = vService.volunteerDetail(bNo);
		
		if(v != null) {
			mv.addObject("v", v)
			  .setViewName("vReviewInsert");
		} else {
			throw new VolunteerException("봉사활동 후기 게시판 연결에 실패하였습니다.");
		}
		return mv;
	}
	
	@RequestMapping("vrInsert.vo")
	public String vrInsert(@ModelAttribute VolunteerReview vr, HttpServletRequest request, 
						   @ModelAttribute Files f,
						   @RequestParam("thumbnailImg1") MultipartFile t1,
						   @RequestParam("thumbnailImg2") MultipartFile t2, 
						   @RequestParam("thumbnailImg3") MultipartFile t3, 
						   HttpSession session) throws IOException {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		
		vr.setmId(userId);
		
		int result1 = vService.vrInsert(vr);
		int result2 = 0;
		int i = 0;
		if(t1 != null && !t1.isEmpty()) {
			f.setfOriginName(t1.getOriginalFilename());
			String renameFileName = saveFile(t1, request, i++);
			
			if(renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			f.setfLevel(0);
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\volunteerReview_uploadFiles");
			
			result2 = vService.insertFiles(f);
		}
		
		if(t2 != null && !t2.isEmpty()) {
			f.setfOriginName(t2.getOriginalFilename());
			String renameFileName = saveFile(t2, request, i++);
			
			if(renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			f.setfLevel(1);
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\volunteerReview_uploadFiles");
			
			result2 = vService.insertFiles(f);
		}
		
		if(t3 != null && !t3.isEmpty()) {
			f.setfOriginName(t3.getOriginalFilename());
			String renameFileName = saveFile(t3, request, i++);
			
			if(renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			f.setfLevel(2);
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\volunteerReview_uploadFiles");
			
			result2 = vService.insertFiles(f);
		}
		if(result1 > 0) {
			int result3 = vService.updateVolunteerCount(vr);
			if(result3 > 0) {
				vService.updateVRStatus(vr);
				return "redirect:volunteerEndList.vo";
			} else { 
				throw new ProductException("후기 등록에 실패하였습니다.");
			}
		} else { 
			throw new ProductException("후기 등록에 실패하였습니다.");
		}
	}
	public String saveFile(MultipartFile file, HttpServletRequest request, int i) {
		String root = request.getSession().getServletContext().getRealPath("resources");	// 파일경로 최상단 설정 --> resources
		String savePath = root + "\\volunteerReview_uploadFiles";	// shares 파일 저장 경로(폴더)
		
		File folder = new File(savePath);
		if(!folder.exists()) {	// 파일 저장폴더 없으면 만들고 시작
			folder.mkdir();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");	// changefileName에 들어갈 날짜 형식 바꿔줌
		String fileOriginName = file.getOriginalFilename();
		String fileChangeName = sdf.format(new Date(System.currentTimeMillis()))
				+ i + "." + fileOriginName.substring(fileOriginName.lastIndexOf(".") + 1);
		
		String changePath = folder + "\\" + fileChangeName;
		
		try {
			file.transferTo(new File(changePath));
		} catch (Exception e) {
			System.out.print("파일 전송 에러 : " + e.getMessage());
			e.printStackTrace();
		}
		
		return fileChangeName;
		
	}
	
	@RequestMapping("vReviewDetail.vo")
	public ModelAndView vReviewDetail(ModelAndView mv, @RequestParam("bNo") int bNo, @ModelAttribute VolunteerReview vr, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		
		vr.setmId(userId);
		
		VolunteerReview vReview = vService.vReviewDetail(vr);
		
		if(vReview != null) {
			int vrNo = vReview.getVrNo();
			ArrayList<Files> files = vService.selectFiles(vrNo);
			Volunteer v = vService.volunteerDetailStandard(bNo);
			
			
			mv.addObject("vReview", vReview);
			mv.addObject("files", files);
			mv.addObject("v", v);
			mv.addObject("category", 1);
			mv.setViewName("vReviewDetail");
		} else {
			throw new ProductException("후기 조회에 실패하였습니다.");
		}
		
		return mv;
	}
	
	@RequestMapping("vrUpdateVeiw.vo")
	public ModelAndView vrUpdateView(@RequestParam("bNo") int bNo, @ModelAttribute VolunteerReview vr, ModelAndView mv, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		
		vr.setmId(userId);
		
		VolunteerReview vReview = vService.vReviewDetail(vr);
		
		if(vReview != null) {
			int vrNo = vReview.getVrNo();
			ArrayList<Files> files = vService.selectFiles(vrNo);
			Volunteer v = vService.volunteerDetailStandard(bNo);
			
			mv.addObject("vReview", vReview);
			mv.addObject("files", files);
			mv.addObject("v", v);
			mv.setViewName("vReviewUpdate");
		} else {
			throw new ProductException("후기 수정 연결에 실패하였습니다.");
		}
		
		return mv;
	}
	
	@RequestMapping("vrUpdate.vo")
	public String vrUpdate(@ModelAttribute VolunteerReview vr, HttpServletRequest request, 
			   			   @ModelAttribute Files f,
			   			   @RequestParam("thumbnailImg1") MultipartFile t1,
			   			   @RequestParam("thumbnailImg2") MultipartFile t2, 
			   			   @RequestParam("thumbnailImg3") MultipartFile t3,
			   			   @RequestParam("fNum1") int fNum1,
			   			   @RequestParam("fNum2") int fNum2,
			   			   @RequestParam("fNum3") int fNum3,
			   			   HttpSession session) throws IOException {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		vr.setmId(userId);
		vService.vrUpdate(vr);
		int i = 0;
		if(t1 != null && !t1.isEmpty()) {
			f.setfOriginName(t1.getOriginalFilename());
			f.setfNum(fNum1);
			String renameFileName = saveFile(t1, request, i++);
			
			if(renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			f.setfLevel(0);
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\volunteerReview_uploadFiles");
			if(fNum1==0 && fNum2==0 && fNum3==0) {
				int vrNo = vr.getVrNo();
				f.setbNo(vrNo);
				vService.vrinsertFiles(f);
			} else {
				if(fNum1 != 0) {
					vService.updateFiles(f);
				} else {
					Files fi = vService.fileBNoSelect(vr);
					int selectResult = fi.getbNo();
					f.setbNo(selectResult);
					vService.vrinsertFiles(f);
				}
			}
		}
		
		if(t2 != null && !t2.isEmpty()) {
			f.setfOriginName(t2.getOriginalFilename());
			f.setfNum(fNum2);
			String renameFileName = saveFile(t2, request, i++);
			
			if(renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			f.setfLevel(1);
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\volunteerReview_uploadFiles");
			if(fNum2 != 0) {
				vService.updateFiles(f);
			} else {
				Files fi = vService.fileBNoSelect(vr);
				int selectResult = fi.getbNo();
				f.setbNo(selectResult);
				vService.vrinsertFiles(f);
			}
		}
		
		if(t3 != null && !t3.isEmpty()) {
			f.setfOriginName(t3.getOriginalFilename());
			f.setfNum(fNum3);
			String renameFileName = saveFile(t3, request, i++);
			
			if(renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			f.setfLevel(2);
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\volunteerReview_uploadFiles");
			if(fNum3 != 0) {
				vService.updateFiles(f);
			} else {
				Files fi = vService.fileBNoSelect(vr);
				int selectResult = fi.getbNo();
				f.setbNo(selectResult);
				vService.vrinsertFiles(f);
			}
		}
		return "redirect:volunteerEndList.vo";
	}
	
	@RequestMapping("vrdelete.vo")
	public String vrDelete(@RequestParam("vrNo") int vrNo, @RequestParam("bNo") int bNo, HttpSession session, @ModelAttribute Participation p) {
		int result1 = vService.vrDelete(vrNo);
		int result2 = vService.vrFilesDelete(vrNo);
		
		if (result1 > 0 && result2 > 0) {
			int result4 = vService.vrBoardDelete(vrNo);
			if(result4 > 0) {
				p.setbNo(bNo);
				Member loginUser = (Member)session.getAttribute("loginUser");
				String userId = loginUser.getUserId();
				p.setmId(userId);
				int result3 = vService.pVrStatusUpdate(p);
				int result5 = vService.updateVolunteerCountDelete(bNo);
				if(result3 > 0) {
					return "redirect:volunteerEndList.vo";
				} else {
					throw new ProductException("후기 삭제에 실패하였습니다.");
				}
			} else {
				throw new ProductException("후기 삭제에 실패하였습니다.");
			}
		} else {
			throw new ProductException("후기 삭제에 실패하였습니다.");
		}
	}
	
	@RequestMapping("vReviewList.vo")
	public ModelAndView vReviewList(@RequestParam("bNo") int bNo,
									@RequestParam(value = "keywordInput") String keywordInput,
									@ModelAttribute Volunteer v,
									ModelAndView mv,
									HttpSession session) {
		if(keywordInput == "") {
			v = vService.volunteerDetailvr(bNo);
			ArrayList<VolunteerReview> vrList = vService.vrListSelect(bNo);
			mv.addObject("v", v);
			mv.addObject("vrList", vrList);
			mv.setViewName("vReviewListView");
		} else {
			String input = bNo + "@" + keywordInput;
			v = vService.volunteerDetailKeywordvr(input);
			ArrayList<VolunteerReview> vrList = vService.vrListSelect(bNo);
			mv.addObject("v", v);
			mv.addObject("vrList", vrList);
			mv.addObject("keywordInput", keywordInput);
			mv.setViewName("vReviewListView");
		}
		return mv;
	}
	
	@RequestMapping("vReviewDetailList.vo")
	public ModelAndView vReviewDetailList(ModelAndView mv, @RequestParam("vrNo") int vrNo, 
										  @RequestParam(value = "keywordInput") String keywordInput,
										  @RequestParam("bNo") int bNo, 
										  @ModelAttribute VolunteerReview vr) {
		VolunteerReview vReview = vService.vReviewDetailList(vrNo);
		
		if(vReview != null) {
			ArrayList<Files> files = vService.selectFiles(vrNo);
			Volunteer v = vService.volunteerDetailStandard(bNo);
			
			mv.addObject("vReview", vReview);
			mv.addObject("files", files);
			mv.addObject("keywordInput", keywordInput);
			mv.addObject("v", v);
			mv.addObject("category", 2);
			mv.setViewName("vReviewDetail");
		} else {
			throw new ProductException("후기 조회에 실패하였습니다.");
		}
		
		return mv;
	}
	
	@RequestMapping("vrSearch.vo")
	public ModelAndView vrSearch(@RequestParam("keywordInput") String keywordInput,
								 @RequestParam(value="page", required=false) Integer page,
								 ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}

		int listCount = vService.getListSearchCount(keywordInput);// 총 게시글 수

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Volunteer> vList = vService.selectSearchVRList(keywordInput, pi);
		
		if(vList != null) {
			mv.addObject("vList", vList);
			mv.addObject("pi", pi);
			mv.addObject("keywordInput", keywordInput);
			mv.setViewName("vReview");
		} else {
			throw new ProductException("후기 조회에 실패하였습니다.");
		}
		
		return mv;
	}
}
