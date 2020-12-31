package com.kh.green.asked.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.green.alarm.model.service.AlarmService;
import com.kh.green.alarm.model.vo.Alarm;
import com.kh.green.asked.model.service.AskedService;
import com.kh.green.common.BoardException;
import com.kh.green.common.PageInfo;
import com.kh.green.common.Pagination;
import com.kh.green.member.model.vo.Member;
import com.kh.green.question.model.vo.Question;
import com.kh.green.question.model.vo.Reply;
import com.kh.green.shares.model.vo.SearchCondition;


//영실 문의사항 컨트롤러
@Controller
public class AskedController {
	
	@Autowired
	private AskedService aService;
	@Autowired
	private AlarmService alarmService;
	
	 //문의사항 목록보기 화면이동
	 @RequestMapping(value="alist.ao",  method=RequestMethod.GET) 
	 public ModelAndView AskedListView(@RequestParam(value="page", required=false) Integer page, 
			 						   @RequestParam(value="categoryTab", required=false) String categoryTab,
			 						   ModelAndView mv) {
		 
	 int currentPage = 1; 
	 	if(page != null) { 
	 		currentPage = page; 
	 	}
	
	 int listCount = aService.getListCount();
	 
	 PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
	
	 ArrayList<Question> list = aService.selectList(categoryTab, pi);
	 
	 Question q = new Question();
	 
	 if(categoryTab == null) {	// 게시판 처음 들어갔을 때 기본적으로 전체내용 나오게 조건 설정
			categoryTab = "전체";
			list = aService.selectList(categoryTab, pi); //카테고리 설정 넣어주기
			if(list != null) {
				mv.addObject("list", list)
				  .addObject("pi", pi)
				  .setViewName("askedList");
			} else {
				throw new BoardException("문의사항 전체 조회에 실패하였습니다.");
			}
		}else {
			
			list = aService.selectList(categoryTab, pi); 
			
			if(list != null) {
				mv.addObject("list", list)
				  .addObject("pi", pi)				
				  .addObject("category", categoryTab)
				  .setViewName("askedList");
			}else {
				throw new BoardException("문의사항 전체 조회에 실패하였습니다.");
			}
		}
	 return mv; 
	}
	
		//문의사항 검색
		@RequestMapping("aSearch.ao")
		public ModelAndView AskedSearch(@RequestParam(value="page", required=false) Integer page,
										@RequestParam("searchOption") String searchOption,
										@RequestParam("searchText") String searchText,
										ModelAndView mv) {
			
			//제목, 내용, 제목+내용으로 가져올거기 때문에 		
			SearchCondition sc = new SearchCondition();	
			if(searchOption.equals("tAndC")) {
				sc.settAndC(searchText);
			} else if(searchOption.equals("title")) {
				sc.setTitle(searchText);
			} else if(searchOption.equals("content")){
				sc.setContent(searchText);
			}
			
			int currentPage = 1;
			if(page != null) {
				currentPage = page;
			}

			int listCount = aService.getSearchResultListCount(sc);
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			ArrayList<Question> list = aService.selectSearchAskedList(sc, pi);
			
			if(list != null) {
				mv.addObject("pi", pi);
				mv.addObject("list", list);
				mv.addObject("searchOption", searchOption);
				mv.addObject("searchText", searchText);
				mv.setViewName("askedList");
			} else {
				throw new BoardException("문의사항 검색 조회에 실패하였습니다.");
			}
			return mv;
		}
	 
	
	//문의사항 회원이 글쓰기 누르면 글쓰기 화면으로 이동
	@RequestMapping(value="ainsertView.ao")
	public String AskedInsertView() {
		return "askedInsert";
	}
	
	
	//문의사항 입력후 db등록
	@RequestMapping(value="ainsert.ao") 
	public String askedInsert(@ModelAttribute Question q, HttpSession session,
								@RequestParam("title") String title,
								@RequestParam("content") String content,
								@RequestParam("categoryChk") String categoryChk) {
		
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		String userNickname = ((Member)session.getAttribute("loginUser")).getUserNickName();
		q.setmId(userId);
		q.setmNickname(userNickname);
		q.setbTitle(title);
		q.setbContent(content);
		q.setqCategory(categoryChk);
		
		int result1 = aService.insertBoard(q);
		int result2 = aService.insertAsked(q);
		
		if(result1 > 0 && result2 > 0) {
			return "redirect:alist.ao";
		} else {
			throw new BoardException("게시물 등록에 실패하였습니다.");
		}
	}	
	
