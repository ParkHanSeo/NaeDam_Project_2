package com.naedam.admin.map.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naedam.admin.map.model.service.MapService;
import com.naedam.admin.map.model.vo.Maps;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/map")
@Slf4j
public class MapController {

	@Autowired
	private MapService mapService;

	@PostMapping("/getMap")
	@ResponseBody
	public Maps getMap(int mapNo) {
		Maps map = mapService.selectOneMapByMapNo(mapNo);

		return map;
	}

	@PostMapping("/map_process")
	public String map_process(HttpServletRequest request, Maps map, RedirectAttributes redirectAttr) {
		log.debug("map = {}", map);
		int result = 0;
		String msg = "";
		if(request.getParameter("mode").equals("update")) {
			result = mapService.updateMapByMap(map);
			msg = "약도 정보가 수정되었습니다.";
		}else if(request.getParameter("mode").equals("insert")) {
			result = mapService.insertMap(map);
			msg = "약도가 생성되었습니다.";
		}else if(request.getParameter("mode").equals("delete")) {
			List<String> mapNoList = Arrays.asList(request.getParameterValues("list[]"));
			log.debug("mapNoList = {}", mapNoList);
			for(String mapNo : mapNoList) {
				result = mapService.deleteMap(Integer.parseInt(mapNo));
			}
			msg = "약도가 삭제되었습니다.";
		}
		
		redirectAttr.addFlashAttribute("msg", msg);
		return "redirect:/admin/setting/map";
	}
	

}
