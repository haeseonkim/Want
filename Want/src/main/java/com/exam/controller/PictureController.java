package com.exam.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.oreilly.servlet.MultipartRequest;


import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


import com.exam.model1.PictureTO;
import com.exam.model1.PictureDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class PictureController {
	
	@Autowired
	private PictureDAO pictureDao;
	
	// 각자 맞는 upload 폴더 경로로 변경
	private String uploadPath = "/Users/hyukjun/git/Want/Want/src/main/webapp/upload/picture";


	// 사진자랑 목록
	@RequestMapping(value = "/picture_list.do")
	public String picture_list(Model model) {
		return "picture/picture_list";
	}
	
	// 사진자랑 글쓰기 form
	@RequestMapping(value = "/picture_write.do")
	public String picture_write(Model model) {
		return "picture/picture_write";
	}
	
	// 사진자랑 글쓰기 ok
	@RequestMapping(value = "/picture_write_ok.do")
	public String write_ok(HttpServletRequest request) {
		
	    int maxFileSize = 2048 * 2048 * 6;
	    String encType = "utf-8";
	    
	    MultipartRequest multi = null;
		
	    try {
			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
			
			PictureTO to = new PictureTO();
			to.setSubject(multi.getParameter("subject"));
			to.setLocation(multi.getParameter("location"));
			to.setWriter(multi.getParameter("writer"));
			to.setContent(multi.getParameter("content"));
			to.setMedia(multi.getFilesystemName("media"));
	
			int flag = pictureDao.pictureWriteOk(to);
			
			request.setAttribute("flag", flag);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "picture/picture_write_ok";
	}

}