	//문의사항 상세보기
	@RequestMapping(value="adetail.ao")
	public ModelAndView askedDetailView(@ModelAttribute Question q,
										@RequestParam("bNo") int bNo,
										@RequestParam(value="page", required=false) String page, 
										ModelAndView mv, HttpSession session) {
	
		
		if(page.equals("")) {
			page = "1";
		}
		
		int page1 = Integer.parseInt(page);
		int currentPage = page1;
		
		int listCount = aService.getListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount); // 페이징
		
		Question question = aService.selectAsked(bNo);
		int result = aService.selectCountReply(bNo);//등록된 답변 수 가져오기
		q.setRecnt(result); //q에 임시저장
		int recnt = q.getRecnt();
		
		System.out.println("recnt : " + recnt);
		
		Member snederUser = alarmService.memberSerachId(question.getmNickname());
		String userId = snederUser.getUserId();

		//이전글 가져오기
		int prevNo = question.getPrevNo();
		String prevTitle = question.getPrevTitle();
		String prevCate = question.getPrevCate();
		String prevNickname = question.getPrevNickname();
		Date prevDate = question.getPrevDate();
		
		//다음글 가져오기
		int nextNo = question.getNextNo();
		String nextTitle = question.getNextTitle();
		String nextCate = question.getNextCate();
		String nextNickname = question.getNextNickname();
		Date nextDate = question.getNextDate();
		
