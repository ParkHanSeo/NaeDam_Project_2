package com.naedam.admin.popup.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.popup.model.vo.Popup;

@Repository
public class PopupDaoImpl implements PopupDao {
	@Autowired
	private SqlSession session;

	@Override
	public int insertPopup(Popup popup) {
		// TODO Auto-generated method stub
		return session.insert("popup.insertPopup", popup);
	}

	@Override
	public Popup selectOnePopupByCode(int code) {
		// TODO Auto-generated method stub
		return session.selectOne("popup.selectOnePopupByCode", code);
	}

	@Override
	public int updatePopup(Popup popup) {
		// TODO Auto-generated method stub
		return session.update("popup.updatePopup", popup);
	}

	@Override
	public int deletePopup(int code) {
		// TODO Auto-generated method stub
		return session.delete("popup.deletePopup", code);
	}
	
	
}
