package gd.fintech.fileuploadtest.vo;

import java.util.List;

import lombok.Data;

@Data
public class Comment {
	private int commentId;
	private int boardId;
	private String commentContent;
}
