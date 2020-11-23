package gd.fintech.fileuploadtest.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.fileuploadtest.vo.Boardfile;

@Mapper
public interface BoardfileMapper {
	// 첨부파일 목록
	List<String> selectBoardFileNameList(int boardId);
	
	// 첨부파일 입력
	int insertBoardfile(Boardfile boardfile);
	
	// 단일 첨부파일 삭제
	int deleteBoardfileOne(int boardfileId);
	
	// 전체 첨부파일 삭제
	int deleteBoardfile(int boardId);
}
