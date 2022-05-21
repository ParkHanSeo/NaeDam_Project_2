package com.naedam.admin.menu.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naedam.admin.menu.model.service.MenuService;
import com.naedam.admin.menu.model.vo.MenuCategory;

@Controller
@RequestMapping("/admin/menuCategory/*")
public class MenuCategoryController {

	@Autowired	
	private MenuService menuService;
	
	@RequestMapping(value="getMenuCategoryList")
	public String getMenuCategoryList(Model model, MenuCategory menuCategory) throws Exception{
		System.out.println("menuCategory/getMenuCategoryList 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> resultMap = menuService.getMenuCategoryList(map);
		Map<String, Object> resultMap2 = menuService.getMenuCategoryList2(map);
		
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("list2", resultMap2.get("list"));
		
		return "admin/menu/tree";
	}
	
}
