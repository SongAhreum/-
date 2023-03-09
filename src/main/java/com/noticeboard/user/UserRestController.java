package com.noticeboard.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.noticeboard.common.EncryptUtils;
import com.noticeboard.user.bo.UserBO;
import com.noticeboard.user.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

//API용-RestController (responseBody+controller)
@RequestMapping("/user")
@RestController
public class UserRestController {
	@Autowired
	private UserBO userBO;
	
	/**
	 * 아이디중복확인 api
	 * @param loginId
	 * @return
	 */
	@GetMapping("/is_duplicated_id")
	public Map<String,Object> isDuplicatedId(
			@RequestParam("loginId") String loginId
			){
		Map<String,Object> result = new HashMap<>();
		//2가지방법-bo에서 행 받아 null체크/boolean으로 받기
		boolean isDuplicated =  false;
		try {
			isDuplicated =  userBO.existLoginId(loginId);
		} catch(Exception e){
			result.put("code", 500);
			result.put("errorMessage","중복확인실패");
		}
		
		if(isDuplicated) {
			result.put("code",1);
			result.put("result",true);
		} else {
			result.put("code",1);
			result.put("result",false);
			return result;
		}		
		return result;
	}
	
	/**
	 * 회원가입
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return
	 */
	@PostMapping("/sign_up")
	public  Map<String,Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email
			){
		//비밀번호 (암호화)해싱-md5(해싱된값으로 db저장)
		String hashedPassword = EncryptUtils.md5(password);//static메서드
		
		//db insert
		userBO.addUser(loginId, hashedPassword, name, email);
		Map<String,Object> result = new HashMap<>();
		result.put("code",1);
		result.put("result","성공");
		return result;
	}
	
	/**
	 * 로그인하기
	 * @param loginId
	 * @param password
	 * @param request
	 * @param model
	 * @return
	 */
	@PostMapping("/sign_in")
	public Map<String,Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request,
			Model model
			){
		//비밀번호 해싱
		String hashedPassword = EncryptUtils.md5(password);
		//db select
		User user = userBO.getUser(loginId,hashedPassword);
		
		Map<String,Object> result = new HashMap<>();
		//있으면 로그인//없으면 로그인 실패
		if(user != null) {
			result.put("code",1);
			result.put("result","성공");
			
			//세션에 유저정보를 담는다(로그인 상태 유지)
			HttpSession session =  request.getSession(); 
			session.setAttribute("userId",user.getId());
			session.setAttribute("userLoginId",user.getLoginId());
			session.setAttribute("userName",user.getName());
		} else {
			result.put("code", 500);
			result.put("errorMessage","존재하지 않는 사용자입니다.");
		}
	
		return result;
	}
}
