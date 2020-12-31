package com.kh.green.product.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.kh.green.alarm.model.service.AlarmService;
import com.kh.green.alarm.model.vo.Alarm;
import com.kh.green.board.model.vo.Files;
import com.kh.green.common.PageInfo;
import com.kh.green.common.Pagination;
import com.kh.green.member.model.vo.Member;
import com.kh.green.product.model.exception.ProductException;
import com.kh.green.product.model.service.ProductService;
import com.kh.green.product.model.vo.Cart;
import com.kh.green.product.model.vo.Order;
import com.kh.green.product.model.vo.Product;
import com.kh.green.product.model.vo.Review;
import com.kh.green.product.model.vo.Wish;
import com.kh.green.question.model.exception.QuestionException;

@Controller
public class ProductController {

	@Autowired
	private ProductService pService;
	@Autowired
	private AlarmService alarmService;
	@RequestMapping("plist.po")
	public ModelAndView productList(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv) {
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}

		int listCount = pService.getListCount();// 총 게시글 수

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Product> plist = pService.selectList(1, pi);
		ArrayList<Files> flist = pService.selectList(2, pi);
		
		if (plist != null && flist != null) {
			mv.addObject("plist", plist)
			  .addObject("flist", flist)
			  .addObject("pi", pi)
			  .setViewName("productList");
		} else {
			throw new ProductException("쇼핑몰 전체 조회에 실패하였습니다.");
		}

