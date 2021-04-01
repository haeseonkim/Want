
package com.exam.controller;


import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.model1.lantripHeart.LantripHeartDAO;
import com.exam.model1.lantripHeart.LantripHeartTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.lantrip.LanTripDAO;
import com.exam.model1.lantrip.LanTripListTO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.user.UserDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@Controller
public class LanTripController {


   @Autowired
   private LanTripDAO dao;
   
   @Autowired
   private LantripHeartDAO heartDao;

   // 각자 맞는 upload 폴더 경로로 변경
   private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\lanTrip";

   

   // 랜선여행 목록
   @RequestMapping(value = "/lanTrip_list.do")
   public String lanTrip_list(HttpServletRequest request, Model model, HttpSession session) {
      
      LanTripListTO listTO = new LanTripListTO();
      LanTripTO to = new LanTripTO();
      String nick = (String)session.getAttribute( "nick" );
      listTO.setCpage( Integer.parseInt( request.getParameter( "cpage" ) == null || request.getParameter( "cpage" ).equals( "" ) ? "1" : request.getParameter( "cpage" ) ) );
      //로그인아닐 때
      if( nick == null ) {
    	  listTO = dao.lanTripList(listTO);
      } else {   //로그인일 때
         to.setNick( nick );
         listTO = dao.lanTripListLogin(listTO, to);
      }
      
   // 사진자랑 좋아요(heart)순으로 상위5개 가져오기
   		ArrayList<LanTripTO> bestList = new ArrayList();
   		bestList = dao.bestList();
   		
   		
   		model.addAttribute( "listTO", listTO );
   		model.addAttribute( "bestList", bestList );
      
      return "lanTrip/lanTrip_list";
   }
   

   // 랜선여행 write
   @RequestMapping(value = "/lanTrip_write.do")
   public String lanTrip_write(Model model) {
      return "lanTrip/lanTrip_write";
   }
   
   // 랜선여행 write_ok
   @RequestMapping(value = "/lanTrip_write_ok.do")
   public String lanTrip_write_ok(HttpServletRequest request, Model model) {
	    String encType = "utf-8";
	    int maxFileSize = 2048 * 2048 * 6;
	    
	    MultipartRequest multi = null;
		
	    try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
			
			LanTripTO to = new LanTripTO();
			to.setSubject(multi.getParameter("subject"));
			to.setLocation(multi.getParameter("location"));
			to.setWriter(multi.getParameter("writer"));
			to.setContent(multi.getParameter("content"));
			to.setVideo(multi.getFilesystemName("video"));
			to.setWdate(multi.getParameter("wdate"));
	
			int flag = dao.boardWriteOk(to);
			
			request.setAttribute("flag", flag);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	   return "lanTrip/lanTrip_write_ok";
   }
   
   // 랜선여행 게시물 view
   @RequestMapping(value = "/lanTrip_view.do")
   public String lanTrip_view(HttpServletRequest request) {
	   
	   String no = request.getParameter("no");
	   LanTripTO to = new LanTripTO();
	   
	   to.setNo(no);
	   
	   to = dao.boardView(to);
	   
	   request.setAttribute("to", to);
	   
      return "lanTrip/lanTrip_view";
   }
   
   // 랜선여행 게시물 delete_ok
   @RequestMapping(value = "/lanTrip_delete_ok.do")
   public String lanTrip_delete_ok(HttpServletRequest request, Model model) {
	   
	   LanTripTO to = new LanTripTO();
	   
	   to.setNo(request.getParameter( "no" ));
	   
	   int flag = dao.boardDeleteOk(to);
	   
	   request.setAttribute("flag", flag);
	   
	   return "lanTrip/lanTrip_delete_ok";
   }
   
   //랜선여행 게시물 modify
   @RequestMapping(value = "/lanTrip_modify.do")
	public String modify(HttpServletRequest request, Model model) {
		String no = request.getParameter("no");

		LanTripTO to = new LanTripTO();
		to.setNo(no);
		
		to = dao.boardModify(to);
		
//		model.addAttribute("to", to);
		request.setAttribute("to",to);
		
		return "lanTrip/lanTrip_modify";
	}

   // 랜선여행 modify_ok
   @RequestMapping(value = "/lanTrip_modify_ok.do")
   	public String lanTrip_modify_ok(HttpServletRequest request, Model model) {
	    String encType = "utf-8";
	    int maxFileSize = 2048 * 2048 * 6;
	    
	    MultipartRequest multi = null;
		
	    try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
			
			LanTripTO to = new LanTripTO();
			to.setNo(multi.getParameter("no"));
			to.setSubject(multi.getParameter("subject"));
			to.setLocation(multi.getParameter("location"));
			to.setWriter(multi.getParameter("writer"));
			to.setContent(multi.getParameter("content"));
			to.setVideo(multi.getFilesystemName("video"));
			to.setWdate(multi.getParameter("wdate"));
	
			int flag = dao.boardModifyOk(to);
			
			request.setAttribute("flag", flag);
			request.setAttribute("no", to.getNo());
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	   return "lanTrip/lanTrip_modify_ok";
   }
   
   // 랜선여행 reply_ok
  
   // 랜선여행 좋아요(빈하트 클릭시)/조회수/댓글수
// 빈하트 클릭시 하트 저장
   @ResponseBody
   @RequestMapping(value = "/lanTrip_saveHeart.do")
   public LanTripTO save_heart(@RequestParam String no, HttpSession session) {
      
      LantripHeartTO to = new LantripHeartTO();
      
      // 게시물 번호 세팅
      to.setBno(no);
      
      // 좋아요 누른 사람 nick을 userid로 세팅
      to.setUserid((String)session.getAttribute("nick"));
      

      LanTripTO lto = heartDao.lanTripSaveHeart(to);
      
   
      return lto;
   }
   
   // 꽉찬하트 클릭시 하트 해제
   @ResponseBody
   @RequestMapping(value = "/lanTrip_removeHeart.do")
   public LanTripTO remove_heart(@RequestParam String no, HttpSession session) {
      LantripHeartTO to = new LantripHeartTO();
      
      // 게시물 번호 세팅
      to.setBno(no);
      
      // 좋아요 누른 사람 nick을 userid로 세팅
      to.setUserid((String)session.getAttribute("nick"));
      
      LanTripTO lto = heartDao.lanTripRemoveHeart(to);
   
      return lto;
   }
   
}