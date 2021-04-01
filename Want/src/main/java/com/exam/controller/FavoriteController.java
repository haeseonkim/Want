package com.exam.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.exam.model1.accom.AccomDAO;
import com.exam.model1.accomHeart.AccomHeartDAO;
import com.exam.model1.lantrip.LanTripDAO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.lantripHeart.LantripHeartDAO;
import com.exam.model1.picture.PictureDAO;
import com.exam.model1.pictureHeart.PictureHeartDAO;
import com.exam.model1.shopHeart.ShopHeartDAO;
import com.exam.model1.shopping.ShoppingDAO;


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
			
			list = lantripDao.favoriteList( to );
			
			
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
			list = lantripDao.favoriteList( to );
			
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

}
