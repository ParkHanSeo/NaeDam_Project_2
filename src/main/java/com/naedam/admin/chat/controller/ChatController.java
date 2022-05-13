package com.naedam.admin.chat.controller;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naedam.admin.member.model.vo.Member;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/chat/*")
public class ChatController {

	@GetMapping("chat")
	public String chat(Model model) throws Exception {
		
		//CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		
		log.info("==================================");
		log.info("@ChatController, GET Chat / Username : " + member.getLastName()+member.getFirstName());
		
		model.addAttribute("userid", member.getLastName()+member.getFirstName());
		
		return "admin/chat/chat";
	}
	
	
}
