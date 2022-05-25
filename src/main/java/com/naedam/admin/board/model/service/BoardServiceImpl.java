package com.naedam.admin.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.board.model.dao.BoardDao;
import com.naedam.admin.board.model.vo.Board;
import com.naedam.admin.board.model.vo.BoardAuthority;
import com.naedam.admin.board.model.vo.BoardComment;
import com.naedam.admin.board.model.vo.BoardFile;
import com.naedam.admin.board.model.vo.BoardOption;
import com.naedam.admin.board.model.vo.BoardTranslate;
import com.naedam.admin.board.model.vo.Post;
import com.naedam.admin.board.model.vo.Search;
import com.naedam.admin.member.model.vo.Member;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	@Override
	public int addBoard(Board board) throws Exception {
		return boardDao.addBoard(board);
	}
	
	@Override
	public int addPost(Post post) throws Exception {
		return boardDao.addPost(post);
	}
	
	@Override
	public int addAnswerPost(Post post) throws Exception {
		return boardDao.addAnswerPost(post);
	}

	@Override
	public int addAuthority(BoardAuthority boardAuthority) throws Exception {
		return boardDao.addAuthority(boardAuthority);
	}

	@Override
	public int addOption(BoardOption boardOption) throws Exception {
		return boardDao.addOption(boardOption);
	}
	
	@Override
	public int addComment(BoardComment boardComment) throws Exception {
		return boardDao.addComment(boardComment);
	}

	@Override
	public int addTranslate(BoardTranslate boardTranslate) throws Exception {
		return boardDao.addTranslate(boardTranslate);
	}
	
	@Override
	public int addFile(BoardFile boardFile) throws Exception {
		return boardDao.addFile(boardFile);
	}

	@Override
	public Map<String, Object> getBoardList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", boardDao.getBoardList(map));
		resultMap.put("totalCount", boardDao.getTotalCount(map));
		
		return resultMap;
	}

	@Override
	public Map<String, Object> getPostList(Map<String, Object> map, int offset, int limit) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", boardDao.getPostList(map, offset, limit));
		resultMap.put("totalCount", boardDao.getTotalCount2(map));
				
		return resultMap;
	}
	
	@Override
	public Map<String, Object> getPostList2(Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", boardDao.getPostList2(map));
		resultMap.put("totalCount", boardDao.getTotalCount2(map));
		return resultMap;
	}
	
	@Override
	public List<BoardComment> getCommentList(int postNo) throws Exception {
		return boardDao.getCommentList(postNo);
	}
	
	@Override
	public List<Board> getBoardTitle() throws Exception {
		return boardDao.getBoardTitle();
	}

	@Override
	public Board getBoardData(int boardNo) throws Exception {
		return boardDao.getBoardData(boardNo);
	}
	
	@Override
	public Post getPostData(int postNo) throws Exception {
		return boardDao.getPostData(postNo);
	}
	
	@Override
	public Board getBoardAllData(int boardNo) throws Exception {
		return boardDao.getBoardAllData(boardNo);
	}

	@Override
	public Member getMemberData(int memberNo) throws Exception {
		return boardDao.getMemberData(memberNo);
	}
	
	@Override
	public List<BoardFile> getPostFile(int postNo) throws Exception {
		return boardDao.getPostFile(postNo);
	}
	
	@Override
	public BoardFile getFileData(int fileNo) throws Exception {
		return boardDao.getFileData(fileNo);
	}


	@Override
	public void deleteChoiceBoard(int boardNo) throws Exception {
		boardDao.deleteChoiceBoard(boardNo);
	}
	
	@Override
	public void deleteChoicePost(int postNo) throws Exception {
		boardDao.deleteChoicePost(postNo);
	}
	
	@Override
	public void deleteFile(int fileNo) throws Exception {
		boardDao.deleteFile(fileNo);
	}
	
	@Override
	public void deleteComment(int commentNo) throws Exception {
		boardDao.deleteComment(commentNo);
	}

	@Override
	public int updateBoard(Board board) throws Exception {
		return boardDao.updateBoard(board);
	}

	@Override
	public int updateAuthority(BoardAuthority boardAuthority) throws Exception {
		return boardDao.updateAuthority(boardAuthority);
	}

	@Override
	public int updateOption(BoardOption boardOption) throws Exception {
		return boardDao.updateOption(boardOption);
	}
	
	@Override
	public int updatePost(Post post) throws Exception {
		return boardDao.updatePost(post);
	}
	
	@Override
	public int postViewCount(Post post) throws Exception {
		return boardDao.postViewCount(post);
	}
	
	@Override
	public int postFileCount(Post post) throws Exception {
		return boardDao.postFileCount(post);
	}
	
	@Override
	public int updatePostReply(Post post) throws Exception {
		return boardDao.updatePostReply(post);
	}

	@Override
	public int updateThombnail(Post post) throws Exception {
		return boardDao.updateThombnail(post);
	}

	@Override
	public int getTotalCount2(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int getTotalCount3(int boardNo) throws Exception {
		return boardDao.getTotalCount3(boardNo);
	}


}
