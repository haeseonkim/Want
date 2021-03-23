package com.exam.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
import com.exam.model1.pictureHeart.HeartDAO;
import com.exam.model1.pictureHeart.HeartTO;
import com.exam.model1.pictureReply.ReplyDAO;
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
	private HeartDAO heartDao;
	
	@Autowired
	private ReplyDAO replyDao;
	
	// 각자 맞는 upload 폴더 경로로 변경
	private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\picture";


	// 사진자랑 목록
	@RequestMapping(value = "/picture_list.do")
	public String picture_list(HttpServletRequest request, HttpSession session) {
		
		// 게시판목록을 담을 to
		PictureListTO listTO = new PictureListTO();
		
		if(session.getAttribute("nick") == null) {
			// 로그인 상태가 아닐때 
			System.out.println("로그인 상태가 아닐때 ");
			// 사진 자랑 게시판 목록 가져오기
			
			listTO.setCpage( Integer.parseInt( request.getParameter( "cpage" ) == null || request.getParameter( "cpage" ).equals( "" ) ? "1" : request.getParameter( "cpage" ) ) );
			listTO = pictureDao.boardList(listTO);
		}else {
			// 로그인 상태일때 
			System.out.println("로그인 상태일때 ");
			PictureTO to = new PictureTO();
			
			to.setNick((String)session.getAttribute("nick"));
			
			// 사진자랑 게시판 목록 가져오기
			listTO.setCpage( Integer.parseInt( request.getParameter( "cpage" ) == null || request.getParameter( "cpage" ).equals( "" ) ? "1" : request.getParameter( "cpage" ) ) );
			listTO = pictureDao.boardListLogin(listTO, to);
			
		}
		
		// 사진자랑 좋아요(heart)순으로 상위5개 가져오기
		ArrayList<PictureTO> bestList = new ArrayList();
		bestList = pictureDao.bestList();
		
		
		request.setAttribute( "listTO", listTO );
		request.setAttribute( "bestList", bestList );
		

		return "picture/picture_list";
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
	
	// signup에서 id중복조회

	
	// view
	@ResponseBody
	@RequestMapping(value = "/picture_view.do")
	public PictureTO view(@RequestParam String no, HttpSession session) {
		
		
		PictureTO to = new PictureTO();
		to.setNo(no);
		
		// 현재 사용자 nick 세팅
		to.setNick((String)session.getAttribute("nick"));
		
		to = pictureDao.boardView(to);
		
		// 현재 사용자 nick 다시 세팅
		to.setNick((String)session.getAttribute("nick"));

		return to;
	}
	
	
	// 빈하트 클릭시 하트 저장
	@ResponseBody
	@RequestMapping(value = "/saveHeart.do")
	public PictureTO save_heart(@RequestParam String no, HttpSession session) {
		
		HeartTO to = new HeartTO();
		
		// 게시물 번호 세팅
		to.setBno(no);
		
		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String)session.getAttribute("nick"));
		
		// +1된 하트 갯수를 담아오기위함
		PictureTO pto = heartDao.pictureSaveHeart(to);
	
		return pto;
	}
	
	// 꽉찬하트 클릭시 하트 해제
	@ResponseBody
	@RequestMapping(value = "/removeHeart.do")
	public PictureTO remove_heart(@RequestParam String no, HttpSession session) {
		HeartTO to = new HeartTO();
		
		// 게시물 번호 세팅
		to.setBno(no);
		
		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String)session.getAttribute("nick"));
		
		// -1된 하트 갯수를 담아오기위함
		PictureTO pto = heartDao.pictureRemoveHeart(to);
	
		return pto;
	}
	

}
