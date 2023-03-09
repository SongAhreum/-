package com.noticeboard.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

//화면용-controller
@RequestMapping("/user")
@Controller
public class UserController {
	
	/**
	 * 회원가입화면
	 * @param model
	 * @return
	 */
	@GetMapping("/sign_up_view")
	public String signUpView(Model model) {
		model.addAttribute("viewName","user/signUp");
		return "template/layout";
	}
	/**
	 * 로그인화면
	 * @param model
	 * @return
	 */
	@GetMapping("/sign_in_view")
	public String signInView(Model model) {
		model.addAttribute("viewName","user/signIn");
		return "template/layout";
	}
	/**
	 * 로그아웃
	 * @param session
	 * @return
	 */
	@GetMapping("/sign_out_view")
	public String signOutView(HttpSession session) {
		//로그아웃 : 로그인세션 비우기
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");
		
		return "redirect:/post/post_list_view"; //비로그인상태 postlist 페이지로 이동
	}
	

}
