package com.naedam.admin.point.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.point.model.dao.PointDao;
import com.naedam.admin.point.model.vo.MemberPoint;
import com.naedam.admin.point.model.vo.MemberPointExcelForm;
import com.naedam.admin.point.model.vo.Point;
import com.naedam.admin.point.model.vo.PointSave;
import com.naedam.admin.point.model.vo.PointUse;

@Service
public class pointServiceImpl implements PointService {
	@Autowired
	private PointDao pointDao;

	@Override
	public Map<String, Object> updatePoint(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<>();
		pointDao.updatePoint((Point)map.get("point"));
		pointDao.updatePointSave((PointSave)map.get("pointSave"));
		pointDao.updatePointUse((PointUse)map.get("pointUse"));
		resultMap.put("msg", "적립금 정보가 변경되었습니다.");
		return resultMap;
	}

	@Override
	public int updatePointSave(PointSave pointSave) {
		// TODO Auto-generated method stub
		return pointDao.updatePointSave(pointSave);
	}

	@Override
	public int updatePointUse(PointUse pointUse) {
		// TODO Auto-generated method stub
		return pointDao.updatePointUse(pointUse);
	}

	@Override
	public List<MemberPointExcelForm> selectMemberPointExcelForm(String memberId) {
		// TODO Auto-generated method stub
		return pointDao.selectMemberPointExcelForm(memberId);
	}

	@Override
	public String selectPointName() {
		// TODO Auto-generated method stub
		return pointDao.selectPointName();
	}
	
	
}
