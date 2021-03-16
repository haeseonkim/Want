package com.exam.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.oreilly.servlet.MultipartRequest;


import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.exam.model1.AccomDAO;
import com.exam.model1.AccomListTO;
import com.exam.model1.AccomTO;

@Controller
public class AccomController {
	
	@Autowired
	private AccomDAO accomDao;
	

	// 숙소정보 글쓰기
	@RequestMapping(value = "/accom_write.do")
	public String accom_write(Model model) {
		return "accom/accom_write";
	}

	// 숙소정보 글쓰기 Ok
	@RequestMapping(value = "/accom_write_ok.do")
	public String accom_write_ok(HttpServletRequest request, HttpServletResponse response) {

		int maxFileSize = 1024 * 1024 * 6;
		String encType = "utf-8";
		String uploadPath = "C:\\Users\\bboyr\\OneDrive\\바탕 화면\\이것저것\\kic프로젝트\\최종프로젝트\\git\\Want\\Want\\src\\main\\webapp\\upload\\accom";
		MultipartRequest multi = null;

		try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
			String writer = multi.getParameter("writer");
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String location = multi.getParameter("city");
			String picture = multi.getFilesystemName("picture");
			File file = multi.getFile("profile");

			AccomTO accomTo = new AccomTO();
			accomTo.setWriter(writer);
			accomTo.setSubject(subject);
			accomTo.setContent(content);
			accomTo.setLocation(location);
			accomTo.setPicture(picture);

			int flag = accomDao.accom_write_ok(accomTo);

			request.setAttribute("flag", flag);
			request.setAttribute("cityName", accomTo.getLocation());

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accom/accom_write_ok";
	}

	// 숙소 list
	@RequestMapping(value = "/accom_list.do")
	public String accom_list(HttpServletRequest request, HttpServletResponse response) {
		String location = request.getParameter("cityName");
		int cpage = 1;
		if (request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}

		AccomListTO listTO = new AccomListTO();
		listTO.setLocation(location);
		listTO.setCpage(cpage);

		listTO = accomDao.accomList(listTO);

		request.setAttribute("listTO", listTO);
		request.setAttribute("cpage", cpage);

		return "accom/accom_list";
	}
}
