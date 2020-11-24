package gd.fintech.fileuploadtest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import gd.fintech.fileuploadtest.service.BoardService;
import gd.fintech.fileuploadtest.vo.Board;
import gd.fintech.fileuploadtest.vo.BoardForm;
import gd.fintech.fileuploadtest.vo.Boardfile;

@Controller
public class BoardController {
	@Autowired BoardService boardService;
	
	// INDEX 페이지
	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	// 게시물 목록
	@GetMapping("/boardList/{currentPage}")
	public String boardList(Model model, @PathVariable(value = "") int currentPage) {
		int rowPerPage = 10;	// 한 페이지에 10개씩 데이터 출력
		
		List<Board> boardList = boardService.getBoardListByPage(currentPage, rowPerPage);
		System.out.println("Debug: " + boardList);
		
		int totalCount = boardService.getCountBoard();	// 전체 데이터 수
		int lastPage = totalCount / rowPerPage;	// 마지막 페이지
		
		if (totalCount % rowPerPage != 0) {	// 10 미만의 개수의 데이터가 있는 페이지를 표시
			lastPage += 1;
		}
		
		if (lastPage == 0) { // 전체 페이지가 0개이면 현재 페이지도 0으로 표시
			currentPage = 0;
		}
		
		int navPerPage = 10;	// 네비게이션에 표시할 페이지 수
		int navFirstPage = currentPage - (currentPage % navPerPage) + 1;	// 네비게이션 첫번째 페이지
		int navLastPage = navFirstPage + navPerPage - 1;	// 네비게이션 마지막 페이지
		
		if (currentPage % navPerPage == 0 && currentPage != 0) {	// 10으로 나누어 떨어지는 경우 처리하는 코드
			navFirstPage = navFirstPage - navPerPage;
			navLastPage = navLastPage - navPerPage;
		}
		
	    // 현재 페이지에 대한 이전 페이지
		int prePage = 1;
	    if (currentPage > 10) {
	    	prePage =  currentPage - (currentPage % navPerPage) + 1 - 10;
	    } else {
	    	prePage = 1;
	    }

	    // 현재 페이지에 대한 다음 페이지
	    int nextPage = currentPage - (currentPage % navPerPage) + 1 + 10;
	    if (nextPage > totalCount) {
	    	nextPage = totalCount;
	    }
		
		model.addAttribute("boardList", boardList);
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);
		
		model.addAttribute("navPerPage", navPerPage);
		model.addAttribute("navFirstPage", navFirstPage);
		model.addAttribute("navLastPage", navLastPage);
		
		model.addAttribute("prePage", prePage);
		model.addAttribute("nextPage", nextPage);
		
		return "boardList";
	}
	
	// 게시물 조회
	@GetMapping("/boardOne/{boardId}")
	public String BoardOne(Model model, @PathVariable(value = "boardId") int boardId) {
		List<Board> board = boardService.getBoardOne(boardId);
		System.out.println("Debug: " + board);
		
		model.addAttribute("board", board);
		
		return "boardOne";
	}
	
	// 게시물 입력 Form
	@GetMapping("/addBoard")
	public String addBoard() {
		return "addBoard";
	}
	
	// 게시물 입력 Action
	@PostMapping("/addBoard")
	public String addBoard(BoardForm boardForm) {
		Board board = boardService.addBoard(boardForm);
		
		return "redirect:/boardOne/" + board.getBoardId();
	}
	
	// 게시물 수정 Form
	@GetMapping("/modifyBoard/{boardId}")
	public String modifyBoardForm(Model model, @PathVariable(value = "boardId") int boardId) {
		List<Board> board = boardService.getBoardOne(boardId);
		System.out.println("Debug: " + board);
		
		model.addAttribute("board", board);
		
		return "modifyBoard";
	}
	
	// 게시물 수정 Action
	@PostMapping("/modifyBoard")
	public String modifyBoardAction(BoardForm boardForm) {
		System.out.println("Debug: " + boardForm);
		boardService.modifyBoard(boardForm);
		
		return "redirect:/boardOne/" + boardForm.getBoardId();
	}
	
	// 게시물 개별 첨부파일 삭제
	@GetMapping("/removeFile/{boardId}/{boardfileId}/{boardfileName}")
	public String removeFile(Model model, 
			@PathVariable(value = "boardId") int boardId, 
			@PathVariable(value = "boardfileId") int boardfileId, 
			@PathVariable(value = "boardfileName") String boardfileName) {
		
		Boardfile boardfile = new Boardfile();
		boardfile.setBoardfileId(boardfileId);
		boardfile.setBoardfileName(boardfileName);
		
		System.out.println("Debug: boardfile[" + boardfile +"] 삭제");
		boardService.removeFile(boardfile);
		
		return "redirect:/modifyBoard/" + boardId;
	}
	
	// 게시물 삭제
	@GetMapping("/removeBoard/{boardId}")
	public String removeBoard(Model model, @PathVariable(value = "boardId") int boardId) {
		
		System.out.println("Debug: boardId[" + boardId + "] 삭제");
		boardService.removeBoard(boardId);
		
		return "redirect:/boardList/1";
	}
}
