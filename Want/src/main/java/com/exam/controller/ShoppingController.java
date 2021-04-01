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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.exam.model1.shopHeart.ShopHeartDAO;
import com.exam.model1.shopHeart.ShopHeartTO;
import com.exam.model1.shopping.ShoppingDAO;
import com.exam.model1.shopping.ShoppingListTO;
import com.exam.model1.shopping.ShoppingTO;
import com.exam.model1.shoppingComment.ShoppingCommentDAO;
import com.exam.model1.shoppingComment.ShoppingCommentTO;
import com.exam.model1.user.UserDAO;

//import com.exam.model1.BoardListTO;
//import com.exam.model1.CommentDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ShoppingController {
	
	@Autowired
	private ShoppingDAO shopDao;
	
	@Autowired
	private ShoppingCommentDAO shopCommentDao;
	
	@Autowired
	private ShopHeartDAO heartDao;

	// 각자 맞는 upload 폴더 경로로 변경
	private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\shopping";
	//private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\shopping";

	// 쇼핑정보 write
	@RequestMapping(value = "/shopping_write.do")
	public String shopping_write(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "shopping/shopping_write";
	}

	// 쇼핑정보 write_ok
	@RequestMapping(value = "/shopping_write_ok.do")
	public String shopping_write_ok(HttpServletRequest request, HttpServletResponse response) {

		int maxFileSize = 1024 * 1024 * 6;
		String encType = "utf-8";
		String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\shopping";
		
		//String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\shopping";
		
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

			ShoppingTO shopTo = new ShoppingTO();
			shopTo.setWriter(writer);
			shopTo.setSubject(subject);
			shopTo.setContent(content);
			shopTo.setLocation(location);
			shopTo.setPicture(picture);

			int flag = shopDao.shopping_write_ok(shopTo);

			request.setAttribute("flag", flag);
			request.setAttribute("location", shopTo.getLocation());

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "shopping/shopping_write_ok";
	}

	// 쇼핑 list
	@RequestMapping(value = "/shopping_list.do")
	public String shopping_list(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");
			String location = request.getParameter("location");
			int cpage = 1;
			String nick = (String)session.getAttribute( "nick" );
			
			ShoppingListTO listTO = new ShoppingListTO();
			ShoppingTO to = new ShoppingTO();
			
			if (request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
				cpage = Integer.parseInt(request.getParameter("cpage"));
			}
			listTO.setLocation(location);
			listTO.setCpage(cpage);
			
			//로그인아닐 때
			if( nick == null ) {
				listTO = shopDao.shopList(listTO);
			} else {	//로그인일 때
				to.setNick( nick );
				to.setLocation(location);
				listTO = shopDao.shopListLogin(listTO, to);
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

		return "shopping/shopping_list";
	}
	
	// 빈하트 클릭시 하트 저장
	@ResponseBody
	@RequestMapping(value = "/shop_saveHeart.do")
	public int save_heart(@RequestParam String no, HttpSession session) {
		
		ShopHeartTO to = new ShopHeartTO();
		
		// 게시물 번호 세팅
		to.setBno(no);
		
		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String)session.getAttribute("nick"));
		
		int flag = heartDao.shopSaveHeart(to);
	
		return flag;
	}
	
	// 꽉찬하트 클릭시 하트 해제
	@ResponseBody
	@RequestMapping(value = "/shop_removeHeart.do")
	public int remove_heart(@RequestParam String no, HttpSession session) {
		ShopHeartTO to = new ShopHeartTO();
		
		// 게시물 번호 세팅
		to.setBno(no);
		
		// 좋아요 누른 사람 nick을 userid로 세팅
		to.setUserid((String)session.getAttribute("nick"));
		
		int flag = heartDao.shopRemoveHeart(to);
	
		return flag;
	}
	
	// 쇼핑 view
	@RequestMapping(value = "/shopping_view.do")
	public String shopping_view(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String no = request.getParameter( "no" );
			String cpage = request.getParameter( "cpage" );
			String nick = (String)session.getAttribute( "nick" );
			
			ShoppingTO to = new ShoppingTO();
			to.setNo( no );
			
			//글 내용 가져오기
			if( nick == null ) {	//로그인아닐 때
				to = shopDao.shopView(to);	
			} else {	//로그인일 때
				to.setNick( nick );
				to = shopDao.shopViewLogin(to);
			}
			
			//해당 글에 대한 댓글 list가져오기
			ShoppingCommentTO commentTo = new ShoppingCommentTO();
			commentTo.setBno( no );
			ArrayList<ShoppingCommentTO> lists = shopCommentDao.shopListComment(commentTo);	
			
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

		return "shopping/shopping_view";
	}
	
	// 쇼핑 view comment ok
	@RequestMapping(value = "/shopping_view_comment_ok.do")
	public String shopping_view_comment_ok(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			
			String bno = request.getParameter( "no" );
			String writer = request.getParameter( "cwriter" );
			String content = request.getParameter( "ccontent" );
			
			ShoppingCommentTO commentTo = new ShoppingCommentTO();
			commentTo.setBno(bno);
			commentTo.setWriter(writer);
			commentTo.setContent(content);

			int flag = shopCommentDao.shopViewCommentOk(commentTo);
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

		return "shopping/shopping_view_comment_ok";
	}
	
	// 쇼핑 rereply_ok
	@RequestMapping(value = "/shopping_rereplyOk.do")
	public String shopping_rereplyOk(HttpServletRequest request) {
		
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			String no = request.getParameter( "no" );
			String bno = request.getParameter("bno");
			String writer = request.getParameter("writer");
			String content = request.getParameter("ccontent_reply");
			
			ShoppingCommentTO commentTo = new ShoppingCommentTO();
			commentTo.setNo(no);
			
			// 부모글의 grp, grps, grpl 가져와서 commentTo에 저장
			commentTo = shopCommentDao.shopParentSelect(commentTo);
			
			commentTo.setBno(bno);
			commentTo.setWriter(writer);
			commentTo.setContent(content);
			
			//기존에 있던 댓글중에서 부모 댓글과 같은 grp이고 부모 grpl(0)보다 자식 grps가 큰 댓글들은 모두 grps를 1씩 늘려준다.
			int result1 = shopCommentDao.shopUpdateGrps(commentTo);
			
			//새로운 답글을 추가 (sql문에서 grps와 grpl을 모두 1씩 늘려준다.)
			int flag = 1;
			int result2 = shopCommentDao.shopRereplyInsertOk(commentTo);
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
		
		return "shopping/shopping_rereply_ok";
	}
	
	// 쇼핑 reply deleteOk
	@RequestMapping(value = "/shopping_reply_deleteOk.do")
	public String shopping_reply_deleteOk(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			String bno = request.getParameter( "bno" );	//게시글번호 bno
			String no = request.getParameter( "no" );	//댓글 번호 no
			String grp = request.getParameter( "grp" );	//그룹번호 grp
			
			ShoppingCommentTO cto = new ShoppingCommentTO();
			cto.setNo(no);
			cto.setGrp(grp);
			
			int flag = shopCommentDao.shopping_reply_deleteOk( cto );
			
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

		return "shopping/shopping_reply_deleteOk";
	}
	
	// 쇼핑 reply modify
	@RequestMapping(value = "/shopping_reply_modifyOk.do")
	public String shopping_reply_modifyOk(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			String content = request.getParameter( "ccontent_modify" );	//댓글내용
			String bno = request.getParameter( "bno" );	//게시글번호
			String no = request.getParameter( "no" );	//댓글번호
			
			ShoppingCommentTO cto = new ShoppingCommentTO();
			cto.setNo(no);
			cto.setContent(content);
			
			int flag = shopCommentDao.shopping_reply_modifyOk( cto );
			
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

		return "shopping/shopping_reply_modifyOk";
	}
	
	// 쇼핑 delete
	@RequestMapping(value = "/shopping_delete_ok.do")
	public String shopping_delete_ok(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String cpage = request.getParameter( "cpage" );
			String location = request.getParameter( "location" );
			String no = request.getParameter( "no" );
			String writer = request.getParameter( "writer" );
			
			ShoppingTO to = new ShoppingTO();
			to.setWriter( writer );
			to.setNo(no);
			
			int flag = shopDao.shopDeleteOk( to );
			
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

		return "shopping/shopping_delete_ok";
	}
	
	// 쇼핑 modify
	@RequestMapping(value = "/shopping_modify.do")
	public String shopping_modify(HttpServletRequest request, HttpServletResponse response) {
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

		return "shopping/shopping_modify";
	}
	
	// 쇼핑 modify_ok
	@RequestMapping(value = "/shopping_modify_ok.do")
	public String shopping_modify_ok(HttpServletRequest request, HttpServletResponse response) {
		
		int maxFileSize = 1024 * 1024 * 6;
		String encType = "utf-8";
		String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\shopping";
		
		//String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\shopping";
		
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

			ShoppingTO to = new ShoppingTO();
			to.setNo(no);
			to.setWriter(writer);
			to.setSubject(subject);
			to.setContent(content);
			to.setLocation(location);
			to.setPicture(picture);

			int flag = shopDao.shopModifyOk(to);

			request.setAttribute("flag", flag);
			request.setAttribute("cpage", cpage);
			request.setAttribute("location", location );
			

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "shopping/shopping_modify_ok";
	}	
	
	
	
	
}
