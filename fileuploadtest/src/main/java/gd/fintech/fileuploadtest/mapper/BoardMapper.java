package gd.fintech.fileuploadtest.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.fileuploadtest.vo.Board;

@Mapper
public interface BoardMapper {
	// 게시물 목록
	List<Board> selectBoardListByPage(Map<String, Integer> map);
	
	// 게시물 개수 카운트
	int countBoard();
	
	// 게시물 내용
	List<Board> selectBoardOne(int boardId);
	
	// 게시물 입력
	int insertBoard(Board board);
	
	// 게시물 수정
	int updateBoard(Board board);
	
	// 게시물 삭제
	int deleteBoard(int boardId);
}
