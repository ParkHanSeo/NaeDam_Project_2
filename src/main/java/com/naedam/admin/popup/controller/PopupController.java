package com.naedam.admin.popup.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public String popup_process(Popup popup, HttpServletRequest request, RedirectAttributes redirectAttr) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("mode", request.getParameter("mode"));
		map.put("popup", popup);
		map.put("request", request);
		Map<String, Object> resultMap = popupService.popupProcess(map);
		redirectAttr.addFlashAttribute("msg", (String)resultMap.get("msg"));
		return "redirect: /admin/setting/popup";
	}

	@PostMapping("/getPopup")
	@ResponseBody
	public Popup getPopup(int code) {
		Popup popup = popupService.selectOnePopupByCode(code);
		return popup;
	}
}
