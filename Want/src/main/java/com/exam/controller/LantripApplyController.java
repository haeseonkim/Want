package com.exam.controller;


import java.io.UnsupportedEncodingException;

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
		try {
			request.setCharacterEncoding("utf-8");
			LanTripApplyListTO listTO = new LanTripApplyListTO();
			listTO.setCpage(
					Integer.parseInt(request.getParameter("cpage") == null || request.getParameter("cpage").equals("") ? "1"
							: request.getParameter("cpage")));
			listTO = dao.boardList(listTO);

			model.addAttribute("listTO", listTO);
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "lanTrip_apply/lanTrip_apply_list";
	}

	// 랜선여행 신청 올리기
	@RequestMapping(value = "/lanTrip_apply_write.do")
	public String lanTrip_apply_write(HttpServletRequest request, Model model ) {
		try {
			request.setCharacterEncoding("utf-8");
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "lanTrip_apply/lanTrip_apply_write";
	}

}
