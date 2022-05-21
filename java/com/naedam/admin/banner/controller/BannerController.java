package com.naedam.admin.banner.controller;

import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naedam.admin.banner.model.service.BannerService;
import com.naedam.admin.banner.model.vo.Banner;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/banner")
@Slf4j
public class BannerController {
	@Autowired
	private BannerService bannerService;
	
	@PostMapping("/getBenner")
	@ResponseBody
	public Banner getBanner(int bannerNo) {
		Banner banner = bannerService.selectOneBannerByBannerNo(bannerNo);
		
		return banner;
	}
	
	@GetMapping("/img_view")
	public String img_view(@RequestParam(defaultValue = "0") int bannerNo, Model model) {
		String url = "";
		if(bannerNo == 0) {
			url = "http://fs.joycity.com/web/images/common/fs1_er.png";
		}else {
			url = bannerService.selectOneBannerByBannerNo(bannerNo).getImgUrl();
		}
		
		model.addAttribute("url",url);
		return "/admin/setting/img_view";
	}
	
	@PostMapping("/banner_process")
	public String banner_process(HttpServletRequest request, Banner banner, RedirectAttributes redirectAttr) {
		int result = 0;
		String msg = null;
		String mode = request.getParameter("mode");
		
		if(mode.equals("insert")) {
			result = bannerService.insertBanner(banner);
		}else if(mode.equals("update")) {
			result = bannerService.updateBanner(banner);
			if(result > 0) msg = "배너 정보가 수정 되었습니다.";
		}else if(mode.equals("delete")) {
			List<String> bannerNoList = Arrays.asList(request.getParameterValues("list[]"));
			for(String no : bannerNoList) {
				result = bannerService.deleteBanner(Integer.parseInt(no));
				if(result > 0) msg = "배너가 삭제 되었습니다.";
			}
		}
		
		redirectAttr.addFlashAttribute("msg", msg);
		return "redirect:/admin/setting/banner";
	}
}
