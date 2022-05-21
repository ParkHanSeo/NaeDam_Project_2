package com.naedam.admin.form.model.service;

import java.util.List;

import com.naedam.admin.form.model.vo.Form;
import com.naedam.admin.form.model.vo.FormPost;
import com.naedam.admin.form.model.vo.Item;
import com.naedam.admin.form.model.vo.ItemChoice;

public interface FormService {
	
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
	List<Form> formList() throws Exception;
	
	//문항관리 리스트
	List<Item> itemList(int formNo) throws Exception;
	
	//폼게시물 리스트
	List<FormPost> formPostList(int formNo, int offset, int limit) throws Exception;
	
	//폼게시물 카운트
	int formPostListCount(int code) throws Exception;
	
	//폼메일 정보
	Form getForm(int code) throws Exception;
	
	//문항 정보
	Item getItem(int itemNo) throws Exception;
	
	//폼게시물 정보
	FormPost getFormPost(int code) throws Exception;
	
	//예시 정보
	List<ItemChoice> getItemChoice(int itemNo) throws Exception;
	
	//문항 td
	List<Item> formTd(int formNo) throws Exception;	
	
	//문항 tr
	List<Item> formTr(int formNo) throws Exception;
	
	//폼메일 선택삭제
	public void deleteChoiceForm(int formNo) throws Exception;
	
	//문항 선택삭제
	public void deleteChoiceItem(int itemNo) throws Exception;
	
	//문항 게시글 선택삭제
	public void deleteChoiceFormPost(int code) throws Exception;
	
	//폼메일 수정
	public int updateForm(Form form) throws Exception;
	
	//문항 수정
	public int updateItem(Item item) throws Exception;
	
	//폼 디자인 수정
	public int updateFormDesign(Form form) throws Exception;
	
	//폼 게시글 수정
	public int updateFormPost(FormPost formPost) throws Exception;
}
