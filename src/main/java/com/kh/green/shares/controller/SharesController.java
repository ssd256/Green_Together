package com.kh.green.shares.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.green.common.BoardException;
import com.kh.green.common.Files;
import com.kh.green.common.MyFileRenamePolicy;
import com.kh.green.common.PageInfo;
import com.kh.green.common.Pagination;
import com.kh.green.member.model.vo.Member;
import com.kh.green.shares.model.exception.SharesException;
import com.kh.green.shares.model.service.SharesService;
import com.kh.green.shares.model.vo.Apply;
import com.kh.green.shares.model.vo.Comments;
import com.kh.green.shares.model.vo.SearchCondition;
import com.kh.green.shares.model.vo.Shares;
import com.kh.green.volunteer.model.vo.Volunteer;
//import com.kh.green.shares.model.vo.SharesSearch;
import com.oreilly.servlet.MultipartRequest;

@Controller
public class SharesController {
	
	@Autowired
	private SharesService sService;
	
	@RequestMapping(value = "slist.sh")
	public ModelAndView sharesList(@RequestParam(value="page", required=false) Integer page, 
									ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}

		int listCount = sService.getListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
//			mv.addObject("pi", pi);
//			mv.setViewName("sharesList");
		
		ArrayList<Shares> sList = sService.selectTList(1, pi);
		ArrayList<Files> fList = sService.selectTList(2, pi);

		String condition="title";
		String value="검색어를 입력하세요.";
		
		if(sList != null && fList != null) {
			mv.addObject("pi", pi);
			mv.addObject("sList", sList);
			mv.addObject("fList", fList);
			mv.addObject("searchOption",condition);
			mv.addObject("searchText",value);
			mv.setViewName("sharesList");
		} else {
			throw new SharesException("물품 나눔 게시판 조회에 실패하였습니다.");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "sInsertForm.sh")
	public String sharesInsertForm() {
		return "sharesInsert";
	}
	
	@RequestMapping(value = "sInsert.sh")
	public String sharesInsert(HttpServletRequest request, @ModelAttribute Files f,
			@RequestParam("thumbnailImg1") MultipartFile t1,
			@RequestParam("thumbnailImg2") MultipartFile t2, 
			@RequestParam("thumbnailImg3") MultipartFile t3, HttpSession session
			) throws IOException { 
		
			Member loginUser = (Member)session.getAttribute("loginUser");
			String sWriter = loginUser.getUserId();
		
			String sCategory = "shares";
			String sTitle = request.getParameter("titleText");
			String sContent = request.getParameter("content");
//			String sWriter = request.getParameter("userId");
			String stock = request.getParameter("stock");
			int sStock = Integer.parseInt(stock);
			String sArea = request.getParameter("area");
			
			Shares s = new Shares();
			s.setbTitle(sTitle);
			s.setbContent(sContent);
			s.setmId(sWriter);
			s.setsStock(sStock);
			s.setsAddress(sArea);
			s.setbCategory(sCategory);
			
			int result1 = sService.insertShares(s);
			int result2 = 0;
			
			int i = 0;
			
			if(t1 != null && !t1.isEmpty()) {
				f.setfOriginName(t1.getOriginalFilename());
				String renameFileName = saveFile(t1, request, i++);
				
				if(renameFileName != null) {
					f.setfChangeName(renameFileName);
				}
				f.setfLevel(0);
				f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\shares_uploadFiles");
				
				result2 = sService.insertFiles(f);
			}
			
			if(t2 != null && !t2.isEmpty()) {
				f.setfOriginName(t2.getOriginalFilename());
				String renameFileName = saveFile(t2, request, i++);
				
				if(renameFileName != null) {
					f.setfChangeName(renameFileName);
				}
				f.setfLevel(1);
				f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\shares_uploadFiles");
				
				result2 = sService.insertFiles(f);
			}
			
			if(t3 != null && !t3.isEmpty()) {
				f.setfOriginName(t3.getOriginalFilename());
				String renameFileName = saveFile(t3, request, i++);
				
				if(renameFileName != null) {
					f.setfChangeName(renameFileName);
				}
				f.setfLevel(2);
				f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\shares_uploadFiles");
				
				result2 = sService.insertFiles(f);
			}
		
		return "redirect:slist.sh";
	}
	
