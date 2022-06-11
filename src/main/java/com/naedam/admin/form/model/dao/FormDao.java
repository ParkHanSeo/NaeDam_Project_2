package com.naedam.admin.form.model.dao;

import java.util.List;
import java.util.Map;

import com.naedam.admin.form.model.vo.Form;
import com.naedam.admin.form.model.vo.FormPost;
import com.naedam.admin.form.model.vo.Item;
import com.naedam.admin.form.model.vo.ItemChoice;

public interface FormDao {
	
	//폼메일 등록
	public int addForm(Form form) throws Exception;
	
	//문항 등록
	public int addItem(Item item) throws Exception;
	
	//문항 예시 등록
	public int addItemChoice(ItemChoice itemChoice) throws Exception;
	
	//폼게시글 등록
	public int addFormPost(FormPost formPost) throws Exception;
	
	//폼게시글 등록
	public int addFormPostCopy(FormPost formPost) throws Exception;
	
	//폼메일 리스트
	public List<Form> formList() throws Exception;
	
	//폼메일 리스트 카운트
	public int formListCount() throws Exception;
	
	//폼게시물 리스트
	public List<FormPost> formPostList(int formNo, int offset, int limit) throws Exception;
	
	//폼게시물 리스트2
	public List<FormPost> formPostList2(int formNo) throws Exception;
	
	//문항 td
	public List<Item> formTd(int formNo) throws Exception;
	
	//문항 tr
	public List<Item> formTr(int formNo) throws Exception;
	
	//문항관리 리스트
	public List<Item> itemList(int formNo) throws Exception;

	//문항관리 리스트 카운트
	public int itemListCount(int formNo) throws Exception;
	
	//폼메일 정보
	public Form getForm(int formNo) throws Exception;
	
	//문항 정보
	public Item getItem(int itemNo) throws Exception;
	
	//폼게시물 정보
	public FormPost getFormPost(int code) throws Exception;
	
	//폼게시물 카운트
	public int formPostListCount(int code) throws Exception;
	
	//예시 정보
	public List<ItemChoice> getItemChoice(int itemNo) throws Exception;
	
	//폼메일 선택삭제
	public void deleteChoiceForm(List<Integer> code) throws Exception;
	
	//문항 선택삭제
	public void deleteChoiceItem(List<Integer> itemNo) throws Exception;
	
	//문항 게시글 선택삭제
	public void deleteChoiceFormPost(List<Integer> code) throws Exception;
	
	//폼메일 수정
	public int updateForm(Form form) throws Exception;
	
	//문항 수정
	public int updateItem(Item item) throws Exception;
	
	//폼 디자인 리스트 수정
	public int updateFormDesignList(Form form) throws Exception;
	
	//폼 디자인 쓰기 수정
	public int updateFormDesignWrite(Form form) throws Exception;
	
	//폼 게시글 수정
	public int updateFormPost(FormPost formPost) throws Exception;
	
	//item up순서변경
	public void updateUpAsc(Map<String, Object> map)throws Exception;	
	
	//item down순서변경
	public void updateDownAsc(Map<String, Object> map)throws Exception;
	
	//formPost up순서변경
	public void updateUpAsc2(Map<String, Object> map)throws Exception;	
	
	//formPost down순서변경
	public void updateDownAsc2(Map<String, Object> map)throws Exception;
}
