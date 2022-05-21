package com.naedam.admin.form.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.naedam.admin.form.model.service.FormService;
import com.naedam.admin.form.model.vo.Form;
import com.naedam.admin.form.model.vo.FormPost;
import com.naedam.admin.form.model.vo.Item;

@RestController
@RequestMapping("/admin/form/*")
public class FormRestController {
	
	@Autowired
	private FormService formService;
	
	@GetMapping(value="json/formList")
	public List<Form> formList() throws Exception{
		return formService.formList();
	}
	
	@PostMapping(value="json/getForm")
	public Form getForm(@RequestParam("code") int code) throws Exception{
		System.out.println("/json/getForm 시작");
		return formService.getForm(code);
	}
	
	@PostMapping(value="json/getFormPost")
	public FormPost getFormPost(@RequestParam("code") int code) throws Exception{
		System.out.println("/json/getFormPost 시작");
		FormPost formPost = formService.getFormPost(code);
		return formPost;
	}
	
	@PostMapping(value="json/getItem")
	public Item getItem(@RequestParam("itemNo") int itemNo) throws Exception{
		System.out.println("/json/getItem 시작");
		return formService.getItem(itemNo);
	}
	
	@PostMapping("json/formCopy")
	public void formCopy(@RequestParam(value="formArr[]") List<String> formArr) throws Exception{
		System.out.println("form/formCopy 시작");
		int formNo = 0;
		for(String i : formArr) {
			formNo = Integer.parseInt(i);
			Form form = formService.getForm(formNo);
			formService.addForm(form);
		}
	}

}
