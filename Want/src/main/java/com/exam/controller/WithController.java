package com.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class WithController {
	
	// 동행 구해요 목록
	@RequestMapping(value = "/with_list.do")
	public String with_list(Model model) {
		return "with/with_list";
	}

}
