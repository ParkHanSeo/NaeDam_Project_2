package com.naedam.admin.form.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.form.model.dao.FormDao;
import com.naedam.admin.form.model.vo.Form;
import com.naedam.admin.form.model.vo.FormPost;
import com.naedam.admin.form.model.vo.Item;
import com.naedam.admin.form.model.vo.ItemChoice;

@Service
public class FormServiceImpl implements FormService {
	@Autowired
	private FormDao formDao;
	
	//폼메일 등록
	@Override
	public int addForm(Form form) throws Exception {
		// TODO Auto-generated method stub
		return formDao.addForm(form);
	}

	//문항 등록
	@Override
	public int addItem(Item item) throws Exception {
		// TODO Auto-generated method stub
		return formDao.addItem(item);
	}
	
	//문항 예시 등록
	@Override
	public int addItemChoice(ItemChoice itemChoice) throws Exception {
		// TODO Auto-generated method stub
		return formDao.addItemChoice(itemChoice);
	}

	//폼 게시글 등록
	@Override
	public int addFormPost(FormPost formPost) throws Exception {
		// TODO Auto-generated method stub
		return formDao.addFormPost(formPost);
	}
	

	//폼 게시글 등록
	@Override
	public int addFormPostCopy(FormPost formPost) throws Exception {
		// TODO Auto-generated method stub
		return formDao.addFormPostCopy(formPost);
	}	
	
	//폼메일 리스트
	@Override
	public List<Form> formList() throws Exception {
		// TODO Auto-generated method stub
		return formDao.formList();
	}
	
	//문항관리 리스트
	@Override
	public List<Item> itemList(int formNo) throws Exception {
		// TODO Auto-generated method stub
		return formDao.itemList(formNo);
	}
	
	//폼게시물 리스트
	@Override
	public List<FormPost> formPostList(int formNo, int offset, int limit) throws Exception {
		// TODO Auto-generated method stub
		return formDao.formPostList(formNo,offset,limit);
	}
	
	//폼게시물 리스트
	@Override
	public List<FormPost> formPostList2(int formNo) throws Exception {
		// TODO Auto-generated method stub
		return formDao.formPostList2(formNo);
	}	
	
	//폼게시물 카운트
	@Override
	public int formPostListCount(int code) throws Exception {
		// TODO Auto-generated method stub
		return formDao.formPostListCount(code);
	}
	
	//폼메일 정보
	@Override
	public Form getForm(int code) throws Exception {
		// TODO Auto-generated method stub
		return formDao.getForm(code);
	}

	//문항 정보
	@Override
	public Item getItem(int itemNo) throws Exception {
		// TODO Auto-generated method stub
		return formDao.getItem(itemNo);
	}
	
	//폼 게시물 정보
	@Override
	public FormPost getFormPost(int code) throws Exception {
		// TODO Auto-generated method stub
		return formDao.getFormPost(code);
	}
	
	//예시 정보
	@Override
	public List<ItemChoice> getItemChoice(int itemNo) throws Exception {
		// TODO Auto-generated method stub
		return formDao.getItemChoice(itemNo);
	}
	
	//문항 td
	@Override
	public List<Item> formTd(int formNo) throws Exception {
		// TODO Auto-generated method stub
		return formDao.formTd(formNo);
	}
	
	//문항 tr
	@Override
	public List<Item> formTr(int formNo) throws Exception {
		// TODO Auto-generated method stub
		return formDao.formTr(formNo);
	}
	
	//폼메일 선택삭제
	@Override
	public void deleteChoiceForm(int formNo) throws Exception {
		// TODO Auto-generated method stub
		formDao.deleteChoiceForm(formNo);
	}
	
	//문항 선택삭제
	@Override
	public void deleteChoiceItem(int itemNo) throws Exception {
		// TODO Auto-generated method stub
		formDao.deleteChoiceItem(itemNo);
	}
	
	//문항 게시글 선택삭제
	@Override
	public void deleteChoiceFormPost(int code) throws Exception {
		// TODO Auto-generated method stub
		formDao.deleteChoiceFormPost(code);
	}
	
	//폼메일 업데이트
	@Override
	public int updateForm(Form form) throws Exception {
		// TODO Auto-generated method stub
		return formDao.updateForm(form);
	}
	
	//문항 수정
	@Override
	public int updateItem(Item item) throws Exception {
		// TODO Auto-generated method stub
		return formDao.updateItem(item);
	}
	
	//폼 디자인 수정
	@Override
	public int updateFormDesign(Form form) throws Exception {
		// TODO Auto-generated method stub
		return formDao.updateFormDesign(form);
	}

	//폼 게시글 수정
	@Override
	public int updateFormPost(FormPost formPost) throws Exception {
		// TODO Auto-generated method stub
		return formDao.updateFormPost(formPost);
	}


}
