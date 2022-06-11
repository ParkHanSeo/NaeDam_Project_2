package com.naedam.admin.menu.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.naedam.admin.menu.model.service.MenuService;
import com.naedam.admin.menu.model.vo.Bottom;
import com.naedam.admin.menu.model.vo.Head;
import com.naedam.admin.menu.model.vo.Menu;
import com.naedam.admin.menu.model.vo.MenuCategory;
import com.naedam.admin.menu.model.vo.Meta;



@Controller
@RequestMapping("/admin/menu/*")
public class MenuController {

	@Autowired	
	private MenuService menuService;
	
	@PostMapping("menuProcess")
	public String menuProcess(@ModelAttribute("menu") Menu menu, @ModelAttribute("head") Head head, @ModelAttribute("bottom") Bottom bottom,
							  @ModelAttribute("meta") Meta meta, @RequestParam("mode") String mode, @RequestParam("part") String part) throws Exception{
		Map<String, Object> menuMap = new HashMap<>();
		menuMap.put("menu", menu);
		menuMap.put("head", head);
		menuMap.put("bottom", bottom);
		menuMap.put("meta", meta);
		menuMap.put("mode", mode);
		menuMap.put("part", part);
		return menuService.menuProcess(menuMap);
	}
	
	@RequestMapping(value="menu")
	public String listMenu(Menu menu, Model model) throws Exception{
		System.out.println("menu 시작");
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> resultMap = menuService.getMenuList(map);
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("list2", resultMap.get("list2"));
		return "admin/menu/menu";
	}
	
	@RequestMapping(value="menu2")
	public String listMenu2(@ModelAttribute("menu") Menu menu, Model model) throws Exception{
		System.out.println("menu2 시작");
		menu.setOrd(menu.getOrd()+1);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menu", menu);
		Map<String, Object> resultMap = menuService.getMenuList2(map);
		model.addAttribute("menu", menu);
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("list2", resultMap.get("list2"));			
		return "admin/menu/menuList";
	}	
	
	@RequestMapping(value="menuList")
	public String menuList(Menu menu, Model model, HttpServletRequest request) throws Exception{
		System.out.println("menuList 시작");
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> resultMap = menuService.getMenuList(map);
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("list2", resultMap.get("list2"));
		return "admin/menu/menuList";
	}
	
	@GetMapping("tree")
	public String tree(Model model, MenuCategory menuCategory) throws Exception{
		System.out.println("menuCategory/tree 시작");
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> resultMap = menuService.getMenuCategoryList(map);
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("list2", resultMap.get("list2"));
		return "admin/menu/tree";
	}
	
	@RequestMapping(value="headList")
	public String headList(Head head, Model model) throws Exception{
		System.out.println("head/headList 시작");
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> resultMap = menuService.getHeadList(map);
		model.addAttribute("list", resultMap.get("list"));
		return "admin/menu/head";
	}	
	
	@RequestMapping(value="bottomList")
	public String bottomList(Model model, Bottom bottom) throws Exception{
		System.out.println("bottom/bottomList 시작");
		bottom = menuService.getBottom();
		model.addAttribute("bottom", bottom);
		return "admin/menu/bottom";
	}
	
	@RequestMapping(value="meta")
	public String meta(HttpServletRequest request,Model model) throws Exception{		
		return "admin/menu/meta";
	}	

}

