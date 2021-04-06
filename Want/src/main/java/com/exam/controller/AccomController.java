package com.exam.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;


import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.exam.model1.accom.AccomDAO;
import com.exam.model1.accom.AccomListTO;
import com.exam.model1.accom.AccomTO;
import com.exam.model1.accomComment.AccomCommentDAO;
import com.exam.model1.accomComment.AccomCommentTO;
import com.exam.model1.accomHeart.AccomHeartDAO;
import com.exam.model1.accomHeart.AccomHeartTO;
import com.exam.model1.shopping.ShoppingTO;


@Controller
public class AccomController {
	
	@Autowired
	private AccomDAO accomDao;
	
	@Autowired
	private AccomHeartDAO heartDao;
	
	@Autowired
	private AccomCommentDAO accomCommentDao;

	// 숙소정보 글쓰기
	@RequestMapping(value = "/accom_write.do")
	public String accom_write(HttpServletRequest request, Model model ) {
		try {
			request.setCharacterEncoding("utf-8");
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "accom/accom_write";
	}

	// 숙소정보 글쓰기 Ok
	@RequestMapping(value = "/accom_write_ok.do")
	public String accom_write_ok(HttpServletRequest request, HttpServletResponse response) {
		
		int maxFileSize = 1024 * 1024 * 6;
		String encType = "utf-8";
      

		//String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\accom";
		//String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\accom";
		String uploadPath = "/Users/hyukjun/git/Want/Want/src/main/webapp/upload/accom";
    
		MultipartRequest multi = null;

		try {
			request.setCharacterEncoding("utf-8");
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
			String writer = multi.getParameter("writer");
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String location = multi.getParameter("location");
			String picture = multi.getFilesystemName("picture");
			File file = multi.getFile("profile");

			AccomTO to = new AccomTO();
			to.setWriter(writer);
			to.setSubject(subject);
			to.setContent(content);
			to.setLocation(location);
			to.setPicture(picture);

			int flag = accomDao.accom_write_ok(to);

			request.setAttribute("flag", flag);
			request.setAttribute("location", location );

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_write_ok";
	}

	// 숙소 list
	@RequestMapping(value = "/accom_list.do")
	public String accom_list(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		try {
			//한글 데이터가 넘어올 경우 인코딩해주기
			request.setCharacterEncoding("utf-8");
			String location = request.getParameter("location");
			String nick = (String)session.getAttribute( "nick" );
			
			
			// 한 페이지에 몇개씩 표시할 것인지
			final int PAGE_ROW_COUNT = 8;

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

			// startRowNum 과 rowCount 를  PictureTO 객체에 담는다.
			AccomTO ato = new AccomTO();
			ato.setStartRowNum(startRowNum);
			ato.setEndRowNum(endRowNum);
			ato.setRowCount(rowCount);
			
			//사용자가 국가선택페이지에서 선택한 국가 관련 글만 나오도록 location설정
			ato.setLocation(location);
			
			
			// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			ArrayList<AccomTO> list = null;
			// 전체 row의 개수를 담을 지역변수를 미리 만든다. - 검색조건이 들어올 경우 '검색 결과 갯수'가 된다.
			int totalRow = 0;

			// 만일 검색 키워드가 넘어온다면
			if (!keyword.equals("")) { // 검색 조건이 무엇이냐에 따라 분기하기
				if (condition.equals("subject")) { // 제목 검색인 경우
					// 검색 키워드를 PictureTO에 담아서 전달한다.
					ato.setSubject(keyword);
				} else if (condition.equals("content")) { // 내용 검색인 경우
					ato.setContent(keyword);
				} else if (condition.equals("writer")) { // 작성자 검색인 경우
					ato.setWriter(keyword);
				} // 다른검색 조건을 추가하고 싶다면 아래 else if()를 계속 추가하면 된다.
			}

			// 위의 분기에 따라 pto에 담기는 내용이 다르고
			// 그 내용을 기준으로 조건이 다를때마다 다른 내용이 select 되도록 dynamic query를 구성한다.
			
			//로그인아닐 때
			if( nick == null ) {
				list = accomDao.accomList(ato);
			} else {	//로그인일 때
				ato.setNick( nick );
				list = accomDao.accomListLogin(ato);
			}
			
			// 글의 개수
			totalRow = accomDao.accomCount(ato);

			// 전체 페이지의 갯수 구하기
			int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

			request.setAttribute("list", list);
			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("condition", condition);
			request.setAttribute("keyword", keyword);
			request.setAttribute("totalRow", totalRow);
			// pageNum 도 추가로 담아주기
			request.setAttribute("pageNum", pageNum);
			
			//국가이름 넘겨주기
			request.setAttribute( "location", location );

			request.setAttribute("list", list);
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_list";
	}
	
	// 숙소 list - 로딩으로 불러오는 게시물 리스트
	@RequestMapping(value = "/accom_ajax_page.do")
	public String accom_ajax_page(HttpServletRequest request, HttpSession session) {
		try {
			//한글 데이터가 넘어올 경우 인코딩해주기
			request.setCharacterEncoding("utf-8");
			String location = request.getParameter("location");
			
			// 한 페이지에 몇개씩 표시할 것인지
			final int PAGE_ROW_COUNT = 8;

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

			// startRowNum 과 rowCount 를  PictureTO 객체에 담고
			AccomTO ato = new AccomTO();
			ato.setStartRowNum(startRowNum);
			ato.setEndRowNum(endRowNum);
			ato.setRowCount(rowCount);
			
			//사용자가 국가선택페이지에서 선택한 국가 관련 글만 나오도록 location설정
			ato.setLocation(location);

			// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			ArrayList<AccomTO> list = null;
			// 전체 row의 개수를 담을 지역변수를 미리 만든다.
			int totalRow = 0;

			// 만일 검색 키워드가 넘어온다면
			if (!keyword.equals("")) { // 검색 조건이 무엇이냐에 따라 분기하기
				if (condition.equals("subject")) { // 제목 검색인 경우
					// 검색 키워드를 PictureTO에 담아서 전달한다.
					ato.setSubject(keyword);
				} else if (condition.equals("content")) { // 내용 검색인 경우
					ato.setContent(keyword);
				} else if (condition.equals("writer")) { // 작성자 검색인 경우
					ato.setWriter(keyword);
				} // 다른검색 조건을 추가하고 싶다면 아래 else if()를 계속 추가하면 된다.
			}

			// 위의 분기에 따라 pto에 담기는 내용이 다르고
			// 그 내용을 기준으로 조건이 다를때마다 다른 내용이 select 되도록 dynamic query를 구성한다.
			// 글 목록 얻어오기
			if (session.getAttribute("nick") == null) {
				// 로그인 상태가 아닐때
//				System.out.println("로그인 상태가 아닐때 ");
				// 사진 자랑 게시판 목록 가져오기

				list = accomDao.accomList(ato);
			} else {
				// 로그인 상태일때
//				System.out.println("로그인 상태일때 ");

				// 현재사용자의 nick을 세팅
				ato.setNick((String) session.getAttribute("nick"));

				// 사진자랑 게시판 목록 가져오기
				list = accomDao.accomListLogin(ato);

			}

			// 글의 개수
			totalRow = accomDao.accomCount(ato);

			// 전체 페이지의 갯수 구하기
			int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

			request.setAttribute("list", list);
			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("condition", condition);
			request.setAttribute("keyword", keyword);
			request.setAttribute("totalRow", totalRow);
			// pageNum 도 추가로 담아주기
			request.setAttribute("pageNum", pageNum);
			
			//국가 이름 넘겨주기
			request.setAttribute( "location", location );
			
			/////////////////////////////////////////////////////// 여기까지 picture_list와 동일
			/////////////////////////////////////////////////////// ajax_page는 스크롤을 내릴때 추가되는 게시물들을 가져오기 떄문에 
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_ajax_page";
	}
	
	// 빈하트 클릭시 하트 저장
	@ResponseBody
	@RequestMapping(value = "/accom_saveHeart.do")
	public AccomTO save_heart(@RequestParam String no, HttpSession session) {
		
		AccomHeartTO to = new AccomHeartTO();
		
		// 게시물 번호 세팅
		to.setBno(no);
		
		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String)session.getAttribute("nick"));
		
		AccomTO ato = heartDao.accomSaveHeart(to);
	
		return ato;
	}
	
	// 꽉찬하트 클릭시 하트 해제
	@ResponseBody
	@RequestMapping(value = "/accom_removeHeart.do")
	public AccomTO remove_heart(@RequestParam String no, HttpSession session) {
		AccomHeartTO to = new AccomHeartTO();
		
		// 게시물 번호 세팅
		to.setBno(no);
		
		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String)session.getAttribute("nick"));
		
		AccomTO ato = heartDao.accomRemoveHeart(to);
	
		return ato;
	}
	
