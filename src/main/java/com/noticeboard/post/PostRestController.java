package com.noticeboard.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.noticeboard.post.bo.PostBO;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/post")
public class PostRestController {
	@Autowired
	private PostBO postBO;	
	
	/**
	 * post 글쓰기
	 * @param subject
	 * @param content
	 * @param file
	 * @param session
	 * @return
	 */
	@PostMapping("/create")
	public Map<String,Object> postCreate(
			@RequestParam(value="subject",required=true)String  subject ,
			@RequestParam(value="content",required=false)String  content ,
			@RequestParam(value="file", required=false) MultipartFile file,	
			HttpSession session
			){
		int userId = Integer.valueOf(String.valueOf(session.getAttribute("userId")));
		String userLoginId = (String)session.getAttribute("userLoginId");
		//db insert
		int row = postBO.addPost(userId, userLoginId, subject, content, file);
		
		Map<String,Object> result = new HashMap<>();
			if (row > 0) {
				result.put("code", 1);
				result.put("result", "성공");
			} else {
				result.put("code", 500);
				result.put("errorMessage", "메모 저장에 실패했습니다. 관리자에게 문의해주세요.");
			}
		return result;
	}
	
	//글 삭제하기
	@DeleteMapping("/delete")
	public Map<String,Object> postDelete(int id,HttpSession session) {
		int userId = Integer.valueOf(String.valueOf(session.getAttribute("userId")));
		Map<String,Object> result= new HashMap<>();
		//db delete
		int row = postBO.removePost(id);
		
		if(row > 0) {
			result.put("code", 1);
			result.put("result","성공");
			
		} else {
			result.put("code",500); //실패
			result.put("result","실패");
			result.put("error_message","삭제하는데 실패하였습니다.");
		}
		return result;
	}
	//글수정하기
	@PutMapping("/update")
	public Map<String,Object> postUpdate(
			@RequestParam("id") int id,
			@RequestParam(value="subject",required=true)String  subject ,
			@RequestParam(value="content",required=false)String  content ,
			@RequestParam(value="file", required=false) MultipartFile file,	
			HttpSession session
			){
		
		int userId = Integer.valueOf(String.valueOf(session.getAttribute("userId")));
		String userLoginId = (String)session.getAttribute("userLoginId");
		
		Map<String,Object> result= new HashMap<>();
		int row =  postBO.modifyPost(id,userId,userLoginId, subject, content, file);
		if(row > 0) {
			result.put("code", 1);
			result.put("result","성공");
			
		} else {
			result.put("code",500); //실패
			result.put("result","실패");
			result.put("error_message","삭제하는데 실패하였습니다.");
		}
		
		return result;
	}
	
		
}