		return mv;
	}
	
	
	// 쇼핑몰 검색
	@RequestMapping("psearch.po")
	public ModelAndView productSearch(@RequestParam(value="page", required=false) Integer page,
									  @RequestParam("searchOption") String searchOption,
									  @RequestParam("searchText") String searchText,
									  ModelAndView mv) {
		
		Product p = new Product();
		p.setpCategory(searchOption);
		p.setpName(searchText);
		
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}

		int listCount = pService.getListSearchCount(p);// 총 게시글 수

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Product> plist = pService.selectSearchPList(p, pi);
		ArrayList<Files> flist = pService.selectSearchFList(p, pi);

		if (plist != null && flist != null) {
			mv.addObject("plist", plist)
			   .addObject("flist", flist)
			   .addObject("pi", pi)
			   .addObject("searchOption", searchOption)
			   .addObject("searchText", searchText)
			   .setViewName("productList");
		} else {
			throw new ProductException("상품 검색에 실패하였습니다.");
		}
		
		return mv;
	}
	
	
	// 쇼핑몰 최신순, 판매순, 낮은가격순, 높은 가격순 조건 검색
	@RequestMapping("poption.po")
	public ModelAndView productOption(@RequestParam(value="page", required=false) Integer page,
									  @RequestParam("option") String option,
									  ModelAndView mv) {

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}

		int listCount = pService.getListOptionCount(option);// 총 게시글 수

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Product> plist = pService.selectOptionPList(option, pi);
		ArrayList<Files> flist = pService.selectOptionFList(option, pi);

		if (plist != null && flist != null) {
			mv.addObject("plist", plist)
			   .addObject("flist", flist)
			   .addObject("pi", pi)
			   .setViewName("productList");
		} else {
			throw new ProductException("상품 검색에 실패하였습니다.");
		}
		
		return mv;
	}
	

	@RequestMapping("pdetail.po")
	public ModelAndView productDetail(@RequestParam("bNo") int bNo, 
									  @RequestParam("pNo") String pNo,
									  HttpSession session, ModelAndView mv) {
		
		Product product = pService.selectProduct(bNo);
		ArrayList<Files> flist = pService.selectFiles(bNo);
		
		ArrayList<Review> rlist = pService.selectReview(pNo);
		ArrayList<Files> flistR = pService.selectFReview(pNo);
		System.out.println("flistR : " + flistR);
		
		if ((product != null && flist != null) && rlist != null) {
				if(!flistR.isEmpty()) {
					mv.addObject("product", product)
					.addObject("flist", flist)
					.addObject("rlist", rlist)
					.addObject("flistR", flistR)
					.setViewName("productDetail");
				} else {
					flistR = null;
					mv.addObject("product", product)
					.addObject("flist", flist)
					.addObject("rlist", rlist)
					.addObject("flistR", flistR)
					.setViewName("productDetail");
				}
		} else {
			throw new ProductException("상품 상세보기에 실패하였습니다");
		}

		return mv;
	}

	
	@RequestMapping(value = "pinsertForm.po")
	public String productInsertForm() {
		return "productInsertForm";
	}

	
	@RequestMapping(value = "pinsert.po")
	public String productInsert(@ModelAttribute Product p, @ModelAttribute Files f,
			@RequestParam("uploadFile") MultipartFile[] uploadFile, @RequestParam("pCategory") String pCategory,
			HttpSession session, HttpServletRequest request) throws Exception {

		p.setmId(((Member) session.getAttribute("loginUser")).getUserId());
		p.setpCategory(pCategory);

		int result1 = pService.insertProduct(p);
		int result2 = 0;
		int i = 0; // 이름 변경
		int a = 0; // 파일 레벨 변경
		if (uploadFile != null)
			for (MultipartFile mf : uploadFile) {
				f.setfOriginName(mf.getOriginalFilename()); // 원본 파일 명

				String renameFileName = saveFile(mf, request, i);
				i++;
				a++;

				if (renameFileName != null) {
					f.setfChangeName(renameFileName);
				}

				if (a == 1) {
					f.setfLevel(0);
				} else if (i == 4) {
					f.setfLevel(2);
				} else {
					f.setfLevel(1);
				}

				f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\product_uploadFiles");

				result2 = pService.insertFiles(f);
			}

		if (result1 > 0 && result2 > 0) {
			return "redirect:plist.po";
		} else {
			throw new ProductException("상품 등록에 실패하였습니다.");
		}
	}

	
	public String saveFile(MultipartFile file, HttpServletRequest request, int i) {
		String root = request.getSession().getServletContext().getRealPath("resources"); // 파일경로 최상단 설정 --> resources
		String savePath = root + "\\product_uploadFiles"; // product 파일 저장 경로(폴더)

		File folder = new File(savePath);
		if (!folder.exists()) { // 파일 저장폴더 없으면 만들고 시작
			folder.mkdir();
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); // changefileName에 들어갈 날짜 형식 바꿔줌
		String fileOriginName = file.getOriginalFilename();
		String fileChangeName = sdf.format(new Date(System.currentTimeMillis())) + i + "."
				+ fileOriginName.substring(fileOriginName.lastIndexOf(".") + 1);

		String changePath = folder + "\\" + fileChangeName;

		try {
			file.transferTo(new File(changePath));
		} catch (Exception e) {
			System.out.print("파일 전송 에러 : " + e.getMessage());
			e.printStackTrace();
		}

		return fileChangeName;
	}

	
	@RequestMapping(value = "pupdateForm.po")
	public ModelAndView productUpdateForm(@RequestParam("bNo") int bNo, 
										  @RequestParam(value="page", required=false) Integer page,	
										  ModelAndView mv) {

		Product product = pService.selectProduct(bNo);
		ArrayList<Files> flist = pService.selectFiles(bNo);

		mv.addObject("product", product)
		  .addObject("flist", flist)
		  .addObject("page", page)
		  .setViewName("productUpdateForm");

		return mv;
	}
	
	
	@RequestMapping(value="pupdate.po")
	public String productUpdate(@ModelAttribute Product p, 
								@ModelAttribute Files f, 
								@RequestParam("bNo") int bNo,
								@RequestParam("thumbnailImg1") MultipartFile t1,
								@RequestParam("thumbnailImg2") MultipartFile t2, 
								@RequestParam("thumbnailImg3") MultipartFile t3,
								@RequestParam("thumbnailImg4") MultipartFile t4,
							    HttpServletRequest request) {

		int result1 = pService.updateBoard(p);
		int result2 = pService.updateProduct(p);
		int result3 = 0;
		int i = 0; // 이름 변경

		f.setbNo(bNo);
		
		if (t1 != null && !t1.isEmpty()) {
			f.setfOriginName(t1.getOriginalFilename()); // 원본 파일 명
			String renameFileName = saveFile(t1, request, i++);
			
			if (renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			
			f.setfLevel(0);
		
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\product_uploadFiles");
			result3 = pService.updateFiles(f);
		}
		
		if (t2 != null && !t2.isEmpty()) {
			f.setfOriginName(t2.getOriginalFilename()); // 원본 파일 명
			String renameFileName = saveFile(t2, request, i++);
			
			if (renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			
			f.setfLevel(1);
		
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\product_uploadFiles");
			result3 = pService.updateFiles(f);
		}
		
		if (t3 != null && !t3.isEmpty()) {
			f.setfOriginName(t3.getOriginalFilename()); // 원본 파일 명
			String renameFileName = saveFile(t3, request, i++);
			
			if (renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			
			f.setfLevel(1);
		
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\product_uploadFiles");
			result3 = pService.updateFiles(f);
		}
		
		if (t4 != null && !t4.isEmpty()) {
			f.setfOriginName(t4.getOriginalFilename()); // 원본 파일 명
			String renameFileName = saveFile(t4, request, i++);
			
			if (renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			
			f.setfLevel(2);
		
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\product_uploadFiles");
			result3 = pService.updateFiles(f);
		}

		return "redirect:plist.po";
	}
	
	

	@RequestMapping(value = "pdelete.po")
	public String productDelete(@RequestParam("bNo") int bNo) {

		int result1 = pService.deleteProduct(bNo);
		int result2 = pService.deleteFiles(bNo);

		if (result1 > 0 && result2 > 0) {
			return "redirect:plist.po";
		} else {
			throw new QuestionException("상품 삭제에 실패하였습니다.");
		}
	}

	
	// 마이페이지 - 물품구매정보페이지 넘어가기
	@RequestMapping("memberOrderDetail.me") 
	public ModelAndView memberOrderDetail(@RequestParam(value = "page", required = false) Integer page,
										  HttpSession session, ModelAndView mv) {
		
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		
		int listCount = pService.getListCount();// 총 게시글 수

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		String mId = ((Member) session.getAttribute("loginUser")).getUserId();
		ArrayList<Order> olist = pService.selectOrder(mId, pi);
		System.out.println("olist : " + olist);
		
		if (olist != null) {
			mv.addObject("mId", mId)
			  .addObject("olist", olist)
			  .addObject("pi", pi)
			  .setViewName("myPage_memberOrderDetail");
		} else {
			throw new ProductException("구매 물품 조회에 실패하였습니다.");
		}

		return mv;
	}

	
	// 상품 상세조회에서 장바구니에 추가하는 매핑
	@ResponseBody
	@RequestMapping(value = "cartInsert.po")
	public void cartInsert(@RequestParam("bNo") int bNo,
						   @RequestParam("pNo") int pNo,
						   @RequestParam("cCount") int cCount,
						   @RequestParam("cPrice") int cPrice,
						   @RequestParam("fName") String fName,
						   @RequestParam("pName") String pName,
						   HttpServletResponse response, 
						   HttpSession session) throws IOException {

		response.setContentType("application/json; charset=UTF-8");

		Cart cart = new Cart();
		String mId = ((Member) session.getAttribute("loginUser")).getUserId();
		
		response.setContentType("application/json; charset=UTF-8");

		JSONObject job = new JSONObject();
		job.put("mId", mId);
		
		cart.setmId(mId);
		cart.setpNo(pNo);

		int totalCount = pService.getCountCartTotal(mId);
		int pNoCount = pService.getCountCart(cart);

		if (totalCount == 0 || (totalCount < 5 && pNoCount == 0)) {
			Cart c = new Cart(pNo, bNo, mId, cCount, cPrice * cCount, fName, pName);

			int result = pService.insertCart(c);

			PrintWriter out = response.getWriter();
			if (result > 0) {
				out.print(job);
			} else {
				out.append("fail");
			}
			out.flush();
			out.close();

		} else if (pNoCount == 1) {
			Cart c = new Cart();
			c.setpNo(pNo);
			c.setmId(mId);
			c.setcCount(cCount);
			c.setcPrice(cPrice * cCount);

			int result = pService.updateCart(c);

			PrintWriter out = response.getWriter();
			if (result > 0) {
				out.print(job);
			} else {
				out.append("fail");
			}
			out.flush();
			out.close();

		} else {
			PrintWriter out = response.getWriter();
			out.print("over");
			out.flush();
			out.close();
		}
	}
	
	
	// 찜하기에서 장바구니에 추가하는 매핑
	@ResponseBody
	@RequestMapping(value = "cartWishInsert.po")
	public void cartWishInsert(@RequestParam("bNo") int bNo,
							   @RequestParam("pNo") int pNo,
							   @RequestParam("cCount") int cCount,
							   @RequestParam("cPrice") int cPrice,
							   @RequestParam("fName") String fName,
							   @RequestParam("pName") String pName,
							   HttpServletResponse response, 
							   HttpSession session) throws IOException {

		response.setContentType("application/json; charset=UTF-8");

		Cart cart = new Cart();
		String mId = ((Member) session.getAttribute("loginUser")).getUserId();
		
		response.setContentType("application/json; charset=UTF-8");

		JSONObject job = new JSONObject();
		job.put("mId", mId);
		
		cart.setmId(mId);
		cart.setpNo(pNo);

		int totalCount = pService.getCountCartTotal(mId);
		int pNoCount = pService.getCountCart(cart);

		if (totalCount == 0 || (totalCount < 5 && pNoCount == 0)) {
			Cart c = new Cart(pNo, bNo, mId, 1, cPrice * 1, fName, pName);

			int result = pService.insertCart(c);

			PrintWriter out = response.getWriter();
			if (result > 0) {
				out.print(job);
			} else {
				out.append("fail");
			}
			out.flush();
			out.close();

		} else if (pNoCount == 1) {
			PrintWriter out = response.getWriter();
			out.print("fail");
			out.flush();
			out.close();

		} else {
			PrintWriter out = response.getWriter();
			out.print("over");
			out.flush();
			out.close();
		}
	}


	
	// 장바구니 페이지로 넘어가는 매핑
	@RequestMapping(value = "cartList.po")
	public ModelAndView cartList(ModelAndView mv, HttpSession session) {

		String mId = ((Member) session.getAttribute("loginUser")).getUserId();
		ArrayList<Cart> clist = pService.selectCart(mId);
		ArrayList<Product> pCount = pService.selectPCount();
		
		if (clist != null) {
			mv.addObject("mId", mId)
			  .addObject("clist", clist)
			  .addObject("pCount", pCount)
			  .setViewName("cartList");
		} else {
			throw new ProductException("장바구니 조회에 실패하였습니다.");
		}

		return mv;
	}

	
	// 장바구니 삭제하는 매핑
	@RequestMapping(value = "cartDelete.po")
	public String cartDelete(@RequestParam("cNo") int cNo, HttpSession session) {

		Cart c = new Cart();

		String mId = ((Member) session.getAttribute("loginUser")).getUserId();
		
		c.setcNo(cNo);
		c.setmId(mId);
		int result = pService.deleteCart(c);

		if (result > 0) {
			return "redirect:cartList.po";
		} else {
			throw new ProductException("장바구니 상품 삭제에 실패하였습니다.");
		}
	}

	
	// 찜하기 추가하는 매핑
	@RequestMapping(value = "wishInsert.po")
	public void wishInsert(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {

		String mId = ((Member) session.getAttribute("loginUser")).getUserId();
		int bNo = Integer.parseInt(request.getParameter("bNo"));
		int pNo = Integer.parseInt(request.getParameter("pNo"));
		int cCount = Integer.parseInt(request.getParameter("cCount"));
		int cPrice = Integer.parseInt(request.getParameter("cPrice"));
		String fName = request.getParameter("fName");
		String pName = request.getParameter("pName");

		response.setContentType("application/json; charset=UTF-8");

		JSONObject job = new JSONObject();
		job.put("mId", mId);

		Wish wish = new Wish();
		wish.setmId(mId);
		wish.setpNo(pNo);

		int totalCount = pService.getCountWishTotal(mId);
		int pNoCount = pService.getCountWish(wish);

		if (totalCount == 0 || (totalCount < 5 && pNoCount == 0)) {
			Wish w = new Wish(pNo, bNo, mId, cCount, cPrice * cCount, fName, pName);

			int result = pService.insertWish(w);

			PrintWriter out = response.getWriter();
			if (result > 0) {
				out.print(job);
			} else {
				out.append("fail");
			}
			out.flush();
			out.close();

		} else if (pNoCount == 1) {
			Wish w = new Wish();
			w.setpNo(pNo);
			w.setmId(mId);
			w.setcCount(cCount);
			w.setcPrice(cPrice * cCount);

			int result = pService.updateWish(w);

			PrintWriter out = response.getWriter();
			if (result > 0) {
				out.print(job);
			} else {
				out.append("fail");
			}
			out.flush();
			out.close();

		} else {
			PrintWriter out = response.getWriter();
			out.print("over");
			out.flush();
			out.close();
		}
	}

	
	// 찜하기 페이지로 넘어가는 매핑
	@RequestMapping(value = "wishList.po")
	public ModelAndView wishList(ModelAndView mv, HttpSession session) {

		String mId = ((Member) session.getAttribute("loginUser")).getUserId();
		ArrayList<Wish> wlist = pService.selectWish(mId);

		if (wlist != null) {
			mv.addObject("mId", mId).addObject("wlist", wlist).setViewName("wishList");
		} else {
			throw new ProductException("찜하기 목록 조회에 실패하였습니다.");
		}

		return mv;
	}

	
	// 찜하기 삭제하는 매핑
	@RequestMapping(value = "wishDelete.po")
	public String wishDelete(@RequestParam("pNo") int pNo, HttpSession session) {

		// 찜하기는 하나씩만 삭제 가능
		Wish w = new Wish();

		w.setpNo(pNo);
		w.setmId(((Member) session.getAttribute("loginUser")).getUserId());
		int result = pService.deleteWish(w);

		if (result > 0) {
			return "redirect:wishList.po";
		} else {
			throw new ProductException("찜하기 상품 삭제에 실패하였습니다.");
		}
	}

	
	// 후기 등록여부 확인
	@RequestMapping("reviewchk.po")
	public void reviewCheck(@RequestParam("oId") int oId, HttpSession session,
							HttpServletResponse response) throws IOException {
		
		int result = pService.getCountReview(oId);
		
		PrintWriter out = response.getWriter();
		out.println(result);
		out.flush();
		out.close();
	}
	
	
	// 후기작성폼으로 이동
	@RequestMapping(value="reviewInsertForm.me")
	public ModelAndView reviewInsertForm(Order order,
										 @RequestParam("oId") int oId,
									     HttpSession session,
									     ModelAndView mv) {
		
		String mId = ((Member) session.getAttribute("loginUser")).getUserId();
		order.setoId(oId);
		order.setOrderId(mId);
		Order o = pService.selectOrder(order);	// 후기 작성할 상품 있는지 검색
		
		if(o != null) {
			mv.addObject("order", o)
			  .setViewName("myPage_review");
		} else {
			throw new ProductException("후기를 작성할 상품이 없습니다.");
		}
		
		return mv;
	}

	
	//후기 등록
	@RequestMapping(value="reviewInsert.po")
	public String reviewInsert(@ModelAttribute Review r, 
							   @ModelAttribute Files f,
							   @RequestParam("oNo") String oNo,
							   @RequestParam("oId") int oId,
							   @RequestParam("pNo") int pNo,
							   @RequestParam("starCount") int starCount,
							   @RequestParam("content") String content,
							   @RequestParam("uploadFile") MultipartFile uploadFile,
							   HttpSession session,
							   HttpServletRequest request,
							   HttpServletResponse response) {
		
		String mId = ((Member)session.getAttribute("loginUser")).getUserId();
		r.setmId(mId);
		r.setpNo(pNo);
		r.setoId(oId);
		r.setoNo(oNo);
		r.setrContent(content);
		r.setrStar(starCount);

		int result1 = pService.insertReview(r);
		int result2 = 0;
		
		int i = 1;	// 이름 변경
		int a = 1;	// 파일 레벨 변경
		
		if(!uploadFile.isEmpty()) {
			f.setfOriginName(uploadFile.getOriginalFilename());
			
			String renameFileName = saveFile(uploadFile, request, i); 
			
			if(renameFileName != null) {
				f.setfChangeName(renameFileName);
			}
			
			f.setfLevel(a);
			f.setfPath(request.getSession().getServletContext().getRealPath("resources") + "\\product_uploadFiles");
			
			result2 = pService.insertFiles(f);
			
			if(result1 > 0 && result2 > 0) {
				return "redirect:memberOrderDetail.me?oId=" + oId;
			} else { 
				throw new ProductException("후기 등록에 실패하였습니다.");
			}
		} else {
				if(result1 > 0) {
					return "redirect:memberOrderDetail.me?oId=" + oId;
				} else { 
					throw new ProductException("후기 등록에 실패하였습니다.");
			}
		}
	}
	
	
	// 파일있는 후기 삭제
	@RequestMapping(value = "reviewFileDel.po")
	public String reviewFilDelete(@RequestParam("bNo") int bNo,
							      @RequestParam("rNo") int rNo) {

		System.out.println("bNo : " + bNo);
		System.out.println("rNo : " + rNo);
		
		int result1 = pService.deleteRBoard(bNo);
		int result2 = pService.deleteReview(rNo);
		int result3 = pService.deleteRFiles(bNo);

		if((result1 > 0 && result2 > 0) && result3 > 0) {
			return "redirect:plist.po";
		} else {
			throw new QuestionException("상품 삭제에 실패하였습니다.");
		}
	}
	
	
	// 파일없는 후기 삭제
	@RequestMapping(value = "reviewDel.po")
	public String reviewDelete(@RequestParam("bNo") int bNo,
							   @RequestParam("rNo") int rNo) {

		System.out.println("bNo : " + bNo);
		System.out.println("rNo : " + rNo);
		
		int result1 = pService.deleteRBoard(bNo);
		int result2 = pService.deleteReview(rNo);

		if(result1 > 0 && result2 > 0) {
			return "redirect:plist.po";
		} else {
			throw new QuestionException("상품 삭제에 실패하였습니다.");
		}
	}
	
	
	// 주문 상세 조회 팝업창
	@RequestMapping("orderInfoView.me")
	public ModelAndView orderInfoView(Order order,
									  @RequestParam("oId") int oId,
									  HttpSession session,
									  ModelAndView mv) {
		
		String mId = ((Member) session.getAttribute("loginUser")).getUserId();
		order.setOrderId(mId);
		order.setoId(oId);
		Order o = pService.selectOrder(order);
		
		System.out.println("o : " + o);
		
		if(o != null) {
			mv.addObject("order", o)
			  .setViewName("myPage_orderInfo");
		} else {
			throw new ProductException("배송중인 상품이 없습니다.");
		}
		
		return mv;
	}
	
	
	// 관리자 페이지 매핑
	// 관리자 - 판매 물품 관리[관리자페이지 메인]
	@RequestMapping(value="adminPage.me")
	public ModelAndView adminProductView(@RequestParam(value = "page", required = false) Integer page,
										 @RequestParam(value = "sendId", required = false) String sendId,
										 @RequestParam(value = "delivery", required = false) String delivery,
										 @RequestParam(value = "bNo", required = false) Integer bNo,
										 ModelAndView mv) {
		
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		
		int listCount = pService.getListCount();// 총 게시글 수

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Order> olist = pService.selectOrderAD(pi);
		System.out.println("olist : " + olist);
		
		if(olist != null) {
			mv.addObject("olist", olist)
			  .addObject("pi", pi);
			  if(delivery != null) {
				  mv.addObject("delivery", delivery)
				    .addObject("sendId", sendId)
				    .addObject("bNo", bNo);
			  }
			  mv.setViewName("adminpage_main");
		}
		
		return mv;
	}
	
	
	
	// 주문 상태 변경 매핑
	@RequestMapping(value="adorderChange.me")
	public String orderChange(@RequestParam("oNo") String oNo,
							  @RequestParam("order") String order){
		
		Order o = new Order();
		
		o.setoNo(oNo);
		o.setOrderState(order);
		
		int result = pService.updateOrderStatus(o);
		
		if(result > 0) {
			return "redirect:adminPage.me";
		} else {
			throw new ProductException("주문 상태 변경에 실패하였습니다.");
		}
	}
	
	
	// 배송 상태 변경 매핑
	@RequestMapping(value="addeliveryChange.me")
	public String deliveryChange(@RequestParam("oNo") String oNo,@RequestParam("oId") int oId,
								 HttpServletRequest request,
								 RedirectAttributes redirect,
			  					 @RequestParam("delivery") String delivery) {
		
		Order o = new Order();
				
		o.setoNo(oNo);
		o.setOrderDelivery(delivery);
		
		int result = pService.updateDeliveryStatus(o);
		
		if(result > 0) {
			String strDelivery = o.getOrderDelivery();
			if(strDelivery.equals("배송완료")) {
				int bNo = pService.oId2bNo(oId);
				String sendId = pService.oId2userID(oId);
				Alarm alram = new Alarm();
				String host = request.getRequestURL().toString().replace(request.getRequestURI(),"");
				alram.setbNo(bNo);
				alram.setAlarmType("delivery");
				alram.setAlarmContent("배송완료");
				alram.setAlarmURL(host+"/spring/memberOrderDetail.me");
				alram.setAlarmTitle("배송 완료된 상품이 있습니다.");
				alram.setUserId(sendId);
				int result1 = alarmService.insertAlarm(alram);
				if(result1 > 0) {
					redirect.addAttribute("bNo", bNo); 
					redirect.addAttribute("sendId", sendId);
					redirect.addAttribute("delivery", "delivery");
					return "redirect:adminPage.me";
				}else {
					throw new ProductException("배송 상태 변경에 실패하였습니다.");
				}
			}
			
			return "redirect:adminPage.me";
		} else {
			throw new ProductException("배송 상태 변경에 실패하였습니다.");
		}
	}
	
	
	// 주문취소 매핑
	@RequestMapping(value="ordercancel.po")
	public void orderCancel(@RequestParam("oNo") String oNo,
							@RequestParam("pNo") int pNo,
							@RequestParam("oId") int oId,
							@RequestParam("orderCount") int orderCount,
							HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		int result1 = pService.deleteOrder(oNo);
		int pCount = pService.selectProductCount(pNo);
		
		Order o = new Order();
	    o.setOrderCount(orderCount);
	    o.setpNo(pNo);
	    o.setpCount(pCount);
	   
		int result2 = pService.updateProductCountBack(o);
		
		PrintWriter out = response.getWriter();
		if(result1 > 0 && result2 > 0) {
			out.print(result1);
			out.flush();
			out.close();
		}
		
		int bNo = pService.oId2bNo(oId);
		
		Alarm alram = new Alarm();
		String host = request.getRequestURL().toString().replace(request.getRequestURI(),"");
		alram.setbNo(bNo);
		alram.setAlarmType("ordercancel");
		alram.setAlarmContent("주문이 취소되었습니다.");
		alram.setAlarmURL(host+"/spring/adminPage.me");
		alram.setAlarmTitle("주문 취소 요청이 있습니다.");
		alram.setUserId("admin");
		
		int result3 = alarmService.insertAlarm(alram);
		if(result3 >  0) {
			System.out.println("알람요청 실패");
		}
	}	
	
	
	// 바로구매 주문정보 이동[한 개 구매]
	@RequestMapping(value="orderForm.po")
	public ModelAndView productOrderForm(@ModelAttribute Order order,
									     @RequestParam("pName") String pName,
									     @RequestParam("pNo") int pNo, 
									     @RequestParam("bNo") int bNo,
									     HttpSession session, 
									     ModelAndView mv) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		order.setOrderId(loginUser.getUserId());
		order.setpNo(pNo);
		
		mv.addObject("order", order)
		  .addObject("pName", pName)
		  .addObject("pNo", pNo)
		  .addObject("bNo", bNo)
		  .setViewName("productOrder");
		
		return mv;
	}
	
	
   // 바로구매 주문 매핑[한 개 구매]
   @RequestMapping(value="orderInsert.po")
   public void productOrderInsert(
		   @RequestParam("orderArray[]") List<String> orderArray,
		   							@RequestParam("imp_uid") String imp_uid,
		   							Order order,
		   							HttpServletResponse response) throws IOException {
	   
	   
      Calendar cal = Calendar.getInstance();
      int year = cal.get(Calendar.YEAR);
      String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
      String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
      String subNum = "";
      
      for(int i = 1; i <= 6; i++) {
         subNum += (int)(Math.random() * 10);
      }
            
      String orderNo = ymd + "-" + subNum;

      System.out.println("orderArray.get(6) : " + orderArray.get(6));
      System.out.println("Integer.parseInt(orderArray.get(6)) * Integer.parseInt(orderArray.get(2)) + 2500 : " + Integer.parseInt(orderArray.get(6)) * Integer.parseInt(orderArray.get(2)) + 2500);
      
      
      order.setoNo(orderNo);
      order.setOrderId(orderArray.get(0));
      order.setpNo(Integer.parseInt(orderArray.get(1)));
      order.setOrderCount(Integer.parseInt(orderArray.get(2)));
      order.setRecipient(orderArray.get(3));
      order.setReciPhone(orderArray.get(4));
      order.setOrderAddr(orderArray.get(5));
      order.setOrderPay(Integer.parseInt(orderArray.get(6)));
      order.setOrderWay(orderArray.get(7));
      order.setOrderMsg(orderArray.get(8));
      order.setImp_uid(imp_uid);
      
      int result1 = pService.insertOrder(order);
      
      if(result1 > 0) {
         PrintWriter out = response.getWriter();
         out.print(result1);
         out.flush();
         out.close();
      } else { 
         throw new ProductException("상품 주문에 실패하였습니다.");
      }
      
   }
	
   
   // 장바구니 - 구매 주문정보 이동[여러 개 구매]
   @RequestMapping("cartOrderForm.po")
   public ModelAndView productCartOrderForm(@RequestParam("bItem") int[] bItem,
		   									@RequestParam("cItem") int[] cItem,
		   									@RequestParam("pItem") int[] pItem,
		   									Cart cart,
									        @RequestParam("cPrice") int cPrice, 
									        HttpSession session,
									        HttpServletResponse response,
									        ModelAndView mv) {
	   
	   List<Cart> cartList = new ArrayList<Cart>();
	   Member loginUser = (Member)session.getAttribute("loginUser");
	   
	   
	   for(int i = 0; i < bItem.length; i++) {
		   cart.setmId(loginUser.getUserId());
		   cart.setbNo(bItem[i]);
		   cart.setcNo(cItem[i]);
		   System.out.println("cartList.mId : " + cart.getmId());
		   System.out.println("cartList.bNo : " + cart.getbNo());
		   System.out.println("cartList.cNo : " + cart.getcNo());
		   cartList.add(i, pService.selectProducts(cart));
	   }
	   
	   System.out.println("cartList : " + cartList);
	   
	   mv.addObject("cList", cartList)
	     .addObject("cPrice", cPrice)
	   	 .addObject("loginUser", loginUser)
	   	 .addObject("pItem", pItem)
	   	 .setViewName("productCartOrder");
	   
	   return mv; 
   }
   
   
   // 장바구니 - 주문 매핑[여러 개 구매]
   @ResponseBody
   @RequestMapping("cartOrderInsert.po")
   public void productCartOrderInsert(@RequestParam("imp_uid") String imp_uid,
		   							  @RequestParam("cItem") int[] cItem,
		   							  @RequestParam("recipient") String recipient,
		   							  @RequestParam("orderAddr") String orderAddr,
		   							  @RequestParam("reciPhone") String reciPhone,
		   							  @RequestParam(value="orderMsg", required=false) String orderMsg,
		   							  Order order,
		   							  HttpSession session,
			   						  HttpServletResponse response) throws IOException {
	   
	      Calendar cal = Calendar.getInstance();
	      int year = cal.get(Calendar.YEAR);
	      String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
	      String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
	      String subNum = "";
	      
	      for(int i = 1; i <= 6; i++) {
	         subNum += (int)(Math.random() * 10);
	      }
	            
	      String orderNo = ymd + "-" + subNum;
	   
	      String mId = ((Member)session.getAttribute("loginUser")).getUserId();
	      
	      int result1 = 0;
	      int result2 = 0;
	      Cart orderCart = new Cart();
	      ArrayList<Cart> cart = new ArrayList<Cart>();
	      
	      if(cItem.length == 1) {
	    	  orderCart.setmId(mId);
	    	  orderCart.setcNo(cItem[0]);
	    	  cart = pService.selectCartOrder(orderCart);
	    	  
	    	  if(cart != null) {
			      order.setoNo(orderNo);
			      order.setOrderId(mId);
			      for(Cart c : cart) {
			    	  order.setpNo(c.getpNo());
			    	  order.setOrderCount(c.getcCount());
			    	  order.setOrderPay(c.getcPrice() + 2500);
			      }
		    	  order.setcNo(cItem[0]);
		    	  
		    	  order.setRecipient(recipient);
		    	  order.setReciPhone(reciPhone);
		    	  order.setOrderAddr(orderAddr);
		    	  order.setOrderWay("결제");
		    	  order.setOrderMsg(orderMsg);
		    	  
		    	  result1 = pService.insertOrder(order);
		    	  result2 = pService.deleteCart(orderCart);
	    	  }
	    	  
	      } else {
	    	  for(int i : cItem) {
	    		  orderCart.setmId(mId);
	    		  orderCart.setcNo(i);
	    		  cart = pService.selectCartOrder(orderCart);
	    		  
	    		  if(cart != null) {
	    			  order.setoNo(orderNo);
	    			  order.setOrderId(mId);
	    			  for(Cart c : cart) {
	    				  order.setpNo(c.getpNo());
	    				  order.setOrderCount(c.getcCount());
	    				  order.setOrderPay(c.getcPrice() + 2500);
	    			  }
	    			  order.setcNo(i);
	    			  order.setRecipient(recipient);
	    			  order.setReciPhone(reciPhone);
	    			  order.setOrderAddr(orderAddr);
	    			  order.setOrderWay("결제");
	    			  order.setOrderMsg(orderMsg);
	    			  
	    			  result1 = pService.insertOrder(order);
	    			  result2 = pService.deleteCart(orderCart);
	    		  }
	    	  }
	      }
	      
	      if(result1 > 0) {
	    	PrintWriter out = response.getWriter();
	    	out.print(result1);
	    	out.flush();
	    	out.close();
	      }
   }
   
   
   // 배송완료 시 구매확정
   @RequestMapping(value="ordersuccess_a.po")
   public void orderSuccess_A(@RequestParam("oNo") String oNo,
		   					@RequestParam("pNo") int pNo,
		   					@RequestParam("orderCount") int orderCount,
		   					HttpServletResponse response) throws IOException {
	   
	   
	   int result1 = pService.updateOrderSuccess(oNo);
	   int pCount = pService.selectProductCount(pNo);
	   
	   Order o = new Order();
	   o.setOrderCount(orderCount);
	   o.setpNo(pNo);
	   o.setpCount(pCount);
	   
	   int result2 = pService.updateProductCount(o);
	   
	   PrintWriter out = response.getWriter();
		   out.print(result1);
		   out.flush();
		   out.close();
   }
	
   
   
   	// 배송미완료 시 구매확정
   @RequestMapping(value="ordersuccess_b.po")
   public void orderSuccess_B(@RequestParam("oNo") String oNo,
		   					@RequestParam("pNo") int pNo,
		   					@RequestParam("orderCount") int orderCount,
		   					@RequestParam("delivery") String delivery,
		   					HttpServletResponse response) throws IOException {
	   
	   System.out.println("delivery : " + delivery);
	   int result1 = pService.updateOrderSuccess(oNo);
	   int pCount = pService.selectProductCount(pNo);
	   
	   Order o = new Order();
	   o.setoNo(oNo);
	   o.setOrderCount(orderCount);
	   o.setpNo(pNo);
	   o.setpCount(pCount);
	   o.setOrderDelivery(delivery);
	   
	   int result2 = pService.updateProductCount(o);
	   int result3 = pService.updateDeliveryStatus(o);
	   
	   PrintWriter out = response.getWriter();
		   out.print(result1);
		   out.flush();
		   out.close();
   }
   
   
	   // 홈에 인기상품 
	  //이미지 
	 @RequestMapping("productTopListImg.po")
	 public void productTopListImg(HttpServletResponse response) throws JsonIOException, IOException {
	
		   ArrayList<Files> flist = pService.selectFileTopList();
		   
		   System.out.println("flist찍어보기 : " + flist);
		    
		   response.setContentType("aplication/json; charset=UTF-8");
		   Gson gson = new Gson();
		   gson.toJson(flist, response.getWriter());   
	 }
	 
	
	 //이름 가격
	 @RequestMapping("productTopList.po")
	 public void productTopList(HttpServletResponse response) throws JsonIOException, IOException {
		 
		 ArrayList<Product> plist = pService.selectProductTopList();
		 System.out.println("list찍어보기 : " + plist);
		 
		 response.setContentType("aplication/json; charset=UTF-8");
		   Gson gson = new Gson();
		   gson.toJson(plist, response.getWriter());   
	 	}
	 
}
