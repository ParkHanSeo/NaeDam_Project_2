package com.naedam.admin.popup.model.service;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.popup.model.dao.PopupDao;
import com.naedam.admin.popup.model.vo.Popup;

@Service
public class PopupServiceImpl implements PopupService {
	@Autowired
	private PopupDao popupDao;

	@Override
	public Map<String, Object> popupProcess(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<>();
		Popup popup = (Popup) map.get("popup");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		if("insert".equals(map.get("mode"))) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			popup.setStartDate((Date) sdf.parse(request.getParameter("start_date")));
			popup.setEndDate((Date) sdf.parse(request.getParameter("end_date")));
			popupDao.insertPopup(popup);
			resultMap.put("msg", "팝업 정보가 등록되었습니다.");
		}else if("update".equals(map.get("mode"))) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			popup.setStartDate((Date) sdf.parse(request.getParameter("start_date")));
			popup.setEndDate((Date) sdf.parse(request.getParameter("end_date")));
			popupDao.updatePopup(popup);
			resultMap.put("msg", "팝업 정보가 수정되었습니다.");
		}else if("delete".equals(map.get("mode"))) {
			List<String> codeList = Arrays.asList(request.getParameterValues("list[]"));
			for(String code : codeList) {
				popupDao.deletePopup(Integer.parseInt(code));
			}
			resultMap.put("msg", "팝업이 삭제되었습니다.");
		}
		return resultMap;
	}
	
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
