package gd.fintech.fileuploadtest.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardForm {
	private int boardId;
	private String boardTitle;
	private String boardContent;
	private List<MultipartFile> boardfile;	// MultipartFile을 통해 Form을 통해 받은 실제 파일이 저장됨
}
