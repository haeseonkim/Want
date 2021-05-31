package com.exam.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.model1.user.UserDAO;
import com.exam.model1.user.UserTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;

	// 각자 맞는 upload 폴더 경로로 변경
	  
	//private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\profile";
	//private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\profile";
	//private String uploadPath = "/Users/hyukjun/git/Want/Want/src/main/webapp/upload/";
	//private String uploadPath = "C:\\KICKIC\\Want\\Want\\src\\main\\webapp\\upload\\profile";
	
	//리눅스 경로
	private String uploadPath = "/home/want/apache-tomcat-9.0.44/webapps/Want/upload/profile";
	 
	// ---------------------- 로그인 관련 ----------------------
	@RequestMapping(value = "/loginForm.do")
	public String loginForm(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {

		request.setCharacterEncoding("utf-8");

		if (request.getParameter("login_ok") == null) {
		} else if (request.getParameter("login_ok").equals("1") && !request.getParameter("id").equals("")) {

			// ================= 일반 로그인 =================
//			System.out.println("일반로그인");
//			System.out.println(request.getParameter("id"));
//			System.out.println(request.getParameter("kakaoemail"));

			int flag = 2;
			

			UserTO userTo = new UserTO();

			String id = request.getParameter("id");
			String pwd = request.getParameter("password");
			
			userTo.setId(id);
			
			String key = "secret Key";
			String realPwd = "";
			String decryPwd = "";
			
			if( userDao.loginDecry(userTo) != null ) {
				realPwd = userDao.loginDecry(userTo).getPwd();
				decryPwd = userDao.decryptAES(realPwd, key);
			}
			
			int result_lookup = userDao.loginLookup(userTo);
			if (result_lookup == 1) { // 회원있음

				if (pwd.equals(decryPwd)) { // 사용자가 적은 pwd와 DB에 저장된 암호화된 비번 복호화해서 비교
					userTo.setPwd(realPwd);
					int result_ok = userDao.loginOk(userTo);

					if (result_ok == 1) { // 비번맞음
						flag = 0;
						userTo = userDao.loginOkNick(userTo);
						// id를 세션에 저장
						session.setAttribute("id", userTo.getId());
						// nick을 세션에 저장
						session.setAttribute("nick", userTo.getNick());
						// 프로필 사진 (profile)을 세션에 저장
						session.setAttribute("profile", userTo.getProfile());
						
					
					} else { // 기타오류
						flag = 3;
					}
				} else {	// 비번틀림
					flag = 1;
				}
			} else if (result_lookup == 0) { // 회원없음
				flag = 2;
			} else { // 기타오류
				flag = 3;
			}
			request.setAttribute("flag", flag);

		} else if (request.getParameter("login_ok").equals("1") && !request.getParameter("kakaoemail").equals("")) {

			// ==================== 카카오 로그인 ========================
			System.out.println("카카오로그인");
			System.out.println(request.getParameter("kakaoemail"));
			System.out.println(request.getParameter("kakaoname"));
			System.out.println(request.getParameter("kakaobirth"));
			
			// kakaoemail을 kakaoid에 저장
			String kakaoid = request.getParameter("kakaoemail");

			UserTO userTo = new UserTO();

			// kakaoid를 to의 id로 세팅
			userTo.setId(kakaoid);

			// 카카오계정으로 로그인한 적이 있는지 없는지 
			int result_lookup = userDao.loginLookup(userTo);

			if (result_lookup == 0) { // 회원이 아닌경우 (카카오 계정으로 처음 방문한 경우) 카카오 회원정보 설정 창으로 이동
				System.out.println("카카오 회원 정보 설정");

				request.setAttribute("kakaoid",request.getParameter("kakaoemail"));
				request.setAttribute("kakaoname",request.getParameter("kakaoname"));
				request.setAttribute("kakaobirth",request.getParameter("kakaobirth"));
				request.setAttribute("kakaoemail",request.getParameter("kakaoemail"));
				
				// 회원가입창으로 이동
				return "user/kakaoLogin_editForm";

			} else { // 이미 카카오로 로그인한 적이 있을 때 (최초 1회 로그인때 회원가입된 상태)
				// id, nick, profile을 가져와서
				userTo = userDao.loginOkNick(userTo);
				// id를 세션에 저장
				session.setAttribute("kakaoid", userTo.getId());
				// nick을 세션에 저장
				session.setAttribute("nick", userTo.getNick());
				// 프로필 사진 (profile)을 세션에 저장
				session.setAttribute("profile", userTo.getProfile());
				
				request.setAttribute("flag", 0);
				
				System.out.println("kakaoid : " + userTo.getId());
				System.out.println("nick : " + userTo.getNick());
				System.out.println("profile : " + userTo.getProfile());
			}

		}

		return "user/loginForm";
	}

	// ---------------------- 로그아웃 ----------------------
	@RequestMapping(value = "/logout.do")
	public String logout_ok(HttpSession session, HttpServletRequest request, Model model) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		session.invalidate();
		return "home";

	}

	// ---------------------- 회원가입관련 ----------------------
	@RequestMapping(value = "/signupForm.do")
	public String signupForm(Model model) {
		return "user/signupForm";
	}

	// signup_ok
	@RequestMapping(value = "/signup_ok.do")
	public String signup_ok(HttpServletRequest request, Model model) throws Exception {

		int maxFileSize = 1024 * 1024 * 6;
		String encType = "utf-8";

		MultipartRequest multi = null;

		try {
			request.setCharacterEncoding("utf-8");

			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());

			String key = "secret Key";

			UserTO to = new UserTO();
			to.setId(multi.getParameter("id"));

			// 비밀번호암호화해서 TO에 set
			String encryPwd = userDao.encrytAES(multi.getParameter("pwd"), key);
			to.setPwd(encryPwd);

			to.setName(multi.getParameter("name"));
			to.setBirth(multi.getParameter("birth"));
			to.setMail(multi.getParameter("mail"));
			to.setPhone(multi.getParameter("phone"));
			to.setNick(multi.getParameter("nick"));

			to.setProfile(multi.getFilesystemName("profile"));
			File file = multi.getFile("profile");
			if (multi.getParameter("greet").equals("")) {
				to.setGreet(null);
			} else {
				to.setGreet(multi.getParameter("greet"));
			}

			int flag = userDao.signup_ok(to);

			model.addAttribute("flag", flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "home";
	}
	
	// 카카오로그인 회원정보 설정
	@RequestMapping(value = "/kakaoLogin_editForm_ok.do")
	public String kakaoLogin_editForm_ok(HttpServletRequest request, Model model, HttpSession session) throws Exception {

		int maxFileSize = 1024 * 1024 * 6;
		String encType = "utf-8";

		MultipartRequest multi = null;

		try {
			request.setCharacterEncoding("utf-8");

			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());

			UserTO to = new UserTO();
			to.setId(multi.getParameter("id"));

			// 카카오로그인은 비밀번호가 따로 필요없기때문에 공백으로 세팅
			to.setPwd("");
			
			to.setName(multi.getParameter("name"));
			to.setBirth(multi.getParameter("birth"));
			to.setMail(multi.getParameter("mail"));
			to.setPhone(multi.getParameter("phone"));
			to.setNick(multi.getParameter("nick"));

			to.setProfile(multi.getFilesystemName("profile"));
			File file = multi.getFile("profile");
			if (multi.getParameter("greet").equals("")) {
				to.setGreet(null);
			} else {
				to.setGreet(multi.getParameter("greet"));
			}

			int flag = userDao.signup_ok(to);
			
			// kakaoid를 세션에 저장
			session.setAttribute("kakaoid", to.getId());
			// nick을 세션에 저장
			session.setAttribute("nick", to.getNick());
			// 프로필 사진 (profile)을 세션에 저장
			session.setAttribute("profile", to.getProfile());

			model.addAttribute("flag", flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "home";
	}

	// 프로필수정에서 id중복조회
	@ResponseBody
	@RequestMapping(value = "/usingId_chk.do", produces = "text/plain")
	public String idCheck(HttpServletRequest request, HttpServletResponse response) {

		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String user_id = request.getParameter("user_id");
		UserTO userTo = new UserTO();
		userTo.setId(user_id);

		int using_user = userDao.loginLookup(userTo);
		String result = "" + using_user; // 숫자를 문자열로 변환

		return result;
	}

	// 프로필수정에서 닉네임중복조회
	@ResponseBody
	@RequestMapping(value = "/usingNick_chk.do", produces = "text/plain")
	public String nickCheck(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String user_nick = request.getParameter("user_nick");
		UserTO userTo = new UserTO();
		userTo.setNick(user_nick);

		int using_nick = userDao.nickLookup(userTo);
		String result = "" + using_nick;

		return result;
	}

	// 비밀번호찾기
	@RequestMapping(value = "/pwFindForm.do")
	public String pwFindForm(HttpServletRequest request, Model model) throws Exception{
		return "user/pwFindForm";
	}
	
	// 비번찾기ok
	@RequestMapping(value = "/pwFindForm_ok.do")
	public String pwFindForm_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int flag = 2;
		
		UserTO userTo = new UserTO();

		String id = request.getParameter("id");
		String mail = request.getParameter("mail");
		
		userTo.setId(id);
		userTo.setMail(mail);
		
		int result_lookup = userDao.pwFind_Lookup(userTo);
		if (result_lookup == 1) { // 회원있음
//			System.out.println("lookup : " + result_lookup);
			
			//메일확인
			int pwFind_ok = userDao.pwFind_ok(userTo);
//			System.out.println("pwFind_ok : " + pwFind_ok);
		
			if (pwFind_ok == 1) { // 메일 일치
				userTo = userDao.pwFind_select(userTo);
				
				// 암호화 된 비밀번호 풀어주는 작업
				String key = "secret Key";
				String realPwd = userDao.pwFind_select(userTo).getPwd();
				String decryPwd = userDao.decryptAES(realPwd, key);
				
				// 비밀번호 길이를 2로 나누어서
				int pwdSize = decryPwd.length()/2;
//				System.out.println( pwdSize );
				
				String resultPwd_1 = decryPwd.substring(0, pwdSize );
				
				// 뒤의 절반은 *로 표시
				String tmp = "";
				if (pwdSize%2 ==1) { // 홀수인 경우 * 한개 더 추가
					for( int i=0; i<pwdSize+1; i++ ) {
						tmp += "*";
					}
				} else {
					for( int i=0; i<pwdSize; i++ ) {
						tmp += "*";
					}
				}
				String resultPwd = resultPwd_1 + tmp;
				
				flag = 0;
				
				// 표시될 비밀번호를 pwd에 담음
				userTo.setPwd(resultPwd);
//				System.out.println("getPwd : " + userTo.getPwd());
				
				request.setAttribute("pwd", userTo.getPwd());
				request.setAttribute("id", id);
				
			} else if(pwFind_ok==0) { // 메일x
				flag = 1;
				
			} else {	// 기타오류
				flag = 3;
			}
		} else if (result_lookup == 0) { // 회원없음
			flag = 2;
		} else { // 기타오류
			flag = 3;
		}
		request.setAttribute("flag", flag);

		return "user/pwFindForm_ok";
	}

}