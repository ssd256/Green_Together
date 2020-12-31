package com.kh.green.question.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.green.common.BoardException;
import com.kh.green.common.PageInfo;
import com.kh.green.common.Pagination;
import com.kh.green.member.model.vo.Member;
import com.kh.green.question.model.exception.QuestionException;
import com.kh.green.question.model.service.QuestionService;
import com.kh.green.question.model.vo.Question;

@Controller
public class QuestionController {

	@Autowired
	private QuestionService qService;

	// 자주묻는질문 목록 조회
	@RequestMapping(value = "qlist.qo", method = RequestMethod.GET)
	public ModelAndView questionList(@RequestParam(value = "page", required = false) Integer page,
									 @RequestParam(value = "categoryTab", required = false) String categoryTab, 
									 ModelAndView mv) {
		// category == '전체'일때만 페이징 나타나고, 각 카테고리에서는 없음 --> 각 카테고리별로 게시글 10개 안 넘게 할 예정
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}

		int listCount = qService.getListCount(); // 총 게시글 수
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Question> list = null;
		

		if (categoryTab == null || categoryTab.equals("전체")) { // 게시판 처음 들어갔을 때 기본적으로 전체내용 나오게 조건 설정
			categoryTab = "전체";									// categoryTab 눌렀을 때, 누르지 않았을 때 둘 다 적용
			list = qService.selectList(categoryTab, pi);

			if (list != null) {

				mv.addObject("list", list)
				  .addObject("pi", pi)
				  .setViewName("questionList");
			}
			else {
				throw new QuestionException("자주 묻는 질문 전체 조회에 실패하였습니다.");
			}
		} else { // 카테고리 선택하면 해당하는 게시물들 나오게 조건 설정
			list = qService.selectList(categoryTab, pi);
			
			if (list != null) {
				mv.addObject("list", list)
//				  .addObject("pi", pi)
				  .addObject("category", categoryTab)
				  .setViewName("questionList");
			} else {
				throw new QuestionException("자주 묻는 질문 전체 조회에 실패하였습니다.");
			}
		}

		return mv;
	}

	// 입력 폼 매핑
	@RequestMapping(value = "qinsertForm.qo")
	public String questionInsertForm() {
		return "questionInsertForm";
	}

	// 입력 폼에서 값 가져와서 DB등록 후 목록으로 돌아감
	@RequestMapping(value = "qinsert.qo") // @ModelAttribute : 파라미터 값 여러 개 받아올 때
	public String questionInsert(@ModelAttribute Question q, HttpSession session, @RequestParam("title") String title,
			@RequestParam("content") String content, @RequestParam("categoryChk") String categoryChk) {

		String userId = ((Member) session.getAttribute("loginUser")).getUserId();
		q.setmId(userId);
		q.setbTitle(title);
		q.setbContent(content);
		q.setqCategory(categoryChk);

		int result1 = qService.insertBoard(q);
		int result2 = qService.insertQuestion(q);

		if (result1 > 0 && result2 > 0) {
			return "redirect:qlist.qo";
		} else {
			throw new QuestionException("게시물 등록에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "qupdateForm.qo")
	public ModelAndView questionUpdateForm(@RequestParam("bNo") int bNo, ModelAndView mv) {
		Question question = qService.selectQuestion(bNo);

		mv.addObject("question", question)
		  .setViewName("questionUpdateForm");

		return mv;
	}

	@RequestMapping(value = "qupdate.qo")
	public String questionUpdate(@ModelAttribute Question q, Model model, @RequestParam("bNo") int bNo,
			@RequestParam("title") String title, @RequestParam("content") String content) {

		// update 할 값 받아오기
		// 변경된 값, bNo 필요 --> view : questionList
		q.setbNo(bNo);
		q.setbTitle(title);
		q.setbContent(content);

		int result = qService.updateBoard(q);

		if (result > 0) {
			model.addAttribute("q", q);
			return "redirect:qlist.qo";
		} else {
			throw new QuestionException("게시물 수정에 실패하였습니다.");
		}
	}

	@RequestMapping("qdelete.qo")
	public String questionDelete(@RequestParam("bNo") int bNo) {

		int result = qService.deleteBoard(bNo);

		if (result > 0) {
			return "redirect:qlist.qo";
		} else {
			throw new QuestionException("게시물 삭제에 실패하였습니다.");
		}
	}

}
