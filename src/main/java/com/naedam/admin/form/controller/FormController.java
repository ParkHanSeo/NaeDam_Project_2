package com.naedam.admin.form.controller;

import java.util.ArrayList;
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

import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.form.model.service.FormService;
import com.naedam.admin.form.model.vo.Form;
import com.naedam.admin.form.model.vo.FormPost;
import com.naedam.admin.form.model.vo.Item;
import com.naedam.admin.form.model.vo.ItemChoice;

@Controller
@RequestMapping("/admin/form/*")
public class FormController {
	@Autowired
	private FormService formService;
	
	//폼메일 관리 프로세스
	@PostMapping("formProcess")
	public String formProcess(@ModelAttribute("form") Form form, @ModelAttribute("item") Item item, @ModelAttribute("formPost") FormPost formPost,
							  @RequestParam("mode") String mode, @RequestParam("part") String part) throws Exception{
		Map<String, Object> formMap = new HashMap<>();
		formMap.put("form", form);
		formMap.put("item", item);
		formMap.put("mode", mode);
		formMap.put("part", part);
		return formService.formProcess(formMap);
	}	
	
	//폼메일 리스트
	@GetMapping("list")
	public String formList(Model model) throws Exception {
		System.out.println("formList 시작");
		Map<String, Object> resultMap = formService.formList();
		model.addAttribute("list", resultMap.get("formList"));
		model.addAttribute("formCount", resultMap.get("formCount"));
		model.addAttribute("formPostCount", resultMap.get("formPostCount"));
		return "admin/form/formList";
	}
	
	//폼메일 게시글 리스트
	@GetMapping("formPostList")
	public String formPostList(@RequestParam("formNo") int formNo, Model model, HttpServletRequest request,
							   @RequestParam(defaultValue = "1") int cPage) throws Exception {
		System.out.println("formPostList 시작");
		int limit = 5;
		int offset = (cPage - 1) * limit;
		int totalFormPostListCount = formService.formPostListCount(formNo);
		String url = request.getRequestURI();
		String pagebar = Mir9Utils.getPagebar(cPage, limit, totalFormPostListCount, url);
		List<Item> td = formService.formTd(formNo);
		List<Item> tr = formService.formTr(formNo);
		Map<String, Object> resultMap = formService.formPostList(formNo,offset, limit);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("fp",resultMap.get("fp"));
		model.addAttribute("td",resultMap.get("td"));
		model.addAttribute("tr",resultMap.get("tr"));
		model.addAttribute("formNo", formNo);
		model.addAttribute("number",resultMap.get("number"));
		model.addAttribute("formPostListCount", totalFormPostListCount);
		return "admin/form/formPostList";
	}
	
	//문항관리 리스트
	@GetMapping("itemList")
	public String itemList(@RequestParam("formNo") int formNo, Model model) throws Exception {
		Map<String, Object> resultMap = formService.itemList(formNo);
		model.addAttribute("list",resultMap.get("itemList"));
		model.addAttribute("formNo", formNo);
		model.addAttribute("form", resultMap.get("form"));
		model.addAttribute("itemCount", resultMap.get("itemCount"));
		return "admin/form/itemList";
	}


}
