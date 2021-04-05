package com.exam.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.model1.picture.PictureDAO;
import com.exam.model1.picture.PictureListTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.pictureHeart.PictureHeartDAO;
import com.exam.model1.pictureHeart.PictureHeartTO;
import com.exam.model1.pictureReply.ReplyDAO;
import com.exam.model1.pictureReply.ReplyTO;
import com.exam.model1.user.UserTO;
import com.oreilly.servlet.MultipartRequest;

import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Handles requests for the application home page.
 */
@Controller
public class PictureController {

	@Autowired
	private PictureDAO pictureDao;

	@Autowired
	private PictureHeartDAO heartDao;

	@Autowired
	private ReplyDAO replyDao;


	// 각자 맞는 upload 폴더 경로로 변경
   private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\picture";
   //private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\picture";
   //private String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/picture";
  
	// 사진자랑 목록
	@RequestMapping(value = "/picture_list.do")
	public String picture_list(HttpServletRequest request, HttpSession session) {
		// 한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT = 12;

		// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum = 1;
		// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum = request.getParameter("pageNum");
		// 만일 페이지 번호가 파라미터로 넘어 온다면
		if (strPageNum != null) {
			// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum = Integer.parseInt(strPageNum);
		}

		// 보여줄 페이지의 시작 ROWNUM - 0부터 시작
		int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
		// 보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		int rowCount = PAGE_ROW_COUNT;

		/*
		 * 검색 키워드 관련된 처리 - 검색 키워드가 파라미터로 넘어올 수도 있고 안넘어올 수도 있다.
		 */
		String keyword = request.getParameter("keyword");
		String condition = request.getParameter("condition");
		// 만일 키워드가 넘어오지 않는다면
		if (keyword == null) {
			// 키워드와 검색 조건에 빈 문자열을 넣어준다.
			keyword = "";
			condition = "";
		}
		// 특수기호를 인코딩한 키워드를 미리 준비한다.
		String encodedK = URLEncoder.encode(keyword);

		// startRowNum 과 rowCount 를  PictureTO 객체에 담는다.
		PictureTO pto = new PictureTO();
		pto.setStartRowNum(startRowNum);
		pto.setEndRowNum(endRowNum);
		pto.setRowCount(rowCount);

		// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		ArrayList<PictureTO> list = null;
		// 전체 row의 개수를 담을 지역변수를 미리 만든다. - 검색조건이 들어올 경우 '검색 결과 갯수'가 된다.
		int totalRow = 0;

		// 만일 검색 키워드가 넘어온다면
		if (!keyword.equals("")) { // 검색 조건이 무엇이냐에 따라 분기하기
			if (condition.equals("subject")) { // 제목 검색인 경우
				// 검색 키워드를 PictureTO에 담아서 전달한다.
				pto.setSubject(keyword);
			} else if (condition.equals("content")) { // 내용 검색인 경우
				pto.setContent(keyword);
			} else if (condition.equals("writer")) { // 작성자 검색인 경우
				pto.setWriter(keyword);
			} else if (condition.equals("location")) {	// 위치 검색인 경우
				pto.setLocation(keyword);
			} // 다른검색 조건을 추가하고 싶다면 아래 else if()를 계속 추가하면 된다.
		}

		// 위의 분기에 따라 pto에 담기는 내용이 다르고
		// 그 내용을 기준으로 조건이 다를때마다 다른 내용이 select 되도록 dynamic query를 구성한다.
		// 글 목록 얻어오기

		if (session.getAttribute("nick") == null) {
			// 로그인 상태가 아닐때
//			System.out.println("로그인 상태가 아닐때 ");
			// 사진 자랑 게시판 목록 가져오기

			list = pictureDao.boardList(pto);
		} else {
			// 로그인 상태일때
//			System.out.println("로그인 상태일때 ");

			// 현재사용자의 nick을 세팅
			pto.setNick((String) session.getAttribute("nick"));

			// 사진자랑 게시판 목록 가져오기
			list = pictureDao.boardListLogin(pto);

		}

		// 글의 개수
		totalRow = pictureDao.PictureCount(pto);

		// 전체 페이지의 갯수 구하기
		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

		request.setAttribute("list", list);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("totalRow", totalRow);
		// pageNum 도 추가로 담아주기
		request.setAttribute("pageNum", pageNum);

		/////////////////////////////////////////////////////// 여기까지 picture_ajax_page와 동일
		/////////////////////////////////////////////////////// ajax_page는 스크롤을 내릴때 추가되는 게시물들을 가져오기 떄문에 
		/////////////////////////////////////////////////////// best5를 가져갈 필요가 없다. 

		// 사진자랑 좋아요(heart)순으로 상위5개 가져오기
		ArrayList<PictureTO> bestList = new ArrayList();
		bestList = pictureDao.bestList(pto);

		request.setAttribute("bestList", bestList);

		return "picture/picture_list";
	}

	
	// 사진자랑 목록 - 로딩으로 불러오는 게시물 리스트
	@RequestMapping(value = "/ajax_page.do")
	public String picture_ajax_page(HttpServletRequest request, HttpSession session) {
		// 한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT = 12;

		// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum = 1;
		// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum = request.getParameter("pageNum");
		// 만일 페이지 번호가 파라미터로 넘어 온다면
		if (strPageNum != null) {
			// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum = Integer.parseInt(strPageNum);
		}

		// 보여줄 페이지의 시작 ROWNUM - 0부터 시작
		int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
		// 보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		int rowCount = PAGE_ROW_COUNT;

		/*
		 * 검색 키워드 관련된 처리 -검색 키워드가 파라미터로 넘어올 수도 있고 안넘어올 수도 있다.
		 */
		String keyword = request.getParameter("keyword");
		String condition = request.getParameter("condition");
		// 만일 키워드가 넘어오지 않는다면
		if (keyword == null) {
			// 키워드와 검색 조건에 빈 문자열을 넣어준다.
			keyword = "";
			condition = "";
		}
		// 특수기호를 인코딩한 키워드를 미리 준비한다.
		String encodedK = URLEncoder.encode(keyword);

		// startRowNum 과 rowCount 를  PictureTO 객체에 담고
		PictureTO pto = new PictureTO();
		pto.setStartRowNum(startRowNum);
		pto.setEndRowNum(endRowNum);
		pto.setRowCount(rowCount);

		// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		ArrayList<PictureTO> list = null;
		// 전체 row의 개수를 담을 지역변수를 미리 만든다.
		int totalRow = 0;

		// 만일 검색 키워드가 넘어온다면
		if (!keyword.equals("")) { // 검색 조건이 무엇이냐에 따라 분기하기
			if (condition.equals("subject")) { // 제목 검색인 경우
				// 검색 키워드를 PictureTO에 담아서 전달한다.
				pto.setSubject(keyword);
			} else if (condition.equals("content")) { // 내용 검색인 경우
				pto.setContent(keyword);
			} else if (condition.equals("writer")) { // 작성자 검색인 경우
				pto.setWriter(keyword);
			} else if (condition.equals("location")) {	// 위치 검색인 경우
				pto.setLocation(keyword);
			} // 다른검색 조건을 추가하고 싶다면 아래 else if()를 계속 추가하면 된다.
		}

		// 위의 분기에 따라 pto에 담기는 내용이 다르고
		// 그 내용을 기준으로 조건이 다를때마다 다른 내용이 select 되도록 dynamic query를 구성한다.
		// 글 목록 얻어오기

		if (session.getAttribute("nick") == null) {
			// 로그인 상태가 아닐때
			System.out.println("로그인 상태가 아닐때 ");
			// 사진 자랑 게시판 목록 가져오기

			list = pictureDao.boardList(pto);
		} else {
			// 로그인 상태일때
			System.out.println("로그인 상태일때 ");

			// 현재사용자의 nick을 세팅
			pto.setNick((String) session.getAttribute("nick"));

			// 사진자랑 게시판 목록 가져오기
			list = pictureDao.boardListLogin(pto);

		}

		// 글의 개수
		totalRow = pictureDao.PictureCount(pto);

		// 전체 페이지의 갯수 구하기
		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

		request.setAttribute("list", list);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("totalRow", totalRow);
		// pageNum 도 추가로 담아주기
		request.setAttribute("pageNum", pageNum);
		
		/////////////////////////////////////////////////////// 여기까지 picture_list와 동일
		/////////////////////////////////////////////////////// ajax_page는 스크롤을 내릴때 추가되는 게시물들을 가져오기 떄문에 
		/////////////////////////////////////////////////////// best5를 가져갈 필요가 없다. 

		return "picture/ajax_page";
	}

