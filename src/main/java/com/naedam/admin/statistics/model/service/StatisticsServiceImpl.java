package com.naedam.admin.statistics.model.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.board.model.vo.Search;
import com.naedam.admin.category.model.dao.CategoryDao;
import com.naedam.admin.statistics.model.dao.StatisticsDao;
import com.naedam.admin.statistics.model.vo.AddressStatisticVo;
import com.naedam.admin.statistics.model.vo.AreaVo;
import com.naedam.admin.statistics.model.vo.BeforeYearStatisticVo;
import com.naedam.admin.statistics.model.vo.MemberStatisticVo;
import com.naedam.admin.statistics.model.vo.PeriodStatisticVo;

@Service
public class StatisticsServiceImpl implements StatisticsService {
	@Autowired
	private StatisticsDao statisticsDao;
	@Autowired
	private CategoryDao categoryDao;
	
	public Map<String, Object> statisticsAddress(Map<String, Object> map) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Search search = (Search) map.get("search");
		AddressStatisticVo addressVo = new AddressStatisticVo();
		
		if("address_day".equals(map.get("mode"))) {
			addressVo.setAddressCategory(1);
			map.put("addressVo", addressVo);
			List<AddressStatisticVo> resultList = new ArrayList<AddressStatisticVo>();
			List<AreaVo> areaAddress = new ArrayList<AreaVo>(); 
			areaAddress = statisticsDao.selectAreaPayment(map);
			List<AreaVo> area = statisticsDao.selectArea();
			for(int i = 0; i < areaAddress.size(); i++) {
				area.set(areaAddress.get(i).getAreaNo()-1, areaAddress.get(i));
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate startDateLocal = LocalDate.parse(search.getStart_date(), formatter);
			LocalDate endDateLocal = LocalDate.parse(search.getEnd_date(), formatter);
			List<LocalDate> localDate = startDateLocal.datesUntil(endDateLocal.plusDays(1)).collect(Collectors.toList());
			for(int i = 0; i < localDate.size(); i++) {
				map.put("date", localDate.get(i));			
				AddressStatisticVo address = new AddressStatisticVo();
				try {
					address = statisticsDao.selectAddressStatistics2(map);
				} catch (Exception e) {				
					e.printStackTrace();
				}
				if(address == null) {
					address = new AddressStatisticVo();
					address.setPaidAt(localDate.get(i));
				}
				resultList.add(address);
			}
			resultMap.put("resultList", resultList);
			resultMap.put("area", area);
			resultMap.put("return", "admin/statistics/address_day");
			return resultMap;
		}else if("address_month".equals(map.get("mode"))) {
			addressVo.setAddressCategory(2);
			map.put("addressVo", addressVo);
			List<AddressStatisticVo> resultList = new ArrayList<AddressStatisticVo>();
			List<AreaVo> areaAddress = new ArrayList<AreaVo>(); 
			areaAddress = statisticsDao.selectAreaPayment(map);
			List<AreaVo> area = statisticsDao.selectArea();
			for(int i = 0; i < areaAddress.size(); i++) {
				area.set(areaAddress.get(i).getAreaNo()-1, areaAddress.get(i));
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");			
			LocalDate startDateLocal = LocalDate.parse(search.getStart_date(), formatter);
			LocalDate endDateLocal = LocalDate.parse(search.getEnd_date(), formatter);					
			int numOfDaysBetween = (int) ChronoUnit.MONTHS.between(startDateLocal, endDateLocal.plusMonths(1));
			List<LocalDate> localDate = IntStream.iterate(0, i -> i + 1)
							        	.limit(numOfDaysBetween)
							        	.mapToObj(i -> startDateLocal.plusMonths(i))
							        	.collect(Collectors.toList());
			for(int i = 0; i < localDate.size(); i++) {
				map.put("date", localDate.get(i));
				AddressStatisticVo address = new AddressStatisticVo();
				try {
					address = statisticsDao.selectAddressStatistics2(map);
				} catch (Exception e) {	
					e.printStackTrace();
				}
				if(address == null) {
					address = new AddressStatisticVo();
					address.setPaidAt(localDate.get(i));
				}
				resultList.add(address);
			}
			resultMap.put("resultList", resultList);
			resultMap.put("area", area);
			resultMap.put("return", "admin/statistics/address_month");
			return resultMap;
		}else if("address_year".equals(map.get("mode"))) {
			addressVo.setAddressCategory(3);
			map.put("addressVo", addressVo);
			List<AddressStatisticVo> resultList = new ArrayList<AddressStatisticVo>();
			List<AreaVo> areaAddress = new ArrayList<AreaVo>(); 
			areaAddress = statisticsDao.selectAreaPayment(map);
			List<AreaVo> area = statisticsDao.selectArea();
			for(int i = 0; i < areaAddress.size(); i++) {
				area.set(areaAddress.get(i).getAreaNo()-1, areaAddress.get(i));
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");			
			LocalDate startDateLocal = LocalDate.parse(search.getStart_date(), formatter);
			LocalDate endDateLocal = LocalDate.parse(search.getEnd_date(), formatter);			
			int numOfDaysBetween = (int) ChronoUnit.YEARS.between(startDateLocal, endDateLocal.plusYears(1));		
			List<LocalDate> localDate = IntStream.iterate(0, i -> i + 1)
							        	.limit(numOfDaysBetween)
							        	.mapToObj(i -> startDateLocal.plusYears(i))
							        	.collect(Collectors.toList());	
			for(int i = 0; i < localDate.size(); i++) {
				map.put("date", localDate.get(i));
				AddressStatisticVo address = new AddressStatisticVo();
				try {
					address = statisticsDao.selectAddressStatistics2(map);
				} catch (Exception e) {				
					e.printStackTrace();
				}
				if(address == null) {
					address = new AddressStatisticVo();
					address.setPaidAt(localDate.get(i));
				}
				resultList.add(address);
			}
			resultMap.put("resultList", resultList);
			resultMap.put("area", area);
			resultMap.put("return", "admin/statistics/address_year");
			return resultMap;
		}
		return resultMap;
	}
	
	@Override
	public PeriodStatisticVo selectPeriodStatistics(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return statisticsDao.selectPeriodStatistics(param);
	}

	@Override
	public Map<String, Object> selectProductStatistics(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", statisticsDao.selectProductStatistics(map));
		resultMap.put("list2", categoryDao.selectProductCategory("product"));
		return resultMap;
	}
	
	public List<MemberStatisticVo> selectMemberStatisticsList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return statisticsDao.selectMemberStatisticsList(param);
	}

	@Override
	public BeforeYearStatisticVo selectBeforeStatisticsList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return statisticsDao.selectBeforeStatisticsList(param);
	}


	
	
}
