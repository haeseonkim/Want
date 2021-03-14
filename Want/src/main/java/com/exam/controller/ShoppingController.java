package com.exam.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.oreilly.servlet.MultipartRequest;

import com.exam.config.SqlMapperInter;

import com.exam.model1.UserTO;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
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
	
	// 각자 맞는 upload 폴더 경로로 변경
	private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload";


	// 쇼핑 정보 목록
	@RequestMapping(value = "/shopping_list.do")
	public String shopping_list(Model model) {
		return "shopping/shopping_list";
	}
	
	// 쇼핑정보 올리기
	@RequestMapping(value = "/shopping_write.do")
	public String shopping_write(Model model) {
		return "write/shopping_write";
	}
	
}