	// 사진자랑 글쓰기 form
	@RequestMapping(value = "/picture_write.do")
	public String picture_write(HttpServletRequest request, Model model) {
		try {
			request.setCharacterEncoding("utf-8");

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "picture/picture_write";
	}

	// 사진자랑 글쓰기 ok
	@RequestMapping(value = "/picture_write_ok.do")
	public String write_ok(HttpServletRequest request) {

		int maxFileSize = 2048 * 2048 * 6;
		String encType = "utf-8";

		MultipartRequest multi = null;

		try {
      
   String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\picture";
   //String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\picture";
   //String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/picture";
      
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());

			PictureTO to = new PictureTO();
			to.setSubject(multi.getParameter("subject"));
			to.setLocation(multi.getParameter("location"));
			to.setWriter(multi.getParameter("writer"));
			to.setContent(multi.getParameter("content"));
			to.setMedia(multi.getFilesystemName("media"));

			int flag = pictureDao.pictureWriteOk(to);

			request.setAttribute("flag", flag);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "picture/picture_write_ok";
	}

	// view
	@ResponseBody
	@RequestMapping(value = "/picture_view.do")
	public PictureTO view(@RequestParam String no, HttpSession session) {

		PictureTO to = new PictureTO();
		to.setNo(no);

		// 현재 사용자 nick 세팅
		to.setNick((String) session.getAttribute("nick"));

		to = pictureDao.boardView(to);

		// 현재 사용자 nick 다시 세팅
		to.setNick((String) session.getAttribute("nick"));

		return to;
	}

	// 빈하트 클릭시 하트 저장
	@ResponseBody
	@RequestMapping(value = "/saveHeart.do")
	public PictureTO save_heart(@RequestParam String no, HttpSession session) {

		PictureHeartTO to = new PictureHeartTO();

		// 게시물 번호 세팅
		to.setBno(no);

		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String) session.getAttribute("nick"));