	// 숙소 view
	@RequestMapping(value = "/accom_view.do")
	public String accom_view(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String no = request.getParameter( "no" );
			String cpage = request.getParameter( "cpage" );
			String nick = (String)session.getAttribute( "nick" );
			
			AccomTO to = new AccomTO();
			to.setNo( no );
			
			//글 내용 가져오기
			if( nick == null ) {	//로그인아닐 때
				to = accomDao.accomView(to);	
			} else {	//로그인일 때
				to.setNick( nick );
				to = accomDao.accomViewLogin(to);
			}
			
			//해당 글에 대한 댓글 list가져오기
			AccomCommentTO commentTo = new AccomCommentTO();
			commentTo.setBno( no );
			ArrayList<AccomCommentTO> lists = accomCommentDao.accomListComment(commentTo);	
			
			request.setAttribute( "to", to );
			request.setAttribute( "lists", lists );
			request.setAttribute( "cpage", cpage );
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_view";
	}
	
	// 숙소 view comment ok
	@RequestMapping(value = "/accom_view_comment_ok.do")
	public String accom_view_comment_ok(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			
			String bno = request.getParameter( "no" );
			String writer = request.getParameter( "cwriter" );
			String content = request.getParameter( "ccontent" );
			
			AccomCommentTO commentTo = new AccomCommentTO();
			commentTo.setBno(bno);
			commentTo.setWriter(writer);
			commentTo.setContent(content);

			int flag = accomCommentDao.accomViewCommentOk(commentTo);
			request.setAttribute( "flag", flag );
			request.setAttribute( "cpage", cpage );
			request.setAttribute( "no", bno );
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_view_comment_ok";
	}
	
