package com.naedam.admin.board.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.naedam.admin.board.model.service.BoardService;
import com.naedam.admin.board.model.vo.Board;
import com.naedam.admin.board.model.vo.BoardAuthority;
import com.naedam.admin.board.model.vo.BoardComment;
import com.naedam.admin.board.model.vo.BoardFile;
import com.naedam.admin.board.model.vo.BoardOption;
import com.naedam.admin.board.model.vo.Page;
import com.naedam.admin.board.model.vo.Post;
import com.naedam.admin.board.model.vo.Search;
import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.member.controller.MemberController;
import com.naedam.admin.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/board/*")
@Slf4j
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	int pageUnit = 5;
	int pageSize = 5;
	
	// 게시판 프로세스
	// 게시판 등록, 수정, 선택삭제
	// 권한 등록, 수정
	// 옵션 등록, 수정
	@PostMapping("boardProcess")
	public String boardProcess(@ModelAttribute("board") Board board, @ModelAttribute("boardAuthority") BoardAuthority boardAuthority, @ModelAttribute("boardOption") BoardOption boardOption,
							   @RequestParam("mode") String mode) throws Exception {
		Map<String, Object> boardMap = new HashMap<>();
		boardMap.put("board", board);
		boardMap.put("boardAuthority", boardAuthority);
		boardMap.put("boardOption", boardOption);
		boardMap.put("mode", mode);
		boardService.boardProcess(boardMap);
		return "redirect:/admin/board/listBoard";
	}
	
	// 게시글 프로세스
	// 게시글 등록, 수정, 삭제, 복사, 이전, 파일등록, 계층형쿼리 등록
	@PostMapping("postProcess")
	public String postProcess(@ModelAttribute("board") Board board, @ModelAttribute("post") Post post,
							  @RequestParam(value="postName", required = false) MultipartFile[] postName, @RequestParam(value="postName", required = false) String[] postName2, 
							  @RequestParam(value="ThombnailName", required = false) MultipartFile ThombnailName, @RequestParam("secNo") String secNo, @RequestParam("mode") String mode,
						      HttpServletRequest request) throws Exception {
		String filePath = request.getServletContext().getRealPath("resources/imgs/imageBoard/board");	
		Map<String, Object> postMap	 = new HashMap<>();
		postMap.put("board", board);
		postMap.put("post", post);	
		postMap.put("mode", mode);
		postMap.put("postName", postName);
		postMap.put("postName2", postName2);
		postMap.put("ThombnailName", ThombnailName);
		postMap.put("filePath", filePath);
		postMap.put("secNo", secNo);
		boardService.postProcess(postMap);
		return "redirect:/admin/board/postList?boardNo="+board.getBoardNo();
	}
	
	//게시판 목록
	@GetMapping("listBoard")
	public String listBoard(@ModelAttribute("search") Search search, Model model) throws Exception {
		
		//게시글 수
		//각 게시판마다 게시글 수가 필요하여 List로 게시글 수를 뽑아와 List에 add하는 방식
		List postCount = new ArrayList();
		List<Board> board = boardService.getBoardTitle();
		//게시판 리스트
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("board", board);
		Map<String, Object> resultMap = boardService.getBoardList(map);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)resultMap.get("totalCount")).intValue(), pageUnit, pageSize);
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("postCount", resultMap.get("postCount"));
		
		return "admin/board/boardList";
	}
	
	//게시글 목록
	@RequestMapping( value="postList")
	public String listPost(Model model, HttpServletRequest request ,
						   @RequestParam("boardNo") int boardNo, 
						   @RequestParam(defaultValue = "1") int cPage,
						   @ModelAttribute("search") Search search) throws Exception {
		//게시글 리스트 수 limit 10으로
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		//게시글 리스트 옵션과 권한의 조건에 따라 태그를 생성해야 함
		Board board2 = boardService.getBoardAllData(boardNo);
		model.addAttribute("board2", board2);
		
		//게시글 리스트
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("boardNo", boardNo);
		Map<String, Object> resultMap = boardService.getPostList(map, offset, limit);
		int totalPostListCount = Integer.parseInt(resultMap.get("totalCount").toString());
		
		// pagebar
		String url = request.getRequestURI();
		String pagebar = Mir9Utils.getPagebar(cPage, limit, totalPostListCount, url);
		model.addAttribute("pagebar", pagebar);		
		model.addAttribute("list", resultMap.get("list")); 
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("pageCount",totalPostListCount);
		return "admin/board/postList";
	}
	
	@PostMapping("deleteThombnail")
	public String deleteThombnail(@ModelAttribute("post") Post post,
								  @RequestParam("boardNo") int boardNo) throws Exception {
		System.out.println("deleteThombnail 시작");
		boardService.updateThombnail(post);
		return "redirect:/admin/board/postList?boardNo="+boardNo;
	}	
	
	//ckEditor 이미지 업로드
	@PostMapping("imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,
							MultipartHttpServletRequest multiFile,
							@RequestParam MultipartFile upload) throws Exception{
		UUID uid = UUID.randomUUID();
		OutputStream out = null;
		PrintWriter printWriter = null;
		try{ 
			//파일 이름 가져오기 
			String fileName = upload.getOriginalFilename(); 
			byte[] bytes = upload.getBytes(); 
			//이미지 경로 생성 
			String path = request.getServletContext().getRealPath("resources/imgs/imageBoard/ckeditorImg/");
			// fileDir는 전역 변수라 그냥 이미지 경로 설정해주면 된다. 
			String ckUploadPath = path + uid + "_" + fileName; 
			File folder = new File(path); 
			//해당 디렉토리 확인 
			if(!folder.exists()){ 
				try{ folder.mkdirs(); // 폴더 생성 
				}catch(Exception e){ 
					e.getStackTrace(); 
				} 
			} 
			out = new FileOutputStream(new File(ckUploadPath)); 
			out.write(bytes); 
			out.flush(); // outputStram에 저장된 데이터를 전송하고 초기화 
			String callback = request.getParameter("CKEditorFuncNum"); 
			printWriter = response.getWriter(); 
			String fileUrl = "/admin/board/ckImgSubmit?uid=" + uid + "&fileName=" + fileName; // 작성화면 
			// 업로드시 메시지 출력 
			printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}"); 
			printWriter.flush(); 
			}catch(IOException e){ 
				e.printStackTrace(); 
			} finally { 
				try { 
					if(out != null) { 
						out.close(); 
					} 
					if(printWriter != null) { 
						printWriter.close(); 
					} 
				} catch(IOException e) { 
					e.printStackTrace(); 
				} 
			} return;
					
	}
	//ckEditor 이미지 업로드 실행
	@RequestMapping(value="ckImgSubmit") 
	public void ckSubmit(@RequestParam(value="uid") String uid , 
						 @RequestParam(value="fileName") String fileName , 
						 HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{ 
		//서버에 저장된 이미지 경로 
		String path = request.getServletContext().getRealPath("resources/imgs/imageBoard/ckeditorImg/");
		String sDirPath = path + uid + "_" + fileName; 
		File imgFile = new File(sDirPath); 
		//사진 이미지 찾지 못하는 경우 예외처리로 빈 이미지 파일을 설정한다. 
		if(imgFile.isFile()){ 
			byte[] buf = new byte[1024]; 
			int readByte = 0; 
			int length = 0; 
			byte[] imgBuf = null; 
			FileInputStream fileInputStream = null; 
			ByteArrayOutputStream outputStream = null; 
			ServletOutputStream out = null; 
			try{ 
				fileInputStream = new FileInputStream(imgFile); 
				outputStream = new ByteArrayOutputStream(); 
				out = response.getOutputStream(); 
				while((readByte = fileInputStream.read(buf)) != -1){ 
					outputStream.write(buf, 0, readByte); 
				} 
				imgBuf = outputStream.toByteArray(); 
				length = imgBuf.length; 
				out.write(imgBuf, 0, length); 
				out.flush(); 
			}catch(IOException e){ 	 
			}finally { 
				outputStream.close(); 
				fileInputStream.close(); 
				out.close(); 
			} 
		} 
	}
	
	
}

