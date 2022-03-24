package com.naedam.mir9.delivery.controller;

import java.util.ArrayList;
import java.util.Arrays;
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

import com.naedam.mir9.common.Mir9Utils;
import com.naedam.mir9.delivery.model.service.DeliveryService;
import com.naedam.mir9.delivery.model.vo.DeliveryCompany;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/delivery")
@Slf4j
public class DeliveryController {
	@Autowired
	private DeliveryService deliveryService;
	
	@GetMapping("/doseosangan")
	@ResponseBody
	public int doseosangan(int zipcode) {
		int result = deliveryService.selectDoseosanganFeeByZipcode(zipcode);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/insertCompany")
	public int insertCompany(String jsonStr){
		Map<String,Object> param = Mir9Utils.parseJsonStr(jsonStr);
		
		int result = deliveryService.insertDeliveryCompanyByParam(param);
		
		
		return result;
	}
	
	@PostMapping("/deleteCompany")
	public String deleteCompany(HttpServletRequest request, RedirectAttributes redirectAttr) {
		ArrayList<String> ComNoList = new ArrayList<String>(Arrays.asList(request.getParameterValues("checkedNo")));
		
		for(String comNo : ComNoList) {
			int result = deliveryService.deleteDeliveryCompanyByComNo(comNo);
		}
		
		
		redirectAttr.addFlashAttribute("msg", "삭제되었습니다.");
		
		return "redirect:/setting/delivery_company";
	}
	
	@PostMapping("/companyDetail")
	@ResponseBody
	public DeliveryCompany companyDetail(String comNo) {
		log.debug("comNo = {}",comNo);
		DeliveryCompany deliCom = deliveryService.selectOneDeliveryCompanyByComNo(comNo);
		return deliCom;
	}
	
	@ResponseBody
	@GetMapping("/updateCompany")
	public int updateCompany(String jsonStr){
		Map<String,Object> param = Mir9Utils.parseJsonStr(jsonStr);
		
		
		int result = deliveryService.updateDeliveryCompanyByParam(param);
		
		
		return result;
	}
	
	@ResponseBody
	@GetMapping("/companySearch")
	public List<DeliveryCompany> companySearch(String jsonStr) {
		Map<String, Object> param = Mir9Utils.parseJsonStr(jsonStr);
		
		List<DeliveryCompany> companyList = deliveryService.selectDeliveryCompanyListByParam(param);
		
		return companyList;
	}
	
	
}
