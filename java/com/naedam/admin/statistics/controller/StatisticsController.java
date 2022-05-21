package com.naedam.admin.statistics.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naedam.admin.board.model.vo.Search;
import com.naedam.admin.category.model.service.CategoryService;
import com.naedam.admin.category.model.vo.Category;
import com.naedam.admin.statistics.model.service.StatisticsService;
import com.naedam.admin.statistics.model.vo.AddressStatisticVo;
import com.naedam.admin.statistics.model.vo.AreaVo;
import com.naedam.admin.statistics.model.vo.MemberStatisticVo;
import com.naedam.admin.statistics.model.vo.PeriodStatisticVo;
import com.naedam.admin.statistics.model.vo.ProductStatisticVo;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/statistics")
@Slf4j
public class StatisticsController {
	@Autowired
	private StatisticsService statisticsService;
	@Autowired
	private CategoryService categoryService;
	
	@GetMapping("/period_day")
	public String statisticsPeriod_day(Model model) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<PeriodStatisticVo> result = new ArrayList<PeriodStatisticVo>();
		param.put("type", "D");
		
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
		

		return "admin/statistics/period_day";
	}
	
	@GetMapping("/period_month")
	public String statisticsPeriod_month(Model model) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<PeriodStatisticVo> result = new ArrayList<PeriodStatisticVo>();
		param.put("type", "M");
		for(int i = 0; i < 3; i++) {
			Calendar cal = new GregorianCalendar();
			cal.add(GregorianCalendar.MONTH, -i);
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

		return "admin/statistics/period_month";
	}

	
	@GetMapping("/period_year")
	public String statisticsPeriod_year(Model model) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<PeriodStatisticVo> result = new ArrayList<PeriodStatisticVo>();
		param.put("type", "Y");
		for(int i = 0; i < 5; i++) {
			Calendar cal = new GregorianCalendar();
			cal.add(GregorianCalendar.YEAR, -i);
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

		return "admin/statistics/period_year";
	}
	
	@PostMapping("/period_process")
	public String statisticsPeriod_day(Model model, HttpServletRequest request) {
		String type = request.getParameter("statistics_type");
		String startDateStr = request.getParameter("start_date");
		String endDateStr = request.getParameter("end_date");
		GregorianCalendar startDate = strToIntDate(startDateStr, type);
		GregorianCalendar endDate = strToIntDate(endDateStr, type);
		log.debug("type = {}", type);
		Map<String, Object> param = new HashMap<String, Object>();
		List<PeriodStatisticVo> result = new ArrayList<PeriodStatisticVo>();
		int length = 0;
		
		if(type.equals("date")) {
			length = (int) ((endDate.getTimeInMillis() - startDate.getTimeInMillis())/1000/(24*60*60) + 1);
			param.put("type", "D");
		}else if(type.equals("month")) {
			length = (int) ((endDate.getTimeInMillis() - startDate.getTimeInMillis())/1000/(24*60*60)/30);
			param.put("type", "M");
		}else if(type.equals("year")) {
			length = (int) ((endDate.getTimeInMillis() - startDate.getTimeInMillis())/1000/(24*60*60)/365 + 1);
			param.put("type", "Y");
		}
		
		for(int i = 0; i < length; i++) {
			Calendar cal = endDate;
			
			if(type.equals("date")) {
				cal.add(GregorianCalendar.DATE, -1);				
			}else if(type.equals("month")) {
				cal.add(GregorianCalendar.MONTH, -1);				
			}else if(type.equals("year")) {
				cal.add(GregorianCalendar.YEAR, -1);
			}
			
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
		model.addAttribute("startDateStr", startDateStr);
		model.addAttribute("endDateStr", endDateStr);
		
		if(type.equals("date")) {
			return "statistics/period_day";
		}else if(type.endsWith("month")) {
			return "statistics/period_month";
		}
		
		return "admin/statistics/period_year";
	}
	
	private GregorianCalendar strToIntDate(String dateStr, String type){
		int year=0; int month=0; int day = 0;
		if(type.equals("year")) {
			year = Integer.parseInt((dateStr.substring(0, 4)));
			return new GregorianCalendar(year+2, 0, 0);
			
		}else if(type.equals("month")) {
			year = Integer.parseInt((dateStr.substring(0, 4)));
			month = Integer.parseInt((dateStr.substring(5, 7))) - 1;
			
			return new GregorianCalendar(year, month +2, 0);
		}else if(type.equals("date")) {
			year = Integer.parseInt((dateStr.substring(0, 4)));
			month = Integer.parseInt((dateStr.substring(5, 7))) - 1;
			day = Integer.parseInt((dateStr.substring(8, 10)));
			return new GregorianCalendar(year, month, day+1);			
		}
		
		return null;
		
	}
	
	@RequestMapping(value="/product")
	public String statisticsProduct(Model model, @ModelAttribute("search") Search search) throws Exception {
		System.out.println("statistics/product 시작");
		String type = "product";
		ProductStatisticVo product = new ProductStatisticVo();
		product.setRegStartdate(search.getStart_date());
		product.setRegEnddate(search.getEnd_date());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("product", product);
		Map<String, Object> resultMap = statisticsService.selectProductStatistics(map);
		List<Category> categoryList = categoryService.selectProductCategory(type);
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("list2", categoryList);
		return "admin/statistics/product";
	}
	
	@GetMapping("/member")
	public String statisticsMember(Model model) {
		Map<String, Object> param = new HashMap<String, Object>();
		Calendar cal = new GregorianCalendar();
		
		param.put("endDate", cal.getTime());
		cal.add(GregorianCalendar.MONTH, -3);
		param.put("startDate", cal.getTime());
		
		List<MemberStatisticVo> memberStatisticsList = statisticsService.selectMemberStatisticsList(param);
		
		model.addAttribute("result", memberStatisticsList);
		
		return "admin/statistics/member";
	}
	
	@PostMapping("/member")
	public String statisticsMember(Model model, HttpServletRequest request) {
		String type = "date";		
		String startDateStr = request.getParameter("start_date");
		String endDateStr = request.getParameter("end_date");
		GregorianCalendar startDate = strToIntDate(startDateStr, type);
		GregorianCalendar endDate = strToIntDate(endDateStr, type);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("startDate", startDate.getTime());
		param.put("endDate", endDate.getTime());
		
		List<MemberStatisticVo> memberStatisticsList = statisticsService.selectMemberStatisticsList(param);
		
		model.addAttribute("result", memberStatisticsList);
		model.addAttribute("startDateStr", startDateStr);
		model.addAttribute("endDateStr", endDateStr);
		
		return "admin/statistics/member";
	}
	
	@GetMapping("/address_day")
	public String statisticsAddress_day(Model model, Search search) throws Exception {
		System.out.println("get/statistics/address_day 시작");
		LocalDate now = LocalDate.now();
		String startDate = now.minusDays(7).toString();
		String endDate = now.toString();
		search.setStart_date(startDate);
		search.setEnd_date(endDate);
		Map<String, Object> map = new HashMap<String, Object>();
		AddressStatisticVo addressVo = new AddressStatisticVo();
		addressVo.setAddressCategory(1);
		map.put("search", search);
		map.put("addressVo", addressVo);
		List<AddressStatisticVo> resultList = new ArrayList<AddressStatisticVo>();
		List<AreaVo> areaAddress = new ArrayList<AreaVo>(); 
		areaAddress = statisticsService.selectAreaPayment(map);
		List<AreaVo> area = statisticsService.selectArea();

		for(int i = 0; i < areaAddress.size(); i++) {
			area.set(areaAddress.get(i).getAreaNo()-1, areaAddress.get(i));
		}

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		LocalDate startDateLocal = LocalDate.parse(startDate, formatter);
		LocalDate endDateLocal = LocalDate.parse(endDate, formatter);
				
		List<LocalDate> localDate = startDateLocal.datesUntil(endDateLocal.plusDays(1)).collect(Collectors.toList());
		
		for(int i = 0; i < localDate.size(); i++) {
			map.put("date", localDate.get(i));
			
			AddressStatisticVo address = new AddressStatisticVo();
			try {
				address = statisticsService.selectAddressStatistics2(map);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			if(address == null) {
				address = new AddressStatisticVo();
				address.setPaidAt(localDate.get(i));
			}
			resultList.add(address);
		}
		
		
		
		model.addAttribute("list", resultList);
		model.addAttribute("list2", area);
		return "admin/statistics/address_day";
	}
	
	@PostMapping("/address_day")
	public String statisticsAddress_day(Model model, HttpServletRequest request, Search search) throws Exception {
		System.out.println("post/statistics/statisticsAddress_day 시작");
		
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		search.setStart_date(startDate);
		search.setEnd_date(endDate);
		Map<String, Object> map = new HashMap<String, Object>();
		AddressStatisticVo addressVo = new AddressStatisticVo();
		addressVo.setAddressCategory(1);
		map.put("search", search);
		map.put("addressVo", addressVo);
		List<AddressStatisticVo> resultList = new ArrayList<AddressStatisticVo>();
		List<AreaVo> areaAddress = new ArrayList<AreaVo>(); 
		areaAddress = statisticsService.selectAreaPayment(map);
		List<AreaVo> area = statisticsService.selectArea();

		for(int i = 0; i < areaAddress.size(); i++) {
			area.set(areaAddress.get(i).getAreaNo()-1, areaAddress.get(i));
		}

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		LocalDate startDateLocal = LocalDate.parse(startDate, formatter);
		LocalDate endDateLocal = LocalDate.parse(endDate, formatter);
				
		List<LocalDate> localDate = startDateLocal.datesUntil(endDateLocal.plusDays(1)).collect(Collectors.toList());
		
		for(int i = 0; i < localDate.size(); i++) {
			map.put("date", localDate.get(i));
			
			AddressStatisticVo address = new AddressStatisticVo();
			try {
				address = statisticsService.selectAddressStatistics2(map);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			if(address == null) {
				address = new AddressStatisticVo();
				address.setPaidAt(localDate.get(i));
			}
			resultList.add(address);
		}
		
		model.addAttribute("list", resultList);
		model.addAttribute("list2", area);
		return "admin/statistics/address_day";
	}	

	@GetMapping("/address_month")
	public String statisticsAddress_month(Model model, Search search) throws Exception {
		LocalDate now = LocalDate.now();
		String startDate = now.minusMonths(1).toString();
		String endDate = now.toString();
		search.setStart_date(startDate);
		search.setEnd_date(endDate);
		Map<String, Object> map = new HashMap<String, Object>();
		AddressStatisticVo addressVo = new AddressStatisticVo();
		addressVo.setAddressCategory(2);
		map.put("search", search);
		map.put("addressVo", addressVo);
		List<AddressStatisticVo> resultList = new ArrayList<AddressStatisticVo>();
		List<AreaVo> areaAddress = new ArrayList<AreaVo>(); 
		areaAddress = statisticsService.selectAreaPayment(map);
		List<AreaVo> area = statisticsService.selectArea();

		for(int i = 0; i < areaAddress.size(); i++) {
			area.set(areaAddress.get(i).getAreaNo()-1, areaAddress.get(i));
		}
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		LocalDate startDateLocal = LocalDate.parse(startDate, formatter);
		LocalDate endDateLocal = LocalDate.parse(endDate, formatter);
				
		int numOfDaysBetween = (int) ChronoUnit.MONTHS.between(startDateLocal, endDateLocal.plusMonths(1));
		
		List<LocalDate> localDate = IntStream.iterate(0, i -> i + 1)
						        	.limit(numOfDaysBetween)
						        	.mapToObj(i -> startDateLocal.plusMonths(i))
						        	.collect(Collectors.toList());
		
		for(int i = 0; i < localDate.size(); i++) {
			map.put("date", localDate.get(i));
			AddressStatisticVo address = new AddressStatisticVo();
			try {
				address = statisticsService.selectAddressStatistics2(map);
			} catch (Exception e) {	
				e.printStackTrace();
			}
			if(address == null) {
				address = new AddressStatisticVo();
				address.setPaidAt(localDate.get(i));
			}
			resultList.add(address);
		}
		model.addAttribute("list", resultList);
		model.addAttribute("list2", area);
		return "admin/statistics/address_month";
	}
	
	@PostMapping("/address_month")
	public String statisticsAddress_month(Model model, HttpServletRequest request, Search search) throws Exception {
		System.out.println("post/statistics/statisticsAddress_month 시작");
		
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		StringBuffer sbStartDate = new StringBuffer();
		StringBuffer sbEndDate = new StringBuffer();
		sbStartDate.append(startDate);
		sbEndDate.append(endDate);
		search.setStart_date(sbStartDate.append("-01").substring(0, 10));
		search.setEnd_date(sbEndDate.append("-01").substring(0, 10));
		Map<String, Object> map = new HashMap<String, Object>();
		AddressStatisticVo addressVo = new AddressStatisticVo();
		map.put("search", search);
		map.put("addressVo", addressVo);
		addressVo.setAddressCategory(2);
		List<AddressStatisticVo> resultList = new ArrayList<AddressStatisticVo>();
		List<AreaVo> areaAddress = new ArrayList<AreaVo>(); 
		areaAddress = statisticsService.selectAreaPayment(map);
		List<AreaVo> area = statisticsService.selectArea();

		for(int i = 0; i < areaAddress.size(); i++) {
			area.set(areaAddress.get(i).getAreaNo()-1, areaAddress.get(i));
		}
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		LocalDate startDateLocal = LocalDate.parse(sbStartDate, formatter);
		LocalDate endDateLocal = LocalDate.parse(sbEndDate, formatter);
				
		int numOfDaysBetween = (int) ChronoUnit.MONTHS.between(startDateLocal, endDateLocal.plusMonths(1));
		
		List<LocalDate> localDate = IntStream.iterate(0, i -> i + 1)
						        	.limit(numOfDaysBetween)
						        	.mapToObj(i -> startDateLocal.plusMonths(i))
						        	.collect(Collectors.toList());
		
		for(int i = 0; i < localDate.size(); i++) {
			map.put("date", localDate.get(i));
			AddressStatisticVo address = new AddressStatisticVo();
			try {
				address = statisticsService.selectAddressStatistics2(map);
			} catch (Exception e) {	
				e.printStackTrace();
			}
			if(address == null) {
				address = new AddressStatisticVo();
				address.setPaidAt(localDate.get(i));
			}
			resultList.add(address);
		}
		model.addAttribute("list", resultList);
		model.addAttribute("list2", area);
		return "admin/statistics/address_month";
	}
	
	@GetMapping("/address_year")
	public String statisticsAddress_year(Model model, Search search) throws Exception {
		LocalDate now = LocalDate.now();
		String startDate = now.minusYears(4).toString();
		String endDate = now.toString();
		search.setStart_date(startDate);
		search.setEnd_date(endDate);		
		Map<String, Object> map = new HashMap<String, Object>();
		AddressStatisticVo addressVo = new AddressStatisticVo();
		addressVo.setAddressCategory(3);
		map.put("search", search);
		map.put("addressVo", addressVo);
		List<AddressStatisticVo> resultList = new ArrayList<AddressStatisticVo>();
		List<AreaVo> areaAddress = new ArrayList<AreaVo>(); 
		areaAddress = statisticsService.selectAreaPayment(map);
		List<AreaVo> area = statisticsService.selectArea();

		for(int i = 0; i < areaAddress.size(); i++) {
			area.set(areaAddress.get(i).getAreaNo()-1, areaAddress.get(i));
		}
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		LocalDate startDateLocal = LocalDate.parse(startDate, formatter);
		LocalDate endDateLocal = LocalDate.parse(endDate, formatter);
				
		int numOfDaysBetween = (int) ChronoUnit.YEARS.between(startDateLocal, endDateLocal.plusYears(1));
		
		List<LocalDate> localDate = IntStream.iterate(0, i -> i + 1)
						        	.limit(numOfDaysBetween)
						        	.mapToObj(i -> startDateLocal.plusYears(i))
						        	.collect(Collectors.toList());
		
		for(int i = 0; i < localDate.size(); i++) {
			map.put("date", localDate.get(i));
			AddressStatisticVo address = new AddressStatisticVo();
			try {
				address = statisticsService.selectAddressStatistics2(map);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			if(address == null) {
				address = new AddressStatisticVo();
				address.setPaidAt(localDate.get(i));
			}
			resultList.add(address);
		}
		model.addAttribute("list", resultList);
		model.addAttribute("list2", area);
		return "admin/statistics/address_year";
	}
	
	@PostMapping("/address_year")
	public String statisticsAddress_year(Model model, HttpServletRequest request, Search search) throws Exception {
		System.out.println("post/statistics/statisticsAddress_year 시작");
		
		LocalDate now = LocalDate.now();
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		StringBuffer sbStartDate = new StringBuffer();
		StringBuffer sbEndDate = new StringBuffer();
		sbStartDate.append(startDate);
		sbEndDate.append(endDate);
		search.setStart_date(sbStartDate.append("-01-01").substring(0, 10));
		search.setEnd_date(sbEndDate.append("-01-01").substring(0, 10));		
		
		Map<String, Object> map = new HashMap<String, Object>();
		AddressStatisticVo addressVo = new AddressStatisticVo();
		addressVo.setAddressCategory(3);
		map.put("search", search);
		map.put("addressVo", addressVo);
		List<AddressStatisticVo> resultList = new ArrayList<AddressStatisticVo>();
		List<AreaVo> areaAddress = new ArrayList<AreaVo>(); 
		areaAddress = statisticsService.selectAreaPayment(map);
		List<AreaVo> area = statisticsService.selectArea();

		for(int i = 0; i < areaAddress.size(); i++) {
			area.set(areaAddress.get(i).getAreaNo()-1, areaAddress.get(i));
		}
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		LocalDate startDateLocal = LocalDate.parse(sbStartDate, formatter);
		LocalDate endDateLocal = LocalDate.parse(sbEndDate, formatter);
				
		int numOfDaysBetween = (int) ChronoUnit.YEARS.between(startDateLocal, endDateLocal.plusYears(1));
		
		List<LocalDate> localDate = IntStream.iterate(0, i -> i + 1)
						        	.limit(numOfDaysBetween)
						        	.mapToObj(i -> startDateLocal.plusYears(i))
						        	.collect(Collectors.toList());
		
		for(int i = 0; i < localDate.size(); i++) {
			map.put("date", localDate.get(i));
			AddressStatisticVo address = new AddressStatisticVo();
			try {
				address = statisticsService.selectAddressStatistics2(map);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			if(address == null) {
				address = new AddressStatisticVo();
				address.setPaidAt(localDate.get(i));
			}
			resultList.add(address);
		}
		model.addAttribute("list", resultList);
		model.addAttribute("list2", area);
		return "admin/statistics/address_year";
	}
}