	public String saveFile(MultipartFile file, HttpServletRequest request, int i) {
		String root = request.getSession().getServletContext().getRealPath("resources");	// 파일경로 최상단 설정 --> resources
		String savePath = root + "\\shares_uploadFiles";	// shares 파일 저장 경로(폴더)
		
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
	
//	@RequestMapping(value = "sInsert.sh", method=RequestMethod.POST)
//	public String sharesInsert(HttpServletRequest request) throws IOException { //매개변수 추가
//		
//		
//		if(ServletFileUpload.isMultipartContent(request)) {
//			int maxSize = 1024 * 1024 * 10;
//			String root = request.getSession().getServletContext().getRealPath("resources");
//			String savePath = root + "\\shares_uploadFiles";
//
//			File f = new File(savePath);
//			if(!f.exists()) {
//				f.mkdirs();
//			}
//
//			
// 			MultipartRequest multiRequest
//				= new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
// 			
// 			
// 			ArrayList<String> saveFiles = new ArrayList<String>();		// 바뀐 파일의 이름을 저장할 ArrayList
// 			ArrayList<String> originFiles = new ArrayList<String>();	// 원본 파일의 이름을 저장한 ArrayList
// 			
// 			Enumeration<String> files = multiRequest.getFileNames(); // getFileNames() : 폼에서 전송된 File의 name반환
// 			while(files.hasMoreElements()) {
// 				String name = files.nextElement();
// 				
// 				if(multiRequest.getFilesystemName(name) != null) { // getFilesystemName() : RenamePolicy의 rename()에서 작성한대로 rename된 파일 명 (이름이 바뀐 파일 이름들)
// 					saveFiles.add(multiRequest.getFilesystemName(name));
// 					originFiles.add(multiRequest.getOriginalFileName(name)); //실제 업로드 했을 때 그 이름을 넣어주는 것이다. 
// 				}
// 			}
// 			
// 			System.out.println(multiRequest);
// 			
// 			String sCategory = "shares";
// 			String sTitle = multiRequest.getParameter("titleText");
// 			String sContent = multiRequest.getParameter("content");
// 			String sWriter = multiRequest.getParameter("userId");
// 			String stock = multiRequest.getParameter("stock");
// 			int sStock = Integer.parseInt(stock);
// 			String sArea = multiRequest.getParameter("area");
// 			
// 			Shares s = new Shares();
// 			s.setbTitle(sTitle);
// 			s.setbContent(sContent);
// 			s.setmId(sWriter);
// 			s.setsStock(sStock);
// 			s.setsAddress(sArea);
// 			s.setbCategory(sCategory);
// 			
// 			System.out.println(s);
// 			
// 			
// 			
// 			
// 			
// 			ArrayList<Files> fileList = new ArrayList<Files>();
// 			for(int i = originFiles.size() - 1; i >= 0; i--) {
// 				Files at = new Files();
// 				at.setfPath(savePath);
// 				at.setfOriginName(originFiles.get(i));
// 				at.setfChangeName(saveFiles.get(i));
// 				
// 				if(i == originFiles.size() - 1) {
// 					at.setfLevel(0);
// 				} else {
// 					at.setfLevel(1);
// 				}
// 				
// 				fileList.add(at);
// 			}
// 			
// 			int result = sService.insertThumbnail(s, fileList);
// 			
// 			if(result > 0) {
// 				return "sharesList";
// 			} else {
// 				for(int i = 0; i < saveFiles.size(); i++) {
// 					File failedFile = new File(savePath + saveFiles.get(i));
// 					failedFile.delete();
// 				}
// 				throw new SharesException("물품 나눔 게시판 삽입에 실패하였습니다.");
// 			}
//		} else {
//			System.out.println("실패");
//			
//			return "sharesList";
//		}
////		}
//// 			return "sharesList";
//	}
	
	
	@RequestMapping(value = "sdetail.sh")
	public ModelAndView sharesDetail(@RequestParam("bNo") int bNo, HttpSession session, @RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		Shares shares = sService.selectBoard(bNo);
		ArrayList<Files> files = sService.selectFiles(bNo);
		
		Shares shares2 = sService.selectBoard(bNo);
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String sApplicant = loginUser.getUserId();
		
		shares2.setmId(sApplicant);
		
		Apply apply = sService.selectApply(shares2);
		
		
		mv.addObject(shares)
//		  .addObject("page", page)
		  .addObject("files", files)
		  .addObject("apply", apply)
		  .setViewName("sharesDetail");
		
		return mv;
	}

	
	@RequestMapping("addReply.bo")
	@ResponseBody
	public String addReply(@ModelAttribute Comments r, HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String sWriter = loginUser.getUserId();
		
		r.setmId(sWriter);
		
		int result = sService.insertReply(r);
		
		if(result > 0) {
			return "success";
		} else {
			throw new SharesException("댓글 등록에 실패하였습니다.");
		}
	}
	
	@RequestMapping("cList.sh")
	public void getReplyList(int bNo, HttpServletResponse response) throws JsonIOException, IOException {
		
		ArrayList<Comments> list = sService.selectReplyList(bNo);
		
		response.setContentType("application/json; charset=UTF-8");
		
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder df = gb.setDateFormat("yyyy-MM-dd");
		
		Gson gson = df.create();
		gson.toJson(list, response.getWriter());
	}
	
	@RequestMapping(value = "sUpdateForm.sh")
	public ModelAndView sharesUpView(@RequestParam("bNo") int bNo, @RequestParam(value="page", required=false) Integer page, ModelAndView mv) throws IOException { //매개변수 추가
		Shares shares = sService.selectBoard(bNo);
		ArrayList<Files> files = sService.selectFiles(bNo);
		
		
		mv.addObject("shares", shares)
		  .addObject("page", page)
		  .addObject("files", files)
		  .setViewName("sharesUpdate");
		
		return mv;
	}
	
	@RequestMapping(value = "sUpdate.sh")
	public String sharesUpdate(@RequestParam("bNo") int bNo, HttpServletRequest request, @ModelAttribute Files f,
			@RequestParam("thumbnailImg1") MultipartFile t1,
			@RequestParam("thumbnailImg2") MultipartFile t2, 
			@RequestParam("thumbnailImg3") MultipartFile t3, HttpSession session
			) throws IOException { 
		
		
			Member loginUser = (Member)session.getAttribute("loginUser");
			String sWriter = loginUser.getUserId();
		
			String sCategory = "shares";
			String sTitle = request.getParameter("titleText");
			String sContent = request.getParameter("content");
//			String sWriter = request.getParameter("userId");
			String stock = request.getParameter("stock");
			int sStock = Integer.parseInt(stock);
			String sArea = request.getParameter("area");
			
			Shares s = new Shares();
			s.setbTitle(sTitle);
			s.setbContent(sContent);
			s.setmId(sWriter);
			s.setsStock(sStock);
			s.setsAddress(sArea);
			s.setbCategory(sCategory);
			s.setbNo(bNo);
			
			
			f.setbNo(bNo);
			
			int result1 = sService.updateShares(s);
			int result2 = 0;
			
			int i = 0;
			
			if(t1 != null && !t1.isEmpty()) {
				f.setfOriginName(t1.getOriginalFilename());
				String renameFileName = saveFile(t1, request, i++);
				
				if(renameFileName != null) {
					f.setfChangeName(renameFileName);
				}
				f.setfLevel(0);
				f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\shares_uploadFiles");
				
				result2 = sService.updateFiles(f);
			}
			
			if(t2 != null && !t2.isEmpty()) {
				f.setfOriginName(t2.getOriginalFilename());
				String renameFileName = saveFile(t2, request, i++);
				
				if(renameFileName != null) {
					f.setfChangeName(renameFileName);
				}
				f.setfLevel(1);
				f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\shares_uploadFiles");
				
				result2 = sService.updateFiles(f);
			}
			
			if(t3 != null && !t3.isEmpty()) {
				f.setfOriginName(t3.getOriginalFilename());
				String renameFileName = saveFile(t3, request, i++);
				
				if(renameFileName != null) {
					f.setfChangeName(renameFileName);
				}
				f.setfLevel(2);
				f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\shares_uploadFiles");
				
				result2 = sService.updateFiles(f);
			}
		
		return "redirect:slist.sh";
		
	}
	
	
//	@RequestMapping(value = "sUpdate.sh")
//	public String sharesUpdate(@RequestParam("bNo") int bNo, HttpServletRequest request) throws IOException { //매개변수 추가
//		if(ServletFileUpload.isMultipartContent(request)) {
//			int maxSize = 1024 * 1024 * 10;
//			String root = request.getSession().getServletContext().getRealPath("resources");
//			String savePath = root + "\\shares_uploadFiles";
//
//			File f = new File(savePath);
//			if(!f.exists()) {
//				f.mkdirs();
//			}
//
//			
// 			MultipartRequest multiRequest
//				= new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
// 			
// 			
// 			ArrayList<String> saveFiles = new ArrayList<String>();		// 바뀐 파일의 이름을 저장할 ArrayList
// 			ArrayList<String> originFiles = new ArrayList<String>();	// 원본 파일의 이름을 저장한 ArrayList
// 			
// 			Enumeration<String> files = multiRequest.getFileNames(); // getFileNames() : 폼에서 전송된 File의 name반환
// 			while(files.hasMoreElements()) {
// 				String name = files.nextElement();
// 				
// 				if(multiRequest.getFilesystemName(name) != null) { // getFilesystemName() : RenamePolicy의 rename()에서 작성한대로 rename된 파일 명 (이름이 바뀐 파일 이름들)
// 					saveFiles.add(multiRequest.getFilesystemName(name));
// 					originFiles.add(multiRequest.getOriginalFileName(name)); //실제 업로드 했을 때 그 이름을 넣어주는 것이다. 
// 				}
// 			}
// 			
// 			System.out.println(multiRequest);
// 			
// 			String sCategory = "shares";
// 			String sTitle = multiRequest.getParameter("titleText");
// 			String sContent = multiRequest.getParameter("content");
// 			String sWriter = multiRequest.getParameter("userId");
// 			String stock = multiRequest.getParameter("stock");
// 			int sStock = Integer.parseInt(stock);
// 			String sArea = multiRequest.getParameter("area");
// 			
// 			Shares s = new Shares();
// 			s.setbTitle(sTitle);
// 			s.setbContent(sContent);
// 			s.setmId(sWriter);
// 			s.setsStock(sStock);
// 			s.setsAddress(sArea);
// 			s.setbCategory(sCategory);
// 			
// 			System.out.println(s);
// 			
// 			
// 			
// 			
// 			
// 			ArrayList<Files> fileList = new ArrayList<Files>();
// 			for(int i = originFiles.size() - 1; i >= 0; i--) {
// 				Files at = new Files();
// 				at.setfPath(savePath);
// 				at.setfOriginName(originFiles.get(i));
// 				at.setfChangeName(saveFiles.get(i));
// 				
// 				if(i == originFiles.size() - 1) {
// 					at.setfLevel(0);
// 				} else {
// 					at.setfLevel(1);
// 				}
// 				
// 				fileList.add(at);
// 			}
// 			
// 			int result = sService.updateThumbnail(bNo, s, fileList);
// 			
// 			if(result > 0) {
// 				return "sharesList";
// 			} else {
// 				for(int i = 0; i < saveFiles.size(); i++) {
// 					File failedFile = new File(savePath + saveFiles.get(i));
// 					failedFile.delete();
// 				}
// 				throw new SharesException("물품 나눔 게시판 삽입에 실패하였습니다.");
// 			}
//		} else {
//			System.out.println("실패");
//			
//			return "sharesList";
//		}
//	}
	
	@RequestMapping(value = "sApply.sh")
	public String addApply(@RequestParam("bNo") int bNo, HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String sApplicant = loginUser.getUserId();
		
		System.out.println(sApplicant);
		
		Apply a = new Apply(bNo, sApplicant, "shares");

		int result1 = sService.insertApply(a);
		int result2 = sService.updateApplyShares(bNo);
		
		if(result1 > 0 && result2 > 0) {
			return "redirect:slist.sh";
		} else {
			throw new SharesException("신청하기에 실패하였습니다.");
		}
	}
	@RequestMapping(value = "sApplyDelete.sh")
	public String DeleteApply(@RequestParam("bNo") int bNo, HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String sApplicant = loginUser.getUserId();
		
		Apply a = new Apply(bNo, sApplicant, "shares");
		
		int result1 = sService.deleteApply(a);
		int result2 = sService.updateApplyDeleteShares(bNo);
		
		System.out.println(result1);
		System.out.println(result2);
		
		if(result1 > 0 && result2 > 0) {
			return "redirect:slist.sh";
		} else {
			throw new SharesException("취소하기에 실패하였습니다.");
		}
	}
	
	@RequestMapping(value="sDelete.sh")
	public String sharesDelete(@RequestParam("bNo") int bNo) {
		
		int result = sService.deleteBoard(bNo);
		
		if(result > 0) {
			return "redirect:slist.sh";
		} else {
			throw new BoardException("게시물 삭제에 실패하였습니다.");
		}
	}
	
	@RequestMapping("sSearch.sh")
	public ModelAndView sharesSearch(@RequestParam(value="page", required=false) Integer page, 
			ModelAndView mv, @RequestParam("searchOption") String condition, @RequestParam("searchText") String value) {

		SearchCondition sc = new SearchCondition();
		if(condition.equals("writer")) {
			sc.setWriter(value);
		} else if(condition.equals("title")) {
			sc.setTitle(value);
		} else if(condition.equals("content")){
			sc.setContent(value);
		}
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}

		int listCount = sService.getSearchResultListCount(sc);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
//			mv.addObject("pi", pi);
//			mv.setViewName("sharesList");
		
		ArrayList<Shares> sList = sService.selectSearchTList(sc, pi);
		ArrayList<Files> fList = sService.selectSearchFList(sc, pi);
		
		if(sList != null && fList != null) {
			mv.addObject("pi", pi);
			mv.addObject("sList", sList);
			mv.addObject("fList", fList);
			mv.addObject("searchOption",condition);
			mv.addObject("searchText",value);
			mv.setViewName("sharesList");
		} else {
			throw new SharesException("물품 나눔 게시판 조회에 실패하였습니다.");
		}
		
		
		return mv;
	}
	

