
package com.exam.controller;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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

import com.exam.model1.lantripHeart.LantripHeartDAO;
import com.exam.model1.lantripHeart.LantripHeartTO;
import com.exam.model1.lantripReply.LanTripReplyDAO;
import com.exam.model1.lantripReply.LanTripReplyTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.shoppingComment.ShoppingCommentTO;
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
   
   @Autowired
   private LanTripReplyDAO lantripReplyDao;

   // 각자 맞는 upload 폴더 경로로 변경
  
   //private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\lanTrip";
   private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\lanTrip";
   //private String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/lanTrip";
   

   // 랜선여행 목록
   @RequestMapping(value = "/lanTrip_list.do")
   public String lanTrip_list(HttpServletRequest request, Model model, HttpSession session) {
      
//      LanTripListTO listTO = new LanTripListTO();
//      LanTripTO to = new LanTripTO();
//      String nick = (String)session.getAttribute( "nick" );
//      listTO.setCpage( Integer.parseInt( request.getParameter( "cpage" ) == null || request.getParameter( "cpage" ).equals( "" ) ? "1" : request.getParameter( "cpage" ) ) );
//      //로그인아닐 때
//      if( nick == null ) {
//    	  listTO = dao.lanTripList(listTO);
//      } else {   //로그인일 때
//         to.setNick( nick );
//         listTO = dao.lanTripListLogin(listTO, to);
//      }
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
			LanTripTO to = new LanTripTO();
			to.setStartRowNum(startRowNum);
			to.setEndRowNum(endRowNum);
			to.setRowCount(rowCount);

			// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			ArrayList<LanTripTO> lists = null;
			// 전체 row의 개수를 담을 지역변수를 미리 만든다. - 검색조건이 들어올 경우 '검색 결과 갯수'가 된다.
			int totalRow = 0;

			// 만일 검색 키워드가 넘어온다면
			if (!keyword.equals("")) { // 검색 조건이 무엇이냐에 따라 분기하기
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
			}

			// 위의 분기에 따라 pto에 담기는 내용이 다르고
			// 그 내용을 기준으로 조건이 다를때마다 다른 내용이 select 되도록 dynamic query를 구성한다.
			// 글 목록 얻어오기

			if (session.getAttribute("nick") == null) {
				// 로그인 상태가 아닐때
				System.out.println("로그인 상태가 아닐때 ");
				// 사진 자랑 게시판 목록 가져오기

				lists = dao.boardLists(to);
			} else {
				// 로그인 상태일때
				System.out.println("로그인 상태일때 ");

				// 현재사용자의 nick을 세팅
				to.setNick((String) session.getAttribute("nick"));

				// 사진자랑 게시판 목록 가져오기
				lists = dao.lanTripListLogin(to);

			}

			// 글의 개수
			totalRow = dao.LanTripCount(to);

			// 전체 페이지의 갯수 구하기
			int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

			request.setAttribute("lists", lists);
			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("condition", condition);
			request.setAttribute("keyword", keyword);
			request.setAttribute("totalRow", totalRow);
			// pageNum 도 추가로 담아주기
			request.setAttribute("pageNum", pageNum);
     
   // 랜선여행 좋아요(heart)순으로 상위5개 가져오기
			ArrayList<LanTripTO> bestList = new ArrayList();
			bestList = dao.bestList();
			
			
			model.addAttribute( "to", to );
			model.addAttribute( "bestList", bestList );
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      
      return "lanTrip/lanTrip_list";
   }
   
   
	// 랜선여행 목록 - 로딩으로 불러오는 게시물 리스트
	@RequestMapping(value = "/lanTrip_ajax_page.do")
	public String lanTrip_ajax_page(HttpServletRequest request, HttpSession session) {
		
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
			LanTripTO to = new LanTripTO();
			to.setStartRowNum(startRowNum);
			to.setEndRowNum(endRowNum);
			to.setRowCount(rowCount);

			// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			ArrayList<LanTripTO> list = null;
			// 전체 row의 개수를 담을 지역변수를 미리 만든다.
			int totalRow = 0;

			// 만일 검색 키워드가 넘어온다면
			if (!keyword.equals("")) { // 검색 조건이 무엇이냐에 따라 분기하기
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
			}

			// 위의 분기에 따라 pto에 담기는 내용이 다르고
			// 그 내용을 기준으로 조건이 다를때마다 다른 내용이 select 되도록 dynamic query를 구성한다.
			// 글 목록 얻어오기

			if (session.getAttribute("nick") == null) {
				// 로그인 상태가 아닐때
				System.out.println("로그인 상태가 아닐때 ");
				// 사진 자랑 게시판 목록 가져오기

				list = dao.boardLists(to);
			} else {
				// 로그인 상태일때
				System.out.println("로그인 상태일때 ");

				// 현재사용자의 nick을 세팅
				to.setNick((String) session.getAttribute("nick"));

				// 사진자랑 게시판 목록 가져오기
				list = dao.lanTripListLogin(to);

			}

			// 글의 개수
			totalRow = dao.LanTripCount(to);

			// 전체 페이지의 갯수 구하기
			int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

			request.setAttribute("list", list);
			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("condition", condition);
			request.setAttribute("keyword", keyword);
			request.setAttribute("totalRow", totalRow);
			// pageNum 도 추가로 담아주기
			request.setAttribute("pageNum", pageNum);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		/////////////////////////////////////////////////////// 여기까지 lanTrip_list와 동일
		/////////////////////////////////////////////////////// ajax_page는 스크롤을 내릴때 추가되는 게시물들을 가져오기 떄문에 
		/////////////////////////////////////////////////////// best5를 가져갈 필요가 없다. 

		return "lanTrip/lanTrip_ajax_page";
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
	    int maxFileSize = 4096 * 4096 * 6;
	    
	    System.out.println("controller");
	    
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
			System.out.println(flag);
			
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
	   
	   LanTripReplyTO replyTo = new LanTripReplyTO();
	   replyTo.setBno(no);
	   ArrayList<LanTripReplyTO> rLists = lantripReplyDao.lantripReplyList(replyTo);
	   
	   
	   request.setAttribute("to", to);
	   request.setAttribute("no", no);
	   request.setAttribute("rLists", rLists);
	   
      return "lanTrip/lanTrip_view";
   }
   
	// 랜선여행 view reply ok
	@RequestMapping(value = "/lanTrip_view_reply_ok.do")
	public String lanTrip_view_reply_ok(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			//System.out.println(request.getParameter( "bno" ));
			
			String bno = request.getParameter( "bno" );
			String writer = request.getParameter( "cwriter" );
			String content = request.getParameter( "ccontent" );
			LanTripReplyTO replyTo = new LanTripReplyTO();
			replyTo.setBno(bno);
			replyTo.setWriter(writer);
			replyTo.setContent(content);

			int flag = lantripReplyDao.lanTripReplyOk(replyTo);
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

		return "lanTrip/lanTrip_view_reply_ok";
	}
	
	// 랜선여행 rereply_ok
		@RequestMapping(value = "/lanTrip_rereply_ok.do")
		public String lanTrip_rereply_ok(HttpServletRequest request) {
			
			try {
				request.setCharacterEncoding("utf-8");
				
				String cpage = request.getParameter( "cpage" );
				String no = request.getParameter( "no" );
				String bno = request.getParameter("bno");
				String writer = request.getParameter("writer");
				String content = request.getParameter("r_ccontent");
				
				LanTripReplyTO replyTo = new LanTripReplyTO();
				replyTo.setNo(no);
				
				// 부모글의 grp, grps, grpl 가져와서 commentTo에 저장
				replyTo = lantripReplyDao.lanParentSelect(replyTo);
				
				replyTo.setBno(bno);
				replyTo.setWriter(writer);
				replyTo.setContent(content);
				
				//기존에 있던 댓글중에서 부모 댓글과 같은 grp이고 부모 grpl(0)보다 자식 grps가 큰 댓글들은 모두 grps를 1씩 늘려준다.
				int result1 = lantripReplyDao.lanUpdateGrps(replyTo);
				
				//새로운 답글을 추가 (sql문에서 grps와 grpl을 모두 1씩 늘려준다.)
				int flag = 1;
				int result2 = lantripReplyDao.lanRereplyInsertOk(replyTo);
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
			
			return "lanTrip/lanTrip_rereply_ok";
		}
		
		// 랜선여행 reply deleteOk
		@RequestMapping(value = "/lanTrip_reply_deleteOk.do")
		public String lanTrip_reply_deleteOk(HttpServletRequest request, HttpServletResponse response) {
			try {
				request.setCharacterEncoding("utf-8");
				
				String cpage = request.getParameter( "cpage" );
				String bno = request.getParameter( "bno" );	//게시글번호 bno
				String no = request.getParameter( "no" );	//댓글 번호 no
				String grp = request.getParameter( "grp" );	//그룹번호 grp
				
				LanTripReplyTO rto = new LanTripReplyTO();
				rto.setNo(no);
				rto.setGrp(grp);
				
				int flag = lantripReplyDao.lanTrip_reply_deleteOk( rto );
				
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

			return "lanTrip/lanTrip_reply_deleteOk";
		}
		
		// 랜선여행 reply modify
		@RequestMapping(value = "/lanTrip_reply_modifyOk.do")
		public String lanTrip_reply_modifyOk(HttpServletRequest request, HttpServletResponse response) {
			try {
				request.setCharacterEncoding("utf-8");
				
				String cpage = request.getParameter( "cpage" );
				String content = request.getParameter( "ccontent_modify" );	//댓글내용
				String bno = request.getParameter( "bno" );	//게시글번호
				String no = request.getParameter( "no" );	//댓글번호
				
				LanTripReplyTO rto = new LanTripReplyTO();
				rto.setNo(no);
				rto.setContent(content);
				
				int flag = lantripReplyDao.lanTrip_reply_modifyOk( rto );
				
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

			return "lanTrip/lanTrip_reply_modifyOk";
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