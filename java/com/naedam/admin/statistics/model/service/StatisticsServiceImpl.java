package com.naedam.admin.statistics.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		return resultMap;
	}

	@Override
	public AddressStatisticVo selectAddressStatistics(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub selectAddressStatistics
		return statisticsDao.selectAddressStatistics(map);
	}
	
	@Override
	public AddressStatisticVo selectAddressStatistics2(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub selectAddressStatistics
		return statisticsDao.selectAddressStatistics2(map);
	}

	@Override
	public List<AreaVo> selectAreaPayment(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return statisticsDao.selectAreaPayment(map);
	}

	@Override
	public List<AreaVo> selectArea() throws Exception {
		// TODO Auto-generated method stub
		return statisticsDao.selectArea();
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
