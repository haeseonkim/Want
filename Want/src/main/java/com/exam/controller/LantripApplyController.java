package com.exam.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.exam.model1.LanTripApplyDAO;
import com.exam.model1.LanTripApplyListTO;

@Controller
public class LantripApplyController {

	// 랜선여행 신청 목록
	@Autowired
	private LanTripApplyDAO dao;

	@RequestMapping(value = "/lanTrip_apply_list.do")

	public String list(HttpServletRequest request, Model model) {

		LanTripApplyListTO listTO = new LanTripApplyListTO();
		listTO.setCpage(
				Integer.parseInt(request.getParameter("cpage") == null || request.getParameter("cpage").equals("") ? "1"
						: request.getParameter("cpage")));
		listTO = dao.boardList(listTO);

		model.addAttribute("listTO", listTO);

		return "lanTrip_apply/lanTrip_apply_list";
	}

	// 랜선여행 신청 올리기
	@RequestMapping(value = "/lanTrip_apply_write.do")
	public String lanTrip_apply_write(Model model) {
		return "lanTrip_apply/lanTrip_apply_write";
	}

}
