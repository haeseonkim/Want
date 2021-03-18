/*
 * package com.exam.controller;
 * 
 * import java.io.File; import java.io.IOException;
 * 
 * import javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpServletResponse; import
 * javax.servlet.http.HttpSession;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.mail.MailSender; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.ResponseBody;
 * 
 * import com.oreilly.servlet.MultipartRequest;
 * 
 * 
 * import com.exam.model1.UserTO; import
 * com.oreilly.servlet.multipart.DefaultFileRenamePolicy; import
 * com.exam.model1.MailSendService; import com.exam.model1.UserDAO;
 * 
 * 
 * @Controller public class PwFindController {
 * 
 * @Autowired private UserDAO userDao;
 * 
 * // 비밀번호찾기
 * 
 * @RequestMapping(value = "/pwFindForm.do") public String pwFindForm(UserTO
 * userTO, HttpServletRequest request) { return "user/pwFindForm"; }
 * 
 * // 비밀번호찾기
 * 
 * @RequestMapping(value = "/pwFindForm_ok.do") public String
 * pwFindForm_ok(UserTO userTO, HttpServletRequest request) throws Exception {
 * if( request.getParameter("pwFind_ok") == null ) { return"user/pwFindForm"; }
 * else if ( request.getParameter("pwFind_ok").equals("1")) {
 * 
 * int flag = 2;
 * 
 * String key = "secret Key";
 * 
 * UserTO userTo = new UserTO();
 * 
 * String id = request.getParameter("id"); String mail =
 * request.getParameter("mail");
 * 
 * userTo.setId(id);
 * 
 * int result = userDao.pwFind(userTO); }
 * 
 * return "user/loginForm"; }
 * 
 * }
 */