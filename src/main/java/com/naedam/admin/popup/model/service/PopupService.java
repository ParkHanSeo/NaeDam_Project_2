package com.naedam.admin.popup.model.service;

import com.naedam.admin.popup.model.vo.Popup;

public interface PopupService {

	int insertPopup(Popup popup);

	Popup selectOnePopupByCode(int code);

	int updatePopup(Popup popup);

	int deletePopup(int code);

}
