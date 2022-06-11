package com.naedam.admin.form.model.service;

import java.util.List;
import java.util.Map;

import com.naedam.admin.form.model.vo.Form;
import com.naedam.admin.form.model.vo.FormPost;
import com.naedam.admin.form.model.vo.Item;
import com.naedam.admin.form.model.vo.ItemChoice;

public interface FormService {
	
	//폼메일 관리 프로세서
	public String formProcess(Map<String, Object> map) throws Exception;
	
	//문항 예시 등록
	public int addItemChoice(ItemChoice itemChoice) throws Exception;
	
	//폼메일 리스트
	Map<String, Object> formList() throws Exception;
	
	//폼메일 리스트 카운트
	int formListCount() throws Exception;
	
	//문항관리 리스트
	Map<String, Object> itemList(int formNo) throws Exception;
	
	//문항관리 리스트 카운트
	int itemListCount(int formNo) throws Exception;
	
	//폼게시물 리스트
	Map<String, Object> formPostList(int formNo, int offset, int limit) throws Exception;
	
	//폼게시물 리스트
	List<FormPost> formPostList2(int formNo) throws Exception;
	
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
	
	//item down순서변경
	public void updateDownAsc(Map<String, Object> map)throws Exception;
	
	//item up순서변경
	public void updateUpAsc(Map<String, Object> map)throws Exception;
	
	//item down순서변경
	public void updateDownAsc2(Map<String, Object> map)throws Exception;
	
	//item up순서변경
	public void updateUpAsc2(Map<String, Object> map)throws Exception;	
}
