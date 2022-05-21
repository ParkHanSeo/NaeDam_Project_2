package com.naedam.admin.popup.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naedam.admin.popup.model.service.PopupService;
import com.naedam.admin.popup.model.vo.Popup;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/popup")
@Slf4j
public class PopupController {
	@Autowired
	private PopupService popupService;
	
	@PostMapping("/popup_process")
	public String popup_process(Popup popup, HttpServletRequest request, RedirectAttributes redirectAttr) {
		String mode = request.getParameter("mode");
		int result = 0;
		String msg = null;
		if(mode.equals("insert")) {
			popup.setStartDate(stringToDate(request.getParameter("start_date")));
			popup.setEndDate(stringToDate(request.getParameter("end_date")));
			result = popupService.insertPopup(popup);
			if(result <= 0) msg = "팝업 등록 오류. 관리자에게 문의하세요.";
		}else if(mode.equals("update")) {
			popup.setStartDate(stringToDate(request.getParameter("start_date")));
			popup.setEndDate(stringToDate(request.getParameter("end_date")));
			result = popupService.updatePopup(popup);
			if(result > 0) msg = "팝업 정보가 수정되었습니다.";
		}else if(mode.equals("delete")) {
			List<String> codeList = Arrays.asList(request.getParameterValues("list[]"));
			for(String code : codeList) {
				result = popupService.deletePopup(Integer.parseInt(code));
			}
			if(result > 0) msg = "팝업이 삭제되었습니다.";
		}


		redirectAttr.addFlashAttribute("msg",msg);
		
		return "redirect: /admin/setting/popup";
	}
	
	private Date stringToDate(String dateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		try {
			date = sdf.parse(dateStr);
		} catch (ParseException e) {}
		return date;
	}
	
	@PostMapping("/getPopup")
	@ResponseBody
	public Popup getPopup(int code) {
		Popup popup = popupService.selectOnePopupByCode(code);
		
		return popup;
	}
}
