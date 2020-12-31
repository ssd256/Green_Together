package com.kh.green.board.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.green.board.model.service.BoardService;
import com.kh.green.board.model.vo.Board;
import com.kh.green.board.model.vo.Files;
import com.kh.green.common.BoardException;

@Controller
public class BoardController {

	@Autowired
	private BoardService bService;
	
	@RequestMapping("mainImage.bo")
	public ModelAndView mainImageList(ModelAndView mv) {
		
		int listCount = bService.getImageListCount();
		
		for(int i=1; i <= listCount; i++) {
			Board board = bService.selectImageBoard("메인이미지"+i);
			Files files = bService.selectImageFiles(board.getbNo());
		
			if(board != null) {
				mv.addObject("board"+i, board);
				mv.addObject("files"+i, files);
			}
		}
		mv.addObject("listCount", listCount);
		
		mv.setViewName("member/adminpage_mainImage");
		
		return mv;
	}
	
	@RequestMapping("mainImageUpdate.bo")
	@ResponseBody
	public String boardInsert(@ModelAttribute Board b, @ModelAttribute Files f, HttpServletRequest request,HttpServletResponse response,
							  @RequestParam("uploadFile") MultipartFile uploadFile) {
		response.setContentType("application/json; charset=UTF-8");
//		System.out.println("f : " + f);
//		System.out.println("b : " + b);
//		System.out.println("uploadFile : " + uploadFile);
		int result1 =0;
		int result2 =0;
		String renameFileName=null;
		//새로만들때
		if(b.getbNo()==0) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				//saveFile() : 파일을 저장할 경로 지정
				renameFileName = saveFile(uploadFile, request, f);
					
				if(renameFileName != null) {
					f.setfOriginName(uploadFile.getOriginalFilename());
					f.setfChangeName(renameFileName);
				}
			}
			 result1 = bService.insertBoard(b);
			 result2 = bService.insertFiles(f);
		}else {//파일 수정할때
			//자꾸 이상한 파일을 삭제해서 확실하게 가져오기 위해 추가
			Files files = bService.selectImageFiles(b.getbNo());
			deleteFile(files.getfChangeName(), request);
			renameFileName = saveFile(uploadFile, request, f);
			
			if(renameFileName != null) {
				f.setfOriginName(uploadFile.getOriginalFilename());
				f.setfChangeName(renameFileName);
			}
			
			result1 = bService.updateBoard(b);
			result2 = bService.updateFiles(f);
		}
		
		JSONObject job = new JSONObject();
		
		if(result1 >0 && result2 >0) {
			job.put("imgURL", b.getbContent());
			job.put("mainImg", f.getfChangeName());
//			System.out.println("job.toJSONString() : " + job.toJSONString());
			
			return job.toJSONString();
		}else {
			throw new BoardException("메인 이미지 업데이트 실패!");
		}
			
	}
	
	//파일 저장
	public String saveFile(MultipartFile file, HttpServletRequest request, Files f) {
		String root = request.getSession().getServletContext().getRealPath("resources");
//		System.out.println(root);
		
		String savePath = root + "\\buploadFiles";
		f.setfPath(savePath);
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis()))
								+ "." + originFileName.substring(originFileName.lastIndexOf(".") + 1); 
		
		String renamePath = folder + "\\" + renameFileName;
		
		try {
			file.transferTo(new File(renamePath));
		} catch (Exception e) {
//			System.out.println("파일 전송 에러 : " + e.getMessage());
			e.printStackTrace();
		}
		
		return renameFileName;
	}
	
	//파일 삭제
	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";
		
		File f = new File(savePath + "\\" + fileName);
//		System.out.println("deleteFile : " + f);
		if(f.exists()) {
			f.delete();
		}
	}
	
	@RequestMapping("siteInfo.bo")
	public String siteInfo() {
		return "common/siteInfo";
	}
}
