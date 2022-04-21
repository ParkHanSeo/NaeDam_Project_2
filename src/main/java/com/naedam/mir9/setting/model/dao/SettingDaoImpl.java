package com.naedam.mir9.setting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.mir9.banner.model.vo.Banner;
import com.naedam.mir9.category.model.vo.Category;
import com.naedam.mir9.coupon.model.vo.Coupon;
import com.naedam.mir9.delivery.model.vo.DeliveryCompany;
import com.naedam.mir9.delivery.model.vo.DeliveryNotice;
import com.naedam.mir9.delivery.model.vo.DeliverySetting;
import com.naedam.mir9.delivery.model.vo.Doseosangan;
import com.naedam.mir9.history.model.vo.History;
import com.naedam.mir9.map.model.vo.Maps;
import com.naedam.mir9.point.model.vo.Point;
import com.naedam.mir9.point.model.vo.PointSave;
import com.naedam.mir9.point.model.vo.PointUse;
import com.naedam.mir9.popup.model.vo.Popup;
import com.naedam.mir9.setting.model.vo.AdminMenu;
import com.naedam.mir9.setting.model.vo.AdminSetting;
import com.naedam.mir9.setting.model.vo.Locale;

@Repository
public class SettingDaoImpl implements SettingDao {
	@Autowired
	private SqlSession session;

	@Override
	public List<DeliveryCompany> selectDeliveryCompanyList() {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectDeliveryCompanyList");
	}

	@Override
	public DeliverySetting selectOneDeliverySetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectOneDeliverySetting");
	}

	@Override
	public List<Doseosangan> selectDoseosanganList() {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectDoseosanganList");
	}

	@Override
	public List<Maps> selectMapList() {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectMapList");
	}

	@Override
	public List<History> selectHistoryList() {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectHistoryList");
	}

	@Override
	public List<Banner> selectBannerList() {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectBannerList");
	}

	@Override
	public List<Category> selectMenuCteList() {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectMenuCteList");
	}

	@Override
	public List<Popup> selectPopupListByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectPopupList", param);
	}

	@Override
	public List<Coupon> selectCouponListByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectCouponListByParam", param);
	}

	@Override
	public Point selectPoint() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectPoint");
	}

	@Override
	public PointUse selectPointUse() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectPointUse");
	}

	@Override
	public PointSave selectPointSave() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectPointSave");
	}

	@Override
	public List<AdminMenu> selectAdminMenuList() {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectAdminMenuList");
	}

	@Override
	public List<Locale> selectLocaleList() {
		// TODO Auto-generated method stub
		return session.selectList("setting.selectLocaleList");
	}

	@Override
	public AdminSetting selectAdminSetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectAdminSetting");
	}

	@Override
	public DeliveryNotice selectOneDeliveryNotice(String locale) {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectOneDeliveryNotice", locale);
	}

	@Override
	public int updateAdminSetting(AdminSetting adminSetting) {
		// TODO Auto-generated method stub
		return session.update("setting.updateAdminSetting", adminSetting);
	}

	@Override
	public int updateDeliveryNotice(DeliveryNotice deliveryNotice) {
		// TODO Auto-generated method stub
		return session.update("setting.updateDeliveryNotice", deliveryNotice);
	}
	
	
	
}
