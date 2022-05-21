package com.naedam.admin.setting.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.naedam.admin.banner.model.vo.Banner;
import com.naedam.admin.category.model.vo.Category;
import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.coupon.model.vo.Coupon;
import com.naedam.admin.delivery.model.vo.DeliveryCompany;
import com.naedam.admin.delivery.model.vo.DeliveryNotice;
import com.naedam.admin.delivery.model.vo.DeliverySetting;
import com.naedam.admin.delivery.model.vo.Doseosangan;
import com.naedam.admin.history.model.vo.History;
import com.naedam.admin.map.model.service.MapService;
import com.naedam.admin.map.model.vo.MapApi;
import com.naedam.admin.map.model.vo.Maps;
import com.naedam.admin.point.model.vo.Point;
import com.naedam.admin.point.model.vo.PointSave;
import com.naedam.admin.point.model.vo.PointUse;
import com.naedam.admin.popup.model.vo.Popup;
import com.naedam.admin.setting.model.service.SettingService;
import com.naedam.admin.setting.model.vo.AdminMenu;
import com.naedam.admin.setting.model.vo.AdminSetting;
import com.naedam.admin.setting.model.vo.Locale;
import com.naedam.admin.setting.model.vo.SeoSetting;
import com.naedam.admin.setting.model.vo.SnsSetting;
import com.naedam.admin.setting.model.vo.Staff;
import com.naedam.admin.setting.model.vo.PGs.BillingPgSetting;
import com.naedam.admin.setting.model.vo.PGs.EximbaySetting;
import com.naedam.admin.setting.model.vo.PGs.KcpSetting;
import com.naedam.admin.setting.model.vo.PGs.KgIniSetting;
import com.naedam.admin.setting.model.vo.PGs.NaverShoppingSetting;
import com.naedam.admin.setting.model.vo.PGs.NaverpaySetting;
import com.naedam.admin.setting.model.vo.PGs.XpaySetting;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/setting")
@Slf4j
public class SettingController {
	@Autowired
	private SettingService settingService;
	@Autowired
	private MapService mapService;
	// (설정-임원관리) : 첨부파일 업로드
	@Autowired
	ServletContext application;

	@GetMapping("/point")
	public void point(Model model) {
		Point point = settingService.selectPoint();
		PointUse pointUse = settingService.selectPointUse();
		PointSave pointSave = settingService.selectPointSave();

		model.addAttribute("point", point);
		model.addAttribute("pointUse", pointUse);
		model.addAttribute("pointSave", pointSave);
	}

	@GetMapping("/coupon")
	public void coupon(Model model) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<Coupon> couponList = settingService.selectCouponListByParam(param);