	// 숙소 rereply_ok
	@RequestMapping(value = "/accom_rereplyOk.do")
	public String accom_rereplyOk(HttpServletRequest request) {
		
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			String no = request.getParameter( "no" );
			String bno = request.getParameter("bno");
			String writer = request.getParameter("writer");
			String content = request.getParameter("ccontent_reply");
			
			AccomCommentTO commentTo = new AccomCommentTO();
			commentTo.setNo(no);
			
			// 부모글의 grp, grps, grpl 가져와서 commentTo에 저장
			commentTo = accomCommentDao.accomParentSelect(commentTo);
			
			commentTo.setBno(bno);
			commentTo.setWriter(writer);
			commentTo.setContent(content);
			
			//기존에 있던 댓글중에서 부모 댓글과 같은 grp이고 부모 grpl(0)보다 자식 grps가 큰 댓글들은 모두 grps를 1씩 늘려준다.
			int result1 = accomCommentDao.accomUpdateGrps(commentTo);
			
			//새로운 답글을 추가 (sql문에서 grps와 grpl을 모두 1씩 늘려준다.)
			int flag = 1;
			int result2 = accomCommentDao.accomRereplyInsertOk(commentTo);
			if( result2 == 1 ) {
				flag = 0;
			}
			
			request.setAttribute( "flag", flag );
			request.setAttribute( "cpage", cpage );
			request.setAttribute( "no", bno );
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "accom/accom_rereply_ok";
	}
	
