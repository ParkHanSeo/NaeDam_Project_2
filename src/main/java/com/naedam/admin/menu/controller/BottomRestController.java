package com.naedam.admin.menu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.naedam.admin.menu.model.service.MenuService;
import com.naedam.admin.menu.model.vo.Bottom;
import com.naedam.admin.menu.model.vo.Meta;

@RestController
@RequestMapping("/admin/bottom/*")
public class BottomRestController {
	
	@Autowired
	private MenuService menuService;
	
	@PostMapping(value="json/getBottom")
	public Bottom getBottom() throws Exception{
		System.out.println("/json/getBottom 시작");
		return menuService.getBottom();
	}
	
	@PostMapping(value="json/getMeta")
	public Meta getMeta() throws Exception{
		System.out.println("/json/getMeta 시작");
		return menuService.getMeta();
	}
}
