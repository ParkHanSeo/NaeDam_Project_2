package com.naedam.admin.statistics.model.service;

import java.util.List;
import java.util.Map;

import com.naedam.admin.board.model.vo.Search;
import com.naedam.admin.statistics.model.vo.AddressStatisticVo;
import com.naedam.admin.statistics.model.vo.AreaVo;
import com.naedam.admin.statistics.model.vo.BeforeYearStatisticVo;
import com.naedam.admin.statistics.model.vo.MemberStatisticVo;
import com.naedam.admin.statistics.model.vo.PeriodStatisticVo;

public interface StatisticsService {

	Map<String, Object> statisticsAddress(Map<String, Object> map) throws Exception;
	
	PeriodStatisticVo selectPeriodStatistics(Map<String, Object> param);
	
	Map<String, Object> selectProductStatistics(Map<String, Object> map) throws Exception;

	List<MemberStatisticVo> selectMemberStatisticsList(Map<String, Object> param);

	BeforeYearStatisticVo selectBeforeStatisticsList(Map<String, Object> param);
}
