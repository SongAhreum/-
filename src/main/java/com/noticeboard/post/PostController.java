package com.noticeboard.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.noticeboard.post.bo.PostBO;
import com.noticeboard.post.model.Comment;
import com.noticeboard.post.model.Post;
import com.noticeboard.vo.PostUser;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/post")
@Controller
public class PostController {
	@Autowired
	private PostBO postBO; 
	
	
	/**
	 * 전체 글 목록
	 * @param model
	 * @return
	 */
	@GetMapping("/post_list_view")
	public String postList(Model model) {
		model.addAttribute("viewName","post/postList");
		
		List<PostUser> postList = postBO.getPost();
		model.addAttribute("postList", postList);
		
		//post작성자 정보
		
		
		return "template/layout";
	}
	
	/**
	 * 해당 글화면 (내가쓴글일때, 내가쓴글이 아닐때)
	 * @param postId
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/post_detail_view")
	public String postDetail(
			@RequestParam("postId")int  postId,
			HttpSession session,
			Model model) {
		 
		//로그인정보
		int userId = Integer.valueOf(String.valueOf(session.getAttribute("userId")));
		//선택한 글정보 post에담기		
		Post post =  postBO.getPostBYPostId(postId);
		model.addAttribute("post", post);
		
		
		//내가쓴글인지 아닌지 //필터에 로직넣기
		//String으로 타입바꾼후 비교-> ==를 equals로
		if(userId == post.getUserId()) {
			model.addAttribute("isMyPost",true);
		} else {
			model.addAttribute("isMyPost",false);
		}
		//댓글정보
		List<Comment> comments = postBO.getComment(postId);
		model.addAttribute("comments", comments);
		//내가쓴 댓글인지
		
		
		model.addAttribute("viewName","post/postDetail");
		return "template/layout";
	}	
	
	/**
	 * 내 글 목록
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/post_my_view")
	public String postMyList(
			HttpSession session,
			Model model) {
		int userId = Integer.valueOf(String.valueOf(session.getAttribute("userId")));
		//String userLoginId = (String)session.getAttribute("userLoginId");		
		
		List<Post> postMyList =postBO.getMyPost((userId));
		model.addAttribute("postMyList", postMyList);
		
		model.addAttribute("viewName","post/postMyList");
		return "template/layout";
	}
	
	
	/**
	 * 글 작성 화면
	 * @param model
	 * @return
	 */
	@GetMapping("/post_create_view")
	public String postCreate(Model model) {
		model.addAttribute("viewName","post/postCreate");
		return "template/layout";
	}
	
	/**
	 * 글 수정화면
	 * @param model
	 * @return
	 */
	@GetMapping("/post_modify_view")
	public String postModify(Model model,int id) {
		
		//어떤post를 수정할건지 작성
		Post post = postBO.getPostBYPostId(id);
		model.addAttribute("post", post);
		
		
		model.addAttribute("viewName","post/postModify");
		return "template/layout";
	}
	
	
	
	
}
