package com.naedam.admin.popup.model.dao;

import com.naedam.admin.popup.model.vo.Popup;

public interface PopupDao {

	int insertPopup(Popup popup);

	Popup selectOnePopupByCode(int code);

	int updatePopup(Popup popup);

	int deletePopup(int code);

}
