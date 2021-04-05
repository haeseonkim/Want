package com.exam.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.model1.message.MessageDAO;
import com.exam.model1.message.MessageTO;
import com.exam.model1.picture.PictureDAO;
import com.exam.model1.user.UserDAO;
import com.exam.model1.user.UserTO;


@Controller
public class ProfileController {
	
	
	
	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private MessageDAO messageDao;

   private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\profile";
   //private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\profile";
   //private String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/profile";
	
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
	
	// 메세지 목록 가져오기
	@RequestMapping(value = "/message_content_list_inprofile.do")
	public String message_content_list_inprofile(HttpServletRequest request, HttpSession session) {

		//int room = Integer.parseInt(request.getParameter("room"));
		String other_nick = request.getParameter("other_nick");

		MessageTO to = new MessageTO();
		to.setRecv_nick(other_nick);
		to.setNick((String) session.getAttribute("nick"));

		// 메세지 내용을 가져온다.
		ArrayList<MessageTO> clist = messageDao.roomContentList(to);

		request.setAttribute("clist", clist);
		
		System.out.println(clist);

		return "message/message_content_list";
	}

	// 메세지 리스트에서 메세지 보내기
	@ResponseBody
	@RequestMapping(value = "/message_send_inlist_inprofile.do")
	public int message_send_inlist_inprofile(@RequestParam String other_nick, @RequestParam String content, HttpSession session) {
		System.out.println("컨트롤러 들어옴");
		System.out.println("other_nick: " + other_nick);
		System.out.println("content: " + content);
		
		MessageTO to = new MessageTO();
		to.setSend_nick((String) session.getAttribute("nick"));
		to.setRecv_nick(other_nick);
		to.setContent(content);

		int flag = messageDao.messageSendInlist(to);

		return flag;
	}
	

}
