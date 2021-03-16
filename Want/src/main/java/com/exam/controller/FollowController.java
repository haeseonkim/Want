package com.exam.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

public class FollowController {
	

	// 팔로우/팔로워 목록
	@RequestMapping(value = "/follow_list.do")
	public String follow_list(Model model) {
		return "follow/follow_list";
	}


}
