package com.exam.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;

import com.exam.config.SqlMapperInter;

import com.exam.model1.UserTO;
import com.exam.model1.pwFindDAO;
import com.exam.model1.pwFindTO;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.exam.model1.LanTripApplyDAO;
import com.exam.model1.LanTripApplyListTO;
import com.exam.model1.LanTripApplyTO;
import com.exam.model1.LanTripDAO;
import com.exam.model1.UserDAO;


//import com.exam.model1.BoardListTO;
//import com.exam.model1.CommentDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private UserDAO userDao;
	
//	@Autowired
//	private BoardDAO dao;

//	@Autowired
//	private CommentDAO cdao;
	private String uploadPath = "C:\\Users\\wjdgu\\Desktop\\코딩\\1. [메인프로젝트]\\02. 기획\\Want\\src\\main\\webapp\\upload";



	// ---------------------- 로그인 관련 ----------------------

	   @RequestMapping(value = "/loginForm.do")
	   public String loginForm( HttpServletRequest request, HttpServletResponse response, HttpSession session ) throws Exception {
	      if( request.getParameter( "login_ok" ) == null ) {
	         return "user/loginForm";
	      } else if( request.getParameter( "login_ok" ).equals("1") ) {
	         
	         int flag = 2;
	         String key = "secret Key";
	         
	         UserTO userTo = new UserTO();
	         
	         String id = request.getParameter( "id" );
	         String pwd = request.getParameter( "password" );
	         
	         userTo.setId(id);
	         
	         String realPwd = userDao.loginDecry(userTo);
	         String decryPwd = userDao.decryptAES( realPwd, key );
	         
	         int result_lookup = userDao.loginLookup( userTo );
	         if( result_lookup == 1 ) {   //회원있음

	            if( pwd.equals( decryPwd ) ) {   // 사용자가 적은 pwd와 DB에 저장된 암호화된 비번 복호화해서 비교
	               userTo.setPwd(realPwd);
	               int result_ok = userDao.loginOk( userTo );
	               
	               if( result_ok == 1 ) {   //비번맞음
	                  flag = 0;
	               } else if( result_ok == 0 ) {   //비번틀림
	                  flag = 1;
	               } else {   //기타오류
	                  flag = 3;
	               }
	            }
	         } else if ( result_lookup == 0 ) {   //회원없음
	            flag = 2;
	         } else {   //기타오류
	            flag = 3;
	         }
	         request.setAttribute( "flag", flag );
	         request.setAttribute( "id", userTo.getId() );
	         
	         return "user/loginForm";
	      } else {
	         return "user/loginForm";
	      }
	   }
	   

	//로그인ok폼
	@RequestMapping(value = "/loginForm_ok.do" )
	public String loginForm_ok( HttpServletRequest request, HttpServletResponse response ) {
		
		int flag = 2;
		UserTO userTo = new UserTO();
		
		String id = request.getParameter( "id" );
		String pwd = request.getParameter( "password" );
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
		
		return "loginForm_ok";
	}
	
	// pwFindForm
	@RequestMapping(value = "/pwFindForm.do")
	public String pwFindForm( Model model ) {
		return "pwFindForm";
	}
	
	//pwFindForm_ok
	@RequestMapping(value = "/pwFindForm_ok.do" )
	public String pwFindForm_ok( HttpServletRequest request, HttpServletResponse response ) {
		
		int flag = 2;
		UserTO userTo = new UserTO();
		/*
		 * pwFindTO pwFindTo = new pwFindTO();
		 * 
		 * ModelAndView mav;
		 */
		String id = request.getParameter( "id" );
		String mail = request.getParameter( "mail" );
		String pwd = request.getParameter( "pwd" );
		String name = request.getParameter( "name" );
		
		userTo.setId(id);
		userTo.setMail(mail);
		userTo.setPwd(pwd);
		userTo.setName(name);
		
		int result_lookup = userDao.pwFindLookup( userTo );
		if( result_lookup == 1 ) {	//회원있음

			int result_ok = userDao.pwFindOk( userTo );
			if( result_ok == 1 ) {	//메일맞음
				flag = 0;
				/*
				 * 
				 * System.out.println(pwd);
				 * 
				 * if(pwd!=null) { pwFindTo.setContent("비밀번호는 "+pwd+"입니다.");
				 * pwFindTo.setMail(mail); pwFindTo.setSubject(id+"님의 비밀번호 찾기 메일입니다.");
				 * //pwFindDAO.SendEmail(mail); mav = new
				 * ModelAndView("redirect:/loginForm.do");
				 * 
				 * } else { mav = new ModelAndView("redirect:/loginForm.do");
				 * 
				 * }
				 */
			} else if( result_ok == 0 ) {	//메일틀림
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
		
		return "pwFindForm_ok";
	}
	
	
	// 회원가입
	@RequestMapping(value = "/signupForm.do")
	public String signupForm(Model model) {
		return "signupForm";
	}
	
	// signup_ok
	@RequestMapping(value = "/signup_ok.do")
	public String signup_ok(HttpServletRequest request, Model model) {
		
		int maxFileSize = 1024 * 1024 * 6;
	       String encType = "utf-8";
	       
	       MultipartRequest multi = null;
	      
	       try {
	         multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
	         
	         
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
	       
		return "signup_ok";
	}
	
	
	// ---------------------- 게시물 조회 -------------------------
	
	// 랜선여행 목록
	@RequestMapping(value = "/lanTrip_list.do")
	public String lanTrip_list(Model model) {
		return "board/lanTrip_list";
	}
	
	// 랜선여행 신청 목록
	@Autowired
	private LanTripApplyDAO dao;
	
	@RequestMapping(value = "/lanTrip_apply_list.do")
	
	   public String list(HttpServletRequest request, Model model) {
	      
	      LanTripApplyListTO listTO = new LanTripApplyListTO();
	      listTO.setCpage( Integer.parseInt( request.getParameter( "cpage" ) == null || request.getParameter( "cpage" ).equals( "" ) ? "1" : request.getParameter( "cpage" ) ) );
	      listTO = dao.boardList(listTO);
	      
	      model.addAttribute( "listTO", listTO );
	      
	      return "board/lanTrip_apply_list";
	   }

	
	// 사진자랑 목록
	@RequestMapping(value = "/picture_list.do")
	public String picture_list(Model model) {
		return "board/picture_list";
	}
	
	// 쇼핑 정보 목록
	@RequestMapping(value = "/shopping_list.do")
	public String shopping_list(Model model) {
		return "board/shopping_list";
	}
	
	// 숙소 정보 목록
	@RequestMapping(value = "/accom_list.do")
	public String accom_list(Model model) {
		return "board/accom_list";
	}
	
	// 동행 구해요 목록
	@RequestMapping(value = "/with_list.do")
	public String with_list(Model model) {
		return "board/with_list";
	}
	
	// 즐겨찾기한 게시물 목록
	@RequestMapping(value = "/favorite_list.do")
	public String favorite_list(Model model) {
		return "board/favorite_list";
	}
	
	// 팔로우/팔로워 목록
	@RequestMapping(value = "/follow_list.do")
	public String follow_list(Model model) {
		return "board/follow_list";
	}
	
	// 내가올린 게시물 목록
	@RequestMapping(value = "/my_list.do")
	public String my_list(Model model) {
		return "board/my_list";
	}
	
	// 내 프로필
	@RequestMapping(value = "/profile.do")
	public String profile(Model model) {
		return "board/profile";
	}
	
	// about us
	@RequestMapping(value = "/aboutUs.do")
	public String aboutUs(Model model) {
		return "aboutUs";
	}
	
	
	
	
	// -------------------- 게시물 올리기 -----------------
	
	// 숙소 정보 올리기
	@RequestMapping(value = "/accom_write.do")
	public String accom_write(Model model) {
		return "write/accom_write";
	}
	
	// 쇼핑정보 올리기
	@RequestMapping(value = "/shopping_write.do")
	public String shopping_write(Model model) {
		return "write/shopping_write";
	}
	
	// 랜선여행 올리기
	@RequestMapping(value = "/lanTrip_write.do")
	public String lanTrip_write(Model model) {
		return "write/lanTrip_write";
	}
	
	// 랜선여행 신청 올리기
	@RequestMapping(value = "/lanTrip_apply_write.do")
	public String lanTrip_apply_write(Model model) {
		return "lanTrip_apply/lanTrip_apply_write";
	}
}
