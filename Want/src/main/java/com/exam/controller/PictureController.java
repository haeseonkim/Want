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
	    	String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\picture";

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
		
		PictureHeartTO to = new PictureHeartTO();
		
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
		PictureHeartTO to = new PictureHeartTO();
		
		// 게시물 번호 세팅
		to.setBno(no);
		
		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String)session.getAttribute("nick"));
		
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
		to.setWriter((String)session.getAttribute("nick"));
			
		// +1된 댓글 갯수를 담아오기 위함 
		PictureTO pto = replyDao.pictureWriteReply(to);
		
		return pto;
	}
	
	// 답글 작성
	@ResponseBody
	@RequestMapping(value = "/picture_write_rereply.do")
	public PictureTO write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content, HttpSession session) {
			
		ReplyTO to = new ReplyTO();
		
		// 게시물 번호 세팅
		to.setBno(bno);
		
		// grp, grps, grpl 은  ReplyTO에  int로 정의되어 있기 때문에 String인 no를 int로 변환해서 넣어준다.
		// 모댓글 번호 no를 grp으로 세팅한다.
		to.setGrp(Integer.parseInt(no));
			
		// 답글은 깊이가 1이되어야 하므로 grpl을 1로 세팅한다.
		to.setGrpl(1);

		// 답글 내용 세팅
		to.setContent(content);
			
		// 답글작성자 nick을 writer로 세팅
		to.setWriter((String)session.getAttribute("nick"));
			
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
		
		// grp 세팅(모댓글이 뭔지) - 모댓글은 삭제를 해도 답글이 있으면 남아있게 되는데 답글이 모두 삭제되었을 때 모댓글도 삭제하기 위해 필요함
		to.setGrp(grp);
		
		// 갱신된 댓글 갯수를 담아오기 위함 
		PictureTO pto = replyDao.pictureDeleteReReply(to);
		
		return pto;
	}

}
