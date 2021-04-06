package com.exam.controller;

import java.io.File;
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

import com.exam.model1.message.MessageDAO;
import com.exam.model1.picture.PictureDAO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.pictureReply.ReplyDAO;
import com.exam.model1.pictureReply.ReplyTO;
import com.exam.model1.shopping.ShoppingDAO;
import com.exam.model1.shopping.ShoppingTO;
import com.exam.model1.shoppingComment.ShoppingCommentDAO;
import com.exam.model1.shoppingComment.ShoppingCommentTO;
import com.exam.model1.accom.AccomDAO;
import com.exam.model1.accom.AccomTO;
import com.exam.model1.accomComment.AccomCommentDAO;
import com.exam.model1.accomComment.AccomCommentTO;
import com.exam.model1.lantrip.LanTripDAO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.lantripApply.LanTripApplyTO;
import com.exam.model1.lantripReply.LanTripReplyDAO;
import com.exam.model1.lantripReply.LanTripReplyTO;
import com.exam.model1.user.UserDAO;
import com.exam.model1.user.UserTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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

   
   @Autowired
   private PictureDAO pictureDao;
   @Autowired
   private ReplyDAO p_replyDao;
   
   @Autowired
   private ShoppingDAO shopDao;
   @Autowired
   private ShoppingCommentDAO  s_replyDao;

   @Autowired
   private AccomDAO accomDao;
   @Autowired
   private AccomCommentDAO a_replyDao;
   
   //private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\profile";
   //private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\profile";
   private String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/profile";
   
   // 내 프로필
   @RequestMapping(value = "/profile.do")
   public String profile(HttpServletRequest request, HttpSession session) {
      try {

    	  	
    	  // 그냥 들어왔을때 0, 프로필 사진 수정 후 1
    	  // profil.jsp의 jsp문 실행 조건
    	  int result= 0;
    	  

         request.setCharacterEncoding("utf-8");
         
         //======= 유저 정보가져오기 =======
         //세션에 저장된 nick값을 to에 저장
         UserTO uto = new UserTO();
         String nick = (String)session.getAttribute( "nick" );
         uto.setNick(nick);
         
         //저장된 nick값을 userDao함수 매개변수로 넘겨줌
         //userDao에서 myProfile함수를 실행시켜서 유저 정보를 다시 uto에 저장
         uto = userDao.myProfile(uto);
         
         
         
         //======= 랜선여행 글list 가져오기 =======
         LanTripTO lto = new LanTripTO();
         
         String pageNum = request.getParameter( "pageNum" );
         
         int recordNum = 9;   //가져올 글의 개수
         
         int currentPage = 1;   //현재 페이지번호
         if( pageNum != null ) {
            currentPage = Integer.parseInt( pageNum );
         }         
         int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
         int endRowNum = currentPage * recordNum;
         
         lto.setWriter(nick);
         lto.setStartRowNum(startRowNum);
         lto.setEndRowNum(endRowNum);
         
         //전체 글의 개수를 이용해서 전페 페이지수 구하기
         int totalRow = 0;
         totalRow = lantripDao.profileLanTripCount( lto );
         
         int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );

         //랜선여행 글리스트 결과를 리턴받는다.
         ArrayList<LanTripTO> list = lantripDao.lantrip_MyProfileList(lto);
      
         
         //jsp로 uto값을 넘겨줌
         request.setAttribute( "uto", uto );
         request.setAttribute( "totalPageCount", totalPageCount );
         //jsp로 to가 담긴 arrayList넘겨준다.
         request.setAttribute( "pageNum", pageNum );
         request.setAttribute( "list", list );   

         
         request.setAttribute("result", result);


      } catch (UnsupportedEncodingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      return "profile/profile";
   }
   


   //랜선여행리스트 불러오기
   @RequestMapping(value = "/profile_lanTrip_ajax_page.do")
   public String profile_lanTrip_ajax_page(HttpServletRequest request, HttpSession session) {
      try {
         request.setCharacterEncoding("utf-8");

         
         //세션에 저장된 nick값과 페이지 가져올 글수를 정하는 
         //startRowNum과 endRowNum을 to에 저장
         LanTripTO lto = new LanTripTO();
         
         String writer = (String)session.getAttribute( "nick" );
         String pageNum = request.getParameter( "pageNum" );
         
         int recordNum = 9;   //가져올 글의 개수
         
         int currentPage = 1;   //현재 페이지번호
         if( pageNum != null ) {
            currentPage = Integer.parseInt( pageNum );
         }         
         int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
         int endRowNum = currentPage * recordNum;
         
         lto.setWriter(writer);
         lto.setStartRowNum(startRowNum);
         lto.setEndRowNum(endRowNum);
         
         //전체 글의 개수를 이용해서 전페 페이지수 구하기
         int totalRow = 0;
         totalRow = lantripDao.profileLanTripCount( lto );
         
         int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );
         
         //랜선여행 글리스트 결과를 리턴받는다.
         ArrayList<LanTripTO> list = lantripDao.lantrip_MyProfileList(lto);
         
         //jsp로 to가 담긴 arrayList넘겨준다.
         request.setAttribute( "totalPageCount", totalPageCount );
         request.setAttribute( "pageNum", pageNum );
         request.setAttribute( "list", list );
         

      } catch (UnsupportedEncodingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      return "profile/profile_lanTrip_ajax_page";
   }
   
   //랜선여행하기 댓글리스트
   @RequestMapping(value = "/lantrip_replyList.do")
   public String lantrip_replyList(HttpServletRequest request, HttpSession session) {

      LanTripReplyTO to = new LanTripReplyTO();
      
      // 가져올 댓글 리스트의 게시물번호를 세팅
      to.setBno( request.getParameter( "no" ) );

      ArrayList<LanTripReplyTO> replyList = new ArrayList();

      replyList = l_replyDao.lantripReplyList(to);
         
      request.setAttribute( "rlist", replyList );
      
      return "profile/profile_lantripReply_ajax_page";
   }
   
   //랜선여행 모댓글 작성
   @ResponseBody
   @RequestMapping( value= "/lantrip_write_reply.do" )
   public LanTripTO lantrip_write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session ) {
      
      LanTripReplyTO to = new LanTripReplyTO();
      //게시물번호 세팅
      to.setBno(bno);
      
      //댓글 내용 세팅
      to.setContent(content);
      
      //댓글 작성자 nick을 writer로 세팅
      to.setWriter( (String)session.getAttribute( "nick" ) );
      
      LanTripTO lto = l_replyDao.lantripWriteReply( to );
      
      return lto;
   }
   
   // 모댓글 삭제
   @ResponseBody
   @RequestMapping(value = "/lantrip_delete_reply.do")

   public LanTripTO lantrip_delete_reply(@RequestParam String no, @RequestParam String bno, @RequestParam int grpl) {


      LanTripReplyTO to = new LanTripReplyTO();

      // 모댓글 번호 세팅
      to.setNo(no);

      // 게시물 번호 세팅
      to.setBno(bno);
      
      //grpl세팅
      to.setGrpl(grpl);


      // 갱신된 댓글 갯수를 담아오기 위함
      LanTripTO lto = l_replyDao.lantripDeleteReply(to);

      return lto;
   }
   
   // 자식댓글 삭제
   @ResponseBody
   @RequestMapping(value = "/lantrip_delete_rereply.do")

   public LanTripTO lantrip_delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String grp) {


      LanTripReplyTO to = new LanTripReplyTO();

      // 모댓글 번호 세팅
      to.setNo(no);

      // 게시물 번호 세팅
      to.setBno(bno);
      
      //grp세팅
      to.setGrp(grp);

      // 갱신된 댓글 갯수를 담아오기 위함

      LanTripTO lto = l_replyDao.lantripDeleteRereply(to);


      return lto;
   }
   

   	//답글 작성
	@ResponseBody
	@RequestMapping(value = "/lantrip_write_rereply.do")
	public LanTripTO lantrip_write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content,
			HttpSession session) {

		LanTripReplyTO to = new LanTripReplyTO();

		// 게시물 번호 세팅
		to.setBno(bno);

		// grp, grps, grpl 은 ReplyTO에 int로 정의되어 있기 때문에 String인 no를 int로 변환해서 넣어준다.
		// 모댓글 번호 no를 grp으로 세팅한다.
		to.setGrp(no);

		// 답글은 깊이가 1이되어야 하므로 grpl을 1로 세팅한다.
		to.setGrpl(1);

		// 답글 내용 세팅
		to.setContent(content);

		// 답글작성자 nick을 writer로 세팅
		to.setWriter((String)session.getAttribute("nick"));

		// +1된 댓글 갯수를 담아오기 위함
		LanTripTO lto = l_replyDao.lantripWriteReReply(to);
		
		
		return lto;
	}
   
	//=====================사진관련=========================
	// 사진 리스트 불러오기
	@RequestMapping(value = "/profile_picture_ajax_page.do")
	public String profile_picture_ajax_page(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");

			// 세션에 저장된 nick값과 페이지 가져올 글수를 정하는
			// startRowNum과 endRowNum을 to에 저장
			PictureTO to = new PictureTO();

			String writer = (String) session.getAttribute("nick");
			String pageNum = request.getParameter("pageNum");

			int recordNum = 9; // 가져올 글의 개수

			int currentPage = 1; // 현재 페이지번호
			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}
			int startRowNum = 0 + (currentPage - 1) * recordNum;
			int endRowNum = currentPage * recordNum;

			to.setWriter(writer);
			to.setStartRowNum(startRowNum);
			to.setEndRowNum(endRowNum);

			// 전체 글의 개수를 이용해서 전페 페이지수 구하기
			int totalRow = 0;
			totalRow = pictureDao.PictureCount(to);
			
			int totalPageCount = (int) Math.ceil(totalRow / (double) recordNum);

			// 랜선여행 글리스트 결과를 리턴받는다.
			ArrayList<PictureTO> list = pictureDao.picture_MyProfileList(to);
			
			// jsp로 to가 담긴 arrayList넘겨준다.
			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("list", list);

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "profile/profile_picture_ajax_page";
	}

	// 사진 댓글리스트
	@RequestMapping(value = "/Picture_replyList.do")
	public String picture_replyList(HttpServletRequest request, HttpSession session) {

		ReplyTO to = new ReplyTO();

		// 가져올 댓글 리스트의 게시물번호를 세팅
		to.setBno(request.getParameter("no"));

		ArrayList<ReplyTO> replyList = new ArrayList();
		
		//댓글리스트 가져옴
		replyList = p_replyDao.replyList(to);
		
		request.setAttribute("rlist", replyList);

		return "profile/profile_lantripReply_ajax_page";
	}

	// 사진 모댓글 작성
	@ResponseBody
	@RequestMapping(value = "/Picture_write_reply.do")
	public PictureTO picture_write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session) {
		
		ReplyTO to = new ReplyTO();
		// 게시물번호 세팅
		to.setBno(bno);

		// 댓글 내용 세팅
		to.setContent(content);

		// 댓글 작성자 nick을 writer로 세팅
		to.setWriter((String) session.getAttribute("nick"));
		
		PictureTO pto = p_replyDao.profile_pictureWriteReply(to);
		
		return pto;
	}

	// 모댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/Picture_delete_reply.do")
	public PictureTO picture_delete_reply(@RequestParam String no, @RequestParam String bno, @RequestParam int grpl) {

		ReplyTO to = new ReplyTO();

		// 모댓글 번호 세팅
		to.setNo(no);

		// 게시물 번호 세팅
		to.setBno(bno);

		// grpl세팅
		to.setGrpl(grpl);

		// 갱신된 댓글 갯수를 담아오기 위함
		PictureTO pto = p_replyDao.pictureDeleteReply(to);

		return pto;
	}

	// 자식댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/Picture_delete_rereply.do")
	public PictureTO picure_delete_rereply(@RequestParam String no, @RequestParam String bno,
			@RequestParam String grp) {

		ReplyTO to = new ReplyTO();

		// 모댓글 번호 세팅
		to.setNo(no);

		// 게시물 번호 세팅
		to.setBno(bno);

		// grp세팅
		to.setGrp( Integer.parseInt(grp) );

		// 갱신된 댓글 갯수를 담아오기 위함
		PictureTO pto = p_replyDao.pictureDeleteReReply(to);

		return pto;
	}

	// 답글 작성
	@ResponseBody
	@RequestMapping(value = "/Picture_write_rereply.do")
	public PictureTO picture_write_rereply(@RequestParam String no, @RequestParam String bno,
			@RequestParam String content, HttpSession session) {

		ReplyTO to = new ReplyTO();

		// 게시물 번호 세팅
		to.setBno(bno);

		// grp, grps, grpl 은 ReplyTO에 int로 정의되어 있기 때문에 String인 no를 int로 변환해서 넣어준다.
		// 모댓글 번호 no를 grp으로 세팅한다.
		to.setGrp( Integer.parseInt(no) );

		// 답글은 깊이가 1이되어야 하므로 grpl을 1로 세팅한다.
		to.setGrpl(1);

		// 답글 내용 세팅
		to.setContent(content);

		// 답글작성자 nick을 writer로 세팅
		to.setWriter((String) session.getAttribute("nick"));

		// +1된 댓글 갯수를 담아오기 위함
		PictureTO lto = p_replyDao.pictureWriteReReply(to);

		return lto;
	}
	
	//=====================쇼핑관련=========================
   //쇼핑리스트 불러오기
   @RequestMapping(value = "/profile_shop_ajax_page.do")
   public String profile_shop_ajax_page(HttpServletRequest request, HttpSession session) {
      try {
         request.setCharacterEncoding("utf-8");
         
         //세션에 저장된 nick값과 페이지 가져올 글수를 정하는
         //startRowNum과 endRowNum을 to에 저장
         ShoppingTO sto = new ShoppingTO();
         
         String writer = (String)session.getAttribute( "nick" );
         String pageNum = request.getParameter( "pageNum" );
         
         int recordNum = 9;   //가져올 글의 개수
         
         int currentPage = 1;   //현재 페이지번호
         if( pageNum != null ) {
            currentPage = Integer.parseInt( pageNum );
         }         
         int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
         int endRowNum = currentPage * recordNum;
         
         sto.setWriter(writer);
         sto.setStartRowNum(startRowNum);
         sto.setEndRowNum(endRowNum);
         
         //전체 글의 개수를 이용해서 전페 페이지수 구하기
         int totalRow = 0;
         totalRow = shopDao.profileShopCount( sto );
         
         int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );
         
         //랜선여행 글리스트 결과를 리턴받는다.
         ArrayList<ShoppingTO> list = shopDao.shop_MyProfileList(sto);
         
         //jsp로 to가 담긴 arrayList넘겨준다.
         request.setAttribute( "totalPageCount", totalPageCount );
         request.setAttribute( "pageNum", pageNum );
         request.setAttribute( "list", list );
         

      } catch (UnsupportedEncodingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      return "profile/profile_shop_ajax_page";
   }
   
   //쇼핑 댓글리스트
   @RequestMapping(value = "/shop_replyList.do")
   public String shop_replyList(HttpServletRequest request, HttpSession session) {

      ShoppingCommentTO to = new ShoppingCommentTO();
      
      // 가져올 댓글 리스트의 게시물번호를 세팅
      to.setBno( request.getParameter( "no" ) );

      ArrayList<ShoppingCommentTO> replyList = new ArrayList();

      replyList = s_replyDao.shopReplyList(to);
         
      request.setAttribute( "rlist", replyList );
      
      return "profile/profile_shopReply_ajax_page";
   }
   
   //쇼핑 모댓글 작성
   @ResponseBody
   @RequestMapping( value= "/shop_write_reply.do" )
   public ShoppingTO shop_write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session ) {
      
	   ShoppingCommentTO to = new ShoppingCommentTO();
      //게시물번호 세팅
      to.setBno(bno);
      
      //댓글 내용 세팅
      to.setContent(content);
      
      //댓글 작성자 nick을 writer로 세팅
      to.setWriter( (String)session.getAttribute( "nick" ) );
      
      ShoppingTO sto = s_replyDao.shopWriteReply( to );
      
      return sto;
   }
   
   // 모댓글 삭제
   @ResponseBody
   @RequestMapping(value = "/shop_delete_reply.do")
   public ShoppingTO shop_delete_reply(@RequestParam String no, @RequestParam String bno, @RequestParam int grpl) {

	   ShoppingCommentTO to = new ShoppingCommentTO();

      // 모댓글 번호 세팅
      to.setNo(no);

      // 게시물 번호 세팅
      to.setBno(bno);
      
      //grpl세팅
      to.setGrpl(grpl);

      // 갱신된 댓글 갯수를 담아오기 위함
      ShoppingTO sto = s_replyDao.shopDeleteReply(to);

      return sto;
   }
   
   // 자식댓글 삭제
   @ResponseBody
   @RequestMapping(value = "/shop_delete_rereply.do")
   public ShoppingTO shop_delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String grp) {

	   ShoppingCommentTO to = new ShoppingCommentTO();

      // 모댓글 번호 세팅
      to.setNo(no);

      // 게시물 번호 세팅
      to.setBno(bno);
      
      //grp세팅
      to.setGrp(grp);

      // 갱신된 댓글 갯수를 담아오기 위함
      ShoppingTO sto = s_replyDao.shopDeleteRereply(to);

      return sto;
   }
   
   	//답글 작성
	@ResponseBody
	@RequestMapping(value = "/shop_write_rereply.do")
	public ShoppingTO shop_write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content,
			HttpSession session) {

		ShoppingCommentTO to = new ShoppingCommentTO();

		// 게시물 번호 세팅
		to.setBno(bno);

		// grp, grps, grpl 은 ReplyTO에 int로 정의되어 있기 때문에 String인 no를 int로 변환해서 넣어준다.
		// 모댓글 번호 no를 grp으로 세팅한다.
		to.setGrp(no);

		// 답글은 깊이가 1이되어야 하므로 grpl을 1로 세팅한다.
		to.setGrpl(1);

		// 답글 내용 세팅
		to.setContent(content);

		// 답글작성자 nick을 writer로 세팅
		to.setWriter((String)session.getAttribute("nick"));

		// +1된 댓글 갯수를 담아오기 위함
		ShoppingTO sto = s_replyDao.shopWriteReReply(to);
		
		return sto;
	}
	
	//=====================숙소관련=========================
   //숙소리스트 불러오기
   @RequestMapping(value = "/profile_accom_ajax_page.do")
   public String profile_accom_ajax_page(HttpServletRequest request, HttpSession session) {
      try {
         request.setCharacterEncoding("utf-8");
         
         //세션에 저장된 nick값과 페이지 가져올 글수를 정하는
         //startRowNum과 endRowNum을 to에 저장
         AccomTO ato = new AccomTO();
         
         String writer = (String)session.getAttribute( "nick" );
         String pageNum = request.getParameter( "pageNum" );
         
         int recordNum = 9;   //가져올 글의 개수
         
         int currentPage = 1;   //현재 페이지번호
         if( pageNum != null ) {
            currentPage = Integer.parseInt( pageNum );
         }         
         int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
         int endRowNum = currentPage * recordNum;
         
         ato.setWriter(writer);
         ato.setStartRowNum(startRowNum);
         ato.setEndRowNum(endRowNum);
         
         //전체 글의 개수를 이용해서 전페 페이지수 구하기
         int totalRow = 0;
         totalRow = accomDao.profileAccomCount( ato );
         
         int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );
         
         //랜선여행 글리스트 결과를 리턴받는다.
         ArrayList<AccomTO> list = accomDao.accom_MyProfileList(ato);
         
         //jsp로 to가 담긴 arrayList넘겨준다.
         request.setAttribute( "totalPageCount", totalPageCount );
         request.setAttribute( "pageNum", pageNum );
         request.setAttribute( "list", list );
         

      } catch (UnsupportedEncodingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      return "profile/profile_accom_ajax_page";
   }
   
   //쇼핑 댓글리스트
   @RequestMapping(value = "/accom_replyList.do")
   public String accom_replyList(HttpServletRequest request, HttpSession session) {

      AccomCommentTO to = new AccomCommentTO();
      
      // 가져올 댓글 리스트의 게시물번호를 세팅
      to.setBno( request.getParameter( "no" ) );

      ArrayList<AccomCommentTO> replyList = new ArrayList();

      replyList = a_replyDao.accomReplyList(to);
         
      request.setAttribute( "rlist", replyList );
      
      return "profile/profile_accomReply_ajax_page";
   }
   
   //쇼핑 모댓글 작성
   @ResponseBody
   @RequestMapping( value= "/accom_write_reply.do" )
   public AccomTO accom_write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session ) {
      
	   AccomCommentTO to = new AccomCommentTO();
      //게시물번호 세팅
      to.setBno(bno);
      
      //댓글 내용 세팅
      to.setContent(content);
      
      //댓글 작성자 nick을 writer로 세팅
      to.setWriter( (String)session.getAttribute( "nick" ) );
      
      AccomTO ato = a_replyDao.accomWriteReply( to );
      
      return ato;
   }
   
   // 모댓글 삭제
   @ResponseBody
   @RequestMapping(value = "/accom_delete_reply.do")
   public AccomTO accom_delete_reply(@RequestParam String no, @RequestParam String bno, @RequestParam int grpl) {

	   AccomCommentTO to = new AccomCommentTO();

      // 모댓글 번호 세팅
      to.setNo(no);

      // 게시물 번호 세팅
      to.setBno(bno);
      
      //grpl세팅
      to.setGrpl(grpl);

      // 갱신된 댓글 갯수를 담아오기 위함
      AccomTO ato = a_replyDao.accomDeleteReply(to);

      return ato;
   }
   
   // 자식댓글 삭제
   @ResponseBody
   @RequestMapping(value = "/accom_delete_rereply.do")
   public AccomTO accom_delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String grp) {

	   AccomCommentTO to = new AccomCommentTO();

      // 모댓글 번호 세팅
      to.setNo(no);

      // 게시물 번호 세팅
      to.setBno(bno);
      
      //grp세팅
      to.setGrp(grp);

      // 갱신된 댓글 갯수를 담아오기 위함
      AccomTO ato = a_replyDao.accomDeleteRereply(to);

      return ato;
   }
   
   	//답글 작성
	@ResponseBody
	@RequestMapping(value = "/accom_write_rereply.do")
	public AccomTO accom_write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content,
			HttpSession session) {

		AccomCommentTO to = new AccomCommentTO();

		// 게시물 번호 세팅
		to.setBno(bno);

		// grp, grps, grpl 은 ReplyTO에 int로 정의되어 있기 때문에 String인 no를 int로 변환해서 넣어준다.
		// 모댓글 번호 no를 grp으로 세팅한다.
		to.setGrp(no);

		// 답글은 깊이가 1이되어야 하므로 grpl을 1로 세팅한다.
		to.setGrpl(1);

		// 답글 내용 세팅
		to.setContent(content);

		// 답글작성자 nick을 writer로 세팅
		to.setWriter((String)session.getAttribute("nick"));

		// +1된 댓글 갯수를 담아오기 위함
		AccomTO ato = a_replyDao.accomWriteReReply(to);
		
		return ato;
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
	// edit_profile_ok
	@RequestMapping(value = "/edit_profile_ok.do")
	public String edit_profile_ok(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
		
		request.setCharacterEncoding("utf-8");
		
		int flag=2;
		System.out.println("session nick 전 : "+session.getAttribute("nick"));
		UserTO to = new UserTO();
			
		String name = request.getParameter("name");
		String birth = request.getParameter("birth");
		String mail = request.getParameter("mail");
		String phone = request.getParameter("phone");
		String nick = request.getParameter("nick");
		String greet = request.getParameter("greet");
		String id = request.getParameter("id");

		to.setId(id);
		to.setName(name);
		to.setBirth(birth);
		to.setMail(mail);
		to.setPhone(phone);
		to.setNick(nick);
		to.setGreet(greet);
		
		to.setSession_nick((String)session.getAttribute("nick"));
		
		int edit = userDao.edit_profile_ok(to);
		
		if(edit==1) {	// 수정 완료
			flag = 0;
			
			// 수정성공하면 session의 nick을 수정한 nick으로 변경
			session.setAttribute("nick",to.getNick());
			System.out.println("session nick 성공 후 : "+session.getAttribute("nick"));
			
		} else {		// 수정 실패
			flag = 1;
			System.out.println("session nick 실패 후 : "+session.getAttribute("nick"));
		}

		request.setAttribute("flag", flag);
			
		return "profile/edit_profile_ok";
	}
		
	// 프로필 이미지 변경
	@RequestMapping(value = "/edit_img_ok.do")
	public String edit_img_ok(HttpServletRequest request, HttpSession session) {

		int result = 1;
		
		int maxFileSize = 2048 * 2048 * 6;
		String encType = "utf-8";

		MultipartRequest multi = null;

		try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType,
					new DefaultFileRenamePolicy());
			
			UserTO to = new UserTO();
			String nick = (String)session.getAttribute("nick");
			to.setNick(nick);
			
			if( multi.getFilesystemName( "img" ) == null ) {
				to.setProfile(multi.getParameter( "ex-profile" ) );
			} else {
				to.setProfile(multi.getFilesystemName( "img" ) );
			}

			int flag = userDao.edit_img_ok(to);

			request.setAttribute("flag", flag);
			session.setAttribute("nick",to.getNick());
			request.setAttribute("result", result);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "profile/profile";
	}
	// 프로필 이미지 제거
	@RequestMapping(value = "/delete_img_ok.do")
	public String delete_img_ok(HttpServletRequest request, HttpSession session) {

		int result = 2;
	
		UserTO to = new UserTO();
		String nick = (String)session.getAttribute("nick");
		to.setNick(nick);
				
		int flag = userDao.delete_img_ok(to);


		request.setAttribute("flag", flag);
		request.setAttribute("result", result);

			return "profile/profile";
		
	}



}