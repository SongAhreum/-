package com.noticeboard.post.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noticeboard.post.dao.CommentDAO;

@Service
public class CommentBO {
	@Autowired
	private CommentDAO commentDAO;
	
	public void addComment(int postId,int userId,String content) {
		commentDAO.insertComment(postId, userId, content);
	}
	public int removeComment(int id) {
		return commentDAO.deleteComment(id);
	}
}
