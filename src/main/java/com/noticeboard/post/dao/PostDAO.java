package com.noticeboard.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.noticeboard.post.model.Comment;
import com.noticeboard.post.model.Post;
import com.noticeboard.vo.PostUser;

@Repository
public interface PostDAO {
	//모든 post list
	public List<PostUser> selectPost();
	//내 post list
	public List<Post> selectMyPost(int userId);
	//해당 post detail
	public Post selectPostBYPostId(
			@Param("postId") int postId);
	//해당 post의 댓글
	public List<Comment> selectComment(int postId);
	//글쓰기
	public int insertPost(
			@Param("userId") int userId,
			@Param("subject") String  subject ,
			@Param("content") String  content ,
			@Param("imagePath") String imagePath);
	//글지우기
	public int deletePost(int id);
	//글수정하기
	public int updatePost(
			@Param("id") int id,
			@Param("userId") int userId,
			@Param("subject") String subject,
			@Param("content") String content,
			@Param("imagePath") String imagePath); 

}
