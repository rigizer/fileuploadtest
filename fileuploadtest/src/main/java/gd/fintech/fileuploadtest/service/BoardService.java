package gd.fintech.fileuploadtest.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import gd.fintech.fileuploadtest.vo.Board;
import gd.fintech.fileuploadtest.vo.BoardForm;
import gd.fintech.fileuploadtest.vo.Boardfile;
import gd.fintech.fileuploadtest.mapper.BoardMapper;
import gd.fintech.fileuploadtest.mapper.BoardfileMapper;

@Service
@Transactional
public class BoardService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String PATH = "C:\\Users\\Jaeyong\\Downloads\\sts-4.8.1.RELEASE\\stswork\\fileuploadtest\\src\\main\\webapp\\upload\\";
	
	@Autowired BoardMapper boardMapper;
	@Autowired BoardfileMapper boardfileMapper;
	
	public List<Board> getBoardListByPage(int currentPage, int rowPerPage) {
		// currentPage, rowPerPage를 통해 beginRow, rowPerPage 전달하여
		// boardMapper 메소드를 호출한다.
		// 이후 결과값을 받아 return 한다.
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		
		List<Board> boardList = boardMapper.selectBoardListByPage(map);
		
		return boardList;
	}
	
	public int getCountBoard() {
		return boardMapper.countBoard();
	}
	
	public List<Board> getBoardOne(int boardId) {
		List<Board> boardOne = boardMapper.selectBoardOne(boardId);
		
		return boardOne;
	}
	
	public void addBoard(BoardForm boardForm) {
		// 1. board DB 입력 -> Key 값을 받는다
		Board board = new Board();
		board.setBoardTitle(boardForm.getBoardTitle());
		board.setBoardContent(boardForm.getBoardContent());
		
		boardMapper.insertBoard(board);	// setBoardId(SELECT LAST_INSERT_ID())
		
		List<Boardfile> boardfile = null;
		
		// 사용자가 view에서 파일을 추가해서 null이 아님
		if (boardForm.getBoardfile() != null) {
			boardfile = new ArrayList<Boardfile>();
			
			for (MultipartFile mf : boardForm.getBoardfile()) {
				Boardfile bf = new Boardfile();
				
				bf.setBoardId(board.getBoardId());
				
				String filename = UUID.randomUUID().toString().replace("-", "");	// 랜덤한 파일 이름을 생성
				int p = mf.getOriginalFilename().lastIndexOf(".");	// 확장자 점 위치 확인
				String ext = mf.getOriginalFilename().substring(p).toLowerCase();	// 확장자 잘라내어 저장 (+ 소문자로 저장)
				
				bf.setBoardfileName(filename + ext);	// UUID로 만든 랜덤한 파일 이름 + 파일 확장자
				bf.setBoardfileSize(mf.getSize());
				bf.setBoardfileType(mf.getContentType());
				
				boardfile.add(bf);	// 파일 추가
				
				// 5. 서버에 파일을 저장
				try {
					// 파일을 지정한 경로로 옮긴다
					mf.transferTo(new File(PATH + filename + ext));
				} catch (Exception e) {		// 오류 발생 시 예외처리
					e.printStackTrace();	// 디버깅 코드를 출력
					throw new RuntimeException();	// 오류를 발생시킴으로서 트랜잭션 중단 및 작업 취소
				}
			}
		}
		
		if (boardfile != null) {	// 파일이 존재하는 경우
			// 리스트의 반복문 만큼 for문 반복
			for (Boardfile bf : boardfile) {
				// 데이터베이스에 파일 정보를 저장
				boardfileMapper.insertBoardfile(bf);
			}
			
			// 2. boardfile DB 입력
			// 3. boardfile.size()의 횟수만큼 입력.
			// 4. 입력시마다 boardId는 1번에서 받은 Key 값 이용
		}
	}
	
	public void modifyBoard(BoardForm boardForm) {
		Board board = new Board();
		board.setBoardId(boardForm.getBoardId());
		board.setBoardTitle(boardForm.getBoardTitle());
		board.setBoardContent(boardForm.getBoardContent());
		
		boardMapper.updateBoard(board);
		
		List<Boardfile> boardfile = null;
		
		// 사용자가 view에서 파일을 추가해서 null이 아님
		if (boardForm.getBoardfile() != null) {
			boardfile = new ArrayList<Boardfile>();
			
			for (MultipartFile mf : boardForm.getBoardfile()) {
				Boardfile bf = new Boardfile();
				
				bf.setBoardId(board.getBoardId());
				
				String filename = UUID.randomUUID().toString().replace("-", "");	// 랜덤한 파일 이름을 생성
				int p = mf.getOriginalFilename().lastIndexOf(".");	// 확장자 점 위치 확인
				String ext = mf.getOriginalFilename().substring(p).toLowerCase();	// 확장자 잘라내어 저장 (+ 소문자로 저장)
				
				bf.setBoardfileName(filename + ext);	// UUID로 만든 랜덤한 파일 이름 + 파일 확장자
				bf.setBoardfileSize(mf.getSize());
				bf.setBoardfileType(mf.getContentType());
				
				boardfile.add(bf);	// 파일 추가
				
				// 5. 서버에 파일을 저장
				try {
					// 파일을 지정한 경로로 옮긴다
					mf.transferTo(new File(PATH + filename + ext));
				} catch (Exception e) {		// 오류 발생 시 예외처리
					e.printStackTrace();	// 디버깅 코드를 출력
					throw new RuntimeException();	// 오류를 발생시킴으로서 트랜잭션 중단 및 작업 취소
				}
			}
		}
		
		if (boardfile != null) {	// 파일이 존재하는 경우
			// 리스트의 반복문 만큼 for문 반복
			for (Boardfile bf : boardfile) {
				// 데이터베이스에 파일 정보를 저장
				boardfileMapper.insertBoardfile(bf);
			}
			
			// 2. boardfile DB 입력
			// 3. boardfile.size()의 횟수만큼 입력.
			// 4. 입력시마다 boardId는 1번에서 받은 Key 값 이용
		}
	}
	
	public void removeFile(Boardfile boardfile) {
		int boardfileId = boardfile.getBoardfileId();
		String boardfileName = boardfile.getBoardfileName();
		
		// 첨부파일 경로 + 첨부파일 이름
		File file = new File(PATH + boardfileName);
		
		// 파일이 존재하는 경우
		if (file.exists()) {
			// 파일 삭제
			file.delete();
		}
		
		// 데이터베이스의 첨부파일 삭제
		boardfileMapper.deleteBoardfileOne(boardfileId);
	}
	
	public void removeBoard(int boardId) {
		// 게시물에 속해있는 첨부파일 이름 목록 조회
		List<String> boardfileNameList = boardfileMapper.selectBoardFileNameList(boardId);
		
		// 첨부파일 목록에서 파일을 하나씩 불러온다
		for (String s: boardfileNameList) {
			// 첨부파일 경로 + 첨부파일 이름
			File file = new File(PATH + s);
			
			// 파일이 존재하는 경우
			if (file.exists()) {
				// 파일 삭제
				file.delete();
			}
		}
		
		// 데이터베이스의 첨부파일 목록 삭제
		boardfileMapper.deleteBoardfile(boardId);
		
		// 데이터베이스의 게시물 삭제
		boardMapper.deleteBoard(boardId);
	}
}
