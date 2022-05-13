package com.naedam.admin.point.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.point.model.vo.MemberPoint;
import com.naedam.admin.point.model.vo.MemberPointExcelForm;
import com.naedam.admin.point.model.vo.Point;
import com.naedam.admin.point.model.vo.PointSave;
import com.naedam.admin.point.model.vo.PointUse;

@Repository
public class PointDaoImpl implements PointDao {
	@Autowired
	private SqlSession session;

	@Override
	public int updatePoint(Point point) {
		// TODO Auto-generated method stub
		return session.update("point.updatePoint", point);
	}

	@Override
	public int updatePointSave(PointSave pointSave) {
		// TODO Auto-generated method stub
		return session.update("point.updatePointSave", pointSave);
	}

	@Override
	public int updatePointUse(PointUse pointUse) {
		// TODO Auto-generated method stub
		return session.update("point.updatePointUse", pointUse);
	}

	@Override
	public List<MemberPointExcelForm> selectMemberPointExcelForm() {
		// TODO Auto-generated method stub
		return session.selectList("point.selectMemberPointExcelForm");
	}

	@Override
	public int insertMemberPoint(MemberPoint memberPoint) {
		// TODO Auto-generated method stub
		return session.insert("point.insertMemberPoint", memberPoint);
	}

	@Override
	public String selectPointName() {
		// TODO Auto-generated method stub
		return session.selectOne("point.selectPointName");
	}
	
	
	
}
