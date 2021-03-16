package com.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;




@Controller
public class ProfileController {
	
	// 각자 맞는 upload 폴더 경로로 변경
	//private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload";
	
	// 내 프로필
	@RequestMapping(value = "/profile.do")
	public String profile(Model model) {
		return "profile/profile";
	}
	


}