	@RequestMapping("sCurrentList.sh")
	public void sharesCurrentList(HttpServletResponse response) throws JsonIOException, IOException {
		ArrayList<Shares> list = sService.sharesCurrentList();
		
		response.setContentType("application/json; charset=UTF-8");
		
		new GsonBuilder().setDateFormat("yyyy-MM-dd").create().toJson(list, response.getWriter());
	}
	
	
	@RequestMapping("commentsDelete.sh")
	@ResponseBody
	public String commentsDelete(@RequestParam("cNo") int cNo, @RequestParam("mId") String mId, HttpSession session) throws JsonIOException, IOException {

		Member loginUser = (Member)session.getAttribute("loginUser");
		String commentsId = loginUser.getUserId();
		
		Comments c = new Comments();
		c.setcNo(cNo);
		c.setmId(mId);
		
		if(mId.equals(commentsId)) {
			int result = sService.commentsDelete(c);
			return "success";
		} else {
			return "";
		}
//		if(result > 0) {
//			return "success";
//		} else {
//			throw new SharesException("댓글 삭제에 실패하였습니다.");
//		}
	}
	
	@RequestMapping("modifyComments.sh")
	@ResponseBody
	public String modifyComments(@RequestParam("cNo") int cNo, @RequestParam("mId") String mId, @RequestParam("cContent") String cContent, HttpSession session) throws JsonIOException, IOException {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String commentsId = loginUser.getUserId();
		
		Comments c = new Comments();
		c.setcNo(cNo);
		c.setcContent(cContent);
		
		if(mId.equals(commentsId)) {
			int result = sService.modifyComments(c);
			return "success";
		} else {
			return "";
		}
//		if(result > 0) {
//			return "success";
//		} else {
//			throw new SharesException("댓글 삭제에 실패하였습니다.");
//		}
	}
	
	
	
	
	
	
//	@RequestMapping(value = "sSearchList.sh")
//	public ModelAndView sharesSearchList(@RequestParam(value="page", required=false) Integer page, 
//			@RequestParam("searchOption") String searchOption, @RequestParam("searchText") String searchText,
//									ModelAndView mv) {
//		
//		int currentPage = 1;
//		if(page != null) {
//			currentPage = page;
//		}
//		
//		SharesSearch ss = new SharesSearch(searchOption, searchText);
//
//		int listCount = sService.getSharesListCount(ss);
//		
//		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
//		
////			mv.addObject("pi", pi);
////			mv.setViewName("sharesList");
//		
//		ArrayList<Shares> sList = sService.selectSTList(1, pi, ss);
//		ArrayList<Files> fList = sService.selectSTList(2, pi, ss);
//		
//		if(sList != null && fList != null) {
//			mv.addObject("pi", pi);
//			mv.addObject("sList", sList);
//			mv.addObject("fList", fList);
//			mv.setViewName("sharesList");
//		} else {
//			throw new SharesException("물품 나눔 게시판 조회에 실패하였습니다.");
//		}
//		
//		return mv;
//	}
}
