package com.exam.controller;


import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.exam.model1.LanTripDAO;
import com.exam.model1.LanTripListTO;
import com.exam.model1.UserDAO;

@Controller
public class LanTripController {


	@Autowired
	private LanTripDAO dao;

	// 각자 맞는 upload 폴더 경로로 변경
	private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload";

	// 랜선여행 목록
	@RequestMapping(value = "/lanTrip_list.do")
	public String lanTrip_list(HttpServletRequest request, Model model) {
		try {
			request.setCharacterEncoding("utf-8");
			LanTripListTO listTO = new LanTripListTO();
			listTO.setCpage( Integer.parseInt( request.getParameter( "cpage" ) == null || request.getParameter( "cpage" ).equals( "" ) ? "1" : request.getParameter( "cpage" ) ) );
			listTO = dao.lanTripList(listTO);
			
			model.addAttribute( "listTO", listTO );
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "lanTrip/lanTrip_list";
	}
	

	// 랜선여행 올리기
	@RequestMapping(value = "/lanTrip_write.do")
	public String lanTrip_write(HttpServletRequest request, Model model ) {
		try {
			request.setCharacterEncoding("utf-8");
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "lanTrip/lanTrip_write";
	}
	
	// 랜선여행 게시물 view
	@RequestMapping(value = "/lanTrip_view.do")
	public String lanTrip_view(HttpServletRequest request, Model model ) {
		try {
			request.setCharacterEncoding("utf-8");
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "lanTrip/lanTrip_view";
	}

}