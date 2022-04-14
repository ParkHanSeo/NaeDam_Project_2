package com.naedam.mir9.setting.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naedam.mir9.delivery.model.vo.DeliveryCompany;
import com.naedam.mir9.delivery.model.vo.DeliverySetting;
import com.naedam.mir9.delivery.model.vo.Doseosangan;
import com.naedam.mir9.map.model.service.MapService;
import com.naedam.mir9.map.model.vo.MapApi;
import com.naedam.mir9.map.model.vo.Maps;
import com.naedam.mir9.setting.model.service.SettingService;

@Controller
@RequestMapping("/setting")
public class SettingController {
	@Autowired
	private SettingService settingService;
	@Autowired
	private MapService mapService;
	
	@GetMapping("/point")
	public void point() {
		
	}
	
	@GetMapping("/coupon")
	public void coupon() {
		
	}
	
	@GetMapping("/popup")
	public void popup() {
		
	}
	
	@GetMapping("/map")
	public void map(Model model) {
		List<Maps> mapList = settingService.selectMapList();
		List<MapApi> apiList = mapService.selectAllMapApiList();
		model.addAttribute("mapList",mapList);
		model.addAttribute("apiList",apiList);
		model.addAttribute("apiKey", "D914287C-19AA-31AD-B187-1532CEF93E7F");
	}
	
	@GetMapping("/staff")
	public void staff() {
		
	}
	
	@GetMapping("/history")
	public void history() {}
	
	@GetMapping("/banner")
	public void banner() {}
	
	@GetMapping("/contract")
	public void contract() {}
	
	@GetMapping("/delivery_setting")
	public String deliverySertting(Model model) {
		DeliverySetting deliverySetting = settingService.selectOneDeliverySetting();
		List<Doseosangan> doseosanganList = settingService.selectDoseosanganList();
		
		model.addAttribute("deliverySetting",deliverySetting);
		model.addAttribute("doseosanganList",doseosanganList);
		
		return "setting/deliverySetting";
	}
	
	@GetMapping("/delivery_company")
	public String deliveryCompany(Model model) {
		
		List<DeliveryCompany> deliveryCompanyList = settingService.selectDeliveryCompanyList();
		model.addAttribute("deliveryCompanyList",deliveryCompanyList);
		model.addAttribute("companyListCnt",deliveryCompanyList.size());
		
		
		return "setting/deliveryCompany";
	}
	
	@GetMapping("/info")
	public void info() {}
	
	@GetMapping("/seo")
	public void seo() {}
	
	@GetMapping("/paymentpg")
	public void paymentpg() {}
	
	@GetMapping("/snslogin")
	public void snsLogin() {}
	
	@GetMapping("/locale")
	public void locale() {}
	
	@GetMapping("/version")
	public void version() {}
	
	@GetMapping("/test")
	public void test() {}
}
