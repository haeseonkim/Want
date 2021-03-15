package com.exam.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oreilly.servlet.MultipartRequest;

import com.exam.config.SqlMapperInter;

import com.exam.model1.UserTO;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.exam.model1.UserDAO;


//import com.exam.model1.BoardListTO;
//import com.exam.model1.CommentDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;
	
	// 각자 맞는 upload 폴더 경로로 변경
	private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload";

	
	// 로그인폼
	@RequestMapping(value = "/loginForm.do")
	public String loginForm( Model model ) {
		return "user/loginForm";
	}
	
	//로그인ok폼
	@RequestMapping(value = "/loginForm_ok.do" )
	public String loginForm_ok( HttpServletRequest request, HttpServletResponse response ) {
		
		int flag = 2;
		UserTO userTo = new UserTO();
		
		String id = "";
		String pwd = "";
		String kakaoid = "";
		
		if(request.getParameter("kakaoemail").equals("")) {
			id = request.getParameter( "id" );
			pwd = request.getParameter( "password" );
			userTo.setId(id);
			userTo.setPwd(pwd);
			
			int result_lookup = userDao.loginLookup( userTo );
			if( result_lookup == 1 ) {	//회원있음

				int result_ok = userDao.loginOk( userTo );
				if( result_ok == 1 ) {	//비번맞음
					flag = 0;
				} else if( result_ok == 0 ) {	//비번틀림
					flag = 1;
				} else {	//기타오류
					flag = 3;
				}
				
			} else if ( result_lookup == 0 ) {	//회원없음
				flag = 2;
			} else {	//기타오류
				flag = 3;
			}
			request.setAttribute( "flag", flag );
			request.getSession().setAttribute("id", id);
		}else {
			kakaoid = request.getParameter("kakaoemail");
			
			// 로그인 성공 flag
			flag = 0;
			
			request.setAttribute( "flag", flag );
			
			// kakaoemail을 kakaoid에 set
			request.getSession().setAttribute("kakaoid", kakaoid);
		}
		
		
		return "user/loginForm_ok";
	}
	
	
	// 로그아웃
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		
		session.invalidate(); 
		return "user/logout_ok";
	}
	
	// 회원가입
	@RequestMapping(value = "/signupForm.do")
	public String signupForm(Model model) {
		return "user/signupForm";
	}
	
	// signup_ok
	@RequestMapping(value = "/signup_ok.do")
	public String signup_ok(HttpServletRequest request, Model model) {
		
		int maxFileSize = 1024 * 1024 * 6;
	       String encType = "utf-8";
	       
	       MultipartRequest multi = null;
	      
	       try {
	         multi = new MultipartRequest(request, uploadPath+"\\profile", maxFileSize, encType, new DefaultFileRenamePolicy());
	         
	         
	         UserTO to = new UserTO();
	         to.setId(multi.getParameter("id"));
	         to.setPwd(multi.getParameter("pwd"));
	         to.setName(multi.getParameter("name"));
	         to.setBirth(multi.getParameter("birth"));
	         to.setMail(multi.getParameter("mail"));
	         to.setPhone(multi.getParameter("phone"));
	         to.setNick(multi.getParameter("nick"));
	         to.setProfile(multi.getParameter("profile"));
	         to.setGreet(multi.getParameter("greet"));

	         
	         int flag = userDao.signup_ok(to);
	         
	         model.addAttribute("flag", flag);
	      } catch (IOException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }
	       
		return "user/signup_ok";
	}
	
	
	
}