		if(question != null) {
			mv.addObject("question", question);
			mv.addObject("userId", userId);
			mv.addObject("recnt", recnt);
			
			//이전글
			mv.addObject("prevNo", prevNo);
			mv.addObject("prevTitle", prevTitle);
			mv.addObject("prevCate", prevCate);
			mv.addObject("prevNickname", prevNickname);
			mv.addObject("prevDate", prevDate);
			
			//다음글
			mv.addObject("nextNo", nextNo);
			mv.addObject("nextTitle", nextTitle);
			mv.addObject("nextCate", nextCate);
			mv.addObject("nextNickname", nextNickname);
			mv.addObject("nextDate", nextDate);
			
			
			mv.addObject("pi", pi);
			mv.setViewName("askedDetail");
		} 
		return mv;
	}
	
	//문의사항 작성글 수정하기페이지로 이동하기
	@RequestMapping("aupdateView.ao")
	public ModelAndView askedUpdateView(@RequestParam("bNo") int bNo,
										@RequestParam("page") int page, 
										ModelAndView mv) {
		
		Question question = aService.selectAsked(bNo);
		
		mv.addObject("question", question);
		mv.addObject("page", page);
		mv.setViewName("askedUpdate");
		return mv;
	}
	
	//문의사항 수정하기 DB에 수정 값 저장
	@RequestMapping("aupdate.ao")
	public ModelAndView askedUpdate(@ModelAttribute Question q, @RequestParam("page") int page,
									@RequestParam("bNo") int bNo, 
									@RequestParam("title") String title,
									@RequestParam("content") String content,
									@RequestParam("categoryChk") String categoryChk,
									ModelAndView mv){
		
		//vo 에 수정한값 저장해놓기
		q.setbNo(bNo);
		q.setbTitle(title);
		q.setbContent(content);
		q.setqCategory(categoryChk); 
		
		int result1 = aService.updateBoard(q);
		int result2 = aService.updateAsked(q);
		
		if(result1 > 0 && result2 > 0) {
			mv.addObject("page", page);
			mv.setViewName("redirect:adetail.ao?bNo=" + q.getbNo());
		} else {
			throw new BoardException("문의사항 수정에 실패하였습니다.");
		}
	
		return mv;
	}
	
	
	//문의사항 삭제하기
	@RequestMapping("adelete.ao")
	public String askedDelete(@RequestParam("bNo") int bNo) {
		
		int result = aService.deleteBoard(bNo);

		if(result > 0) {
			return  "redirect:alist.ao";
		} else {
			throw new BoardException("게시물 삭제에 실패했습니다.");
		}
	}
	
	
	
	//답변 컨트롤러(댓글)
	//답변 리스트 출력
	@RequestMapping("replyList.ao")
	@ResponseBody
	public void getReplyList(int bNo, HttpServletResponse response) throws JsonIOException, IOException{
			
		ArrayList<Reply> list = aService.selectReplyList(bNo);
		
		response.setContentType("application/json; charset=UTF-8");
		//날짜형식 처리
		GsonBuilder gb = new GsonBuilder();
		//GsonBuilder를 받는 DateFormat
		GsonBuilder df = gb.setDateFormat("yyyy-MM-dd");
		Gson gson = df.create();			
		gson.toJson(list, response.getWriter());
	
	}
	
	
	//답변 작성, 등록
	@RequestMapping("addReply.ao")
	@ResponseBody
	public String addReply(@RequestParam int bNo, @RequestParam String userId,
						   @RequestParam String content, 
						   HttpSession session, HttpServletRequest request) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String rWriter = loginUser.getUserId();
		
		String referer = request.getHeader("Referer");
		
		Reply r = new Reply();
		r.setbNo(bNo);
		r.setcContent(content);
		r.setmId(rWriter);
		int result1 = aService.insertReply(r);
		String host = request.getRequestURL().toString().replace(request.getRequestURI(),"");
		Alarm alram = new Alarm();
		alram.setbNo(bNo);
		alram.setAlarmType("reply");
		alram.setAlarmContent(content);
		alram.setAlarmURL(host+"/spring/memberAskedList.me");
		alram.setAlarmTitle("문의사항 답변이 등록되었습니다.");
		alram.setUserId(userId.trim());
		System.out.println("snederUser : " + userId);
		
		int result2 = alarmService.insertAlarm(alram);
		
		if(result1 > 0 && result2 >0) {
			return "success";
		} else {
			throw new BoardException("답변 등록에 실패하였습니다."); 
		}
		
	}
	
	
	//댓글 수정하기
	@RequestMapping("rupdate.ao")
	@ResponseBody
	public int updateReply(@RequestParam int cNo, 
	    					@RequestParam String cContent) throws Exception{
	        
	        Reply reply = new Reply();
	        reply.setcNo(cNo);
	        reply.setcContent(cContent);
	        
	        return aService.updateReply(reply);
	}
	
	
	
	//댓글 삭제하기
	@RequestMapping("rdelete.ao")
	@ResponseBody
	public int deleteReply(@RequestParam int cNo) {
		Reply reply = new Reply();
        reply.setcNo(cNo);
        
        int bNo = alarmService.cNo2bNo(cNo);
        if(bNo > 0) {
        	int result = alarmService.deleteAlarm(bNo);
        }
        
        return aService.deleteReply(reply);
	}
	
	
	//관리자페이지 문의사항 관리 목록
	 @RequestMapping(value="adminAsked.ao",  method=RequestMethod.GET) 
	 public ModelAndView adminAsked(@RequestParam(value="page", required=false) Integer page, 
			 						@RequestParam(value="categoryTab", required=false) 
	 								String categoryTab, ModelAndView mv) {
		 
	 int currentPage = 1; 
	 	if(page != null) { 
	 		currentPage = page; 
	 	}
	
	 int listCount = aService.getListCount();
	 
	 PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
	
	 ArrayList<Question> list = aService.selectList(categoryTab, pi);
	 
	 if(categoryTab == null) {	
			categoryTab = "전체";
			list = aService.selectList(categoryTab, pi); 
			if(list != null) {
				mv.addObject("list", list)
				  .addObject("pi", pi)
				  .setViewName("adminpage_asked");
			} else {
				throw new BoardException("관리자 문의사항목록 조회에 실패하였습니다.");
			}
		}else {
			
			list = aService.selectList(categoryTab, pi); 
			
			if(list != null) {
				mv.addObject("list", list)
				  .addObject("pi", pi)				
				  .addObject("category", categoryTab)
				  .setViewName("adminpage_asked");
			}else {
				throw new BoardException("관리자 문의사항 전체 조회에 실패하였습니다.");
			}
		}
	 return mv; 
	}
}
