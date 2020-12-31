package com.kh.green;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.green.board.model.service.BoardService;
import com.kh.green.board.model.vo.Board;
import com.kh.green.board.model.vo.Files;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private BoardService bService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		int listImage = bService.getImageListCount();
		
		for(int i=1; i <= listImage; i++) {
			Board bImage = bService.selectImageBoard("메인이미지"+i);
			Files files = bService.selectImageFiles(bImage.getbNo());
		
			if(bImage != null) {
				model.addAttribute("bImage"+i, bImage);
				model.addAttribute("files"+i, files);
			}
		}
		model.addAttribute("image", "image");
		
		return "home";
	}
	
}
