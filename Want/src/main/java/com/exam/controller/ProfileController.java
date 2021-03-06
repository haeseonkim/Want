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
	//private String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/profile";
	//private String uploadPath = "C:\\KICKIC\\Want\\Want\\src\\main\\webapp\\upload\\profile";
   
	//????????? ??????
	private String uploadPath = "/home/want/apache-tomcat-9.0.44/webapps/Want/upload/profile";
  
   // ??? ?????????
   @RequestMapping(value = "/profile.do")
   public String profile(HttpServletRequest request, HttpSession session) {
      try {

    	  // ?????? ??????????????? 0, ????????? ?????? ?????? ??? 1
    	  // profil.jsp??? jsp??? ?????? ??????
    	  int result= 0;
    	  

         request.setCharacterEncoding("utf-8");
         
         //======= ?????? ?????????????????? =======
         //????????? ????????? nick?????? to??? ??????
         UserTO uto = new UserTO();
         String nick = (String)session.getAttribute( "nick" );
         uto.setNick(nick);
         
         //????????? nick?????? userDao?????? ??????????????? ?????????
         //userDao?????? myProfile????????? ??????????????? ?????? ????????? ?????? uto??? ??????
         uto = userDao.myProfile(uto);
         
         
         
         //======= ???????????? ???list ???????????? =======
         LanTripTO lto = new LanTripTO();
         
         String pageNum = request.getParameter( "pageNum" );
         
         int recordNum = 9;   //????????? ?????? ??????
         
         int currentPage = 1;   //?????? ???????????????
         if( pageNum != null ) {
            currentPage = Integer.parseInt( pageNum );
         }         
         int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
         int endRowNum = currentPage * recordNum;
         
         lto.setWriter(nick);
         lto.setStartRowNum(startRowNum);
         lto.setEndRowNum(endRowNum);
         
         //?????? ?????? ????????? ???????????? ?????? ???????????? ?????????
         int totalRow = 0;
         totalRow = lantripDao.profileLanTripCount( lto );
         
         int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );

         //???????????? ???????????? ????????? ???????????????.
         ArrayList<LanTripTO> list = lantripDao.lantrip_MyProfileList(lto);
      
         
         //jsp??? uto?????? ?????????
         request.setAttribute( "uto", uto );
         request.setAttribute( "totalPageCount", totalPageCount );
         //jsp??? to??? ?????? arrayList????????????.
         request.setAttribute( "pageNum", pageNum );
         request.setAttribute( "list", list );   

         
         request.setAttribute("result", result);


      } catch (UnsupportedEncodingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      return "profile/profile";
   }
   


   //????????????????????? ????????????
   @RequestMapping(value = "/profile_lanTrip_ajax_page.do")
   public String profile_lanTrip_ajax_page(HttpServletRequest request, HttpSession session) {
      try {
         request.setCharacterEncoding("utf-8");

         
         //????????? ????????? nick?????? ????????? ????????? ????????? ????????? 
         //startRowNum??? endRowNum??? to??? ??????
         LanTripTO lto = new LanTripTO();
         
         String writer = (String)session.getAttribute( "nick" );
         String pageNum = request.getParameter( "pageNum" );
         
         int recordNum = 9;   //????????? ?????? ??????
         
         int currentPage = 1;   //?????? ???????????????
         if( pageNum != null ) {
            currentPage = Integer.parseInt( pageNum );
         }         
         int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
         int endRowNum = currentPage * recordNum;
         
         lto.setWriter(writer);
         lto.setStartRowNum(startRowNum);
         lto.setEndRowNum(endRowNum);
         
         //?????? ?????? ????????? ???????????? ?????? ???????????? ?????????
         int totalRow = 0;
         totalRow = lantripDao.profileLanTripCount( lto );
         
         int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );
         
         //???????????? ???????????? ????????? ???????????????.
         ArrayList<LanTripTO> list = lantripDao.lantrip_MyProfileList(lto);
         
         //jsp??? to??? ?????? arrayList????????????.
         request.setAttribute( "totalPageCount", totalPageCount );
         request.setAttribute( "pageNum", pageNum );
         request.setAttribute( "list", list );
         

      } catch (UnsupportedEncodingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      return "profile/profile_lanTrip_ajax_page";
   }
   
   //?????????????????? ???????????????
   @RequestMapping(value = "/lantrip_replyList.do")
   public String lantrip_replyList(HttpServletRequest request, HttpSession session) {

      LanTripReplyTO to = new LanTripReplyTO();
      
      // ????????? ?????? ???????????? ?????????????????? ??????
      to.setBno( request.getParameter( "no" ) );

      ArrayList<LanTripReplyTO> replyList = new ArrayList();

      replyList = l_replyDao.lantripReplyList(to);
         
      request.setAttribute( "rlist", replyList );
      
      return "profile/profile_lantripReply_ajax_page";
   }
   
   //???????????? ????????? ??????
   @ResponseBody
   @RequestMapping( value= "/lantrip_write_reply.do" )
   public LanTripTO lantrip_write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session ) {
      
      LanTripReplyTO to = new LanTripReplyTO();
      //??????????????? ??????
      to.setBno(bno);
      
      //?????? ?????? ??????
      to.setContent(content);
      
      //?????? ????????? nick??? writer??? ??????
      to.setWriter( (String)session.getAttribute( "nick" ) );
      
      LanTripTO lto = l_replyDao.lantripWriteReply( to );
      
      return lto;
   }
   
   // ????????? ??????
   @ResponseBody
   @RequestMapping(value = "/lantrip_delete_reply.do")

   public LanTripTO lantrip_delete_reply(@RequestParam String no, @RequestParam String bno, @RequestParam int grpl) {


      LanTripReplyTO to = new LanTripReplyTO();

      // ????????? ?????? ??????
      to.setNo(no);

      // ????????? ?????? ??????
      to.setBno(bno);
      
      //grpl??????
      to.setGrpl(grpl);


      // ????????? ?????? ????????? ???????????? ??????
      LanTripTO lto = l_replyDao.lantripDeleteReply(to);

      return lto;
   }
   
   // ???????????? ??????
   @ResponseBody
   @RequestMapping(value = "/lantrip_delete_rereply.do")

   public LanTripTO lantrip_delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String grp) {


      LanTripReplyTO to = new LanTripReplyTO();

      // ????????? ?????? ??????
      to.setNo(no);

      // ????????? ?????? ??????
      to.setBno(bno);
      
      //grp??????
      to.setGrp(grp);

      // ????????? ?????? ????????? ???????????? ??????

      LanTripTO lto = l_replyDao.lantripDeleteRereply(to);


      return lto;
   }
   

   	//?????? ??????
	@ResponseBody
	@RequestMapping(value = "/lantrip_write_rereply.do")
	public LanTripTO lantrip_write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content,
			HttpSession session) {

		LanTripReplyTO to = new LanTripReplyTO();

		// ????????? ?????? ??????
		to.setBno(bno);

		// grp, grps, grpl ??? ReplyTO??? int??? ???????????? ?????? ????????? String??? no??? int??? ???????????? ????????????.
		// ????????? ?????? no??? grp?????? ????????????.
		to.setGrp(no);

		// ????????? ????????? 1???????????? ????????? grpl??? 1??? ????????????.
		to.setGrpl(1);

		// ?????? ?????? ??????
		to.setContent(content);

		// ??????????????? nick??? writer??? ??????
		to.setWriter((String)session.getAttribute("nick"));

		// +1??? ?????? ????????? ???????????? ??????
		LanTripTO lto = l_replyDao.lantripWriteReReply(to);
		
		
		return lto;
	}
   
	//=====================????????????=========================
	// ?????? ????????? ????????????
	@RequestMapping(value = "/profile_picture_ajax_page.do")
	public String profile_picture_ajax_page(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");

			// ????????? ????????? nick?????? ????????? ????????? ????????? ?????????
			// startRowNum??? endRowNum??? to??? ??????
			PictureTO to = new PictureTO();

			String writer = (String) session.getAttribute("nick");
			String pageNum = request.getParameter("pageNum");

			int recordNum = 9; // ????????? ?????? ??????

			int currentPage = 1; // ?????? ???????????????
			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}
			int startRowNum = 0 + (currentPage - 1) * recordNum;
			int endRowNum = currentPage * recordNum;

			to.setWriter(writer);
			to.setStartRowNum(startRowNum);
			to.setEndRowNum(endRowNum);

			// ?????? ?????? ????????? ???????????? ?????? ???????????? ?????????
			int totalRow = 0;
			totalRow = pictureDao.PictureCount(to);
			
			int totalPageCount = (int) Math.ceil(totalRow / (double) recordNum);

			// ???????????? ???????????? ????????? ???????????????.
			ArrayList<PictureTO> list = pictureDao.picture_MyProfileList(to);
			
			// jsp??? to??? ?????? arrayList????????????.
			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("list", list);

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "profile/profile_picture_ajax_page";
	}

	// ?????? ???????????????
	@RequestMapping(value = "/Picture_replyList.do")
	public String picture_replyList(HttpServletRequest request, HttpSession session) {

		ReplyTO to = new ReplyTO();

		// ????????? ?????? ???????????? ?????????????????? ??????
		to.setBno(request.getParameter("no"));

		ArrayList<ReplyTO> replyList = new ArrayList();
		
		//??????????????? ?????????
		replyList = p_replyDao.replyList(to);
		
		request.setAttribute("rlist", replyList);

		return "profile/profile_lantripReply_ajax_page";
	}

	// ?????? ????????? ??????
	@ResponseBody
	@RequestMapping(value = "/Picture_write_reply.do")
	public PictureTO picture_write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session) {
		
		ReplyTO to = new ReplyTO();
		// ??????????????? ??????
		to.setBno(bno);

		// ?????? ?????? ??????
		to.setContent(content);

		// ?????? ????????? nick??? writer??? ??????
		to.setWriter((String) session.getAttribute("nick"));
		
		PictureTO pto = p_replyDao.profile_pictureWriteReply(to);
		
		return pto;
	}

	// ????????? ??????
	@ResponseBody
	@RequestMapping(value = "/Picture_delete_reply.do")
	public PictureTO picture_delete_reply(@RequestParam String no, @RequestParam String bno, @RequestParam int grpl) {

		ReplyTO to = new ReplyTO();

		// ????????? ?????? ??????
		to.setNo(no);

		// ????????? ?????? ??????
		to.setBno(bno);

		// grpl??????
		to.setGrpl(grpl);

		// ????????? ?????? ????????? ???????????? ??????
		PictureTO pto = p_replyDao.pictureDeleteReply(to);

		return pto;
	}

	// ???????????? ??????
	@ResponseBody
	@RequestMapping(value = "/Picture_delete_rereply.do")
	public PictureTO picure_delete_rereply(@RequestParam String no, @RequestParam String bno,
			@RequestParam String grp) {

		ReplyTO to = new ReplyTO();

		// ????????? ?????? ??????
		to.setNo(no);

		// ????????? ?????? ??????
		to.setBno(bno);

		// grp??????
		to.setGrp( Integer.parseInt(grp) );

		// ????????? ?????? ????????? ???????????? ??????
		PictureTO pto = p_replyDao.pictureDeleteReReply(to);

		return pto;
	}

	// ?????? ??????
	@ResponseBody
	@RequestMapping(value = "/Picture_write_rereply.do")
	public PictureTO picture_write_rereply(@RequestParam String no, @RequestParam String bno,
			@RequestParam String content, HttpSession session) {

		ReplyTO to = new ReplyTO();

		// ????????? ?????? ??????
		to.setBno(bno);

		// grp, grps, grpl ??? ReplyTO??? int??? ???????????? ?????? ????????? String??? no??? int??? ???????????? ????????????.
		// ????????? ?????? no??? grp?????? ????????????.
		to.setGrp( Integer.parseInt(no) );

		// ????????? ????????? 1???????????? ????????? grpl??? 1??? ????????????.
		to.setGrpl(1);

		// ?????? ?????? ??????
		to.setContent(content);

		// ??????????????? nick??? writer??? ??????
		to.setWriter((String) session.getAttribute("nick"));

		// +1??? ?????? ????????? ???????????? ??????
		PictureTO lto = p_replyDao.pictureWriteReReply(to);

		return lto;
	}
	
	//=====================????????????=========================
   //??????????????? ????????????
   @RequestMapping(value = "/profile_shop_ajax_page.do")
   public String profile_shop_ajax_page(HttpServletRequest request, HttpSession session) {
      try {
         request.setCharacterEncoding("utf-8");
         
         //????????? ????????? nick?????? ????????? ????????? ????????? ?????????
         //startRowNum??? endRowNum??? to??? ??????
         ShoppingTO sto = new ShoppingTO();
         
         String writer = (String)session.getAttribute( "nick" );
         String pageNum = request.getParameter( "pageNum" );
         
         int recordNum = 9;   //????????? ?????? ??????
         
         int currentPage = 1;   //?????? ???????????????
         if( pageNum != null ) {
            currentPage = Integer.parseInt( pageNum );
         }         
         int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
         int endRowNum = currentPage * recordNum;
         
         sto.setWriter(writer);
         sto.setStartRowNum(startRowNum);
         sto.setEndRowNum(endRowNum);
         
         //?????? ?????? ????????? ???????????? ?????? ???????????? ?????????
         int totalRow = 0;
         totalRow = shopDao.profileShopCount( sto );
         
         int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );
         
         //???????????? ???????????? ????????? ???????????????.
         ArrayList<ShoppingTO> list = shopDao.shop_MyProfileList(sto);
         
         //jsp??? to??? ?????? arrayList????????????.
         request.setAttribute( "totalPageCount", totalPageCount );
         request.setAttribute( "pageNum", pageNum );
         request.setAttribute( "list", list );
         

      } catch (UnsupportedEncodingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      return "profile/profile_shop_ajax_page";
   }
   
   //?????? ???????????????
   @RequestMapping(value = "/shop_replyList.do")
   public String shop_replyList(HttpServletRequest request, HttpSession session) {

      ShoppingCommentTO to = new ShoppingCommentTO();
      
      // ????????? ?????? ???????????? ?????????????????? ??????
      to.setBno( request.getParameter( "no" ) );

      ArrayList<ShoppingCommentTO> replyList = new ArrayList();

      replyList = s_replyDao.shopReplyList(to);
         
      request.setAttribute( "rlist", replyList );
      
      return "profile/profile_shopReply_ajax_page";
   }
   
   //?????? ????????? ??????
   @ResponseBody
   @RequestMapping( value= "/shop_write_reply.do" )
   public ShoppingTO shop_write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session ) {
      
	   ShoppingCommentTO to = new ShoppingCommentTO();
      //??????????????? ??????
      to.setBno(bno);
      
      //?????? ?????? ??????
      to.setContent(content);
      
      //?????? ????????? nick??? writer??? ??????
      to.setWriter( (String)session.getAttribute( "nick" ) );
      
      ShoppingTO sto = s_replyDao.shopWriteReply( to );
      
      return sto;
   }
   
   // ????????? ??????
   @ResponseBody
   @RequestMapping(value = "/shop_delete_reply.do")
   public ShoppingTO shop_delete_reply(@RequestParam String no, @RequestParam String bno, @RequestParam int grpl) {

	   ShoppingCommentTO to = new ShoppingCommentTO();

      // ????????? ?????? ??????
      to.setNo(no);

      // ????????? ?????? ??????
      to.setBno(bno);
      
      //grpl??????
      to.setGrpl(grpl);

      // ????????? ?????? ????????? ???????????? ??????
      ShoppingTO sto = s_replyDao.shopDeleteReply(to);

      return sto;
   }
   
   // ???????????? ??????
   @ResponseBody
   @RequestMapping(value = "/shop_delete_rereply.do")
   public ShoppingTO shop_delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String grp) {

	   ShoppingCommentTO to = new ShoppingCommentTO();

      // ????????? ?????? ??????
      to.setNo(no);

      // ????????? ?????? ??????
      to.setBno(bno);
      
      //grp??????
      to.setGrp(grp);

      // ????????? ?????? ????????? ???????????? ??????
      ShoppingTO sto = s_replyDao.shopDeleteRereply(to);

      return sto;
   }
   
   	//?????? ??????
	@ResponseBody
	@RequestMapping(value = "/shop_write_rereply.do")
	public ShoppingTO shop_write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content,
			HttpSession session) {

		ShoppingCommentTO to = new ShoppingCommentTO();

		// ????????? ?????? ??????
		to.setBno(bno);

		// grp, grps, grpl ??? ReplyTO??? int??? ???????????? ?????? ????????? String??? no??? int??? ???????????? ????????????.
		// ????????? ?????? no??? grp?????? ????????????.
		to.setGrp(no);

		// ????????? ????????? 1???????????? ????????? grpl??? 1??? ????????????.
		to.setGrpl(1);

		// ?????? ?????? ??????
		to.setContent(content);

		// ??????????????? nick??? writer??? ??????
		to.setWriter((String)session.getAttribute("nick"));

		// +1??? ?????? ????????? ???????????? ??????
		ShoppingTO sto = s_replyDao.shopWriteReReply(to);
		
		return sto;
	}
	
	//=====================????????????=========================
   //??????????????? ????????????
   @RequestMapping(value = "/profile_accom_ajax_page.do")
   public String profile_accom_ajax_page(HttpServletRequest request, HttpSession session) {
      try {
         request.setCharacterEncoding("utf-8");
         
         //????????? ????????? nick?????? ????????? ????????? ????????? ?????????
         //startRowNum??? endRowNum??? to??? ??????
         AccomTO ato = new AccomTO();
         
         String writer = (String)session.getAttribute( "nick" );
         String pageNum = request.getParameter( "pageNum" );
         
         int recordNum = 9;   //????????? ?????? ??????
         
         int currentPage = 1;   //?????? ???????????????
         if( pageNum != null ) {
            currentPage = Integer.parseInt( pageNum );
         }         
         int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
         int endRowNum = currentPage * recordNum;
         
         ato.setWriter(writer);
         ato.setStartRowNum(startRowNum);
         ato.setEndRowNum(endRowNum);
         
         //?????? ?????? ????????? ???????????? ?????? ???????????? ?????????
         int totalRow = 0;
         totalRow = accomDao.profileAccomCount( ato );
         
         int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );
         
         //???????????? ???????????? ????????? ???????????????.
         ArrayList<AccomTO> list = accomDao.accom_MyProfileList(ato);
         
         //jsp??? to??? ?????? arrayList????????????.
         request.setAttribute( "totalPageCount", totalPageCount );
         request.setAttribute( "pageNum", pageNum );
         request.setAttribute( "list", list );
         

      } catch (UnsupportedEncodingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      return "profile/profile_accom_ajax_page";
   }
   
   //?????? ???????????????
   @RequestMapping(value = "/accom_replyList.do")
   public String accom_replyList(HttpServletRequest request, HttpSession session) {

      AccomCommentTO to = new AccomCommentTO();
      
      // ????????? ?????? ???????????? ?????????????????? ??????
      to.setBno( request.getParameter( "no" ) );

      ArrayList<AccomCommentTO> replyList = new ArrayList();

      replyList = a_replyDao.accomReplyList(to);
         
      request.setAttribute( "rlist", replyList );
      
      return "profile/profile_accomReply_ajax_page";
   }
   
   //?????? ????????? ??????
   @ResponseBody
   @RequestMapping( value= "/accom_write_reply.do" )
   public AccomTO accom_write_reply(@RequestParam String bno, @RequestParam String content, HttpSession session ) {
      
	   AccomCommentTO to = new AccomCommentTO();
      //??????????????? ??????
      to.setBno(bno);
      
      //?????? ?????? ??????
      to.setContent(content);
      
      //?????? ????????? nick??? writer??? ??????
      to.setWriter( (String)session.getAttribute( "nick" ) );
      
      AccomTO ato = a_replyDao.accomWriteReply( to );
      
      return ato;
   }
   
   // ????????? ??????
   @ResponseBody
   @RequestMapping(value = "/accom_delete_reply.do")
   public AccomTO accom_delete_reply(@RequestParam String no, @RequestParam String bno, @RequestParam int grpl) {

	   AccomCommentTO to = new AccomCommentTO();

      // ????????? ?????? ??????
      to.setNo(no);

      // ????????? ?????? ??????
      to.setBno(bno);
      
      //grpl??????
      to.setGrpl(grpl);

      // ????????? ?????? ????????? ???????????? ??????
      AccomTO ato = a_replyDao.accomDeleteReply(to);

      return ato;
   }
   
   // ???????????? ??????
   @ResponseBody
   @RequestMapping(value = "/accom_delete_rereply.do")
   public AccomTO accom_delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String grp) {

	   AccomCommentTO to = new AccomCommentTO();

      // ????????? ?????? ??????
      to.setNo(no);

      // ????????? ?????? ??????
      to.setBno(bno);
      
      //grp??????
      to.setGrp(grp);

      // ????????? ?????? ????????? ???????????? ??????
      AccomTO ato = a_replyDao.accomDeleteRereply(to);

      return ato;
   }
   
   	//?????? ??????
	@ResponseBody
	@RequestMapping(value = "/accom_write_rereply.do")
	public AccomTO accom_write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content,
			HttpSession session) {

		AccomCommentTO to = new AccomCommentTO();

		// ????????? ?????? ??????
		to.setBno(bno);

		// grp, grps, grpl ??? ReplyTO??? int??? ???????????? ?????? ????????? String??? no??? int??? ???????????? ????????????.
		// ????????? ?????? no??? grp?????? ????????????.
		to.setGrp(no);

		// ????????? ????????? 1???????????? ????????? grpl??? 1??? ????????????.
		to.setGrpl(1);

		// ?????? ?????? ??????
		to.setContent(content);

		// ??????????????? nick??? writer??? ??????
		to.setWriter((String)session.getAttribute("nick"));

		// +1??? ?????? ????????? ???????????? ??????
		AccomTO ato = a_replyDao.accomWriteReReply(to);
		
		return ato;
	}


   
   // ???????????? ????????? ?????? ???????????? ????????????
   @RequestMapping(value = "/edit_profile.do")
   public String edit_profile(HttpServletRequest request, HttpSession session) {
      try {
         request.setCharacterEncoding("utf-8");

         // ======= ?????? ?????????????????? =======
         // ????????? ????????? nick?????? to??? ??????
         UserTO uto = new UserTO();
         String nick = (String) session.getAttribute("nick");
         uto.setNick(nick);

         // ????????? nick?????? userDao?????? ??????????????? ?????????
         // userDao?????? myProfile????????? ??????????????? ?????? ????????? ?????? uto??? ??????
         uto = userDao.myProfile(uto);

         // jsp??? uto?????? ?????????
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
		System.out.println("session nick ??? : "+session.getAttribute("nick"));
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
		
		if(edit==1) {	// ?????? ??????
			flag = 0;
			
			// ?????????????????? session??? nick??? ????????? nick?????? ??????
			session.setAttribute("nick",to.getNick());
			System.out.println("session nick ?????? ??? : "+session.getAttribute("nick"));
			
		} else {		// ?????? ??????
			flag = 1;
			System.out.println("session nick ?????? ??? : "+session.getAttribute("nick"));
		}

		request.setAttribute("flag", flag);
			
		return "profile/edit_profile_ok";
	}
		
	// ????????? ????????? ??????
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
	// ????????? ????????? ??????
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