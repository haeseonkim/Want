package com.exam.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.model1.message.MessageDAO;
import com.exam.model1.message.MessageTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.pictureReply.ReplyTO;
import com.exam.model1.lantrip.LanTripDAO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.lantripReply.LanTripReplyDAO;
import com.exam.model1.lantripReply.LanTripReplyTO;
import com.exam.model1.user.UserDAO;
import com.exam.model1.user.UserTO;

@Controller
public class ProfileController {

	@Autowired
	private UserDAO userDao;

	@Autowired
	private MessageDAO messageDao;
	@Autowired
	private LanTripDAO lantripDao;
	@Autowired
	private LanTripReplyDAO l_replyDao;

	//private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\profile";
	// private String uploadPath = "C:\\KICKIC\\git
	// repo\\Want\\Want\\src\\main\\webapp\\upload\\profile";
	private String uploadPath = "/Users/hyukjun/git/Want/Want/src/main/webapp/upload/profile";

	// 내 프로필
	@RequestMapping(value = "/profile.do")
	public String profile(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");

			// ======= 유저 정보가져오기 =======
			// 세션에 저장된 nick값을 to에 저장
			UserTO uto = new UserTO();
			String nick = (String) session.getAttribute("nick");
			uto.setNick(nick);

			// 저장된 nick값을 userDao함수 매개변수로 넘겨줌
			// userDao에서 myProfile함수를 실행시켜서 유저 정보를 다시 uto에 저장
			uto = userDao.myProfile(uto);

			// ======= 랜선여행 글list 가져오기 =======
			LanTripTO lto = new LanTripTO();

			String pageNum = request.getParameter("pageNum");

			int recordNum = 9; // 가져올 글의 개수

			int currentPage = 1; // 현재 페이지번호
			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}
			int startRowNum = 0 + (currentPage - 1) * recordNum;
			int endRowNum = currentPage * recordNum;

			lto.setWriter(nick);
			lto.setStartRowNum(startRowNum);
			lto.setEndRowNum(endRowNum);

			// 전체 글의 개수를 이용해서 전페 페이지수 구하기
			int totalRow = 0;
			totalRow = lantripDao.profileLanTripCount(lto);

			int totalPageCount = (int) Math.ceil(totalRow / (double) recordNum);

			// 랜선여행 글리스트 결과를 리턴받는다.
			ArrayList<LanTripTO> list = lantripDao.lantrip_MyProfileList(lto);

			// jsp로 uto값을 넘겨줌
			request.setAttribute("uto", uto);
			request.setAttribute("totalPageCount", totalPageCount);
			// jsp로 to가 담긴 arrayList넘겨준다.
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("list", list);

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "profile/profile";
	}

	// 랜선여행리스트 불러오기
	@RequestMapping(value = "/profile_lanTrip_ajax_page.do")
	public String profile_lanTrip_ajax_page(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");

			// 세션에 저장된 nick값과 페이지 가져올 글수를 정하는
			// startRowNum과 endRowNum을 to에 저장
			LanTripTO lto = new LanTripTO();

			String writer = (String) session.getAttribute("nick");
			String pageNum = request.getParameter("pageNum");

			int recordNum = 9; // 가져올 글의 개수

			int currentPage = 1; // 현재 페이지번호
			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}
			int startRowNum = 0 + (currentPage - 1) * recordNum;
			int endRowNum = currentPage * recordNum;

			lto.setWriter(writer);
			lto.setStartRowNum(startRowNum);
			lto.setEndRowNum(endRowNum);

			// 전체 글의 개수를 이용해서 전페 페이지수 구하기
			int totalRow = 0;
			totalRow = lantripDao.profileLanTripCount(lto);

			int totalPageCount = (int) Math.ceil(totalRow / (double) recordNum);

			// 랜선여행 글리스트 결과를 리턴받는다.
			ArrayList<LanTripTO> list = lantripDao.lantrip_MyProfileList(lto);

			// jsp로 to가 담긴 arrayList넘겨준다.
			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("list", list);

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "profile/profile_lanTrip_ajax_page";
	}

	// 랜선여행하기 댓글리스트
	@RequestMapping(value = "/lantrip_replyList.do")
	public String lantrip_replyList(HttpServletRequest request, HttpSession session) {

		LanTripReplyTO to = new LanTripReplyTO();

		// 가져올 댓글 리스트의 게시물번호를 세팅
		to.setBno(request.getParameter("no"));

		ArrayList<LanTripReplyTO> replyList = new ArrayList();

		replyList = l_replyDao.lantripReplyList(to);

		request.setAttribute("rlist", replyList);

		return "profile/profile_lantripReply_ajax_page";
	}

	// 랜선여행 모댓글 작성
	@ResponseBody
	@RequestMapping(value = "/lantrip_write_reply.do")
	public LanTripTO lantrip_write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session) {

		LanTripReplyTO to = new LanTripReplyTO();
		// 게시물번호 세팅
		to.setBno(bno);

		// 댓글 내용 세팅
		to.setContent(content);

		// 댓글 작성자 nick을 writer로 세팅
		to.setWriter((String) session.getAttribute("nick"));

		LanTripTO lto = l_replyDao.lantripWriteReply(to);

		return lto;
	}

	// 모댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/lantrip_delete_reply.do")
	public LanTripTO lantrip_delete_reply(@RequestParam String no, @RequestParam String bno) {

		LanTripReplyTO to = new LanTripReplyTO();

		// 모댓글 번호 세팅
		to.setNo(no);

		// 게시물 번호 세팅
		to.setBno(bno);

		// 갱신된 댓글 갯수를 담아오기 위함
		LanTripTO lto = l_replyDao.lantripDeleteReply(to);

		return lto;
	}

	// 자식댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/lantrip_delete_rereply.do")
	public LanTripTO lantrip_delete_reply(@RequestParam String no, @RequestParam String bno, @RequestParam String grp) {

		LanTripReplyTO to = new LanTripReplyTO();

		// 모댓글 번호 세팅
		to.setNo(no);

		// 게시물 번호 세팅
		to.setBno(bno);

		// grp세팅
		to.setGrp(grp);

		// 갱신된 댓글 갯수를 담아오기 위함
		LanTripTO lto = l_replyDao.lantripDeleteReply(to);

		return lto;
	}

	// 회원정보 수정을 위해 회원정보 가져오기
	@RequestMapping(value = "/edit_profile.do")
	public String edit_profile(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");

			// ======= 유저 정보가져오기 =======
			// 세션에 저장된 nick값을 to에 저장
			UserTO uto = new UserTO();
			String nick = (String) session.getAttribute("nick");
			uto.setNick(nick);

			// 저장된 nick값을 userDao함수 매개변수로 넘겨줌
			// userDao에서 myProfile함수를 실행시켜서 유저 정보를 다시 uto에 저장
			uto = userDao.myProfile(uto);

			// jsp로 uto값을 넘겨줌
			request.setAttribute("uto", uto);

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "profile/edit_profile";
	}

}