	// 숙소 reply delete
	@RequestMapping(value = "/accom_reply_deleteOk.do")
	public String accom_reply_deleteOk(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			String bno = request.getParameter( "bno" );	//게시글번호
			String no = request.getParameter( "no" );	//댓글 번호
			
			AccomCommentTO cto = new AccomCommentTO();
			cto.setNo(no);
			
			int flag = accomCommentDao.accom_reply_deleteOk( cto );
			
			request.setAttribute( "cpage", cpage );
			request.setAttribute( "no", bno );
			request.setAttribute( "flag", flag );
			
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_reply_deleteOk";
	}
	
	// 숙소 reply modify
	@RequestMapping(value = "/accom_reply_modifyOk.do")
	public String accom_reply_modifyOk(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			String content = request.getParameter( "ccontent_modify" );	//댓글내용
			String bno = request.getParameter( "bno" );	//게시글번호
			String no = request.getParameter( "no" );	//댓글번호
			
			AccomCommentTO cto = new AccomCommentTO();
			cto.setNo(no);
			cto.setContent(content);
			
			int flag = accomCommentDao.accom_reply_modifyOk( cto );
			
			request.setAttribute( "cpage", cpage );
			request.setAttribute( "no", bno );
			request.setAttribute( "flag", flag );
			
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_reply_modifyOk";
	}
	
	// 숙소 delete
	@RequestMapping(value = "/accom_delete_ok.do")
	public String accom_delete_ok(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String location = request.getParameter( "location" );
			String no = request.getParameter( "no" );
			String writer = request.getParameter( "writer" );
			
			AccomTO to = new AccomTO();
			to.setWriter( writer );
			to.setNo(no);
			
			int flag = accomDao.accomDelete( to );
			
			request.setAttribute( "location", location );
			request.setAttribute( "flag", flag );
			
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_delete_ok";
	}
	
	// 숙소 modify
	@RequestMapping(value = "/accom_modify.do")
	public String accom_modify(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			String no = request.getParameter( "no" );
			String writer = request.getParameter( "writer" );
			String subject = request.getParameter( "subject" );
			String location = request.getParameter( "location" );
			String picture = request.getParameter( "picture" );
			String content = request.getParameter( "content" );
			
			request.setAttribute( "cpage", cpage );
			request.setAttribute( "no", no );
			request.setAttribute( "writer", writer );
			request.setAttribute( "subject", subject );
			request.setAttribute( "location", location );
			request.setAttribute( "subject", subject );
			request.setAttribute( "picture", picture );
			request.setAttribute( "content", content );
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_modify";
	}
	
	// 숙소 modify_ok
	@RequestMapping(value = "/accom_modify_ok.do")
	public String accom_modify_ok(HttpServletRequest request, HttpServletResponse response) {
		
		int maxFileSize = 1024 * 1024 * 6;
		String encType = "utf-8";
    
		//String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\accom";
		//String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\accom";
		String uploadPath = "/Users/hyukjun/git/Want/Want/src/main/webapp/upload/accom";

		MultipartRequest multi = null;

		try {
			request.setCharacterEncoding("utf-8");
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
			
			String cpage = multi.getParameter( "cpage" );
			String no = multi.getParameter( "no" );
			String writer = multi.getParameter("writer");
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String location = multi.getParameter("location");
			String picture = "";
			if( multi.getFilesystemName("picture") == null ) {	//사진파일 수정안했을 때
				picture = multi.getParameter( "ex-picture" );
			} else {
				picture = multi.getFilesystemName("picture");
				
			}

			AccomTO to = new AccomTO();
			to.setNo(no);
			to.setWriter(writer);
			to.setSubject(subject);
			to.setContent(content);
			to.setLocation(location);
			to.setPicture(picture);

			int flag = accomDao.accomModifyOk(to);

			request.setAttribute("flag", flag);
			request.setAttribute("cpage", cpage);
			request.setAttribute("location", location );
			

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_modify_ok";
	}	
	
}
