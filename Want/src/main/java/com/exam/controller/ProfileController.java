package com.exam.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.exam.model1.picture.PictureDAO;
import com.exam.model1.user.UserDAO;
import com.exam.model1.user.UserTO;


@Controller
public class ProfileController {
	
	
	
	@Autowired
	private UserDAO userDao;

   //private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\profile";
   //private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\profile";
   private String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/profile";
	
	// 내 프로필
	@RequestMapping(value = "/profile.do")
	public String profile(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "profile/profile";
	}
	
	// 남이 보는 내 프로필
	@RequestMapping(value = "/other_profile.do")
	public String other_profile(HttpServletRequest request) {
		
		UserTO to = new UserTO();
		
		to.setNick(request.getParameter("other_nick"));
		to = userDao.OtherProfile(to);
		
		System.out.println(to);
		
		request.setAttribute("to", to);
		
		return "profile/other_profile";
	}
	
	
	


}
