package com.exam.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.model1.message.MessageDAO;
import com.exam.model1.message.MessageTO;
import com.exam.model1.otherProfile.OtherProfileDAO;
import com.exam.model1.picture.PictureDAO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.pictureHeart.PictureHeartTO;
import com.exam.model1.pictureReply.ReplyTO;
import com.exam.model1.shopping.ShoppingDAO;
import com.exam.model1.shopping.ShoppingTO;
import com.exam.model1.accom.AccomDAO;
import com.exam.model1.accom.AccomTO;
import com.exam.model1.lantrip.LanTripDAO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.lantripReply.LanTripReplyDAO;
import com.exam.model1.lantripReply.LanTripReplyTO;
import com.exam.model1.user.UserDAO;
import com.exam.model1.user.UserTO;


@Controller
public class OtherProfileController {
   
   @Autowired
   private UserDAO userDao;
   @Autowired
   private OtherProfileDAO otherProfileDao;

   
   @Autowired
   private MessageDAO messageDao;
   
   @Autowired
   private LanTripReplyDAO l_replyDao;
   
   @Autowired
   private LanTripDAO lantripDao;

   @RequestMapping(value = "/other_profile.do")
   public String other_profile(HttpServletRequest request, HttpSession session) {
      
      String nick = (String)session.getAttribute( "nick" );
      
      //게시물 프로필사진 눌렀을 때 넘어오는 nick값과 현재 로그인된 nick값을 비교한다.
      if( nick.equals( request.getParameter("other_nick") ) ) {
         
         // ======= 유저 정보가져오기 =======
         // 세션에 저장된 nick값을 to에 저장
         UserTO uto = new UserTO();
         uto.setNick(nick);

         // 저장된 nick값을 userDao함수 매개변수로 넘겨줌
         // userDao에서 myProfile함수를 실행시켜서 유저 정보를 다시 uto에 저장
         uto = userDao.myProfile(uto);

         // ======= 랜선여행 글list 가져오기 =======
         LanTripTO lto = new LanTripTO();

         String pageNum = request.getParameter("pageNum");

         int recordNum = 9; // 가져올 글의 개수

         int currentPage = 1; // 현재 페이지번호
         if (pageNum != null) {
            currentPage = Integer.parseInt(pageNum);
         }
         int startRowNum = 0 + (currentPage - 1) * recordNum;
         int endRowNum = currentPage * recordNum;

         lto.setWriter(nick);
         lto.setStartRowNum(startRowNum);
         lto.setEndRowNum(endRowNum);

         // 전체 글의 개수를 이용해서 전페 페이지수 구하기
         int totalRow = 0;
         totalRow = lantripDao.profileLanTripCount(lto);

         int totalPageCount = (int) Math.ceil(totalRow / (double) recordNum);

         // 랜선여행 글리스트 결과를 리턴받는다.
         ArrayList<LanTripTO> list = lantripDao.lantrip_MyProfileList(lto);

         // jsp로 uto값을 넘겨줌
         request.setAttribute("uto", uto);
         request.setAttribute("totalPageCount", totalPageCount);
         // jsp로 to가 담긴 arrayList넘겨준다.
         request.setAttribute("pageNum", pageNum);
         request.setAttribute("list", list);
         
         
         return "profile/profile";
      }

      UserTO to = new UserTO();
         
      to.setNick(request.getParameter("other_nick"));
      to = userDao.OtherProfile(to);
         
      System.out.println(to);
         
      request.setAttribute("to", to);
         
      return "other_profile/other_profile";
   }
   
//   // 남이 보는 내 프로필
//   @RequestMapping(value = "/other_profile.do")
//   public String other_profile(HttpServletRequest request) {
//      
//      UserTO to = new UserTO();
//      
//      to.setNick(request.getParameter("other_nick"));
//      to = userDao.OtherProfile(to);
//      
//      System.out.println(to);
//      
//      request.setAttribute("to", to);
//      
//      return "other_profile/other_profile";
//   }
   
   // 메세지 목록 가져오기
   @RequestMapping(value = "/message_content_list_inprofile.do")
   public String message_content_list_inprofile(HttpServletRequest request, HttpSession session) {
      
      System.out.println("other profile 메세지 리스트 가져오기");
      
      //int room = Integer.parseInt(request.getParameter("room"));
      String other_nick = request.getParameter("other_nick");

      MessageTO to = new MessageTO();
      to.setRecv_nick(other_nick);
      to.setNick((String) session.getAttribute("nick"));

      // 메세지 내용을 가져온다.
      ArrayList<MessageTO> clist = messageDao.roomContentList(to);

      request.setAttribute("clist", clist);
      
      System.out.println(clist);

      return "message/message_content_list";
   }

