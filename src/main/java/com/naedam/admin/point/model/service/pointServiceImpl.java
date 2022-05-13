package com.naedam.admin.point.model.service;

import java.util.List;

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
	public int updatePoint(Point point) {
		// TODO Auto-generated method stub
		return pointDao.updatePoint(point);
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
	public List<MemberPointExcelForm> selectMemberPointExcelForm() {
		// TODO Auto-generated method stub
		return pointDao.selectMemberPointExcelForm();
	}

	@Override
	public int insertMemberPoint(MemberPoint memberPoint) {
		// TODO Auto-generated method stub
		return pointDao.insertMemberPoint(memberPoint);
	}

	@Override
	public String selectPointName() {
		// TODO Auto-generated method stub
		return pointDao.selectPointName();
	}
	
	
}
