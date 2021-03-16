package com.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class FavoriteController {
	
	
	// 즐겨찾기한 게시물 목록
	@RequestMapping(value = "/favorite_list.do")
	public String favorite_list(Model model) {
		return "favorite/favorite_list";
	}
	
}
