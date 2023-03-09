package com.noticeboard.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.noticeboard.post.bo.CommentBO;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/post")
public class CommentRestController {
	@Autowired
	private CommentBO commentBO;
	
	/**
	 * 댓글등록하기
	 * @param postId
	 * @param content
	 * @param session
	 * @return
	 */
	@RequestMapping("/post_comment")
	public  Map<String,Object> postComment(
			@RequestParam("postId") int postId,
			@RequestParam("content") String content,			
			HttpSession session){
		//로그인정보
		int userId = Integer.valueOf(String.valueOf(session.getAttribute("userId"))); 
		
		//DB insert
		commentBO.addComment(postId, userId, content);
		//결과
		Map<String,Object> result = new HashMap<>();
		result.put("code",1);
		result.put("result","성공");
		return result;
	}
	
	//댓글삭제하기
	@DeleteMapping("/delete_comment")
	public Map<String,Object> removeComment(int id){
		Map<String,Object> result= new HashMap<>();
		//db delete
		int row = commentBO.removeComment(id);
		
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
