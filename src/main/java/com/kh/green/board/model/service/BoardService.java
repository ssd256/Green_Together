package com.kh.green.board.model.service;

import com.kh.green.board.model.vo.Board;
import com.kh.green.board.model.vo.Files;

public interface BoardService {

	int insertFiles(Files f);

	int insertBoard(Board b);

	Board selectImageBoard(String string);

	Files selectImageFiles(int getbNo);

	int getImageListCount();

	int updateBoard(Board b);

	int updateFiles(Files f);

}
