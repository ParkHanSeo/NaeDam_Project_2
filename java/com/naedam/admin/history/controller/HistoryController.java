package com.naedam.admin.history.controller;

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

import com.naedam.admin.history.model.service.HistoryService;
import com.naedam.admin.history.model.vo.History;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/history")
@Slf4j
public class HistoryController {
	@Autowired
	private HistoryService historyService;
	
	@PostMapping("/getHistory")
	@ResponseBody
	public History getHistory(int historyNo) {
		History history = historyService.selectOneHistoryByHisNo(historyNo);
		
		return history;
	}
	
	@PostMapping("history_process")
	public String history_process(HttpServletRequest request, History history) {
		String mode = request.getParameter("mode");
		log.debug("mode = {}", mode);
		String msg = null;
		int result = 0;
		
		if(mode.equals("insert")) {
			Date date = strToDate(request.getParameter("year"), request.getParameter("month"), request.getParameter("date"));
			history.setHistoryDate(date);
			result = historyService.insertHistory(history);
		}else if(mode.equals("update")) {
			Date date = strToDate(request.getParameter("year"), request.getParameter("month"), request.getParameter("date"));
			history.setHistoryDate(date);
			result = historyService.updateHistory(history);
		}else if(mode.equals("delete")) {
			List<String> historyNoList = Arrays.asList(request.getParameterValues("list[]"));
			for(String no : historyNoList) {
				result = historyService.deleteHistory(Integer.parseInt(no));
			}
		}
		
		return "/admin/setting/history";
	}
	
	private Date strToDate(String year, String month, String date) {
		StringBuilder str = new StringBuilder();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Date resultDate = new Date();
		str.append(year);
		if(month.length() < 2) {
			str.append("0"+month);
		}else {
			str.append(month);
		}
		if(date.length() < 2) {
			str.append("0" + date);
		}else {
			str.append(date);
		}
		
		try {
			resultDate = formatter.parse(str.toString());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultDate;
	}
}