		model.addAttribute("couponList", couponList);
	}

	@PostMapping("/coupon")
	@SuppressWarnings("rawtypes")
	public void coupon(HttpServletRequest request, Model model) {
		Map<String, Object> param = new HashMap<String, Object>();

		Enumeration params = request.getParameterNames();
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			param.put(name, request.getParameter(name));
		}

		List<Coupon> couponList = settingService.selectCouponListByParam(param);

		model.addAttribute("couponList", couponList);
		model.addAttribute("param", param);
	}

	@GetMapping("/popup")
	public void popup(Model model) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<Popup> popupList = settingService.selectPopupListByParam(param);

		model.addAttribute("popupList", popupList);
	}

	@PostMapping("/popup")
	public String popup(HttpServletRequest request, Model model) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("start_date", request.getParameter("start_date"));
		param.put("end_date", request.getParameter("end_date"));
		param.put("field", request.getParameter("field"));
		param.put("keyword", request.getParameter("keyword"));

		log.debug("param = {}", param);

		List<Popup> popupList = settingService.selectPopupListByParam(param);

		model.addAttribute("param", param);
		model.addAttribute("popupList", popupList);

		return "/admin/setting/popup";
	}

	@GetMapping("/map")
	public void map(Model model) {
		List<Maps> mapList = settingService.selectMapList();
		List<MapApi> apiList = mapService.selectAllMapApiList();
		model.addAttribute("mapList", mapList);
		model.addAttribute("apiList", apiList);
		model.addAttribute("apiKey", "D914287C-19AA-31AD-B187-1532CEF93E7F");
	}

	

	@GetMapping("/history")
	public void history(Model model) {
		List<History> historyList = settingService.selectHistoryList();

		model.addAttribute("historyList", historyList);
	}

	@GetMapping("/banner")
	public void banner(Model model) {
		List<Banner> bannerList = settingService.selectBannerList();
		List<Category> menuCteList = settingService.selectMenuCteList();
		model.addAttribute("bannerList", bannerList);
		model.addAttribute("menuCteList", menuCteList);
	}

	@GetMapping("/contract")
	public void contract() {
	}

	@GetMapping("/delivery_setting")
	public String deliverySertting(Model model) {
		DeliverySetting deliverySetting = settingService.selectOneDeliverySetting();
		List<Doseosangan> doseosanganList = settingService.selectDoseosanganList();

		model.addAttribute("deliverySetting", deliverySetting);
		model.addAttribute("doseosanganList", doseosanganList);

		return "admin/setting/deliverySetting";
	}

	@GetMapping("/delivery_company")
	public String deliveryCompany(Model model) {

		List<DeliveryCompany> deliveryCompanyList = settingService.selectDeliveryCompanyList();
		model.addAttribute("deliveryCompanyList", deliveryCompanyList);
		model.addAttribute("companyListCnt", deliveryCompanyList.size());

		return "admin/setting/deliveryCompany";
	}

	@GetMapping("/info")
	public void info(Model model) {
		List<AdminMenu> adminMenuList = settingService.selectAdminMenuList();
		List<Locale> localeList = settingService.selectLocaleList();
		AdminSetting adminSetting = settingService.selectAdminSetting();

		model.addAttribute("adminSetting", adminSetting);
		model.addAttribute("adminMenuList", adminMenuList);
		model.addAttribute("localeList", localeList);

	}

	@GetMapping("/img_view")
	public void img_view(String type, Model model) {
		AdminSetting adminSetting = settingService.selectAdminSetting();
		String url = null;
		if (type.equals("thumb")) {
			url = adminSetting.getThumbnailImg();
		} else if (type.equals("favicon")) {
			url = adminSetting.getFaviconImg();
		}

		model.addAttribute("url", url);
	}

	@PostMapping("/getDeliveryNotice.do")
	@ResponseBody
	public DeliveryNotice getDeliveryNotice(String locale) {
		DeliveryNotice deliveryNotice = settingService.selectOneDeliveryNotice(locale);

		return deliveryNotice;
	}

	@PostMapping("/process.do")
	public String process(HttpServletRequest request, AdminSetting adminSetting, DeliveryNotice deliveryNotice,
			AdminMenu adminMenu) {
		int result = 0;
		String mode = request.getParameter("mode");
		if (mode.equals("info")) {
			String phone = request.getParameter("mobile1") + request.getParameter("mobile2")
					+ request.getParameter("mobile3");
			String callerId = request.getParameter("tel1") + request.getParameter("tel2")
					+ request.getParameter("tel3");
			adminSetting.setPhone(phone);
			adminSetting.setCallerId(callerId);
			if (adminSetting.getIsDiscount() == null)
				adminSetting.setIsDiscount("N");

			List<String> menuList = Arrays.asList(request.getParameterValues("admin_menu_list[]"));
			result = settingService.updateAdminMenuAllN();
			for (String menuNo : menuList) {
				result = settingService.updateAdminMenu(menuNo);
			}
			List<String> localeList = Arrays.asList(request.getParameterValues("locale_list[]"));
			result = settingService.updateLocaleAllN();
			for (String localeCode : localeList) {
				result = settingService.updateLocaleChoosen(localeCode);
			}

			result = settingService.updateLocaleDefault(request.getParameter("default_locale"));
			result = settingService.updateAdminSetting(adminSetting);

		} else if (mode.equals("updateGuide")) {
			result = settingService.updateDeliveryNotice(deliveryNotice);
		}

		return "redirect:/admin/setting/info";
	}

	@GetMapping("/seo")
	public void seo(Model model) throws Exception {
		SeoSetting seo = settingService.selectSeoSetting();
		model.addAttribute("seo", seo);
	}

	@PostMapping("/seo_process")
	public String seo_process(HttpServletRequest request, SeoSetting seo,
			@RequestParam("webmaster_naver") MultipartFile naverFileName,
			@RequestParam("webmaster_google") MultipartFile googleFileName,
			@RequestParam("webmaster_bing") MultipartFile bingFileName) throws Exception {
		SeoSetting seoSetting = settingService.selectSeoSetting();

		String filePath = request.getServletContext().getRealPath("webapp/");
		if (seoSetting.getNaverFileName() == null && naverFileName.getOriginalFilename() != "") {
			File naver = new File(filePath + naverFileName.getOriginalFilename());
			naverFileName.transferTo(naver);
			seo.setNaverFileName(naverFileName.getOriginalFilename());
		}
		if (seoSetting.getGoogleFileName() == null && googleFileName.getOriginalFilename() != "") {
			File google = new File(filePath + googleFileName.getOriginalFilename());
			googleFileName.transferTo(google);
			seo.setGoogleFileName(googleFileName.getOriginalFilename());
		}
		if (seoSetting.getBingFileName() == null && bingFileName.getOriginalFilename() != "") {
			File bing = new File(filePath + bingFileName.getOriginalFilename());
			bingFileName.transferTo(bing);
			seo.setBingFileName(bingFileName.getOriginalFilename());
		}

		int result = settingService.updateSeoSetting(seo);
		System.out.println("여기 확인 ::: " + seo);
		String imagePath = request.getServletContext().getRealPath("robots.txt");
		BufferedWriter bw = new BufferedWriter(new FileWriter(imagePath));
		bw.write(seo.getRobots());
		bw.close();
		return "redirect:/admin/setting/seo";
	}

	@GetMapping("/paymentpg")
	public void paymentpg(Model model) {
		BillingPgSetting pg = settingService.selectPgSetting();
		NaverShoppingSetting naverShopping = settingService.selectNaverShoppingSetting();

		model.addAttribute("pg", pg);
		model.addAttribute("naverShopping", naverShopping);
	}

	@PostMapping("/pg_process")
	@ResponseBody
	public Object pg_process(String method, HttpServletRequest request) {
		Map<String, String> result = new HashMap<String, String>();
		log.debug("method = {}", method);

		if (method.equals("billing_pg_info")) {
			BillingPgSetting pgSetting = settingService.selectPgSetting();

			return pgSetting;
		} else if (method.equals("getCardPgInfo")) {
			String type = request.getParameter("type");
			log.debug("type = {}", type);
			if (type.equals("ini")) {
				KgIniSetting kg = settingService.selectKgIniSetting();
				return kg;
			} else if (type.equals("xpay")) {
				XpaySetting xpay = settingService.selectXpaySetting();
				return xpay;
			} else if (type.equals("kcp")) {
				KcpSetting kcp = settingService.selectKcpSetting();
				return kcp;
			} else if (type.equals("naverpay")) {
				NaverpaySetting naverpay = settingService.selectNaverpaySetting();
				return naverpay;
			} else if (type.equals("eximbay")) {
				EximbaySetting eximbay = settingService.selectEximbaySetting();
				return eximbay;
			}
		}
		return result;
	}

	@PostMapping("/updatePaymentPG")
	public String updatePaymentPG(HttpServletRequest request, BillingPgSetting pg, KgIniSetting kg, XpaySetting xpay,
			KcpSetting kcp, NaverpaySetting naverpay, EximbaySetting eximbay, NaverShoppingSetting naverShopping) {
		int result = 0;
		if (pg.getIsDomestic() == null) {
			pg.setIsDomestic("N");
		}
		if (pg.getIsForeigne() == null) {
			pg.setIsForeigne("N");
		}
		if (pg.getNaverpayUse() == null) {
			pg.setNaverpayUse("N");
		}

		if (kg.getUseIni() == null) {
			kg.setUseIni("N");
		}
		if (kg.getUseCreditIni() == null) {
			kg.setUseCreditIni("N");
		}
		if (kg.getUseBankIni() == null) {
			kg.setUseBankIni("N");
		}
		if (kg.getUseVBankIni() == null) {
			kg.setUseVBankIni("N");
		}

		if (xpay.getUseXpay() == null) {
			xpay.setUseXpay("N");
		}
		if (xpay.getUseCreditXpay() == null) {
			xpay.setUseCreditXpay("N");
		}
		if (xpay.getUseBankXpay() == null) {
			xpay.setUseBankXpay("N");
		}
		if (xpay.getUseVBankXpay() == null) {
			xpay.setUseVBankXpay("N");
		}

		if (kcp.getUseKcp() == null) {
			kcp.setUseKcp("N");
		}
		if (kcp.getUseCredit() == null) {
			kcp.setUseCredit("N");
		}
		if (kcp.getUseBank() == null) {
			kcp.setUseBank("N");
		}
		if (kcp.getUseVBank() == null) {
			kcp.setUseVBank("N");
		}

		if (eximbay.getUseEximbay() == null) {
			eximbay.setUseEximbay("N");
		}
		if (eximbay.getUseCreditEximbay() == null) {
			eximbay.setUseCreditEximbay("N");
		}
		if (eximbay.getUsePaypal() == null) {
			eximbay.setUsePaypal("N");
		}
		if (eximbay.getUseUnion() == null) {
			eximbay.setUseUnion("N");
		}
		if (eximbay.getUseAli() == null) {
			eximbay.setUseAli("N");
		}

		if (!(kg.getUseCreditIni().equals("N") && kg.getUseBankIni().equals("N") && kg.getUseVBankIni().equals("N"))) {
			result = settingService.updateKgIniSetting(kg);
		}
		if (!(xpay.getUseCreditXpay().equals("N") && xpay.getUseBankXpay().equals("N")
				&& xpay.getUseVBankXpay().equals("N"))) {
			result = settingService.updateXpaySetting(xpay);
		}
		if (!(kcp.getUseCredit().equals("N") && kcp.getUseBank().equals("N") && kcp.getUseVBank().equals("N"))) {
			result = settingService.updateKcpSetting(kcp);
		}

		result = settingService.updateBillingPgSetting(pg);
		result = settingService.updateNaverpaySetting(naverpay);
		result = settingService.updateNaverShoppingSetting(naverShopping);

		return "admin/setting/paymentpg";
	}

	@GetMapping("/snslogin")
	public String snsLogin(Model model, SnsSetting snsSetting) {
		System.out.println("settingController/snsSetting 시작");

		snsSetting = settingService.selectSnsSetting();
		model.addAttribute("snsSetting", snsSetting);

		return "admin/setting/sns";
	}

	@PostMapping("/updateSnsSetting")
	public String updateSnsSetting(SnsSetting snsSetting) {
		System.out.println("settingController/updateSnsSetting 시작");
		settingService.updateSnsSetting(snsSetting);
		return "redirect:/admin/setting/snslogin";
	}

	@GetMapping("/locale")
	public void locale() {
	}

	@GetMapping("/version")
	public void version() {
	}

	@GetMapping("/test")
	public void test() {
	}

	// 임원 리스트 
	@GetMapping("/staff.do")
	public void staffList(@RequestParam(defaultValue = "1") int cPage, Model model) {
		try {
			// 임원 리스트 게시물
			List<Staff> resultStaffList = settingService.selectStaffList();
			model.addAttribute("resultStaffList", resultStaffList);
			
			// 전체 게시물 수
			int totalStaffListCount = settingService.selectStaffListCount();
			model.addAttribute("totalStaffListCount", totalStaffListCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 임원 등록/수정
	@PostMapping("/staff_process.do")
	public String staffProcess(Staff staff, RedirectAttributes redirectAttribute, HttpServletRequest request) {
		int result = 0;
		String msg = null;
		String mode = request.getParameter("mode");

		try {
			if (mode.equals("insert")) {
				int resultInsertStaff = settingService.insertStaff(staff);
			} else if (mode.equals("update")) {
				int resultUpdateStaff = settingService.updateStaff(staff);
				if (resultUpdateStaff > 0) {
					msg = "수정 되었습니다.";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/admin/setting/staff.do";
	}

	// 임원 삭제
	@PostMapping("/staff_delete.do")
	public String staffDelete(@RequestParam int[] staffNo, RedirectAttributes redirectAttribute, HttpServletRequest request) {
		int result = 0;
		String msg = null;
		String mode = request.getParameter("mode");

		try {
			if (mode.equals("delete")) {
				int resultDeleteStaff = settingService.deleteStaff(staffNo);
				if (resultDeleteStaff > 0) {
					msg = "삭제 되었습니다.";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/admin/setting/staff.do";
	}

	// 임원 관리 타입별 검색
	@ResponseBody
	@GetMapping("/staffTypeSearch.do")
	public Map<String, Object> staffTypeSearch(@RequestParam String type, @RequestParam String keyword, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);

		// 임원 검색 게시물 리스트
		List<Staff> searchStaffList = settingService.selectSearchStaffList(param);

		// 임원 검색 게시물 수
		int searchStaffCount = settingService.selectsearchStaffListCount(param);

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("searchStaffList", searchStaffList);
		resultMap.put("searchStaffCount", searchStaffCount);

		return resultMap;
	}

	// 임원관리 상세보기
	@ResponseBody
	@GetMapping("/staffDetail.do/{staffNo}")
	public Map<String, Object> staffDetail(@PathVariable int staffNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<>();
		Staff staff = settingService.selectOneStaffByStaffNo(staffNo);
		resultMap.put("staff", staff);
		return resultMap;
	}

	// 임원 관리 - 팝업 이미지
	@GetMapping("/imgView")
	public String imgView(@RequestParam(defaultValue = "0") int staffNo, Model model) {

		String url = "";

		try {
			if (staffNo == 0) {
				url = "http://fs.joycity.com/web/images/common/fs1_er.png";
			} else {
				url = settingService.selectOneimgUrlBystaffNo(staffNo).getImgUrl();
			}
			model.addAttribute("url", url);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/admin/setting/imgView";
	}

	// 임원 관리 - 이미지 삭제
	@PostMapping("/deleteImg.do/{staffNo}")
	public String deleteImg(@PathVariable int staffNo, RedirectAttributes redirectAttribute, HttpServletRequest request) {

		try {
			int resultDeleteImg = settingService.deleteStaffImg(staffNo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

	// 게시물 순서 변경
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/changeOrder.do")
	public Map<String, Object> changeOrder(@RequestBody String data, RedirectAttributes redirectAttribute) {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			Map<String, String> map = mapper.readValue(data, Map.class);
			String direction = map.get("direction");
			
			Staff paramStaff = new Staff();
			paramStaff.setStaffNo(Integer.parseInt(map.get("staffNo")));
			// ajax로 데이터를 받아온 후 radio 체크를 위해 설정
			resultMap.put("staffNo", map.get("staffNo"));
		
			// 초기 row_order
			Staff resultInputRowOrder = settingService.selectInputRowOrder(paramStaff);
			int input_row_order = resultInputRowOrder.getRowOrder();
			paramStaff.setRowOrder(input_row_order);
			
			if (direction.equals("up")) {
				// row_order 최대값 찾기
				Staff resultMaxOrder = settingService.selectMaxOrder();
				int max_order = resultMaxOrder.getRowOrder();
				
				// 선택 게시물 위로 올리기 row_order + 1
				int resultChangeOrderUp = settingService.updateChangeOrderUp(paramStaff);
				int changed_row_order = paramStaff.getRowOrder();
				
				/*
				 *  선택한 row_order + 1 값이 기존 row_order 최대값보다 작다면 다음행 row_order - 1 진행
				 *  선택된 row_order + 1 값이 최대값보다 커질 경우 해당 메소드 미작동
				 */
				log.debug("paramStaff = {}", paramStaff);
				if(max_order > input_row_order && max_order >= changed_row_order) {
					// 선택 게시물 위에 있던 게시물 내리기 row_order - 1
					int resultChangeOrderUpNext = settingService.updateChangeOrderUpNext(paramStaff);
					resultMap.put("changeOrderUpBan", "success");
				} else {
					resultMap.put("changeOrderUpBan", "ban");
				}

			} else if (direction.equals("down")) {
				// row_order 최소값 찾기
				Staff resultMinOrder = settingService.selectMinOrder();
				int min_order = resultMinOrder.getRowOrder();
				
				// 선택 게시물 아래로 내리기 row_order - 1
				int resultChangeOrderDown = settingService.updateChangeOrderDown(paramStaff);
				int changed_row_order = paramStaff.getRowOrder();
				
				if(min_order < input_row_order && changed_row_order >= min_order ) {
					// 선택 게시물 아래에 있던 게시물 올리기 row_order + 1
					int resultChangeOrderDownNext = settingService.updateChangeOrderDownNext(paramStaff);
					resultMap.put("changeOrderDownBan", "success");
				} else {
					resultMap.put("changeOrderDownBan", "ban");
				}
			}

		} catch (Exception e) {
		}

		// 임원 리스트 게시물
		List<Staff> staffList = settingService.selectStaffList();
		resultMap.put("staffList", staffList);

		return resultMap;
	}

}
