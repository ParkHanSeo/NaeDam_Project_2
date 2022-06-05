package com.naedam.admin.point.controller;

import java.util.HashMap;
import java.util.Map;

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
	public String updatePoints(Point point, PointSave pointSave, PointUse pointUse, RedirectAttributes redirectAttr) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("point", point);
		map.put("pointSave", pointSave);
		map.put("pointUse", pointUse);
		Map<String, Object> resultMap = pointService.updatePoint(map);
		redirectAttr.addFlashAttribute("msg", resultMap.get("msg"));
		return "redirect:/admin/setting/point";
	}
}
