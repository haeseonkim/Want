package com.exam.want;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
public class HomeController {
	
	@Autowired
	private UserDAO userDao;
	
//	@Autowired
//	private BoardDAO dao;

//	@Autowired
//	private CommentDAO cdao;
	private String uploadPath = "C:\\Users\\bboyr\\OneDrive\\바탕 화면\\이것저것\\kic프로젝트\\최종프로젝트\\git\\Want\\Want\\src\\main\\webapp\\upload\\profile";

//	@Autowired
//	private SqlMapperInter sqlMapperInter;
	
//	@RequestMapping(value = "/list.do")
//	public String list(HttpServletRequest request, Model model) {
//		
//		BoardListTO listTO = new BoardListTO();
//		listTO.setCpage( Integer.parseInt( request.getParameter( "cpage" ) == null || request.getParameter( "cpage" ).equals( "" ) ? "1" : request.getParameter( "cpage" ) ) );
//		listTO = dao.boardList(listTO);
//		
//		model.addAttribute( "listTO", listTO );
//		
//		return "board_list1";
//	}
	
	// ---------------------- 로그인 관련 ----------------------
	@RequestMapping(value = "/loginForm.do")
	public String loginForm( HttpServletRequest request, HttpServletResponse response ) {
		if( request.getParameter( "login_ok" ) == null ) {
			return "loginForm";
		} else if( request.getParameter( "login_ok" ).equals("1") ) {
			
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
			
			return "loginForm";
		} else {
			return "loginForm";
		}
	}
	
	// ---------------------- 회원가입관련 ----------------------
	@RequestMapping(value = "/signupForm.do")
	public String signupForm(Model model) {
		return "signupForm";
	}
	
	//signup_ok
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
	         to.setProfile( multi.getFilesystemName( "profile" ) );
	         File file = multi.getFile( "profile" );
	         if( multi.getParameter("greet").equals( "" ) ) {
	        	 to.setGreet(null);
	         } else {
	        	 to.setGreet(multi.getParameter("greet")); 
	         }
	         
	         int flag = userDao.signup_ok(to);
	         
	         model.addAttribute("flag", flag);
	      } catch (IOException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }
	       
		return "signup_ok";
	}
	
	//signup에서 id중복조회
	@ResponseBody
	@RequestMapping(value = "/usingId_chk.do", produces="text/plain" )
	public String idCheck( HttpServletRequest request, HttpServletResponse response ) {
		
		String user_id = request.getParameter( "user_id" );
		UserTO userTo = new UserTO();
		userTo.setId( user_id );
		
		int using_user = userDao.loginLookup( userTo );
		String result = "" + using_user;	//숫자를 문자열로 변환
		
		return result;
	}
	
	//signup에서 닉네임중복조회
	@ResponseBody
	@RequestMapping(value = "/usingNick_chk.do", produces="text/plain" )
	public String nickCheck( HttpServletRequest request, HttpServletResponse response ) {
		
		String user_nick = request.getParameter( "user_nick" );
		UserTO userTo = new UserTO();
		userTo.setNick( user_nick );
		
		int using_nick = userDao.nickLookup( userTo );
		String result = "" + using_nick;

		return result;
	}
	
	
	// ---------------------- 게시물 조회 -------------------------
	
	// 랜선여행 목록
	@RequestMapping(value = "/lanTrip_list.do")
	public String lanTrip_list(Model model) {
		return "board/lanTrip_list";
	}
	
	// 랜선여행 신청 목록
	@RequestMapping(value = "/lanTrip_apply_list.do")
	public String lanTrip_apply_list(Model model) {
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
		return "write/lanTrip_apply_write";
	}
}
