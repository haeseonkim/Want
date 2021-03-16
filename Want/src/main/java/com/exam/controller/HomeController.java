package com.exam.controller;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.exam.model1.AccomDAO;
import com.exam.model1.AccomListTO;
import com.exam.model1.AccomTO;
import com.exam.model1.ShoppingDAO;
import com.exam.model1.ShoppingListTO;
import com.exam.model1.ShoppingTO;
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
	@Autowired
	private ShoppingDAO shopDao;
	@Autowired
	private AccomDAO accomDao;
	
	
	
	
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
			if( result_lookup == 1 ) {	//회원있음

				if( pwd.equals( decryPwd ) ) {	// 사용자가 적은 pwd와 DB에 저장된 암호화된 비번 복호화해서 비교
					userTo.setPwd(realPwd);
					int result_ok = userDao.loginOk( userTo );
					
					if( result_ok == 1 ) {	//비번맞음
						flag = 0;
					} else if( result_ok == 0 ) {	//비번틀림
						flag = 1;
					} else {	//기타오류
						flag = 3;
					}
				}
			} else if ( result_lookup == 0 ) {	//회원없음
				flag = 2;
			} else {	//기타오류
				flag = 3;
			}
			request.setAttribute( "flag", flag );
			request.setAttribute( "id", userTo.getId() );
			
			return "user/loginForm";
		} else {
			return "user/loginForm";
		}
	}
	
	// ---------------------- 회원가입관련 ----------------------
	@RequestMapping(value = "/signupForm.do")
	public String signupForm(Model model) {
		return "user/signupForm";
	}
	
	//signup_ok
	@RequestMapping(value = "/signup_ok.do")
	public String signup_ok(HttpServletRequest request, Model model) throws Exception {
		
		int maxFileSize = 1024 * 1024 * 6;
	       String encType = "utf-8";
	       String uploadPath = "C:\\Users\\bboyr\\OneDrive\\바탕 화면\\이것저것\\kic프로젝트\\최종프로젝트\\git\\Want\\Want\\src\\main\\webapp\\upload\\profile";
	       MultipartRequest multi = null;
	      
	       try {
	         multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
	         
	         String key = "secret Key";
	         
	         UserTO to = new UserTO();
	         to.setId(multi.getParameter("id"));
	         
	         //비밀번호암호화해서 TO에 set
	         String encryPwd = userDao.encrytAES( multi.getParameter("pwd"), key);
	         to.setPwd( encryPwd );	         
	         
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
	       
		return "user/signup_ok";
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
		return "lanTrip/lanTrip_list";
	}
	
	// 랜선여행 신청 목록
	@RequestMapping(value = "/lanTrip_apply_list.do")
	public String lanTrip_apply_list(Model model) {
		return "lanTrip_appl/lanTrip_apply_list";
	}
	
	// 사진자랑 목록
	@RequestMapping(value = "/picture_list.do")
	public String picture_list(Model model) {
		return "picture/picture_list";
	}
	
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
	
	// 쇼핑정보 글쓰기
	@RequestMapping(value = "/shopping_write.do")
	public String shopping_write( HttpServletRequest request, HttpServletResponse response, HttpSession session ) {
		
	    return "shopping/shopping_write";
	}
	
	// 쇼핑정보 글쓰기 Ok
	@RequestMapping(value = "/shopping_write_ok.do")
	public String shopping_write_ok( HttpServletRequest request, HttpServletResponse response ) {
		
		int maxFileSize = 1024 * 1024 * 6;
	    String encType = "utf-8";
	    String uploadPath = "C:\\Users\\bboyr\\OneDrive\\바탕 화면\\이것저것\\kic프로젝트\\최종프로젝트\\git\\Want\\Want\\src\\main\\webapp\\upload\\shopping";
		MultipartRequest multi = null;
	      
	    try {
		    multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
			String writer = multi.getParameter( "writer" );
			String subject = multi.getParameter( "subject" );
			String content = multi.getParameter( "content" );
			String location = multi.getParameter( "city" );
			String picture = multi.getFilesystemName( "picture" );
			File file = multi.getFile( "profile" );
			
			ShoppingTO shopTo = new ShoppingTO();
			shopTo.setWriter(writer);
			shopTo.setSubject(subject);
			shopTo.setContent(content);
			shopTo.setLocation(location);
			shopTo.setPicture(picture);
			
			int flag = shopDao.shopping_write_ok(shopTo);
			
			request.setAttribute( "flag", flag );
			request.setAttribute( "cityName", shopTo.getLocation() );
			
	    } catch (IOException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	    }
		
		return "shopping/shopping_write_ok";
	}
	
	// 쇼핑 llist
	@RequestMapping(value = "/shopping_list.do")
	public String shopping_list( HttpServletRequest request, HttpServletResponse response ) {
		String location = request.getParameter( "cityName" );
		int cpage = 1;
		if ( request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals("") ) {
			cpage = Integer.parseInt( request.getParameter( "cpage" ) );
		}
		
		ShoppingListTO listTO = new ShoppingListTO();
		listTO.setLocation(location);
		listTO.setCpage(cpage);
		
		
		listTO = shopDao.shopList(listTO);
		
		request.setAttribute( "listTO", listTO );
		request.setAttribute( "cpage", cpage );
		
		return "shopping/shopping_list";
	}
	
	// 숙소정보 글쓰기
	@RequestMapping(value = "/accom_write.do")
	public String accom_write(Model model) {
		return "accom/accom_write";
	}
	
	// 숙소정보 글쓰기 Ok
	@RequestMapping(value = "/accom_write_ok.do")
	public String accom_write_ok( HttpServletRequest request, HttpServletResponse response ) {
		
		int maxFileSize = 1024 * 1024 * 6;
	    String encType = "utf-8";
	    String uploadPath = "C:\\Users\\bboyr\\OneDrive\\바탕 화면\\이것저것\\kic프로젝트\\최종프로젝트\\git\\Want\\Want\\src\\main\\webapp\\upload\\accom";
		MultipartRequest multi = null;
	      
	    try {
		    multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
			String writer = multi.getParameter( "writer" );
			String subject = multi.getParameter( "subject" );
			String content = multi.getParameter( "content" );
			String location = multi.getParameter( "city" );
			String picture = multi.getFilesystemName( "picture" );
			File file = multi.getFile( "profile" );
			
			AccomTO accomTo = new AccomTO();
			accomTo.setWriter(writer);
			accomTo.setSubject(subject);
			accomTo.setContent(content);
			accomTo.setLocation(location);
			accomTo.setPicture(picture);
			
			int flag = accomDao.accom_write_ok(accomTo);
			
			request.setAttribute( "flag", flag );
			request.setAttribute( "cityName", accomTo.getLocation() );
			
	    } catch (IOException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	    }
		
		return "accom/accom_write_ok";
	}

	// 숙소 list
	@RequestMapping(value = "/accom_list.do")
	public String accom_list( HttpServletRequest request, HttpServletResponse response ) {
		String location = request.getParameter( "cityName" );
		int cpage = 1;
		if ( request.getParameter( "cpage" ) != null && !request.getParameter( "cpage" ).equals("") ) {
			cpage = Integer.parseInt( request.getParameter( "cpage" ) );
		}
		
		AccomListTO listTO = new AccomListTO();
		listTO.setLocation(location);
		listTO.setCpage(cpage);
		
		listTO = accomDao.accomList(listTO);
		
		request.setAttribute( "listTO", listTO );
		request.setAttribute( "cpage", cpage );
		
		return "accom/accom_list";
	}
	
	// 동행 구해요 목록
	@RequestMapping(value = "/with_list.do")
	public String with_list(Model model) {
		return "with/with_list";
	}
	
	// 즐겨찾기한 게시물 목록
	@RequestMapping(value = "/favorite_list.do")
	public String favorite_list(Model model) {
		return "favorite/favorite_list";
	}
	
	// 팔로우/팔로워 목록
	@RequestMapping(value = "/follow_list.do")
	public String follow_list(Model model) {
		return "follow/follow_list";
	}
	
	// 내가올린 게시물 목록
	@RequestMapping(value = "/my_list.do")
	public String my_list(Model model) {
		return "my/my_list";
	}
	
	// 내 프로필
	@RequestMapping(value = "/profile.do")
	public String profile(Model model) {
		return "profile/profile";
	}
	
	// about us
	@RequestMapping(value = "/aboutUs.do")
	public String aboutUs(Model model) {
		return "aboutUs";
	}
	
	
	
	
	// -------------------- 게시물 올리기 -----------------
	

	
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
