package com.exam.want;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.exam.config.SqlMapperInter;
//import com.exam.model1.BoardDAO;
//import com.exam.model1.BoardListTO;
//import com.exam.model1.CommentDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
//	@Autowired
//	private BoardDAO dao;
//	@Autowired
//	private CommentDAO cdao;
//	private String uploadPath = "C:\\KICKIC\\kic-workspace\\Want\\src\\main\\webapp\\upload";
//	
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
	
	// 로그인
	@RequestMapping(value = "/loginForm.do")
	public String loginForm(Model model) {
		return "loginForm";
	}
	
	// 회원가입
	@RequestMapping(value = "/signupForm.do")
	public String signupForm(Model model) {
		return "signupForm";
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
