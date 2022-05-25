package com.naedam.admin.menu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naedam.admin.menu.model.service.MenuService;
import com.naedam.admin.menu.model.vo.Bottom;
import com.naedam.admin.menu.model.vo.Meta;

@Controller
@RequestMapping("/admin/bottom/*")
public class BottomController {
	
	
	@Autowired	
	private MenuService menuService;
	
	@RequestMapping(value="bottomList")
	public String bottomList(Model model, Bottom bottom) throws Exception{
		System.out.println("bottom/bottomList 시작");
		bottom = menuService.getBottom();
		model.addAttribute("bottom", bottom);

		return "admin/menu/bottom";
	}
	
	@PostMapping("updateBottom")
	public String updateBottom(@ModelAttribute("bottom") Bottom bottom) throws Exception{
		System.out.println("bottom/updateBottom 시작");
		menuService.updateBottom(bottom);
		return "redirect:/admin/bottom/bottomList";
	}
	
	@PostMapping("updateMeta")
	public String updateMeta(@ModelAttribute("meta") Meta meta) throws Exception{
		System.out.println("bottom/updateMeta 시작");
		menuService.updateMeta(meta);
		return "admin/menu/meta";
	}
	
}






