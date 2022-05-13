package com.naedam.admin.menu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.naedam.admin.menu.model.service.MenuService;
import com.naedam.admin.menu.model.vo.Head;
import com.naedam.admin.menu.model.vo.Menu;

@Controller
@RequestMapping("/admin/head/*")
public class HeadController {
	
	@Autowired	
	private MenuService menuService;
	
	@PostMapping("addHead")
	public String addHead(@ModelAttribute("head") Head head) throws Exception{
		
		System.out.println("head/addHead 시작");
		menuService.addHead(head);
		
		return "redirect:/admin/head/headList";
	}
	
	@RequestMapping(value="headList")
	public String headList(Head head, Model model) throws Exception{
		System.out.println("head/headList 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> resultMap = menuService.getHeadList(map);
		
		model.addAttribute("list", resultMap.get("list"));
		
		return "admin/menu/head";
	}
	
	@PostMapping("updateHead")
	public String updateHead(@ModelAttribute("head") Head head)throws Exception{
		System.out.println("head/updateHead 시작");
		menuService.updateHead(head);
		
		return "redirect:/admin/head/headList";
	}
	
	@PostMapping("deleteChoiceHead")
	public void deleteChoiceHead(@RequestParam(value = "headArr[]") List<String> headArr, 
								  Head head) throws Exception{
		
		System.out.println("deleteChoiceHead 시작");
		
		int result = 0;
		int headNo = 0;
		
		for(String i : headArr) {
			headNo = Integer.parseInt(i);
			head.setHeadNo(headNo);
			menuService.deleteChoiceHead(head.getHeadNo());
		}
		result = 1;
		
	}
	
}



























