package com.naedam.admin.category.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naedam.admin.category.model.service.CategoryService;
import com.naedam.admin.category.model.vo.Category;
import com.naedam.admin.common.Mir9Utils;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/category")
@Slf4j
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	
	@PostMapping("/info")
	@ResponseBody
	public Category categoryInfo(String cteNo){
		Category cte = categoryService.selectOneProductCategoryByCteNo(cteNo);
		return cte;
	}
	
	@GetMapping("/update")
	@ResponseBody
	public int updateCategory(String jsonStr) {
		int result = 0;
		Map<String, Object> param = Mir9Utils.parseJsonStr(jsonStr);
		
		result = categoryService.updateProductCategoryByParam(param);
		
		return result;
	}
	
	@GetMapping("/insert")
	@ResponseBody
	public int insertCategory(String jsonStr) {
		int result = 0;
		Map<String, Object> param = Mir9Utils.parseJsonStr(jsonStr);
		
		result = categoryService.insertProductCategoryByParam(param);
		
		return result;
	}
	
	@PostMapping("/delete")
	public String deleteCategory(HttpServletRequest request, RedirectAttributes redirectAttr) {
		List<String> cteNoList = Arrays.asList(request.getParameterValues("list[]"));
		int result = 0;
		for(String cteNo : cteNoList) {
			result = categoryService.deleteCategoryByCteNo(cteNo);
		}
		
		if(result > 0) redirectAttr.addFlashAttribute("msg", "삭제되었습니다.!!!");
		
		return "redirect:/admin/product/productCategory_sub?stp=pc";
	}
	
	@PostMapping("/getCategory")
	@ResponseBody
	public Map<String, Object> getCategory(String cteNo){
		Map<String, Object> map = new HashMap<String, Object>();
		List<Category> cteList = categoryService.selectRelatedCtegoryByCteNo(cteNo);
		List<Category> lv1NameList = new ArrayList<Category>();
		List<Category> lv2NameList = new ArrayList<Category>();
		List<Category> lv3NameList = new ArrayList<Category>();
		int depth = 0;
		for(Category c : cteList) {
			if(c.getLevel() > depth) {
				depth = c.getLevel();
			}
			switch(c.getLevel()) {
				case 1 : 
					lv1NameList = categoryService.selectCategoryNamesByCteLv(c.getLevel());
					break;
				case 2 : 
					lv2NameList = categoryService.selectCategoryNamesByCteLv(c.getLevel());
					break;
				case 3 : 
					lv3NameList = categoryService.selectCategoryNamesByCteLv(c.getLevel());
					break;
			}
		}
		map.put("lv1NameList", lv1NameList);
		map.put("lv2NameList", lv2NameList);
		map.put("lv3NameList", lv3NameList);
		map.put("depth", depth);
		if(depth == 3) {
			map.put("cteList", cteList);			
		}
		
		return map;
		
	}
}