package com.naedam.admin.point.model.service;

import java.util.List;

import com.naedam.admin.member.model.vo.MemberListExcelForm;
import com.naedam.admin.point.model.vo.MemberPoint;
import com.naedam.admin.point.model.vo.MemberPointExcelForm;
import com.naedam.admin.point.model.vo.Point;
import com.naedam.admin.point.model.vo.PointSave;
import com.naedam.admin.point.model.vo.PointUse;

public interface PointService {

	int updatePoint(Point point);

	int updatePointSave(PointSave pointSave);

	int updatePointUse(PointUse pointUse);

	List<MemberPointExcelForm> selectMemberPointExcelForm();

	int insertMemberPoint(MemberPoint memberPoint);

	String selectPointName();


}
