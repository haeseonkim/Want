package com.exam.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.exam.model1.with.withDAO;
import com.exam.model1.with.withListTO;
import com.exam.model1.with.withTO;
import com.exam.model1.picture.PictureTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class WithController {

	
	@Autowired
	private withDAO dao;

	private String uploadPath = "C:\\kickic\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\with";
	
	// 랜선여행 신청 목록					
	@RequestMapping(value = "/with_list.do")
	public String list(HttpServletRequest request, Model model) {
		try {
			request.setCharacterEncoding("utf-8");
			withListTO listTO = new withListTO();
			listTO.setCpage(Integer
					.parseInt(request.getParameter("cpage") == null || request.getParameter("cpage").equals("") ? "1"
							: request.getParameter("cpage")));
			listTO = dao.boardList(listTO);

			model.addAttribute("listTO", listTO);

		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "with/with_list";
	}

	// with_write
	@RequestMapping(value = "/with_write.do")
	public String with_write(HttpServletRequest request, Model model) {
		try {
			request.setCharacterEncoding("utf-8");

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "with/with_write";
	}

	// with_write_ok
	@RequestMapping(value = "/with_write_ok.do")
	public String with_write_ok(HttpServletRequest request) {

		int maxFileSize = 2048 * 2048 * 6;
		String encType = "utf-8";

		MultipartRequest multi = null;

		try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType,
					new DefaultFileRenamePolicy());

			withTO to = new withTO();
			to.setSubject(multi.getParameter("subject"));
			to.setLocation(multi.getParameter("location"));
			to.setWriter(multi.getParameter("writer"));
			to.setContent(multi.getParameter("content"));
			to.setPicture(multi.getFilesystemName("picture"));

			int flag = dao.with_write_ok(to);

			request.setAttribute("flag", flag);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "with/with_write_ok";
	}

	// with_view
	@RequestMapping(value = "/with_view.do")
	public String with_view(HttpServletRequest request) {

		String no = request.getParameter("no");
		withTO to = new withTO();

		to.setNo(request.getParameter("no"));

		to = dao.with_View(to);

		request.setAttribute("to", to);

		return "with/with_view";
	}

	// with_delete_ok
	@RequestMapping(value = "/with_delete_ok.do")
	public String with_delete(HttpServletRequest request) {

		String no = request.getParameter("no");
		withTO to = new withTO();

		to.setNo(request.getParameter("no"));

		int flag = dao.with_delete_ok(to);

		request.setAttribute("flag", flag);

		return "with/with_delete_ok";
	}

	// with_modify
	@RequestMapping(value = "/with_modify.do")
	public String with_modify(HttpServletRequest request) {
		
		withTO to = new withTO();

		to.setNo(request.getParameter("no"));

		to = dao.with_modify(to);

		request.setAttribute("to", to);

		return "with/with_modify";
	}
	
	// with_modify_ok
	@RequestMapping(value = "/with_modify_ok.do")
	public String with_modify_ok(HttpServletRequest request) {

		
		int maxFileSize = 2048 * 2048 * 6;
		String encType = "utf-8";

		MultipartRequest multi = null;

		try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType,
					new DefaultFileRenamePolicy());

			String cpage = multi.getParameter("cpage");
			
			withTO to = new withTO();
			to.setNo(multi.getParameter("no"));
			to.setSubject(multi.getParameter("subject"));
			to.setLocation(multi.getParameter("location"));
			to.setWriter(multi.getParameter("writer"));
			to.setContent(multi.getParameter("content"));
			
			if( multi.getFilesystemName( "picture" ) == null ) {
				to.setPicture(multi.getParameter( "ex-picture" ) );
			} else {
				to.setPicture(multi.getFilesystemName( "picture" ) );
			}

			int flag = dao.with_modify_ok(to);

			request.setAttribute("flag", flag);
			request.setAttribute("cpage", cpage);
			request.setAttribute("no", to.getNo());

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "with/with_modify_ok";
	}

}