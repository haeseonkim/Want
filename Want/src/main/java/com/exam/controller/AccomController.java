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
		String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\accom";

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
			request.setCharacterEncoding("utf-8");
			String location = request.getParameter("location");
			int cpage = 1;
			String nick = (String)session.getAttribute( "nick" );
			
			AccomListTO listTO = new AccomListTO();
			AccomTO to = new AccomTO();
			
			if (request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
				cpage = Integer.parseInt(request.getParameter("cpage"));
			}
			listTO.setLocation(location);
			listTO.setCpage(cpage);
			
			//로그인아닐 때
			if( nick == null ) {
				listTO = accomDao.accomList(listTO);
			} else {	//로그인일 때
				to.setNick( nick );
				to.setLocation(location);
				listTO = accomDao.accomListLogin(listTO, to);
			}

			request.setAttribute("listTO", listTO);
			request.setAttribute("cpage", cpage);
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_list";
	}
	
	// 빈하트 클릭시 하트 저장
	@ResponseBody
	@RequestMapping(value = "/accom_saveHeart.do")
	public int save_heart(@RequestParam String no, HttpSession session) {
		
		AccomHeartTO to = new AccomHeartTO();
		
		// 게시물 번호 세팅
		to.setBno(no);
		
		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String)session.getAttribute("nick"));
		
		int flag = heartDao.accomSaveHeart(to);
	
		return flag;
	}
	
	// 꽉찬하트 클릭시 하트 해제
	@ResponseBody
	@RequestMapping(value = "/accom_removeHeart.do")
	public int remove_heart(@RequestParam String no, HttpSession session) {
		AccomHeartTO to = new AccomHeartTO();
		
		// 게시물 번호 세팅
		to.setBno(no);
		
		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String)session.getAttribute("nick"));
		
		int flag = heartDao.accomRemoveHeart(to);
	
		return flag;
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
			
			String cpage = request.getParameter( "cpage" );
			String location = request.getParameter( "location" );
			String no = request.getParameter( "no" );
			String writer = request.getParameter( "writer" );
			
			AccomTO to = new AccomTO();
			to.setWriter( writer );
			to.setNo(no);
			
			int flag = accomDao.accomDelete( to );
			
			request.setAttribute( "cpage", cpage );
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
		String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\accom";

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
