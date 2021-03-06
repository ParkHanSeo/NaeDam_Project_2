package com.naedam.admin.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.naedam.admin.board.model.service.BoardService;
import com.naedam.admin.board.model.vo.Board;
import com.naedam.admin.board.model.vo.BoardComment;
import com.naedam.admin.board.model.vo.BoardFile;
import com.naedam.admin.board.model.vo.Post;
import com.naedam.admin.board.model.vo.Search;
import com.naedam.admin.member.model.vo.Member;
import com.naedam.admin.setting.model.service.SettingService;
import com.naedam.admin.setting.model.vo.AdminMenu;

@RestController
@RequestMapping("/admin/board/*")
public class BoardRestController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private SettingService settingService;
	
	@PostMapping(value="json/addComment")
	public void addComment(@RequestBody BoardComment boardComment)throws Exception{
		System.out.println("/json/addComment 시작");
		Member member = boardService.getMemberData(boardComment.getCommentMemberNo());
		boardComment.setCommentWriter(member.getLastName()+member.getFirstName());
		boardService.addComment(boardComment);
	}
	
	@PostMapping(value="json/plupload")
	public String plupload(@RequestParam("file") MultipartFile file, HttpServletRequest request)throws Exception{
		System.out.println("/json/plupload 시작");
		String a = file.getOriginalFilename();
		String filePath = request.getServletContext().getRealPath("resources/imgs/imageBoard/board");
		File file2 = new File(filePath+file.getOriginalFilename());
		file.transferTo(file2);
		return a;
	}	
	
	@GetMapping(value="json/listBoard")
	public List<Board> listBoard() throws Exception{		
		return boardService.getBoardTitle();
	}
	
	@GetMapping(value="json/getPostList/{boardNo}")
	public Map<String, Object> getPostList(@PathVariable("boardNo") int boardNo) throws Exception{
		Board board = new Board();
		Search search = new Search();
		board.setBoardNo(boardNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("search", search);
		Map<String, Object> resultMap = boardService.getPostList2(map);
		
		return resultMap;
	}	
	
	@GetMapping(value="json/getBoardAllData/{boardNo}")
	public Board getBoardAllData(@PathVariable("boardNo") int boardNo, Model model) throws Exception{
		System.out.println("getBoardAllData 시작");		
		return boardService.getBoardAllData(boardNo);
	}
	
	@GetMapping(value="json/getMemberData/{secNo}")
	public Member getMemberData(@PathVariable("secNo") int secNo) throws Exception{
		return boardService.getMemberData(secNo);
	}
	
	@GetMapping(value="json/getPostData/{postNo}")
	public Post getPostData(@PathVariable("postNo") int postNo)throws Exception{
		System.out.println("getPostData 시작");
		return boardService.getPostData(postNo);
	}
	
	@GetMapping(value="json/getMemberData2/{memberNo}")
	public Member getMemberData2(@PathVariable("memberNo") int memberNo) throws Exception{
		System.out.println("getMemberData2 시작");
		return boardService.getMemberData(memberNo);
	}
	
	@GetMapping(value="json/getCommentList/{postNo}")
	public List<BoardComment> getCommentList(@PathVariable("postNo") int postNo) throws Exception{
		System.out.println("json/getCommentList 시작");
		List<BoardComment> boardComment = boardService.getCommentList(postNo);
		return boardComment;
	}
	
	@GetMapping(value="json/postViewCount/{postNo}")
	public void postViewCount(@PathVariable("postNo") int postNo) throws Exception{
		System.out.println("json/postViewCount 시작");
		Post post = boardService.getPostData(postNo);
		post.setPostViewCount(post.getPostViewCount()+1);
		boardService.postViewCount(post);
	}
	
	@GetMapping(value="json/postFileCount/{postNo}")
	public void postFileCount(@PathVariable("postNo") int postNo) throws Exception{
		System.out.println("json/postFileCount 시작");
		Post post = boardService.getPostData(postNo);
		post.setPostDownloadCount(post.getPostDownloadCount()+1);
		boardService.postFileCount(post);
	}
	
	@GetMapping(value="json/getPostFile/{postNo}")
	public List<BoardFile> getPostFile(@PathVariable("postNo") int postNo) throws Exception{
		System.out.println("json/getPostFile 시작");
		List<BoardFile> boardFile =  boardService.getPostFile(postNo);
		return boardFile;
	}
	
	@PostMapping("json/boardProcess")
	public Boolean boardProcess(@RequestParam(value = "boardArr[]") List<String> boardArr,  @RequestParam("mode") String mode) throws Exception{
		Boolean result = false;
		Map<String, Object> boardMap = new HashMap<>();
		boardMap.put("boardArr", boardArr);
		boardMap.put("mode", mode);
		boardService.boardProcess(boardMap);
		result = true;
		return result;
	}	
	
	@PostMapping("json/postProcess")
	public Boolean postProcess(@RequestParam(value = "postArr[]") List<String> postArr,
							   @RequestParam(value = "boardNo", required = false, defaultValue= "0") int boardNo,
							   @RequestParam("mode") String mode) throws Exception{
		Post post = new Post();
		Boolean result = false;
		Map<String, Object> postMap = new HashMap<>();
		postMap.put("postArr", postArr);
		postMap.put("mode", mode);
		postMap.put("boardNo", boardNo);
		postMap.put("post", post);
		boardService.postProcess(postMap);
		result = true;
		return result;
	}	
	
	@GetMapping(value="json/deleteFile/{fileNo}")
	public void deleteFile(@PathVariable("fileNo") int fileNo) throws Exception{
		System.out.println("json/deleteFile 시작");
		boardService.deleteFile(fileNo);
	}
	
	@GetMapping(value="json/deleteComment/{commentNo}")
	public void deleteComment(@PathVariable("commentNo") int commentNo) throws Exception{
		System.out.println("json/deleteComment 시작");
		boardService.deleteComment(commentNo);
	}
	
	@GetMapping(value="json/getAdminMenu")
	public List<AdminMenu> getAdminMenu() throws Exception{
		System.out.println("json/getAdminMenu 시작");
		List<AdminMenu> adminMenu = settingService.selectAdminMenuList();
		return adminMenu;
	}
	
	@GetMapping(value="json/downloadImg/{fileNo}")
	public void download(HttpServletResponse response, @PathVariable("fileNo") int fileNo) throws Exception {
		System.out.println("json/downloadImg 시작");
		BoardFile boardFile = boardService.getFileData(fileNo);
		
        // 직접 파일 정보를 변수에 저장해 놨지만, 이 부분이 db에서 읽어왔다고 가정한다.
		String fileName = boardFile.getFileName();
		String saveFileName = "C:\\Users\\user\\git\\mir9\\src\\main\\webapp\\resources\\imgs\\imageBoard\\board"+fileName;
		String contentType = "image/jpg";
        File file = new File(saveFileName);
        long fileLength = file.length();

        //파일의 크기와 같지 않을 경우 프로그램이 멈추지 않고 계속 실행되거나, 잘못된 정보가 다운로드 될 수 있다.

        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Content-Type", contentType);
        response.setHeader("Content-Length", "" + fileLength);
        response.setHeader("Pragma", "no-cache;");
        response.setHeader("Expires", "-1;");

        try(
                FileInputStream fis = new FileInputStream(saveFileName);
                OutputStream out = response.getOutputStream();
        ){
                int readCount = 0;
                byte[] buffer = new byte[1024];
                while((readCount = fis.read(buffer)) != -1){
                    out.write(buffer,0,readCount);
                }
        }catch(Exception ex){
            throw new RuntimeException("file Save Error");
        }
	}
	
	@PostMapping("json/updateUpAsc")
	public Boolean updateUpAsc(@RequestParam("boardAsc") int boardAsc,
							@RequestParam("boardUpAsc") int boardUpAsc,
							@RequestParam("postNo") int postNo,
							@RequestParam("upPostNo") int upPostNo) throws Exception{
		System.out.println("updateUpAsc 시작");
		Boolean result = false;
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		map.put("boardUpAsc", boardUpAsc);
		map.put("upPostNo", postNo);
		map2.put("boardUpAsc", boardAsc);
		map2.put("upPostNo", upPostNo);
		boardService.updateUpAsc(map);
		boardService.updateUpAsc(map2);
		result = true;
		return result;
	}
	
	@PostMapping("json/updateDownAsc")
	public Boolean updateDownAsc(@RequestParam("boardAsc") int boardAsc,
							@RequestParam("boardDownAsc") int boardDownAsc,
							@RequestParam("postNo") int postNo,
							@RequestParam("downPostNo") int downPostNo) throws Exception{
		System.out.println("json/updateDownAsc 시작");
		Boolean result = false;
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		map.put("boardDownAsc", boardDownAsc);
		map.put("downPostNo", postNo);
		map2.put("boardDownAsc", boardAsc);
		map2.put("downPostNo", downPostNo);
		boardService.updateDownAsc(map);
		boardService.updateDownAsc(map2);
		result = true;
		return result;
	}
	
}







