package com.naedam.admin.management.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naedam.admin.management.model.service.ManagementService;

@Controller
@RequestMapping("/admin/management")
public class ManagementController {
	@Autowired
	private ManagementService managementService;
	
	@GetMapping("/management")
	public String managemanagement() {
		
		return "admin/management/managementList";
	}
	
	@GetMapping("/header")
	public String manageHeader() {
		
		return "admin/management/header";
	}
	
	@GetMapping("footer")
	public String manageFooter() {
		
		return "admin/management/footer";
	}
	
	@GetMapping("meta")
	public String manageMeta() {
		
		return "admin/management/meta";
	}
}
