package com.naedam.admin.form.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@PostMapping("json/updateUpAsc")
	public Boolean updateUpAsc(@RequestParam("itemAsc") int itemAsc,
							@RequestParam("itemUpAsc") int itemUpAsc,
							@RequestParam("itemNo") int itemNo,
							@RequestParam("upItemNo") int upItemNo) throws Exception{
		System.out.println("updateUpAsc 시작");
		Boolean result = false;
		if(itemNo != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map2 = new HashMap<String, Object>();
			map.put("itemUpAsc", itemUpAsc);
			map.put("upItemNo", itemNo);
			map2.put("itemUpAsc", itemAsc);
			map2.put("upItemNo", upItemNo);
			formService.updateUpAsc(map);
			formService.updateUpAsc(map2);
			result = true;
		}
		return result;
	}
	
	@PostMapping("json/updateDownAsc")
	public Boolean updateDownAsc(@RequestParam("itemAsc") int itemAsc,
							@RequestParam("itemDownAsc") int itemDownAsc,
							@RequestParam("itemNo") int itemNo,
							@RequestParam("downItemNo") int downItemNo) throws Exception{
		System.out.println("json/updateDownAsc 시작");
		Boolean result = false;
		if(itemNo != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map2 = new HashMap<String, Object>();
			map.put("itemDownAsc", itemDownAsc);
			map.put("downItemNo", itemNo);
			map2.put("itemDownAsc", itemAsc);
			map2.put("downItemNo", downItemNo);
			formService.updateDownAsc(map);
			formService.updateDownAsc(map2);
			result = true;
		}

		return result;
	}	

	@PostMapping("json/updateUpAsc2")
	public Boolean updateUpAsc2(@RequestParam("formPostAsc") int formPostAsc,
							@RequestParam("formPostUpAsc") int formPostUpAsc,
							@RequestParam("formPostNo") int formPostNo,
							@RequestParam("upFormPostNo") int upFormPostNo) throws Exception{
		System.out.println("updateUpAsc2 시작");
		Boolean result = false;
		if(formPostNo != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map2 = new HashMap<String, Object>();
			map.put("formPostUpAsc", formPostUpAsc);
			map.put("upFormPostNo", formPostNo);
			map2.put("formPostUpAsc", formPostAsc);
			map2.put("upFormPostNo", upFormPostNo);
			formService.updateUpAsc2(map);
			formService.updateUpAsc2(map2);
			result = true;
		}
		return result;
	}
	
	@PostMapping("json/updateDownAsc2")
	public Boolean updateDownAsc2(@RequestParam("formPostAsc") int formPostAsc,
							@RequestParam("formPostDownAsc") int formPostDownAsc,
							@RequestParam("formPostNo") int formPostNo,
							@RequestParam("downFormPostNo") int downFormPostNo) throws Exception{
		System.out.println("json/updateDownAsc2 시작");
		Boolean result = false;
		if(formPostNo != 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> map2 = new HashMap<String, Object>();
			map.put("formPostDownAsc", formPostDownAsc);
			map.put("downFormPostNo", formPostNo);
			map2.put("formPostDownAsc", formPostAsc);
			map2.put("downFormPostNo", downFormPostNo);
			formService.updateDownAsc2(map);
			formService.updateDownAsc2(map2);
			result = true;
		}

		return result;
	}
	
}






