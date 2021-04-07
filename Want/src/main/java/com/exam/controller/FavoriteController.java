package com.exam.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.exam.model1.accom.AccomDAO;
import com.exam.model1.accom.AccomTO;
import com.exam.model1.accomHeart.AccomHeartDAO;
import com.exam.model1.lantrip.LanTripDAO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.lantripHeart.LantripHeartDAO;
import com.exam.model1.picture.PictureDAO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.pictureHeart.PictureHeartDAO;
import com.exam.model1.shopHeart.ShopHeartDAO;
import com.exam.model1.shopping.ShoppingDAO;
import com.exam.model1.shopping.ShoppingTO;


@Controller
public class FavoriteController {
	
	//lanTrip관련 dao
	@Autowired
	private LanTripDAO lantripDao;
	@Autowired
	private LantripHeartDAO lantripHeartDao;
	
	//picture관련 dao
	@Autowired
	private PictureDAO pictureDao;
	@Autowired
	private PictureHeartDAO pictureHeartDao;
	
	//shopping관련 dao
	@Autowired
	private ShoppingDAO shopDao;
	@Autowired
	private ShopHeartDAO shopHeartDao;
	
	//accom관련 dao
	@Autowired
	private AccomDAO accomDao;
	@Autowired
	private AccomHeartDAO accomHeartDao;
	
	
	// 즐겨찾기한 게시물 목록 (최초 웹페이지 들어올 때 lantrip 글목록 8개만 보여줌)
	@RequestMapping(value = "/favorite_list.do")
	public String favorite_list(HttpServletRequest request, HttpSession session ) {
		try {
			request.setCharacterEncoding("utf-8");
			
//			System.out.println("컨트롤러");
			
			// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
			String strPageNum = request.getParameter("pageNum");
			String nick = (String)session.getAttribute( "nick" );
			
			// 한 페이지에 몇개씩 표시할 것인지
			final int PAGE_ROW_COUNT = 8;

			// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
			int pageNum = 1;
			
			// 만일 페이지 번호가 파라미터로 넘어 온다면
			if (strPageNum != null) {
				// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
				pageNum = Integer.parseInt(strPageNum);
			}

			// 보여줄 페이지의 시작 ROWNUM - 0부터 시작
			int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
			// 보여줄 페이지의 끝 ROWNUM
			int endRowNum = pageNum * PAGE_ROW_COUNT;
			
			//dao메서드에 넘겨줄 to설정
			LanTripTO to = new LanTripTO();
			to.setNick(nick);
			to.setStartRowNum(startRowNum);
			to.setEndRowNum(endRowNum);
			
			// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			ArrayList<LanTripTO> list = null;
			
			list = lantripDao.lantrip_favoriteList( to );
			
			
			//전체 글의 개수 가져오기
			int totalRow = 0;
			totalRow = lantripDao.LanTripCount(to);
			
			// 전체 페이지의 갯수 구하기
			int totalPageCount = (int)Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
			
			
			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("totalRow", totalRow);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute( "list", list );
			
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "favorite/favorite_list";
	}
	
	// 즐겨찾기한 게시물 목록 (랜선여행 버튼 눌렀을 때)
	@RequestMapping(value = "/f_lantrip_list.do")
	public String f_lantrip_list(HttpServletRequest request, HttpSession session ) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String nick = (String)session.getAttribute( "nick" );
			// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
			String strPageNum = request.getParameter("pageNum");

			// 한 페이지에 몇개씩 표시할 것인지
			final int PAGE_ROW_COUNT = 8;

			// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
			int pageNum = 1;
			
			// 만일 페이지 번호가 파라미터로 넘어 온다면
			if (strPageNum != null) {
				// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
				pageNum = Integer.parseInt(strPageNum);
			}
			
			// 보여줄 페이지의 시작 ROWNUM - 0부터 시작
			int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
			// 보여줄 페이지의 끝 ROWNUM
			int endRowNum = pageNum * PAGE_ROW_COUNT;
			
			//dao메서드에 넘겨줄 to설정
			LanTripTO to = new LanTripTO();
			to.setNick(nick);
			to.setStartRowNum(startRowNum);
			to.setEndRowNum(endRowNum);
			
			// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			ArrayList<LanTripTO> list = null;
			
			//글목록 가져오기
			list = lantripDao.lantrip_favoriteList( to );
			
			//전체 글의 개수 가져오기
			int totalRow = 0;
			totalRow = lantripDao.LanTripCount(to);
			
			// 전체 페이지의 갯수 구하기
			int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("totalRow", totalRow);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute( "list", list );
			
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "favorite/favorite_lantrip_ajax_page";
	}

	// 즐겨찾기한 게시물 목록 (사진자랑하기 버튼 눌렀을 때)
	@RequestMapping(value = "/f_picture_list.do")
	public String f_picture_list(HttpServletRequest request, HttpSession session ) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String nick = (String)session.getAttribute( "nick" );
			// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
			String strPageNum = request.getParameter("pageNum");

