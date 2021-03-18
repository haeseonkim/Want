package com.exam.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import com.exam.model1.ShoppingDAO;
import com.exam.model1.ShoppingListTO;
import com.exam.model1.ShoppingTO;
import com.exam.model1.UserDAO;

//import com.exam.model1.BoardListTO;
//import com.exam.model1.CommentDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ShoppingController {

	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private ShoppingDAO shopDao;

	// 각자 맞는 upload 폴더 경로로 변경
	private String uploadPath = "/Users/hyukjun/git/Want/Want/src/main/webapp/upload/lanTrip";

	// 쇼핑정보 글쓰기
	@RequestMapping(value = "/shopping_write.do")
	public String shopping_write(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		return "shopping/shopping_write";
	}

	// 쇼핑정보 글쓰기 Ok
	@RequestMapping(value = "/shopping_write_ok.do")
	public String shopping_write_ok(HttpServletRequest request, HttpServletResponse response) {

		int maxFileSize = 1024 * 1024 * 6;
		String encType = "utf-8";
		String uploadPath = "/Users/hyukjun/git/Want/Want/src/main/webapp/upload/shopping";
		MultipartRequest multi = null;

		try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
			String writer = multi.getParameter("writer");
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String location = multi.getParameter("city");
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
			request.setAttribute("cityName", shopTo.getLocation());

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "shopping/shopping_write_ok";
	}

	// 쇼핑 llist
	@RequestMapping(value = "/shopping_list.do")
	public String shopping_list(HttpServletRequest request, HttpServletResponse response) {
		String location = request.getParameter("cityName");
		int cpage = 1;
		if (request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}

		ShoppingListTO listTO = new ShoppingListTO();
		listTO.setLocation(location);
		listTO.setCpage(cpage);

		listTO = shopDao.shopList(listTO);

		request.setAttribute("listTO", listTO);
		request.setAttribute("cpage", cpage);

		return "shopping/shopping_list";
	}
}
