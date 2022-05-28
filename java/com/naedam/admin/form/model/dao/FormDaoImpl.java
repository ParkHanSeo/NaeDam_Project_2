package com.naedam.admin.form.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.form.model.vo.Form;
import com.naedam.admin.form.model.vo.FormPost;
import com.naedam.admin.form.model.vo.Item;
import com.naedam.admin.form.model.vo.ItemChoice;

@Repository
public class FormDaoImpl implements FormDao {
	@Autowired
	private SqlSession session;

	//폼메일 등록
	@Override
	public int addForm(Form form) throws Exception {
		// TODO Auto-generated method stub
		return session.insert("form.addForm", form);
	}
	
	//문항 등록
	@Override
	public int addItem(Item item) throws Exception {
		// TODO Auto-generated method stub
		return session.insert("form.addItem", item);
	}
	
	//문항 예시 등록
	@Override
	public int addItemChoice(ItemChoice itemChoice) throws Exception {
		// TODO Auto-generated method stub
		return session.insert("form.addItemChoice", itemChoice);
	}
	
	//폼 게시글 등록
	@Override
	public int addFormPost(FormPost formPost) throws Exception {
		// TODO Auto-generated method stub
		return session.insert("form.addFormPost", formPost);
	}
	
	//폼 게시글 등록
	@Override
	public int addFormPostCopy(FormPost formPost) throws Exception {
		// TODO Auto-generated method stub
		return session.insert("form.addFormPostCopy", formPost);
	}	

	//폼메일 리스트
	@Override
	public List<Form> formList() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList("form.formList");
	}

	//폼메일 리스트 카운트
	@Override
	public int formListCount() throws Exception {
		return session.selectOne("form.formListCount");
	}
	
	//문항관리 리스트
	@Override
	public List<Item> itemList(int formNo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList("form.itemList", formNo);
	}

	//문항관리 리스트 카운트
	@Override
	public int itemListCount(int formNo) throws Exception {
		return session.selectOne("form.itemListCount", formNo);
	}	
	
	//폼게시물 리스트
	@Override
	public List<FormPost> formPostList(int formNo, int offset, int limit) throws Exception {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("form.formPostList", formNo, rowBounds);
	}
	
	//폼게시물 리스트2
	@Override
	public List<FormPost> formPostList2(int formNo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList("form.formPostList", formNo);
	}	
	
	//폼게시물 카운트
	@Override
	public int formPostListCount(int code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne("form.formPostListCount", code);
	}

	//폼메일 정보
	@Override
	public Form getForm(int code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne("form.getForm", code);
	}
	
	//문항 정보
	@Override
	public Item getItem(int itemNo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne("form.getItem", itemNo);
	}
	
	//폼 게시물 정보
	@Override
	public FormPost getFormPost(int code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne("form.getFormPost", code);
	}

	//예시 정보
	@Override
	public List<ItemChoice> getItemChoice(int itemNo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList("form.getItemChoice", itemNo);
	}
	
	//문항 td
	@Override
	public List<Item> formTd(int formNo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList("form.formTd", formNo);
	}
	
	//문항 tr
	@Override
	public List<Item> formTr(int formNo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList("form.formTr", formNo);
	}
	
	//폼메일 선택삭제
	@Override
	public void deleteChoiceForm(int formNo) throws Exception {
		// TODO Auto-generated method stub
		session.delete("form.deleteChoiceForm", formNo);
	}
	
	//문항 선택삭제
	@Override
	public void deleteChoiceItem(int itemNo) throws Exception {
		// TODO Auto-generated method stub
		session.delete("form.deleteChoiceItem", itemNo);
	}
	
	//문항 게시글 선택삭제
	@Override
	public void deleteChoiceFormPost(int code) throws Exception {
		// TODO Auto-generated method stub
		session.delete("form.deleteChoiceFormPost", code);
	}	
	
	//폼메일 수정
	@Override
	public int updateForm(Form form) throws Exception {
		// TODO Auto-generated method stub
		return session.update("form.updateForm", form);
	}
	
	//문항 수정
	@Override
	public int updateItem(Item item) throws Exception {
		// TODO Auto-generated method stub
		return session.update("form.updateItem", item);
	}
	
	//폼 디자인 수정
	@Override
	public int updateFormDesign(Form form) throws Exception {
		// TODO Auto-generated method stub
		return session.update("form.updateFormDesign", form);
	}
	
	//폼 게시글 수정
	@Override
	public int updateFormPost(FormPost formPost) throws Exception {
		// TODO Auto-generated method stub
		return session.update("form.updateFormPost", formPost);
	}
	
	//item down순서변경
	public void updateDownAsc(Map<String, Object> map) throws Exception {
		session.update("form.updateDownAsc", map);
	}

	//item up순서변경
	public void updateUpAsc(Map<String, Object> map) throws Exception {
		session.update("form.updateUpAsc", map);
	}
	
	//formPost down순서변경
	public void updateDownAsc2(Map<String, Object> map) throws Exception {
		session.update("form.updateDownAsc2", map);
	}

	//formPost up순서변경
	public void updateUpAsc2(Map<String, Object> map) throws Exception {
		session.update("form.updateUpAsc2", map);
	}


}
