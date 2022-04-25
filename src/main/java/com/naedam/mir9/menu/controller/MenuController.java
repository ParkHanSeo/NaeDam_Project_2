package com.naedam.mir9.menu.controller;

import java.util.HashMap;
import java.util.List;
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

import com.naedam.mir9.board.model.vo.Board;
import com.naedam.mir9.menu.model.service.MenuService;
import com.naedam.mir9.menu.model.vo.Menu;
import com.naedam.mir9.menu.model.vo.MenuCategory;



@Controller
@RequestMapping("/menu/*")
public class MenuController {

	@Autowired	
	private MenuService menuService;
	
	@PostMapping("addMenu")
	public String addMenu(@ModelAttribute("menu") Menu menu)throws Exception{
		
		System.out.println("menu/addMenu 시작");
		System.out.println("menu 데이터 확인 === ::: "+menu);
		menuService.addMenu(menu);
		
		return "menu/menu";
	}
	
	@PostMapping("updateMenu")
	public String updateMenu(@ModelAttribute("menu") Menu menu)throws Exception{
		
		System.out.println("menu/updateMenu 시작");
		System.out.println("menu를 확인합시다. == ::: "+menu);
		Menu menu2 = new Menu();
		menu2 = menuService.getRevision(menu);
		menu2.setOriginNo(menu.getCode());
		System.out.println("menu2를 확인합시다. == ::: "+menu2);
		menuService.addRevision(menu2);
		System.out.println("addRevision 후 확인 체크");
		menuService.updateMenu(menu);
		
		
		return "menu/menu";
	}	
	
	@RequestMapping(value="menu")
	public String listMenu(Menu menu, Model model) throws Exception{
		System.out.println("menu 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> resultMap = menuService.getMenuList(map);
		Map<String, Object> resultMap2 = menuService.getHeadList(map);
		
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("list2", resultMap2.get("list"));
		
		return "menu/menu";
	}
	
	@RequestMapping(value="menu2")
	public String listMenu2(@ModelAttribute("menu") Menu menu, Model model) throws Exception{
		System.out.println("menu2 시작");
		System.out.println("확인 ::: === "+menu);
		menu.setOrd(menu.getOrd()+1);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menu", menu);
		
		if(menu.getOrd() == 2) {
			Map<String, Object> resultMap = menuService.getMenuList2(map);
			Map<String, Object> resultMap2 = menuService.getHeadList(map);
			model.addAttribute("menu", menu);
			model.addAttribute("list", resultMap.get("list"));
			model.addAttribute("list2", resultMap2.get("list"));
		}else if(menu.getOrd() == 3) {
			menu.setOriginNo(menu.getCode());
			Map<String, Object> resultMap = menuService.getMenuList3(map);
			Map<String, Object> resultMap2 = menuService.getHeadList(map);
			model.addAttribute("menu", menu);
			model.addAttribute("list", resultMap.get("list"));
			model.addAttribute("list2", resultMap2.get("list"));
		}
	
		return "menu/menuList";
	}	
	
	@RequestMapping(value="menuList")
	public String menuList(Menu menu, Model model, HttpServletRequest request) throws Exception{
		System.out.println("menuList 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> resultMap = menuService.getMenuList(map);
		Map<String, Object> resultMap2 = menuService.getHeadList(map);
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("list2", resultMap2.get("list"));
		
		System.out.println("확인 ::: "+resultMap2);
		
		return "menu/menuList";
	}
	
	@PostMapping("updateChoiceMenu")
	public void updateChoiceMenu(@RequestParam(value = "menuArr[]") List<String> menuArr, 
								  Menu menu) throws Exception{
		
		System.out.println("updateChoiceMenu 시작");
		
		int result = 0;
		int code = 0;
		
		for(String i : menuArr) {
			code = Integer.parseInt(i);
			menu.setCode(code);
			menuService.updateChoiceMenu(menu.getCode());
		}
		result = 1;
		
	}
	
	@GetMapping("tree")
	public String tree(Model model, MenuCategory menuCategory) throws Exception{
		System.out.println("menuCategory/tree 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> resultMap = menuService.getMenuCategoryList(map);
		Map<String, Object> resultMap2 = menuService.getMenuCategoryList2(map);
		System.out.println("데이터 확인 ::: === "+resultMap);
		System.out.println("데이터 확인2 ::: === "+resultMap2.get("list"));
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("list2", resultMap2.get("list"));
		
		return "menu/tree";
	}
	
	@RequestMapping(value="head")
	public String header(HttpServletRequest request,Model model) throws Exception{
		
		return "menu/head";
	}
	
	@RequestMapping(value="bottom")
	public String bottom(HttpServletRequest request,Model model) throws Exception{
		
		return "menu/bottom";
	}
	
	@RequestMapping(value="meta")
	public String meta(HttpServletRequest request,Model model) throws Exception{
		
		return "menu/meta";
	}
}

