			// 한 페이지에 몇개씩 표시할 것인지
			final int PAGE_ROW_COUNT = 8;

			// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
			int pageNum = 1;
			
			// 만일 페이지 번호가 파라미터로 넘어 온다면
			if (strPageNum != null) {
				// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
				pageNum = Integer.parseInt(strPageNum);
			}
			
			// 보여줄 페이지의 시작 ROWNUM - 0부터 시작
			int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
			// 보여줄 페이지의 끝 ROWNUM
			int endRowNum = pageNum * PAGE_ROW_COUNT;
			
			//dao메서드에 넘겨줄 to설정
			PictureTO pto = new PictureTO();
			pto.setNick(nick);
			pto.setStartRowNum(startRowNum);
			pto.setEndRowNum(endRowNum);
			
			// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			ArrayList<PictureTO> list = null;
			
			//좋아요한 글목록 가져오기
			list = pictureDao.picture_favoriteList( pto );
			
			//좋아요 전체 글의 개수 가져오기
			int totalRow = 0;
			totalRow = pictureDao.PictureFavoriteCount(pto);
			
			System.out.println( "총 글 수" +totalRow);
			//System.out.println(Math.ceil(totalRow / (double) PAGE_ROW_COUNT));
			//System.out.println((int)Math.ceil(totalRow / (double) PAGE_ROW_COUNT));
			
			// 전체 페이지의 갯수 구하기
			//int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT)  ;
			int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT) ;
			
			System.out.println("totalPageCount: " + totalPageCount);

			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("totalRow", totalRow);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute( "list", list );
			
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "favorite/favorite_picture_ajax_page";
	}
	
	// 즐겨찾기한 게시물 목록 (쇼핑 버튼 눌렀을 때)
	@RequestMapping(value = "/f_shop_list.do")
	public String f_shop_list(HttpServletRequest request, HttpSession session ) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String nick = (String)session.getAttribute( "nick" );
			// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
			String strPageNum = request.getParameter("pageNum");

			// 한 페이지에 몇개씩 표시할 것인지
			final int PAGE_ROW_COUNT = 8;

			// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
			int pageNum = 1;
			
			// 만일 페이지 번호가 파라미터로 넘어 온다면
			if (strPageNum != null) {
				// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
				pageNum = Integer.parseInt(strPageNum);
			}
			
			// 보여줄 페이지의 시작 ROWNUM - 0부터 시작
			int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
			// 보여줄 페이지의 끝 ROWNUM
			int endRowNum = pageNum * PAGE_ROW_COUNT;
			
			//dao메서드에 넘겨줄 to설정
			ShoppingTO sto = new ShoppingTO();
			sto.setNick(nick);
			sto.setStartRowNum(startRowNum);
			sto.setEndRowNum(endRowNum);
			
			// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			ArrayList<ShoppingTO> list = null;
			
			//글목록 가져오기
			list = shopDao.shop_favoriteList( sto );
			
			//전체 글의 개수 가져오기
			int totalRow = 0;
			totalRow = shopDao.shopCount(sto);
			
			// 전체 페이지의 갯수 구하기
			int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("totalRow", totalRow);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute( "list", list );
			
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "favorite/favorite_shop_ajax_page";
	}
	
	// 즐겨찾기한 게시물 목록 (숙소 버튼 눌렀을 때)
	@RequestMapping(value = "/f_accom_list.do")
	public String f_accom_list(HttpServletRequest request, HttpSession session ) {
		try {
			request.setCharacterEncoding("utf-8");
			
			String nick = (String)session.getAttribute( "nick" );
			// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
			String strPageNum = request.getParameter("pageNum");

			// 한 페이지에 몇개씩 표시할 것인지
			final int PAGE_ROW_COUNT = 8;

			// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
			int pageNum = 1;
			
			// 만일 페이지 번호가 파라미터로 넘어 온다면
			if (strPageNum != null) {
				// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
				pageNum = Integer.parseInt(strPageNum);
			}
			
			// 보여줄 페이지의 시작 ROWNUM - 0부터 시작
			int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
			// 보여줄 페이지의 끝 ROWNUM
			int endRowNum = pageNum * PAGE_ROW_COUNT;
			
			//dao메서드에 넘겨줄 to설정
			AccomTO ato = new AccomTO();
			ato.setNick(nick);
			ato.setStartRowNum(startRowNum);
			ato.setEndRowNum(endRowNum);
			
			// ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
			ArrayList<AccomTO> list = null;
			
			//글목록 가져오기
			list = accomDao.accom_favoriteList( ato );
			
			//전체 글의 개수 가져오기
			int totalRow = 0;
			totalRow = accomDao.accomCount(ato);
			
			// 전체 페이지의 갯수 구하기
			int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

			request.setAttribute("totalPageCount", totalPageCount);
			request.setAttribute("totalRow", totalRow);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute( "list", list );
			
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "favorite/favorite_accom_ajax_page";
	}
	
}
