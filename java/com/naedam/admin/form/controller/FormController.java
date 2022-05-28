package com.naedam.admin.form.controller;

import java.util.ArrayList;
import java.util.List;

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
	
	@PostMapping("addForm")
	public String addFrom(@ModelAttribute("form") Form form) throws Exception{
		System.out.println("form/addForm 시작");
		formService.addForm(form);
		return "redirect:/admin/form/formList";
	}
	
	@PostMapping("addItem")
	public String addItem(@ModelAttribute("item") Item item, @RequestParam("formNo") int formNo, Form form) throws Exception{
		System.out.println("form/addItem 시작");
		form.setFormNo(formNo);
		item.setForm(form);
		formService.addItem(item);
		if(item.getInput_example() != null) {
			ItemChoice ic = new ItemChoice();
			ic.setItem(item);
			String[] exampleArr = item.getInput_example().split("\r\n"); 
			for(int i = 0; i < exampleArr.length; i++) {
				ic.setName(exampleArr[i]);
				formService.addItemChoice(ic);
			}
		}
		return "redirect:/admin/form/itemList?formNo="+formNo;
	}
	
	@PostMapping("addFormPost")
	public String addFormPost(HttpServletRequest request, 
							  @RequestParam("formNo") int formNo, Item item, Form form)throws Exception{
		System.out.println("form/addFormPost 시작");
		FormPost formPost = new FormPost();
		StringBuffer sb = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		StringBuffer sb3 = new StringBuffer();
		List<Item> trList = formService.formTr(formNo);
		form.setFormNo(formNo);
		for(int i = 0; i < trList.size(); i++) {
			String data = request.getParameter("data"+trList.get(i).getItemNo());
			String data2 = Integer.toString(trList.get(i).getItemNo());
			String data3 = trList.get(i).getInput_type();
			if(i == 0) {
				sb2.append(data2);
				sb3.append(data3);
				if("".equals(data)) {
					sb.append(" ");
				}else {
					sb.append(data);
				}
			}else if(i != 0) {
				sb2.append("&"+data2);
				sb3.append("&"+data3);
				if("".equals(data)) {
					sb.append("& ");
				}else {
					sb.append("&"+data);
				}
			}
			formPost.setItemData(sb.toString());
			formPost.setItemNo(sb2.toString());
			formPost.setItemInput(sb3.toString());
			formPost.setForm(form);
		}
		formService.addFormPost(formPost);
		
		return "redirect:/admin/form/formPostList?formNo="+formNo;
	}
	
	
	@PostMapping("addFormPostCopy")
	public void addFormPostCopy(@RequestParam(value="formPostArr[]") List<String> formPostArr,
								@RequestParam("formNo") int formNo) throws Exception{
		System.out.println("form/addFormPostCopy 시작");
		int result = 0;
		int formPostNo = 0;
		Form form = new Form();
		for(String i : formPostArr) {
			formPostNo = Integer.parseInt(i);
			FormPost formPost = formService.getFormPost(formPostNo);
			form.setFormNo(formNo);
			formPost.setForm(form);
			formService.addFormPostCopy(formPost);
		}
		result = 1;
	}
	
	@PostMapping("updateForm")
	public String updateForm(@ModelAttribute("form") Form form) throws Exception{
		System.out.println("form/updateForm 시작");
		formService.updateForm(form);
		return "redirect:/admin/form/formList";
	}
	
	@PostMapping("updateItem")
	public void updateItem(@ModelAttribute("item") Item item, @RequestParam("formNo") int formNo) throws Exception{
		System.out.println("form/updateItem 시작");
		if(!"select".equals(item.getInput_type()) && !"checkbox".equals(item.getInput_type()) && !"radio".equals(item.getInput_type())) {
			item.setInput_example("");
		}
		formService.updateItem(item);
	}
	
	@PostMapping("updateFormDesign")
	public void updateFormDesign(@ModelAttribute("form") Form form) throws Exception{
		System.out.println("form/updateFormDesign 시작");
		formService.updateFormDesign(form);
	}
	
	@PostMapping("updateFormPost")
	public void updateFormPost(HttpServletRequest request,
							  @ModelAttribute("formPost") FormPost formPost,
							  @RequestParam("formNo") int formNo, Item item, Form form) throws Exception{
		System.out.println("form/updateFormPost 시작");
		StringBuffer sb = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		StringBuffer sb3 = new StringBuffer();
		List<Item> trList = formService.formTr(formNo);
		form.setFormNo(formNo);
		for(int i = 0; i < trList.size(); i++) {
			String data = request.getParameter("data"+trList.get(i).getItemNo());
			String data2 = Integer.toString(trList.get(i).getItemNo());
			String data3 = trList.get(i).getInput_type();
			if(i == 0) {
				sb2.append(data2);
				sb3.append(data3);
				if("".equals(data)) {
					sb.append(" ");
				}else {
					sb.append(data);
				}
			}else if(i != 0) {
				sb2.append("&"+data2);
				sb3.append("&"+data3);
				if("".equals(data)) {
					sb.append("& ");
				}else {
					sb.append("&"+data);
				}
			}
			formPost.setItemData(sb.toString());
			formPost.setItemNo(sb2.toString());
			formPost.setItemInput(sb3.toString());
			formPost.setForm(form);
		}
		formService.updateFormPost(formPost);
	}
	
	@GetMapping("list")
	public String formList(Model model) throws Exception {
		System.out.println("formList 시작");
		List<Form> formList = formService.formList();
		int formCount = formService.formListCount();
		List formPostCount = new ArrayList();
		for(int i = 0; i < formList.size(); i++) {
			int num = formService.formPostListCount(formList.get(i).getFormNo());
			formPostCount.add(num);
		}
		model.addAttribute("list", formList);
		model.addAttribute("formCount", formCount);
		model.addAttribute("formPostCount", formPostCount);
		return "admin/form/formList";
	}
		
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
		List<FormPost> fp = formService.formPostList(formNo,offset, limit);
		List<Integer> number = new ArrayList<>();
		int num = 0;
		for(int i = 0; i < tr.size(); i++) {
			tr.get(i).setInput_example(tr.get(i).getInput_example().replace("\r\n", "&"));
			
			if("y".equals(tr.get(i).getIs_show())) {
				number.add(num, i);
				num = num+1;
			}else if(!"y".equals(tr.get(i).getIs_show())){}
		}
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("fp",fp);
		model.addAttribute("td",td);
		model.addAttribute("tr",tr);
		model.addAttribute("formNo", formNo);
		model.addAttribute("number",number);
		model.addAttribute("formPostListCount", totalFormPostListCount);
		return "admin/form/formPostList";
	}
	
	@GetMapping("itemList")
	public String itemList(@RequestParam("formNo") int formNo, Model model) throws Exception {
		System.out.println("form/itemList 시작");
		List<Item> itemList = formService.itemList(formNo);
		int itemCount = formService.itemListCount(formNo);
		Form form = formService.getForm(formNo);
		for(int i = 0; i < itemList.size(); i++) {
			itemList.get(i).setInput_example(itemList.get(i).getInput_example().replace("\r\n", "/"));
		}
		model.addAttribute("list",itemList);
		model.addAttribute("formNo", formNo);
		model.addAttribute("form", form);
		model.addAttribute("itemCount", itemCount);
		return "admin/form/itemList";
	}
	
	@PostMapping("deleteChoiceForm")
	public void deleteChoiceForm(@RequestParam(value="formArr[]") List<String> formArr, Form form)
								 throws Exception{
		System.out.println("form/deleteChoiceForm 시작");
		int formNo = 0;
		for(String i : formArr) {
			formNo = Integer.parseInt(i);
			form.setFormNo(formNo);
			formService.deleteChoiceForm(formNo);
		}

	}
	
	@PostMapping("deleteChoiceItem")
	public void deleteChoiceItem(@RequestParam(value="itemArr[]") List<String> itemArr, Item item)
								 throws Exception{
		System.out.println("form/deleteChoiceItem 시작");
		int itemNo = 0;
		for(String i : itemArr) {
			itemNo = Integer.parseInt(i);
			item.setItemNo(itemNo);
			formService.deleteChoiceItem(itemNo);
		}

	}
	
	@PostMapping("deleteChoiceFormPost")
	public void deleteChoiceFormPost(@RequestParam(value="formPostArr[]") List<String> formPostArr, FormPost formPost)
								 throws Exception{
		System.out.println("form/deleteChoiceFormPost 시작");
		int formPostNo = 0;
		for(String i : formPostArr) {
			formPostNo = Integer.parseInt(i);
			formPost.setCode(formPostNo);
			formService.deleteChoiceFormPost(formPostNo);
		}

	}	


}
