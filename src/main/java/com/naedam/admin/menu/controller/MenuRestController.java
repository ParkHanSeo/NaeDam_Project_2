package com.naedam.admin.menu.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.naedam.admin.menu.model.service.MenuService;
import com.naedam.admin.menu.model.vo.Menu;

@RestController
@RequestMapping("/admin/menu/*")
public class MenuRestController {
	
	@Autowired
	private MenuService menuService;
	
	
	@PostMapping(value="json/getMenu")
	public Menu getMenu(@RequestParam("code") int code) throws Exception{
		System.out.println("/json/getMenu 시작");
		
		return menuService.getMenu(code);
		
		
	}
	
	@PostMapping(value="json/getRevisionList")
	public Map getRevisionList(@RequestParam("code") int code) throws Exception{
		System.out.println("/json/getRevisionList 시작");
		
		Menu menu = menuService.getMenu(code);
		menu.setOriginNo(code);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menu", menu);
		
		Map<String, Object> resultMap = menuService.getRevisionList(map);
		
		return resultMap;
	}
	
	@PostMapping(value="json/deleteRevisionList")
	public Map deleteRevisionList() throws Exception{
		System.out.println("/json/deleteRevisionList 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> resultMap = menuService.deleteRevisionList(map);
		
		return resultMap;
	}	
	
	@GetMapping(value="json/deleteMenu/{code}")
	public Boolean deleteMenu(@PathVariable("code") int code) throws Exception{
		System.out.println("json/deleteMenu 시작");
		Boolean result = false;
		if(code != 0) {
			menuService.deleteMenu(code);
			result = true;
		}
		
		return result;
	}
	
	@GetMapping(value="json/updateRevision/{code}")
	public Boolean updateRevision(@PathVariable("code") int code) throws Exception{
		System.out.println("json/updateRevision 시작");
		Boolean result = false;
		if(code != 0) {
			menuService.updateRevision(code);
			result = true;
		}
		
		return result;
	}
	
	@PostMapping("json/updateUpAsc")
	public Boolean updateUpAsc(@RequestParam("menuAsc") int menuAsc,
							@RequestParam("menuUpAsc") int menuUpAsc,
							@RequestParam("menuNo") int menuNo,
							@RequestParam("upMenuNo") int upMenuNo) throws Exception{
		System.out.println("updateUpAsc 시작");
		Boolean result = false;
		if(menuNo != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map2 = new HashMap<String, Object>();
			map.put("menuUpAsc", menuUpAsc);
			map.put("upMenuNo", menuNo);
			map2.put("menuUpAsc", menuAsc);
			map2.put("upMenuNo", upMenuNo);
			menuService.updateUpAsc(map);
			menuService.updateUpAsc(map2);
			result = true;
		}
		return result;
	}
	
	@PostMapping("json/updateDownAsc")
	public Boolean updateDownAsc(@RequestParam("menuAsc") int menuAsc,
							@RequestParam("menuDownAsc") int menuDownAsc,
							@RequestParam("menuNo") int menuNo,
							@RequestParam("downMenuNo") int downMenuNo) throws Exception{
		System.out.println("json/updateDownAsc 시작");
		Boolean result = false;
		if(menuNo != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map2 = new HashMap<String, Object>();
			map.put("menuDownAsc", menuDownAsc);
			map.put("downMenuNo", menuNo);
			map2.put("menuDownAsc", menuAsc);
			map2.put("downMenuNo", downMenuNo);
			menuService.updateDownAsc(map);
			menuService.updateDownAsc(map2);
			result = true;
		}

		return result;
	}
	
}





