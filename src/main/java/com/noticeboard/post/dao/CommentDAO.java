package com.noticeboard.post.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentDAO {
	public void insertComment(
			@Param("postId") int postId,
			@Param("userId") int userId,
			@Param("content") String content);
	public int deleteComment(int id); 
}
