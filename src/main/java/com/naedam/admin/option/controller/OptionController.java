package com.naedam.admin.option.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.option.model.service.OptionService;
import com.naedam.admin.option.model.vo.Option;
import com.naedam.admin.option.model.vo.OptionValue;
import com.naedam.admin.option.model.vo.ProductOption;
import com.naedam.admin.product.model.vo.ProductDetail;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/option")
@Slf4j
public class OptionController {
	@Autowired
	private OptionService optionService;
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/insert")
	public int insertOption(@RequestBody String jsonStr) {
		Map<String, Object> map = Mir9Utils.parseJsonStr(jsonStr);
		int result = 0;
		System.out.println(map);
		
		ArrayList<String> valueList = (ArrayList<String>) map.get("option_value");
		ArrayList<String> valueCostList = (ArrayList<String>) map.get("option_value_cost");
		
		
		try {
			result = optionService.insertOption(map);
			
			for(int i = 0; i < valueList.size(); i++) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("optionValue", valueList.get(i));
				param.put("optionValueCost", Integer.parseInt(valueCostList.get(i).replace(",", "")));
				
				result = optionService.insertOptionValue(param);
				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/list")
	public Map<String, Object> orderList(String optionNo){
		Map<String, Object> result = new HashMap<String, Object>();

		ProductOption pOption = optionService.selectOneProductOptionByoptionNo(Integer.parseInt(optionNo));
		result.put("pOption", pOption);
		List<OptionValue> optionValueList = optionService.selectOptionValueListByOptionNo(Integer.parseInt(optionNo));
		
		result.put("optionValueList", optionValueList);
		
		return result;
		
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/update")
	public int updateOption(@RequestBody String jsonStr) {
		Map<String, Object> map = Mir9Utils.parseJsonStr(jsonStr);
		
		ArrayList<String> valueList = (ArrayList<String>) map.get("option_value");
		ArrayList<String> valueCostList = (ArrayList<String>) map.get("option_value_cost");
		ArrayList<String> valueNoList = (ArrayList<String>) map.get("option_value_no");
		int result = 0;
		
		log.debug("optionNo = {}",map.get("optionNo").getClass().getName());
		for(int i = 0; i < valueList.size(); i++) {
			
			OptionValue ov = new OptionValue();
			ov.setOptionValueNo(Integer.parseInt(valueNoList.get(i)));
			
			try {
				ov.setOptionNo((Integer) map.get("optionNo"));
			} catch (Exception e) {
				ov.setOptionNo(Integer.parseInt((String) map.get("optionNo")));
			}
			
			ov.setOptionValue(valueList.get(i));
			ov.setOptionValueCost(Integer.parseInt(valueCostList.get(i).replace(",", "")));
			
			
			result = optionService.updateOptionValue(ov);
			
		}
		
		ProductOption pOption = new ProductOption();
		try {
			pOption.setOptionNo((Integer) map.get("optionNo"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			pOption.setOptionNo(Integer.parseInt((String) map.get("optionNo")));
		}
		
		pOption.setOptionName((String)map.get("option_name"));
		
		result = optionService.updateProductOption(pOption);
		
		return result;
	}
	
	@GetMapping("/option_manager")
	public String option_manager(int optionNo, Model model) {
		ProductOption pOption = optionService.selectOneProductOptionByoptionNo(optionNo);
		List<OptionValue> optionValueList = optionService.selectOptionValueListByOptionNo(optionNo);
			
		model.addAttribute("optionValueList",optionValueList);
		model.addAttribute("pOption",pOption);
		
		return "/admin/product/option_manager";
	}
	
	@GetMapping("/option_manager_bank")
	public String option_manager_bank(Model model) {
		List<Option> optionList = optionService.selectOptionList();
		
		model.addAttribute("optionList",optionList);
		return "/admin/product/option_manager_bank";
	}
	
	@GetMapping("/option_manager_product")
	public String option_manager_product(Model model) {
		List<ProductDetail> productList = optionService.selectProductDetailList();
		
		model.addAttribute("productList",productList);
		return "/admin/product/option_manager_product";
	}

}
