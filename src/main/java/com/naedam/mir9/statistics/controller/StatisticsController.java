package com.naedam.mir9.statistics.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Enumeration;

import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naedam.mir9.board.model.vo.Search;
import com.naedam.mir9.statistics.model.service.StatisticsService;
import com.naedam.mir9.statistics.model.vo.PeriodStatisticVo;
import com.naedam.mir9.statistics.model.vo.ProductStatisticVo;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/statistics")
@Slf4j
public class StatisticsController {
	@Autowired
	private StatisticsService statisticsService;
	
	@GetMapping("/period_day")
	public String statisticsPeriod_day(Model model) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<PeriodStatisticVo> result = new ArrayList<PeriodStatisticVo>();
		for(int i = 0; i < 7; i++) {
			Calendar cal = new GregorianCalendar();
			cal.add(GregorianCalendar.DATE, -i);
			param.put("date", cal.getTime());
			PeriodStatisticVo statistic = new PeriodStatisticVo();
			
			try {
				statistic = statisticsService.selectPeriodStatistics(param);
			
			} catch (Exception e) {}
			
			if(statistic == null) {
				statistic = new PeriodStatisticVo();
				statistic.setPaidAt(cal.getTime());
			}
			
			result.add(statistic);
		}
		
		Collections.reverse(result);
		model.addAttribute("result", result);
		

		return "statistics/period_day";
	}
	
	@PostMapping("/period_day")
	public String statisticsPeriod_day(Model model, HttpServletRequest request) {
		String type = request.getParameter("statistics_type");
		String startDateStr = request.getParameter("start_date");
		String endDateStr = request.getParameter("end_date");
		GregorianCalendar startDate = strToIntDate(startDateStr);
		GregorianCalendar endDate = strToIntDate(endDateStr);
		
		int length = (int) ((endDate.getTimeInMillis() - startDate.getTimeInMillis())/1000/(24*60*60) + 1);
		
		
		
		Map<String, Object> param = new HashMap<String, Object>();
		List<PeriodStatisticVo> result = new ArrayList<PeriodStatisticVo>();
		
		for(int i = 0; i < length; i++) {
			Calendar cal = endDate;
			cal.add(GregorianCalendar.DATE, -1);
			param.put("date", cal.getTime());
			PeriodStatisticVo statistic = new PeriodStatisticVo();
			
			try {
				statistic = statisticsService.selectPeriodStatistics(param);
			
			} catch (Exception e) {}
			
			if(statistic == null) {
				statistic = new PeriodStatisticVo();
				statistic.setPaidAt(cal.getTime());
			}
			
			result.add(statistic);
		}
		
		Collections.reverse(result);
		model.addAttribute("result", result);
		
		if(type.equals("date")) {
			return "statistics/period_day";
		}
		
		return "";
	}
	
	private GregorianCalendar strToIntDate(String dateStr){
		int year = Integer.parseInt((dateStr.substring(0, 4)));
		int month = Integer.parseInt((dateStr.substring(5, 7))) - 1;
		int day = Integer.parseInt((dateStr.substring(8, 10)));
		
		return new GregorianCalendar(year, month, day+1);
	}
	
	@GetMapping("/period_month")
	public String statisticsPeriod_month() {
		
		return "statistics/period_month";
	}
	
	@GetMapping("/period_year")
	public String statisticsPeriod_year() {
		
		return "statistics/period_year";
	}
	
	@RequestMapping(value="/product")
	public String statisticsProduct(Model model, @ModelAttribute("search") Search search) throws Exception {
		System.out.println("statistics/product 시작");
		ProductStatisticVo product = new ProductStatisticVo();
		product.setRegStartdate(search.getStart_date());
		product.setRegEnddate(search.getEnd_date());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("product", product);
		Map<String, Object> resultMap = statisticsService.selectProductStatistics(map);
		System.out.println("데이터 확인 ::: "+resultMap.get("list"));
		model.addAttribute("list", resultMap.get("list"));
		return "statistics/product";
	}
	
	@GetMapping("/member")
	public String statisticsMember() {
		
		return "statistics/member";
	}
	
	@GetMapping("/address_day")
	public String statisticsAddress_day() {
		
		return "statistics/address_day";
	}
	
	@GetMapping("/address_month")
	public String statisticsAddress_month() {
		
		return "statistics/address_month";
	}
	
	@GetMapping("/address_year")
	public String statisticsAddress_year() {
		
		return "statistics/address_year";
	}
}
