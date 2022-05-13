package com.naedam.admin.point.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naedam.admin.point.model.service.PointService;
import com.naedam.admin.point.model.vo.Point;
import com.naedam.admin.point.model.vo.PointSave;
import com.naedam.admin.point.model.vo.PointUse;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/point")
@Slf4j
public class PointController {
	@Autowired
	private PointService pointService;
	
	@PostMapping("/updatePoints")
	public String updatePoints(Point point, PointSave pointSave, PointUse pointUse, RedirectAttributes redirectAttr) {
		int result = 0;
		
		result = pointService.updatePoint(point);
		result = pointService.updatePointSave(pointSave);
		result = pointService.updatePointUse(pointUse);
		if(result > 0) redirectAttr.addFlashAttribute("msg", "적립금 정보가 변경되었습니다.");
		return "redirect:/admin/setting/point";
	}
}
