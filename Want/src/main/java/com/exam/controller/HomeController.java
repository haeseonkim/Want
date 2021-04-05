package com.exam.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.model1.accom.AccomTO;
import com.exam.model1.home.HomeDAO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.shopping.ShoppingTO;

@Controller
public class HomeController {

	@Autowired
	private HomeDAO homeDao;

	// before home
	@ResponseBody
	@RequestMapping(value = "/visitCount.do")
	public int visitCount(HttpSession session) {

		int flag = homeDao.visitCount();

		return flag;
	}

	// home
	@RequestMapping(value = "/home.do")
	public String home(HttpSession session, HttpServletRequest request) {

		// lantrip best 게시물 3
		ArrayList<LanTripTO> lanList = homeDao.l_best3();
		// picture best 게시물 3
		ArrayList<PictureTO> picList = homeDao.p_best3();
		// shopping best 게시물3
		ArrayList<ShoppingTO> shopList = homeDao.s_best3();
		// accom best 게시물3
		ArrayList<AccomTO> accomList = homeDao.a_best3();

		// 오늘 방문자수
		int visit = homeDao.getVisit();
		// 회원수
		int member = homeDao.getMember();
		// 게시물 수
		int boards_contents = homeDao.getBoardsContents();

		request.setAttribute("lanList", lanList);
		request.setAttribute("picList", picList);
		request.setAttribute("shopList", shopList);
		request.setAttribute("accomList", accomList);
		
		request.setAttribute("visit", visit);
		request.setAttribute("member", member);
		request.setAttribute("boards_contents", boards_contents);
		

		return "home";
	}

}