   // 메세지 리스트에서 메세지 보내기
   @ResponseBody
   @RequestMapping(value = "/message_send_inlist_inprofile.do")
   public int message_send_inlist_inprofile(@RequestParam String other_nick, @RequestParam String content, HttpSession session) {
      System.out.println("컨트롤러 들어옴");
      System.out.println("other_nick: " + other_nick);
      System.out.println("content: " + content);
      
      MessageTO to = new MessageTO();
      to.setSend_nick((String) session.getAttribute("nick"));
      to.setRecv_nick(other_nick);
      to.setContent(content);

      int flag = messageDao.messageSendInlist(to);

      return flag;
   }
   
   
   
   
   
   
   // ================================ 랜선여행 ==================================
   
   // 랜선여행 리스트 
   @RequestMapping(value = "/other_ajax_lantrip_page.do")
   public String ajax_lantrip_page(HttpServletRequest request, HttpSession session) {
      try {
         request.setCharacterEncoding("utf-8");
         
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
         

         // startRowNum 과 rowCount 를 PictureTO 객체에 담고
         LanTripTO lto = new LanTripTO();
         
         // 현재 프로필 주인의 nick을 writer로 세팅
         lto.setWriter(request.getParameter("other_nick"));
         lto.setStartRowNum(startRowNum);
         lto.setEndRowNum(endRowNum);
         lto.setRowCount(rowCount);

         // ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
         ArrayList<LanTripTO> list = null;
         // 전체 row의 개수를 담을 지역변수를 미리 만든다.
         int totalRow = 0;
         
         System.out.println(session.getAttribute("nick"));
         
         System.out.println("writer: " + lto.getWriter());
         System.out.println("startrownum: " + lto.getStartRowNum());
         System.out.println("endrownum: " + lto.getEndRowNum());
         System.out.println("rowcount: " + lto.getRowCount());

         if (session.getAttribute("nick") == null) {
            // 로그인 상태가 아닐때
            System.out.println("로그인 상태가 아닐때 ");
            
            // 랜선여행 게시판 목록 가져오기
            list = otherProfileDao.lantripList(lto);
         } else {
            // 로그인 상태일때
//            System.out.println("로그인 상태일때 ");

            // 현재사용자의 nick을 세팅
            lto.setNick((String) session.getAttribute("nick"));

            // 랜선여행 게시판 목록 가져오기
            list = otherProfileDao.lantripList(lto);

         }
         System.out.println("list: " + list);
         // 전체 페이지의 갯수 구하기
         int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

         request.setAttribute("list", list);
         request.setAttribute("totalPageCount", totalPageCount);
         request.setAttribute("totalRow", totalRow);
         // pageNum 도 추가로 담아주기
         request.setAttribute("pageNum", pageNum);
      } catch (UnsupportedEncodingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }


      return "other_profile/other_ajax_lantrip_page";
   }
   
   
   // 모댓글 작성
   @ResponseBody
   @RequestMapping(value = "/other_lantrip_write_reply.do")
   public LanTripTO lanTripwrite_reply(@RequestParam String no, @RequestParam String content, HttpSession session) {

      ReplyTO to = new ReplyTO();

      // 게시물 번호 세팅
      to.setBno(no);

      // 댓글 내용 세팅
      to.setContent(content);

      // 댓글작성자 nick을 writer로 세팅
      to.setWriter((String) session.getAttribute("nick"));
      
      System.out.println("ctrl bno: " + to.getBno());
      System.out.println("ctrl content: " + to.getContent());
      System.out.println("ctrl writer: " + to.getWriter());

      // +1된 댓글 갯수를 담아오기 위함
      LanTripTO lto = otherProfileDao.lanTripWriteReply(to);
   
      return lto;
   }
   
   // 댓글 리스트
   @ResponseBody
   @RequestMapping(value = "/other_lantrip_replyList.do")
   public ArrayList<ReplyTO> reply_list(@RequestParam String no, HttpSession session) {

      ReplyTO to = new ReplyTO();

      // 가져올 댓글 리스트의 게시물번호를 세팅
      to.setBno(no);

      ArrayList<ReplyTO> replyList = new ArrayList();

      replyList = otherProfileDao.lanTripReplyList(to);

      return replyList;
   }
   
