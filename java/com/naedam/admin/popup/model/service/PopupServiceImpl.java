package com.naedam.admin.popup.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.popup.model.dao.PopupDao;
import com.naedam.admin.popup.model.vo.Popup;

@Service
public class PopupServiceImpl implements PopupService {
	@Autowired
	private PopupDao popupDao;

	@Override
	public int insertPopup(Popup popup) {
		// TODO Auto-generated method stub
		return popupDao.insertPopup(popup);
	}

	@Override
	public Popup selectOnePopupByCode(int code) {
		// TODO Auto-generated method stub
		return popupDao.selectOnePopupByCode(code);
	}

	@Override
	public int updatePopup(Popup popup) {
		// TODO Auto-generated method stub
		return popupDao.updatePopup(popup);
	}

	@Override
	public int deletePopup(int code) {
		// TODO Auto-generated method stub
		return popupDao.deletePopup(code);
	}
	
	
}
