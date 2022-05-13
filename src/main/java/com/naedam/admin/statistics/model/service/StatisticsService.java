package com.naedam.admin.statistics.model.service;

import java.util.List;
import java.util.Map;

import com.naedam.admin.statistics.model.vo.AddressStatisticVo;
import com.naedam.admin.statistics.model.vo.AreaVo;
import com.naedam.admin.statistics.model.vo.BeforeYearStatisticVo;
import com.naedam.admin.statistics.model.vo.MemberStatisticVo;
import com.naedam.admin.statistics.model.vo.PeriodStatisticVo;

public interface StatisticsService {

	PeriodStatisticVo selectPeriodStatistics(Map<String, Object> param);
	
	Map<String, Object> selectProductStatistics(Map<String, Object> map) throws Exception;
	
	AddressStatisticVo selectAddressStatistics(Map<String, Object> map) throws Exception;
	
	AddressStatisticVo selectAddressStatistics2(Map<String, Object> map) throws Exception;
	
	List<AreaVo> selectAreaPayment(Map<String, Object> map) throws Exception;
	
	List<AreaVo> selectArea() throws Exception;

	List<MemberStatisticVo> selectMemberStatisticsList(Map<String, Object> param);

	BeforeYearStatisticVo selectBeforeStatisticsList(Map<String, Object> param);
}