   // 답글 작성
   @ResponseBody
   @RequestMapping(value = "/other_lantrip_write_rereply.do")
   public LanTripTO write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content, HttpSession session) {

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
      LanTripTO lto = otherProfileDao.lantripWriteReReply(to);

      return lto;
   }
   
   // 댓글 삭제
   @ResponseBody
   @RequestMapping(value = "/other_lantrip_delete_reply.do")
   public LanTripTO delete_reply(@RequestParam String no, @RequestParam String bno) {

      ReplyTO to = new ReplyTO();

      // 모댓글 번호 세팅
      to.setNo(no);

      // 게시물 번호 세팅
      to.setBno(bno);

      // 갱신된 댓글 갯수를 담아오기 위함
      LanTripTO pto = otherProfileDao.lantripDeleteReply(to);

      return pto;
   }

   // 답글 삭제
   @ResponseBody
   @RequestMapping(value = "/other_lantrip_delete_rereply.do")
   public LanTripTO delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam int grp) {

      ReplyTO to = new ReplyTO();

      // 답글 번호 세팅 - 답글 삭제하기 위해서 필요함
      to.setNo(no);

      // 게시물 번호 세팅 - p_board 의 reply+1하기 위해 필요함
      to.setBno(bno);

      // grp 세팅(모댓글이 뭔지) - 모댓글은 삭제를 해도 답글이 있으면 남아있게 되는데 답글이 모두 삭제되었을 때 모댓글도 삭제하기 위해
      // 필요함
      to.setGrp(grp);

      // 갱신된 댓글 갯수를 담아오기 위함
      LanTripTO pto = otherProfileDao.lantripDeleteReReply(to);

      return pto;
   }
   
   
   
   // ============================= 사진자랑 ==================================
   // 랜선여행하기 리스트 
      @RequestMapping(value = "/other_ajax_picture_page.do")
      public String ajax_picture_page(HttpServletRequest request, HttpSession session) {
         System.out.println("controller");
         try {
            request.setCharacterEncoding("utf-8");
            
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
            

            // startRowNum 과 rowCount 를 PictureTO 객체에 담고
            PictureTO pto = new PictureTO();
            
            // 현재 프로필 주인의 nick을 writer로 세팅
            pto.setWriter(request.getParameter("other_nick"));
            pto.setStartRowNum(startRowNum);
            pto.setEndRowNum(endRowNum);
            pto.setRowCount(rowCount);

            // ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
            ArrayList<PictureTO> list = null;
            // 전체 row의 개수를 담을 지역변수를 미리 만든다.
            int totalRow = 0;
            
            System.out.println(session.getAttribute("nick"));
            
            System.out.println("writer: " + pto.getWriter());
            System.out.println("startrownum: " + pto.getStartRowNum());
            System.out.println("endrownum: " + pto.getEndRowNum());
            System.out.println("rowcount: " + pto.getRowCount());

            if (session.getAttribute("nick") == null) {
               // 로그인 상태가 아닐때
               System.out.println("로그인 상태가 아닐때 ");
               
               // 랜선여행 게시판 목록 가져오기
               list = otherProfileDao.pictureList(pto);
            } else {
               // 로그인 상태일때
//               System.out.println("로그인 상태일때 ");

               // 현재사용자의 nick을 세팅
               pto.setNick((String) session.getAttribute("nick"));

               // 랜선여행 게시판 목록 가져오기
               list = otherProfileDao.pictureList(pto);

            }
            System.out.println("list: " + list);
            // 전체 페이지의 갯수 구하기
            int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

            request.setAttribute("list", list);
            request.setAttribute("totalPageCount", totalPageCount);
            request.setAttribute("totalRow", totalRow);
            // pageNum 도 추가로 담아주기
            request.setAttribute("pageNum", pageNum);
         } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }


         return "other_profile/other_ajax_picture_page";
      }
      
      
      // 모댓글 작성
      @ResponseBody
      @RequestMapping(value = "/other_picture_write_reply.do")
      public PictureTO picture_write_reply(@RequestParam String no, @RequestParam String content, HttpSession session) {

         ReplyTO to = new ReplyTO();

         // 게시물 번호 세팅
         to.setBno(no);

         // 댓글 내용 세팅
         to.setContent(content);

         // 댓글작성자 nick을 writer로 세팅
         to.setWriter((String) session.getAttribute("nick"));
         
         System.out.println("ctrl bno: " + to.getBno());
         System.out.println("ctrl content: " + to.getContent());
         System.out.println("ctrl writer: " + to.getWriter());

         // +1된 댓글 갯수를 담아오기 위함
         PictureTO pto = otherProfileDao.pictureWriteReply(to);
      
         return pto;
      }
      
      // 댓글 리스트
      @ResponseBody
      @RequestMapping(value = "/other_picture_replyList.do")
      public ArrayList<ReplyTO> picture_reply_list(@RequestParam String no, HttpSession session) {

         ReplyTO to = new ReplyTO();

         // 가져올 댓글 리스트의 게시물번호를 세팅
         to.setBno(no);

         ArrayList<ReplyTO> replyList = new ArrayList();

         replyList = otherProfileDao.pictureReplyList(to);

         return replyList;
      }
      
      // 답글 작성
      @ResponseBody
      @RequestMapping(value = "/other_picture_write_rereply.do")
      public PictureTO picture_write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content, HttpSession session) {

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
         PictureTO pto = otherProfileDao.pictureWriteReReply(to);

         return pto;
      }
      
      // 댓글 삭제
      @ResponseBody
      @RequestMapping(value = "/other_picture_delete_reply.do")
      public PictureTO picture_delete_reply(@RequestParam String no, @RequestParam String bno) {

         ReplyTO to = new ReplyTO();

         // 모댓글 번호 세팅
         to.setNo(no);

         // 게시물 번호 세팅
         to.setBno(bno);

         // 갱신된 댓글 갯수를 담아오기 위함
         PictureTO pto = otherProfileDao.pictureDeleteReply(to);

         return pto;
      }

      // 답글 삭제
      @ResponseBody
      @RequestMapping(value = "/other_picture_delete_rereply.do")
      public PictureTO picture_delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam int grp) {

         ReplyTO to = new ReplyTO();

         // 답글 번호 세팅 - 답글 삭제하기 위해서 필요함
         to.setNo(no);

         // 게시물 번호 세팅 - p_board 의 reply+1하기 위해 필요함
         to.setBno(bno);

         // grp 세팅(모댓글이 뭔지) - 모댓글은 삭제를 해도 답글이 있으면 남아있게 되는데 답글이 모두 삭제되었을 때 모댓글도 삭제하기 위해
         // 필요함
         to.setGrp(grp);

         // 갱신된 댓글 갯수를 담아오기 위함
         PictureTO pto = otherProfileDao.pictureDeleteReReply(to);

         return pto;
      }
      
      
      // ================================ 쇼핑정보 ==================================
      
      // 쇼핑정보 리스트 
      @RequestMapping(value = "/other_ajax_shopping_page.do")
      public String ajax_shopping_page(HttpServletRequest request, HttpSession session) {
         try {
            request.setCharacterEncoding("utf-8");
            
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
            

            // startRowNum 과 rowCount 를 PictureTO 객체에 담고
            ShoppingTO sto = new ShoppingTO();
            
            // 현재 프로필 주인의 nick을 writer로 세팅
            sto.setWriter(request.getParameter("other_nick"));
            sto.setStartRowNum(startRowNum);
            sto.setEndRowNum(endRowNum);
            sto.setRowCount(rowCount);

            // ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
            ArrayList<ShoppingTO> list = null;
            // 전체 row의 개수를 담을 지역변수를 미리 만든다.
            int totalRow = 0;
            
            System.out.println(session.getAttribute("nick"));
            
            System.out.println("writer: " + sto.getWriter());
            System.out.println("startrownum: " + sto.getStartRowNum());
            System.out.println("endrownum: " + sto.getEndRowNum());
            System.out.println("rowcount: " + sto.getRowCount());

            if (session.getAttribute("nick") == null) {
               // 로그인 상태가 아닐때
               System.out.println("로그인 상태가 아닐때 ");
               
               // 랜선여행 게시판 목록 가져오기
               list = otherProfileDao.shoppingList(sto);
            } else {
               // 로그인 상태일때
//               System.out.println("로그인 상태일때 ");

               // 현재사용자의 nick을 세팅
               sto.setNick((String) session.getAttribute("nick"));

               // 랜선여행 게시판 목록 가져오기
               list = otherProfileDao.shoppingList(sto);

            }
            System.out.println("list: " + list);
            // 전체 페이지의 갯수 구하기
            int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

            request.setAttribute("list", list);
            request.setAttribute("totalPageCount", totalPageCount);
            request.setAttribute("totalRow", totalRow);
            // pageNum 도 추가로 담아주기
            request.setAttribute("pageNum", pageNum);
         } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }


         return "other_profile/other_ajax_shopping_page";
      }
      
      
      // 모댓글 작성
      @ResponseBody
      @RequestMapping(value = "/other_shopping_write_reply.do")
      public ShoppingTO shoppingwrite_reply(@RequestParam String no, @RequestParam String content, HttpSession session) {

         ReplyTO to = new ReplyTO();

         // 게시물 번호 세팅
         to.setBno(no);

         // 댓글 내용 세팅
         to.setContent(content);

         // 댓글작성자 nick을 writer로 세팅
         to.setWriter((String) session.getAttribute("nick"));
         
         System.out.println("ctrl bno: " + to.getBno());
         System.out.println("ctrl content: " + to.getContent());
         System.out.println("ctrl writer: " + to.getWriter());

         // 댓글을 쓰고 +1된 댓글 갯수를 담아오기 위함
         ShoppingTO sto = otherProfileDao.shoppingWriteReply(to);
      
         return sto;
      }
      
      // 댓글 리스트
      @ResponseBody
      @RequestMapping(value = "/other_shopping_replyList.do")
      public ArrayList<ReplyTO> shopping_reply_list(@RequestParam String no, HttpSession session) {

         ReplyTO to = new ReplyTO();

         // 가져올 댓글 리스트의 게시물번호를 세팅
         to.setBno(no);

         ArrayList<ReplyTO> replyList = new ArrayList();

         replyList = otherProfileDao.shoppingReplyList(to);

         return replyList;
      }
      
      // 답글 작성
      @ResponseBody
      @RequestMapping(value = "/other_shopping_write_rereply.do")
      public ShoppingTO shopping__write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content, HttpSession session) {

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
         ShoppingTO sto = otherProfileDao.shoppingWriteReReply(to);

         return sto;
      }
      
      // 댓글 삭제
      @ResponseBody
      @RequestMapping(value = "/other_shopping_delete_reply.do")
      public ShoppingTO shopping_delete_reply(@RequestParam String no, @RequestParam String bno) {

         ReplyTO to = new ReplyTO();

         // 모댓글 번호 세팅
         to.setNo(no);

         // 게시물 번호 세팅
         to.setBno(bno);

         // 갱신된 댓글 갯수를 담아오기 위함
         ShoppingTO sto = otherProfileDao.shoppingDeleteReply(to);

         return sto;
      }

      // 답글 삭제
      @ResponseBody
      @RequestMapping(value = "/other_shopping_delete_rereply.do")
      public ShoppingTO shopping_delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam int grp) {

         ReplyTO to = new ReplyTO();

         // 답글 번호 세팅 - 답글 삭제하기 위해서 필요함
         to.setNo(no);

         // 게시물 번호 세팅 - p_board 의 reply+1하기 위해 필요함
         to.setBno(bno);

         // grp 세팅(모댓글이 뭔지) - 모댓글은 삭제를 해도 답글이 있으면 남아있게 되는데 답글이 모두 삭제되었을 때 모댓글도 삭제하기 위해
         // 필요함
         to.setGrp(grp);

         // 갱신된 댓글 갯수를 담아오기 위함
         ShoppingTO sto = otherProfileDao.shoppingDeleteReReply(to);

         return sto;
      }
      
      
      
      // ================================ 숙소정보 ==================================
      
      // 숙소정보 리스트 
      @RequestMapping(value = "/other_ajax_accom_page.do")
      public String ajax_accom_page(HttpServletRequest request, HttpSession session) {
         try {
            request.setCharacterEncoding("utf-8");
            
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
                  

            // startRowNum 과 rowCount 를 PictureTO 객체에 담고
            AccomTO sto = new AccomTO();
                  
            // 현재 프로필 주인의 nick을 writer로 세팅
            sto.setWriter(request.getParameter("other_nick"));
            sto.setStartRowNum(startRowNum);
            sto.setEndRowNum(endRowNum);
            sto.setRowCount(rowCount);

            // ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
            ArrayList<AccomTO> list = null;
            // 전체 row의 개수를 담을 지역변수를 미리 만든다.
            int totalRow = 0;
                  
            System.out.println(session.getAttribute("nick"));
            
            System.out.println("writer: " + sto.getWriter());
            System.out.println("startrownum: " + sto.getStartRowNum());
            System.out.println("endrownum: " + sto.getEndRowNum());
            System.out.println("rowcount: " + sto.getRowCount());

            if (session.getAttribute("nick") == null) {
               // 로그인 상태가 아닐때
               System.out.println("로그인 상태가 아닐때 ");
                     
               // 랜선여행 게시판 목록 가져오기
               list = otherProfileDao.accomList(sto);
            } else {
               // 로그인 상태일때
//               System.out.println("로그인 상태일때 ");

               // 현재사용자의 nick을 세팅
               sto.setNick((String) session.getAttribute("nick"));

               // 랜선여행 게시판 목록 가져오기
               list = otherProfileDao.accomList(sto);

            }
            System.out.println("list: " + list);
            // 전체 페이지의 갯수 구하기
            int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

            request.setAttribute("list", list);
            request.setAttribute("totalPageCount", totalPageCount);
            request.setAttribute("totalRow", totalRow);
            // pageNum 도 추가로 담아주기
            request.setAttribute("pageNum", pageNum);
         } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }


         return "other_profile/other_ajax_accom_page";
      }
            
            
      // 모댓글 작성
      @ResponseBody
      @RequestMapping(value = "/other_accom_write_reply.do")
      public AccomTO accomwrite_reply(@RequestParam String no, @RequestParam String content, HttpSession session) {

         ReplyTO to = new ReplyTO();

         // 게시물 번호 세팅
         to.setBno(no);

         // 댓글 내용 세팅
         to.setContent(content);

         // 댓글작성자 nick을 writer로 세팅
         to.setWriter((String) session.getAttribute("nick"));
               
         System.out.println("ctrl bno: " + to.getBno());
         System.out.println("ctrl content: " + to.getContent());
         System.out.println("ctrl writer: " + to.getWriter());

         // 댓글을 쓰고 +1된 댓글 갯수를 담아오기 위함
         AccomTO sto = otherProfileDao.accomWriteReply(to);
            
         return sto;
      }
            
      // 댓글 리스트
      @ResponseBody
      @RequestMapping(value = "/other_accom_replyList.do")
      public ArrayList<ReplyTO> accom_reply_list(@RequestParam String no, HttpSession session) {

         ReplyTO to = new ReplyTO();

         // 가져올 댓글 리스트의 게시물번호를 세팅
         to.setBno(no);

         ArrayList<ReplyTO> replyList = new ArrayList();

         replyList = otherProfileDao.accomReplyList(to);

         return replyList;
      }
            
      // 답글 작성
      @ResponseBody
      @RequestMapping(value = "/other_accom_write_rereply.do")
      public AccomTO accom__write_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam String content, HttpSession session) {

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
         AccomTO sto = otherProfileDao.accomWriteReReply(to);

         return sto;
      }
            
      // 댓글 삭제
      @ResponseBody
      @RequestMapping(value = "/other_accom_delete_reply.do")
      public AccomTO accom_delete_reply(@RequestParam String no, @RequestParam String bno) {

         ReplyTO to = new ReplyTO();

         // 모댓글 번호 세팅
         to.setNo(no);

         // 게시물 번호 세팅
         to.setBno(bno);

         // 갱신된 댓글 갯수를 담아오기 위함
         AccomTO sto = otherProfileDao.accomDeleteReply(to);

         return sto;
      }

      // 답글 삭제
      @ResponseBody
      @RequestMapping(value = "/other_accom_delete_rereply.do")
      public AccomTO accom_delete_rereply(@RequestParam String no, @RequestParam String bno, @RequestParam int grp) {

         ReplyTO to = new ReplyTO();

         // 답글 번호 세팅 - 답글 삭제하기 위해서 필요함
         to.setNo(no);

         // 게시물 번호 세팅 - p_board 의 reply+1하기 위해 필요함
         to.setBno(bno);

         // grp 세팅(모댓글이 뭔지) - 모댓글은 삭제를 해도 답글이 있으면 남아있게 되는데 답글이 모두 삭제되었을 때 모댓글도 삭제하기 위해
         // 필요함
         to.setGrp(grp);

         // 갱신된 댓글 갯수를 담아오기 위함
         AccomTO sto = otherProfileDao.accomDeleteReReply(to);

         return sto;
      }
}