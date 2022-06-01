package com.naedam.admin.menu.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.naedam.admin.menu.model.service.MenuService;
import com.naedam.admin.menu.model.vo.Head;

@RestController
@RequestMapping("/admin/head/*")
public class HeadRestController {
	
	@Autowired
	private MenuService menuService;
	
	@PostMapping(value="json/getHead")
	public Head getHead(@RequestParam("headNo") int headNo) throws Exception{
		System.out.println("/json/getHead 시작");
		return menuService.getHead(headNo);
	}
	
	@PostMapping("json/updateHeadUpAsc")
	public Boolean updateHeadUpAsc(@RequestParam("headAsc") int headAsc,
							@RequestParam("headUpAsc") int headUpAsc,
							@RequestParam("headNo") int headNo,
							@RequestParam("upHeadNo") int upHeadNo) throws Exception{
		System.out.println("updateHeadUpAsc 시작");
		Boolean result = false;
		if(headNo != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map2 = new HashMap<String, Object>();
			map.put("headUpAsc", headUpAsc);
			map.put("upHeadNo", headNo);
			map2.put("headUpAsc", headAsc);
			map2.put("upHeadNo", upHeadNo);
			menuService.updateHeadUpAsc(map);
			menuService.updateHeadUpAsc(map2);
			result = true;
		}
		return result;
	}
	
	@PostMapping("json/updateHeadDownAsc")
	public Boolean updateHeadDownAsc(@RequestParam("headAsc") int headAsc,
							@RequestParam("headDownAsc") int headDownAsc,
							@RequestParam("headNo") int headNo,
							@RequestParam("downHeadNo") int downHeadNo) throws Exception{
		System.out.println("json/updateDownAsc 시작");
		Boolean result = false;
		if(headNo != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map2 = new HashMap<String, Object>();
			map.put("headDownAsc", headDownAsc);
			map.put("downHeadNo", headNo);
			map2.put("headDownAsc", headAsc);
			map2.put("downHeadNo", downHeadNo);
			menuService.updateHeadDownAsc(map);
			menuService.updateHeadDownAsc(map2);
			result = true;
		}

		return result;
	}	
	
}
