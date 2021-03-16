
package com.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class TripInfoController {
	
	// ---------------------- 여행지 정보 -------------------------
	// ------ 쇼핑 & 숙소 선택 -----
	@RequestMapping(value="/select_shop_accom.do")
	public String select_shop_accom( Model model ) {
		return "board/select_shop_accom";
	}
	
	// ------ 도시 선택 -----
	@RequestMapping(value="/select_city.do")
	public String select_city( Model model ) {
		return "board/select_city";
	}
	
	
}
