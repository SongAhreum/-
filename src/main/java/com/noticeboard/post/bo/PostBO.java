package com.noticeboard.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.noticeboard.common.FileManagerService;
import com.noticeboard.post.dao.PostDAO;
import com.noticeboard.post.model.Comment;
import com.noticeboard.post.model.Post;
import com.noticeboard.vo.PostUser;

@Service
public class PostBO {
	
	@Autowired
	private PostDAO postDAO;
	@Autowired
	private  FileManagerService fileManagerService;
	
	//글목록
	public List<PostUser> getPost(){
		return postDAO.selectPost();
	}
	//내글보기
	public List<Post> getMyPost(int userId){		
		return postDAO.selectMyPost(userId);
	}
	//선택글 보기
	public Post getPostBYPostId(int postId) {
		return postDAO.selectPostBYPostId(postId);
	}
	//댓글목록
	public List<Comment> getComment(int postId){
		return postDAO.selectComment(postId);
	}
	//글쓰기
	public int addPost(int userId, String userLoginId, 
			String subject, String content, MultipartFile file){
		// 파일 업로드 => 경로
		String imagePath = null;
		if (file != null) {
			// 파일이 있을 때만 업로드 => 이미지 경로를 얻어냄
			imagePath = fileManagerService.saveFile(userLoginId, file);
		}
		
		return postDAO.insertPost(userId, subject, content, imagePath); 
	}		
	//글지우기
	public int removePost(int id) {
		return postDAO.deletePost(id);
	}
	//글 수정하기
	public int modifyPost(int id,int userId,String userLoginId,String subject,String content, MultipartFile file) {
		String imagePath = null;
		if (file != null) {
			// 파일이 있을 때만 업로드 => 이미지 경로를 얻어냄
			imagePath = fileManagerService.saveFile(userLoginId, file);
		}
		
		return postDAO.updatePost(id, userId, subject, content, imagePath);
	}
}
