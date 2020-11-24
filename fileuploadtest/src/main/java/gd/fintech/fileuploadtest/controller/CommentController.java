package gd.fintech.fileuploadtest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import gd.fintech.fileuploadtest.service.CommentService;
import gd.fintech.fileuploadtest.vo.Comment;

@Controller
public class CommentController {
	@Autowired CommentService commentService;
	
	// 댓글 입력
	@PostMapping("/addComment")
	public String addComment(Comment comment) {
		commentService.addComment(comment);
		
		return "redirect:/boardOne/" + comment.getBoardId();
	}
	
	// 댓글 삭제
	@GetMapping("/removeComment/{commentId}/{boardId}")
	public String removeComment(
			@PathVariable(value = "commentId") int commentId, 
			@PathVariable(value = "boardId") int boardId) {
		commentService.removeComment(commentId);
		
		return "redirect:/boardOne/" + boardId;
	}
}
