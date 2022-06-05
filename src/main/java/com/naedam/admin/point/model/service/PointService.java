package com.naedam.admin.point.model.service;

import java.util.List;
import java.util.Map;

import com.naedam.admin.point.model.vo.MemberPoint;
import com.naedam.admin.point.model.vo.MemberPointExcelForm;
import com.naedam.admin.point.model.vo.Point;
import com.naedam.admin.point.model.vo.PointSave;
import com.naedam.admin.point.model.vo.PointUse;

public interface PointService {

	Map<String, Object> updatePoint(Map<String, Object> map);

	int updatePointSave(PointSave pointSave);

	int updatePointUse(PointUse pointUse);

	List<MemberPointExcelForm> selectMemberPointExcelForm(String memberId);

	String selectPointName();


}