		// +1된 하트 갯수를 담아오기위함
		PictureTO pto = heartDao.pictureSaveHeart(to);

		return pto;
	}

	// 꽉찬하트 클릭시 하트 해제
	@ResponseBody
	@RequestMapping(value = "/removeHeart.do")
	public PictureTO remove_heart(@RequestParam String no, HttpSession session) {
		PictureHeartTO to = new PictureHeartTO();

		// 게시물 번호 세팅
		to.setBno(no);

		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String) session.getAttribute("nick"));

		// -1된 하트 갯수를 담아오기위함
		PictureTO pto = heartDao.pictureRemoveHeart(to);

		return pto;
	}

	// 모댓글 작성
	@ResponseBody
	@RequestMapping(value = "/picture_write_reply.do")
	public PictureTO write_reply(@RequestParam String no, @RequestParam String content, HttpSession session) {

		ReplyTO to = new ReplyTO();

		// 게시물 번호 세팅
		to.setBno(no);

		// 댓글 내용 세팅
		to.setContent(content);

		// 댓글작성자 nick을 writer로 세팅
		to.setWriter((String) session.getAttribute("nick"));

		// +1된 댓글 갯수를 담아오기 위함
		PictureTO pto = replyDao.pictureWriteReply(to);
//
		return pto;
	}

	// 답글 작성
	@ResponseBody
	@RequestMapping(value = "/picture_write_rereply.do")
	public PictureTO write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content,
			HttpSession session) {

		ReplyTO to = new ReplyTO();

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
		PictureTO pto = replyDao.pictureWriteReReply(to);

		return pto;
	}

	// 댓글 리스트
	@ResponseBody
	@RequestMapping(value = "/picture_replyList.do")
	public ArrayList<ReplyTO> reply_list(@RequestParam String no, HttpSession session) {

		ReplyTO to = new ReplyTO();

		// 가져올 댓글 리스트의 게시물번호를 세팅
		to.setBno(no);

		ArrayList<ReplyTO> replyList = new ArrayList();

		replyList = replyDao.replyList(to);

		return replyList;
	}

	// 모댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/picture_delete_reply.do")
	public PictureTO delete_reply(@RequestParam String no, @RequestParam String bno) {

		ReplyTO to = new ReplyTO();

		// 모댓글 번호 세팅
		to.setNo(no);

		// 게시물 번호 세팅
		to.setBno(bno);

		// 갱신된 댓글 갯수를 담아오기 위함
		PictureTO pto = replyDao.pictureDeleteReply(to);

		return pto;
	}

	// 답글 삭제
	@ResponseBody
	@RequestMapping(value = "/picture_delete_rereply.do")
	public PictureTO delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam int grp) {

		ReplyTO to = new ReplyTO();

		// 답글 번호 세팅 - 답글 삭제하기 위해서 필요함
		to.setNo(no);

		// 게시물 번호 세팅 - p_board 의 reply+1하기 위해 필요함
		to.setBno(bno);

		// grp 세팅(모댓글이 뭔지) - 모댓글은 삭제를 해도 답글이 있으면 남아있게 되는데 답글이 모두 삭제되었을 때 모댓글도 삭제하기 위해
		// 필요함
		to.setGrp(grp);

		// 갱신된 댓글 갯수를 담아오기 위함
		PictureTO pto = replyDao.pictureDeleteReReply(to);

		return pto;
	}

	// modify
	@RequestMapping(value = "/picture_modify.do")
	public String modify(@RequestParam String no, HttpSession session, HttpServletRequest request) {

		PictureTO to = new PictureTO();
		to.setNo(no);

		// 현재 사용자 nick 세팅
		to.setNick((String) session.getAttribute("nick"));

		to = pictureDao.pictureModify(to);

		// 현재 사용자 nick 다시 세팅
		to.setNick((String) session.getAttribute("nick"));

		request.setAttribute("to", to);

		return "picture/picture_modify";
	}

	// modify ok
	@RequestMapping(value = "/picture_modify_ok.do")
	public String modify_ok(HttpServletRequest request) {

		int maxFileSize = 2048 * 2048 * 6;
		String encType = "utf-8";

		MultipartRequest multi = null;

		try {
      
   String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\picture";
   //String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\picture";
   //String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/picture";
      
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());

			PictureTO to = new PictureTO();
			to.setNo(multi.getParameter("no"));
			to.setSubject(multi.getParameter("subject"));
			to.setLocation(multi.getParameter("location"));
			// to.setWriter(multi.getParameter("writer"));
			to.setContent(multi.getParameter("content"));

			String media = "";
			if (multi.getFilesystemName("media") == null) { // 파일 수정안했을 때
				media = multi.getParameter("ex-media");
			} else {
				media = multi.getFilesystemName("media");
			}
			to.setMedia(media);

			int flag = pictureDao.pictureModifyOk(to);

			request.setAttribute("flag", flag);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "picture/picture_modify_ok";
	}

	// delete ok
	@ResponseBody
	@RequestMapping(value = "/picture_delete_ok.do")
	public int delete_ok(@RequestParam String no) {

		int flag = pictureDao.pictureDeleteOk(no);

		return flag;
	}

}
