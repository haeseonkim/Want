package com.exam.controller;

import java.io.IOException;
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

import com.exam.model1.lantripApply.LanTripApplyDAO;
import com.exam.model1.lantripApply.LanTripApplyListTO;
import com.exam.model1.lantripApply.LanTripApplyTO;
import com.exam.model1.lantripApplyReply.LaReplyDAO;
import com.exam.model1.lantripApplyReply.LaReplyTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class LantripApplyController {

	
	@Autowired
	private LanTripApplyDAO dao;
	
	@Autowired
	private LaReplyDAO laReplyDao;
 
	//private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\lanTrip_apply";
	//private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\lanTrip_apply";
	//private String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/lanTrip_apply";
	//private String uploadPath = "C:\\KICKIC\\Want\\Want\\src\\main\\webapp\\upload\\lanTrip_apply";
	
	//리눅스 경로
	private String uploadPath = "/home/want/apache-tomcat-9.0.44/webapps/Want/upload/lanTrip_apply";
	
  
	// 랜선여행 신청 목록					
	@RequestMapping(value = "/lanTrip_apply_list.do")
	public String list(HttpServletRequest request, Model model) {
		try {
			request.setCharacterEncoding("utf-8");
			LanTripApplyListTO listTO = new LanTripApplyListTO();
			listTO.setCpage(Integer
					.parseInt(request.getParameter("cpage") == null 
					|| request.getParameter("cpage").equals("") ? "1" : request.getParameter("cpage")));
			listTO = dao.boardList(listTO);

			model.addAttribute("listTO", listTO);

		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "lanTrip_apply/lanTrip_apply_list";
	}

	// 검색 결과
	@RequestMapping(value = "/la_ajax_page.do")
	public String la_ajax_page(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
			
//			System.out.println("컨트롤러 넘어옴");
//
//			System.out.println("condition: " + request.getParameter("condition"));
//			System.out.println("keyword: " + request.getParameter("keyword"));
			
			// 검색결과를 담아올 to
			LanTripApplyListTO listTO = new LanTripApplyListTO();
			LanTripApplyTO to = new LanTripApplyTO();
			
			// 전체 row의 개수를 담을 지역변수를 미리 만든다. - 검색조건이 들어올 경우 '검색 결과 갯수'가 된다.
			int totalRow = 0;
			
			//검색 키워드 관련된 처리 - 검색 키워드가 파라미터로 넘어올 수도 있고 안넘어올 수도 있다.
			String keyword = request.getParameter("keyword");
			String condition = request.getParameter("condition");
			
//			System.out.println("condition: " + condition);
//			System.out.println("keyword: " + keyword);
			
			listTO.setCpage(Integer
					.parseInt(request.getParameter("cpage") == null || request.getParameter("cpage").equals("") ? "1"
							: request.getParameter("cpage")));
			listTO = dao.boardList(listTO);

			
			if (condition.equals("subject")) { // 제목 검색인 경우
				// 검색 키워드를 PictureTO에 담아서 전달한다.
				to.setSubject(keyword);
			} else if (condition.equals("content")) { // 내용 검색인 경우
				to.setContent(keyword);
			} else if (condition.equals("writer")) { // 작성자 검색인 경우
				to.setWriter(keyword);
			} else if (condition.equals("location")) {	// 위치 검색인 경우
				to.setLocation(keyword);
			} // 다른검색 조건을 추가하고 싶다면 아래 else if()를 계속 추가하면 된다.
			
			// 검색 결과를 담아오는 배열
			ArrayList<LanTripApplyTO> lists = dao.searchList(to);
			
			// 검색결과(lists)를 페이징 to (listTO)에 담는 과정
			listTO.setBoardList(lists);
			
			// 검색결과 세팅
			request.setAttribute("listTO", listTO);
			
			
			totalRow = dao.laCount(to);
			
			request.setAttribute("totalRow", totalRow);
			request.setAttribute("keyword", keyword);
			request.setAttribute("condition", condition);

		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "lanTrip_apply/lanTrip_apply_list";
	}
	
	// lanTrip_apply_write
	@RequestMapping(value = "/lanTrip_apply_write.do")
	public String lanTrip_apply_write(HttpServletRequest request, Model model) {
		try {
			request.setCharacterEncoding("utf-8");

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "lanTrip_apply/lanTrip_apply_write";
	}

	// lanTrip_apply_write_ok
	@RequestMapping(value = "/lanTrip_apply_write_ok.do")
	public String lanTrip_Apply_write_ok(HttpServletRequest request) {

		int maxFileSize = 2048 * 2048 * 6;
		String encType = "utf-8";

		MultipartRequest multi = null;

		try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType,
					new DefaultFileRenamePolicy());

			LanTripApplyTO to = new LanTripApplyTO();
			to.setSubject(multi.getParameter("subject"));
			to.setLocation(multi.getParameter("location"));
			to.setWriter(multi.getParameter("writer"));
			to.setContent(multi.getParameter("content"));
			to.setPicture(multi.getFilesystemName("picture"));

			int flag = dao.lanTripApplyWriteOk(to);

			request.setAttribute("flag", flag);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "lanTrip_apply/lanTrip_apply_write_ok";
	}

	// lanTrip_apply_view
	@RequestMapping(value = "/lanTrip_apply_view.do")
	public String lanTrip_apply_view(HttpServletRequest request) {

		String no = request.getParameter("no");
		LanTripApplyTO to = new LanTripApplyTO();

		to.setNo(request.getParameter("no"));

		to = dao.lanTrip_apply_View(to);

		request.setAttribute("to", to);

		return "lanTrip_apply/lanTrip_apply_view";
	}

	// lanTrip_apply_delete_ok
	@RequestMapping(value = "/lanTrip_apply_delete_ok.do")
	public String lanTrip_apply_delete(HttpServletRequest request) {

		String no = request.getParameter("no");
		LanTripApplyTO to = new LanTripApplyTO();

		to.setNo(request.getParameter("no"));

		int flag = dao.lanTrip_apply_delete_ok(to);

		request.setAttribute("flag", flag);

		return "lanTrip_apply/lanTrip_apply_delete_ok";
	}

	// lanTrip_apply_modify
	@RequestMapping(value = "/lanTrip_apply_modify.do")
	public String lanTrip_apply_modify(HttpServletRequest request) {
		
		LanTripApplyTO to = new LanTripApplyTO();

		to.setNo(request.getParameter("no"));

		to = dao.lanTrip_apply_modify(to);

		request.setAttribute("to", to);

		return "lanTrip_apply/lanTrip_apply_modify";
	}
	
	// lanTrip_apply_modify_ok
	@RequestMapping(value = "/lanTrip_apply_modify_ok.do")
	public String lanTrip_apply_modify_ok(HttpServletRequest request) {

		
		int maxFileSize = 2048 * 2048 * 6;
		String encType = "utf-8";

		MultipartRequest multi = null;

		try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType,
					new DefaultFileRenamePolicy());

			String cpage = multi.getParameter("cpage");
			
			LanTripApplyTO to = new LanTripApplyTO();
			to.setNo(multi.getParameter("no"));
			to.setSubject(multi.getParameter("subject"));
			to.setLocation(multi.getParameter("location"));
			to.setWriter(multi.getParameter("writer"));
			to.setContent(multi.getParameter("content"));
			
			if( multi.getFilesystemName( "picture" ) == null ) {
				to.setPicture(multi.getParameter( "ex-picture" ) );
			} else {
				to.setPicture(multi.getFilesystemName( "picture" ) );
			}

			int flag = dao.lanTrip_apply_modify_ok(to);

			request.setAttribute("flag", flag);
			request.setAttribute("cpage", cpage);
			request.setAttribute("no", to.getNo());

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "lanTrip_apply/lanTrip_apply_modify_ok";
	}
	
	// 모댓글 작성
	@ResponseBody
	@RequestMapping(value = "/la_write_reply.do")
	public LanTripApplyTO write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session) {

		LaReplyTO to = new LaReplyTO();
		// 게시물 번호 세팅
		to.setBno(bno);
		
		// 댓글 내용 세팅
		to.setContent(content);

		// 댓글작성자 nick을 writer로 세팅
		to.setWriter((String) session.getAttribute("nick"));
		
		//	값이 잘 넘어오는지 확인
		/*
		  System.out.println("controller bno: " + to.getBno());
		  System.out.println("controller content: " + to.getContent());
		  System.out.println("controller writer: " + to.getWriter());
		 */
		// +1된 댓글 갯수를 담아오기 위함
		LanTripApplyTO lato = laReplyDao.LaWriteReply(to);

		return lato;
	}

	// 답글 작성
	@ResponseBody
	@RequestMapping(value = "/la_write_rereply.do")
	public LanTripApplyTO write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content,
			HttpSession session) {

		LaReplyTO to = new LaReplyTO();

		// 게시물 번호 세팅
		to.setBno(bno);
		
		// grp, grps, grpl 은 ReplyTO에 int로 정의되어 있기 때문에 String인 no를 int로 변환해서 넣어준다.
		// 모댓글 번호 no를 grp으로 세팅한다.
		to.setGrp(Integer.parseInt(no));

		// 답글은 깊이가 1이되어야 하므로 grpl을 1로 세팅한다.
		to.setGrpl(1);

		// 답글 내용 세팅
		to.setContent(content);

		// 답글작성자 nick을 writer로 세팅
		to.setWriter((String) session.getAttribute("nick"));

		// +1된 댓글 갯수를 담아오기 위함
		LanTripApplyTO lato = laReplyDao.LaWriteReReply(to);

		return lato;
	}

	// 댓글 리스트
	@ResponseBody
	@RequestMapping(value = "/la_replyList.do")
	public ArrayList<LaReplyTO> reply_list(@RequestParam String no, HttpSession session) {

		LaReplyTO to = new LaReplyTO();

		// 가져올 댓글 리스트의 게시물번호를 세팅
		to.setBno(no);

		ArrayList<LaReplyTO> replyList = new ArrayList();

		replyList = laReplyDao.replyList(to);

		return replyList;
	}

	// 모댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/la_delete_reply.do")
	public LanTripApplyTO delete_reply(@RequestParam String no, @RequestParam String bno) {

		LaReplyTO to = new LaReplyTO();

		// 모댓글 번호 세팅
		to.setNo(no);
//		System.out.println("컨트롤러 모댓글 no : "+no);
		// 게시물 번호 세팅
		to.setBno(bno);

		// 갱신된 댓글 갯수를 담아오기 위함
		LanTripApplyTO lato = laReplyDao.la_DeleteReply(to);

		return lato;
	}

	// 답글 삭제
	@ResponseBody
	@RequestMapping(value = "/la_delete_rereply.do")
	public LanTripApplyTO delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam int grp) {

		LaReplyTO to = new LaReplyTO();

		// 답글 번호 세팅 - 답글 삭제하기 위해서 필요함
		to.setNo(no);
//		System.out.println("컨트롤러 답글 no : "+no);
		// 게시물 번호 세팅 - p_board 의 reply+1하기 위해 필요함
		to.setBno(bno);

		// grp 세팅(모댓글이 뭔지) - 모댓글은 삭제를 해도 답글이 있으면 남아있게 되는데 답글이 모두 삭제되었을 때 모댓글도 삭제하기 위해
		// 필요함
		to.setGrp(grp);

		// 갱신된 댓글 갯수를 담아오기 위함
		LanTripApplyTO lato = laReplyDao.la_DeleteReReply(to);

		return lato;
	}

}