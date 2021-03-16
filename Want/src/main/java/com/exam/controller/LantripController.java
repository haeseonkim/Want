package com.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class LantripController {
	
	// 랜선여행 목록
	@RequestMapping(value = "/lanTrip_list.do")
	public String lanTrip_list(Model model) {
		return "lanTrip/lanTrip_list";
	}
	

	// 랜선여행 올리기
	@RequestMapping(value = "/lanTrip_write.do")
	public String lanTrip_write(Model model) {
		return "lanTrip/lanTrip_write";
	}
	
	
}
