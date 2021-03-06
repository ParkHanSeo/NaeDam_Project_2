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
	
	@PostMapping("boardProcess")
	public String boardProcess(@ModelAttribute("board") Board board,
							   @ModelAttribute("boardAuthority") BoardAuthority boardAuthority,
							   @ModelAttribute("boardOption") BoardOption boardOption,
							   @RequestParam("mode") String mode) throws Exception {
		Map<String, Object> boardMap = new HashMap<>();
		boardMap.put("board", board);
		boardMap.put("boardAuthority", boardAuthority);
		boardMap.put("boardOption", boardOption);
		boardMap.put("mode", mode);
		boardService.boardProcess(boardMap);
		return "redirect:/admin/board/listBoard";
	}
	
	@PostMapping("addPost")
	public String addPost(@ModelAttribute("post") Post post,
						  @ModelAttribute("board") Board board,
						  HttpSession session,
					      @RequestParam(value="postName") MultipartFile[] postName,
					      @RequestParam("ThombnailName") MultipartFile ThombnailName,HttpServletRequest request) throws Exception {
		
		System.out.println("addPost ??????");
		
		BoardFile boardFile = new BoardFile();
		
		//1??? ????????? ???????????? ????????? ??????
		Member member2 = boardService.getMemberData(1);
		post.setPostMember(member2);
		post.setPostMemberName(member2.getLastName()+member2.getFirstName());
		
		//?????? ?????????
		String filePath = request.getServletContext().getRealPath("resources/imgs/imageBoard/board");
		File file = new File(filePath+ThombnailName.getOriginalFilename());
		post.setPostBoard(board);
		post.setPostThombnail(ThombnailName.getOriginalFilename());
		ThombnailName.transferTo(file);
		boardService.addPost(post);
		
		
		for(int i = 0; i < postName.length; i++) {
			File file2 = new File(filePath+postName[i].getOriginalFilename());
			boardFile.setFilePost(post);
			boardFile.setFileName(postName[i].getOriginalFilename());
			postName[i].transferTo(file2);
			boardService.addFile(boardFile);
		}
		
		return "redirect:/admin/board/postList?boardNo="+board.getBoardNo();
	}
	
	@PostMapping("addPost2")
	public String addPost2(@ModelAttribute("post") Post post,
						  @ModelAttribute("board") Board board,
					      @RequestParam(value="postName") String[] postName,
					      @RequestParam("ThombnailName") MultipartFile ThombnailName,
					      HttpServletRequest request) throws Exception {
		
		System.out.println("addPost2 ??????");
		
		BoardFile boardFile = new BoardFile();
		
		//1??? ????????? ???????????? ????????? ??????
		Member member2 = boardService.getMemberData(1);
		post.setPostMember(member2);
		post.setPostMemberName(member2.getLastName()+member2.getFirstName());
		System.out.println("?????? ?????? ::: === "+ postName.length);
		
		//?????? ?????????
		String filePath = request.getServletContext().getRealPath("resources/imgs/imageBoard/board");
		File file = new File(filePath+ThombnailName.getOriginalFilename());
		post.setPostBoard(board);
		post.setPostThombnail(ThombnailName.getOriginalFilename());
		ThombnailName.transferTo(file);
		boardService.addPost(post);
		
		for(int i = 0; i < postName.length; i++) {
			if(i >= 1) {
				boardFile.setFilePost(post);
				boardFile.setFileName(postName[i]);
				boardService.addFile(boardFile);
			}
		}
		
		return "redirect:/admin/board/postList?boardNo="+board.getBoardNo();
	}
	
	@PostMapping("addAnswerPost")
	public String addAnswerPost(@ModelAttribute("post") Post post,
								@ModelAttribute("board") Board board,
								@RequestParam(value="postName") MultipartFile[] postName,
								@RequestParam("ThombnailName") MultipartFile ThombnailName, HttpServletRequest request) throws Exception {
		
		System.out.println("addAnswerPost ??????");
		System.out.println("post ????????? ?????? ::: "+post);
		BoardFile boardFile = new BoardFile();
		//1??? ????????? ???????????? ????????? ??????
		Member member2 = boardService.getMemberData(1);
		post.setPostMember(member2);
		post.setPostMemberName(member2.getLastName()+member2.getFirstName());
		System.out.println("memeberData ==== "+member2);
		
		//?????? ?????????
		String filePath = request.getServletContext().getRealPath("resources/imgs/imageBoard/board");
		File file = new File(filePath+ThombnailName.getOriginalFilename());
		post.setPostBoard(board);
		post.setPostThombnail(ThombnailName.getOriginalFilename());
		ThombnailName.transferTo(file);
		
		for(int i = 0; i < postName.length; i++) {
			File file2 = new File(filePath+postName[i].getOriginalFilename());
			boardFile.setFilePost(post);;
			boardFile.setFileName(postName[i].getOriginalFilename());
			postName[i].transferTo(file2);
			boardService.addFile(boardFile);
		}
		//?????? ????????? ???	
		
		
		Post post2 = boardService.getPostData(post.getPostNo());
		post.setPostOriginNo(post.getPostOriginNo()); // ?????? ??????
		post.setPostOrd(post2.getPostAsc());
		post.setPostLayer(post2.getPostLayer());
		
		boardService.addAnswerPost(post);
		
		
		
		return "redirect:/admin/board/postList?boardNo="+board.getBoardNo();
	}
	
	@PostMapping("addComment")
	public void updateComment(@ModelAttribute("boardComment") BoardComment boardComment,
							  @RequestParam("postNo") int postNo,
							  @RequestParam("memberNo") int memberNo)throws Exception{
		System.out.println("addComment ??????"); 
	}
	
	
	@PostMapping("updatePost")
	public String updataPost(@ModelAttribute("post") Post post,
							 @RequestParam("boardNo") int boardNo,
							 @RequestParam(value="postName") MultipartFile[] postName,
						     @RequestParam("ThombnailName") MultipartFile ThombnailName, HttpServletRequest request) throws Exception{
		System.out.println("updatePost ??????");
		Board board = new Board();
		BoardFile boardFile = new BoardFile();
		board.setBoardNo(boardNo);
		
		//?????? ?????????
		String filePath = request.getServletContext().getRealPath("resources/imgs/imageBoard/board");
		File file = new File(filePath+ThombnailName.getOriginalFilename());
		post.setPostBoard(board);
		if(ThombnailName.isEmpty() == false) {
			post.setPostThombnail(ThombnailName.getOriginalFilename());
			ThombnailName.transferTo(file);
		}else if(ThombnailName.isEmpty() == true) {
			Post postData = boardService.getPostData(post.getPostNo());
			post.setPostThombnail(postData.getPostThombnail());
			ThombnailName.transferTo(file);
		}
		for(int i = 0; i < postName.length; i++) {
			File file2 = new File(filePath+postName[i].getOriginalFilename());
			boardFile.setFilePost(post);;
			boardFile.setFileName(postName[i].getOriginalFilename());
			postName[i].transferTo(file2);
			boardService.addFile(boardFile);
		}
		//?????? ????????? ???
		
		boardService.updatePost(post);
		
		return "redirect:/admin/board/postList?boardNo="+board.getBoardNo();
	}
	
	@PostMapping("updatePost2")
	public String updataPost2(@ModelAttribute("post") Post post,
							 @RequestParam("boardNo") int boardNo,
							 @RequestParam(value="postName") String[] postName,
						     @RequestParam("ThombnailName") MultipartFile ThombnailName, HttpServletRequest request) throws Exception{
		System.out.println("updatePost2 ??????");
		
		Board board = new Board();
		BoardFile boardFile = new BoardFile();
		board.setBoardNo(boardNo);
		
		//?????? ?????????
		String filePath = request.getServletContext().getRealPath("resources/imgs/imageBoard/board");
		File file = new File(filePath+ThombnailName.getOriginalFilename());
		post.setPostBoard(board);
		if(ThombnailName.isEmpty() == false) {
			post.setPostThombnail(ThombnailName.getOriginalFilename());
			ThombnailName.transferTo(file);
		}else if(ThombnailName.isEmpty() == true) {
			Post postData = boardService.getPostData(post.getPostNo());
			post.setPostThombnail(postData.getPostThombnail());
			ThombnailName.transferTo(file);
		}
		for(int i = 0; i < postName.length; i++) {
			if(i >= 1) {
				boardFile.setFilePost(post);;
				boardFile.setFileName(postName[i]);
				boardService.addFile(boardFile);
			}
		}
		//?????? ????????? ???
		
		boardService.updatePost(post);
		
		return "redirect:/admin/board/postList?boardNo="+board.getBoardNo();
	}
	
	
	
	@GetMapping("listBoard")
	public String listBoard(@ModelAttribute("search") Search search, Board board, Model model) throws Exception {
		
		System.out.println("listBoard ??????");

		List postCount = new ArrayList();
		List<Board> board2 = boardService.getBoardTitle();
		
		for(int i = 0 ; i < board2.size(); i++) {
			int a = boardService.getTotalCount3(board2.get(i).getBoardNo());
			postCount.add(a);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		Map<String, Object> resultMap = boardService.getBoardList(map);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)resultMap.get("totalCount")).intValue(), pageUnit, pageSize);

		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("postCount", postCount);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "admin/board/boardList";
	}
	
	@RequestMapping( value="postList")
	public String listPost(Model model, HttpServletRequest request ,
						   @RequestParam("boardNo") int boardNo, 
						   @RequestParam(defaultValue = "1") int cPage,
						   @ModelAttribute("search") Search search) throws Exception {
		
		System.out.println("/listPost ??????");
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Board board2 = boardService.getBoardAllData(boardNo);
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
		model.addAttribute("board2", board2);
		model.addAttribute("pageCount",totalPostListCount);
		return "admin/board/postList";
	}

	
	@PostMapping("deleteChoicePost")
	public void deleteChoicePost(@RequestParam(value = "postArr[]") List<String> postArr, 
								  Post post) throws Exception{
		
		System.out.println("deleteChoicePost ??????");
		
		int result = 0;
		int postNo = 0;
	
		for(String i : postArr) {
			postNo = Integer.parseInt(i);
			post.setPostNo(postNo);
			boardService.deleteChoicePost(post.getPostNo());
		}
		result = 1;
		
	}
	
	@PostMapping("deleteThombnail")
	public String deleteThombnail(@ModelAttribute("post") Post post,
								  @RequestParam("boardNo") int boardNo) throws Exception {
		System.out.println("deleteThombnail ??????");
		
		boardService.updateThombnail(post);
		
		return "redirect:/admin/board/postList?boardNo="+boardNo;
	}
	
	@PostMapping("addPostCopy")
	public void addPostCopy(@RequestParam(value = "postArr[]") List<String> postArr,
							@RequestParam("boardNo")int boardNo) throws Exception{
		
		System.out.println("addPostCopy ??????");
		Board board = new Board();
		int result = 0;
		int postNo = 0;
		System.out.println("boardNo ?????? ::: "+boardNo);
		for(String i : postArr) {
			postNo = Integer.parseInt(i);
			Post post = boardService.getPostData(postNo);
			post.getPostBoard().setBoardNo(boardNo);
			boardService.addPost(post);
		}
		result = 1;
		
	}
	
	@PostMapping("addPostChange")
	public void addPostChange(@RequestParam(value = "postArr[]") List<String> postArr,
							@RequestParam("boardNo")int boardNo) throws Exception{
		
		System.out.println("addPostChange ??????");
		
		Board board = new Board();
		
		
		int result = 0;
		int postNo = 0;
		
		for(String i : postArr) {
			postNo = Integer.parseInt(i);
			Post post = boardService.getPostData(postNo);
			post.getPostBoard().setBoardNo(boardNo);
			boardService.addPost(post);
			boardService.deleteChoicePost(postNo);
		}
		result = 1;
		
	}	
	
	@PostMapping("imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,
							MultipartHttpServletRequest multiFile,
							@RequestParam MultipartFile upload) throws Exception{
		
		System.out.println("?????? ??????");
		UUID uid = UUID.randomUUID();
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		
		
		try{ 
			//?????? ?????? ???????????? 
			String fileName = upload.getOriginalFilename(); 
			byte[] bytes = upload.getBytes(); 
			//????????? ?????? ?????? 
			String path = request.getServletContext().getRealPath("resources/imgs/imageBoard/ckeditorImg/");
			// fileDir??? ?????? ????????? ?????? ????????? ?????? ??????????????? ??????. 
			String ckUploadPath = path + uid + "_" + fileName; 
			File folder = new File(path); 
			//?????? ???????????? ?????? 
			if(!folder.exists()){ 
				try{ folder.mkdirs(); // ?????? ?????? 
				}catch(Exception e){ 
					e.getStackTrace(); 
				} 
			} 
			out = new FileOutputStream(new File(ckUploadPath)); 
			out.write(bytes); 
			out.flush(); // outputStram??? ????????? ???????????? ???????????? ????????? 
			String callback = request.getParameter("CKEditorFuncNum"); 
			printWriter = response.getWriter(); 
			String fileUrl = "/admin/board/ckImgSubmit?uid=" + uid + "&fileName=" + fileName; // ???????????? 
			// ???????????? ????????? ?????? 
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
	
	@RequestMapping(value="ckImgSubmit") 
	public void ckSubmit(@RequestParam(value="uid") String uid , 
						 @RequestParam(value="fileName") String fileName , 
						 HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{ 
		//????????? ????????? ????????? ?????? 
		String path = request.getServletContext().getRealPath("resources/imgs/imageBoard/ckeditorImg/");
		
		String sDirPath = path + uid + "_" + fileName; 
		
		File imgFile = new File(sDirPath); 
		//?????? ????????? ?????? ????????? ?????? ??????????????? ??? ????????? ????????? ????????????. 
		
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
	
	@RequestMapping("test")
	public String test() throws Exception{
		
		return "admin/board/test";
	}
	

		
	
}

























