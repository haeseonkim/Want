//package com.exam.controller;
//
//import java.io.UnsupportedEncodingException;
//import java.net.URLEncoder;
//import java.util.ArrayList;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.exam.model1.message.MessageDAO;
//import com.exam.model1.message.MessageTO;
//import com.exam.model1.picture.PictureDAO;
//import com.exam.model1.picture.PictureTO;
//import com.exam.model1.shopping.ShoppingDAO;
//import com.exam.model1.accom.AccomDAO;
//import com.exam.model1.lantrip.LanTripDAO;
//import com.exam.model1.lantrip.LanTripTO;
//import com.exam.model1.lantripReply.LanTripReplyDAO;
//import com.exam.model1.lantripReply.LanTripReplyTO;
//import com.exam.model1.user.UserDAO;
//import com.exam.model1.user.UserTO;
//
//
//@Controller
//public class OtherProfileController {
//	
//	@Autowired
//	private UserDAO userDao;
//	@Autowired
//	private LanTripDAO lantripDao;
//	@Autowired
//	private PictureDAO pictureDao;
//	@Autowired
//	private ShoppingDAO shoppingDao;
//	@Autowired
//	private AccomDAO accomDao;
//	
//	@Autowired
//	private MessageDAO messageDao;
//	
//	@Autowired
//	private LanTripReplyDAO l_replyDao;
//
//	
//	// 남이 보는 내 프로필
//	@RequestMapping(value = "/other_profile.do")
//	public String other_profile(HttpServletRequest request) {
//		
//		UserTO to = new UserTO();
//		
//		to.setNick(request.getParameter("other_nick"));
//		to = userDao.OtherProfile(to);
//		
//		System.out.println(to);
//		
//		request.setAttribute("to", to);
//		
//		return "other_profile/other_profile";
//	}
//	
//	// 메세지 목록 가져오기
//	@RequestMapping(value = "/message_content_list_inprofile.do")
//	public String message_content_list_inprofile(HttpServletRequest request, HttpSession session) {
//
//		//int room = Integer.parseInt(request.getParameter("room"));
//		String other_nick = request.getParameter("other_nick");
//
//		MessageTO to = new MessageTO();
//		to.setRecv_nick(other_nick);
//		to.setNick((String) session.getAttribute("nick"));
//
//		// 메세지 내용을 가져온다.
//		ArrayList<MessageTO> clist = messageDao.roomContentList(to);
//
//		request.setAttribute("clist", clist);
//		
//		System.out.println(clist);
//
//		return "message/message_content_list";
//	}
//
//	// 메세지 리스트에서 메세지 보내기
//	@ResponseBody
//	@RequestMapping(value = "/message_send_inlist_inprofile.do")
//	public int message_send_inlist_inprofile(@RequestParam String other_nick, @RequestParam String content, HttpSession session) {
//		System.out.println("컨트롤러 들어옴");
//		System.out.println("other_nick: " + other_nick);
//		System.out.println("content: " + content);
//		
//		MessageTO to = new MessageTO();
//		to.setSend_nick((String) session.getAttribute("nick"));
//		to.setRecv_nick(other_nick);
//		to.setContent(content);
//
//		int flag = messageDao.messageSendInlist(to);
//
//		return flag;
//	}
//	
//	// 랜선여행하기 리스트 
//	@RequestMapping(value = "/ajax_lantrip_page.do")
//	public String ajax_lantrip_page(HttpServletRequest request, HttpSession session) {
//		// 한 페이지에 몇개씩 표시할 것인지
//		final int PAGE_ROW_COUNT = 12;
//
//		// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
//		int pageNum = 1;
//		// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
//		String strPageNum = request.getParameter("pageNum");
//		// 만일 페이지 번호가 파라미터로 넘어 온다면
//		if (strPageNum != null) {
//			// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
//			pageNum = Integer.parseInt(strPageNum);
//		}
//
//		// 보여줄 페이지의 시작 ROWNUM - 0부터 시작
//		int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
//		// 보여줄 페이지의 끝 ROWNUM
//		int endRowNum = pageNum * PAGE_ROW_COUNT;
//
//		int rowCount = PAGE_ROW_COUNT;
//		
//
//		// startRowNum 과 rowCount 를 PictureTO 객체에 담고
//		LanTripTO lto = new LanTripTO();
//		lto.setWriter(request.getParameter("other_nick"));
//		lto.setStartRowNum(startRowNum);
//		lto.setEndRowNum(endRowNum);
//		lto.setRowCount(rowCount);
//
//		// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
//		ArrayList<LanTripTO> list = null;
//		// 전체 row의 개수를 담을 지역변수를 미리 만든다.
//		int totalRow = 0;
//
//
//		if (session.getAttribute("nick") == null) {
//			// 로그인 상태가 아닐때
//			System.out.println("로그인 상태가 아닐때 ");
//			// 사진 자랑 게시판 목록 가져오기
//
//			list = lantripDao.boardList(lto);
//		} else {
//			// 로그인 상태일때
//			System.out.println("로그인 상태일때 ");
//
//			// 현재사용자의 nick을 세팅
//			lto.setNick((String) session.getAttribute("nick"));
//
//			// 사진자랑 게시판 목록 가져오기
//			//list = lantripDao.boardListLogin(lto);
//
//		}
//
//		// 글의 개수
//		//totalRow = lantripDao.LantripCount(lto);
//
//		// 전체 페이지의 갯수 구하기
//		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
//
//		request.setAttribute("list", list);
//		request.setAttribute("totalPageCount", totalPageCount);
//		request.setAttribute("totalRow", totalRow);
//		// pageNum 도 추가로 담아주기
//		request.setAttribute("pageNum", pageNum);
//
//		/////////////////////////////////////////////////////// 여기까지 picture_list와 동일
//		/////////////////////////////////////////////////////// ajax_page는 스크롤을 내릴때 추가되는
//		/////////////////////////////////////////////////////// 게시물들을 가져오기 떄문에
//		/////////////////////////////////////////////////////// best5를 가져갈 필요가 없다.
//
//		return "other_profile/ajax_lantrip_page";
//	}
//		
//	
//	
//
//}
