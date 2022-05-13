package com.naedam.admin.setting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.banner.model.vo.Banner;
import com.naedam.admin.category.model.vo.Category;
import com.naedam.admin.coupon.model.vo.Coupon;
import com.naedam.admin.delivery.model.vo.DeliveryCompany;
import com.naedam.admin.delivery.model.vo.DeliveryNotice;
import com.naedam.admin.delivery.model.vo.DeliverySetting;
import com.naedam.admin.delivery.model.vo.Doseosangan;
import com.naedam.admin.history.model.vo.History;
import com.naedam.admin.map.model.vo.Maps;
import com.naedam.admin.point.model.vo.Point;
import com.naedam.admin.point.model.vo.PointSave;
import com.naedam.admin.point.model.vo.PointUse;
import com.naedam.admin.popup.model.vo.Popup;
import com.naedam.admin.setting.model.vo.AdminMenu;
import com.naedam.admin.setting.model.vo.AdminSetting;
import com.naedam.admin.setting.model.vo.Locale;
import com.naedam.admin.setting.model.vo.SeoSetting;
import com.naedam.admin.setting.model.vo.SnsSetting;
import com.naedam.admin.setting.model.vo.Staff;
import com.naedam.admin.setting.model.vo.PGs.BillingPgSetting;
import com.naedam.admin.setting.model.vo.PGs.EximbaySetting;
import com.naedam.admin.setting.model.vo.PGs.KcpSetting;
import com.naedam.admin.setting.model.vo.PGs.KgIniSetting;
import com.naedam.admin.setting.model.vo.PGs.NaverShoppingSetting;
import com.naedam.admin.setting.model.vo.PGs.NaverpaySetting;
import com.naedam.admin.setting.model.vo.PGs.XpaySetting;


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

	@Override
	public int updateAdminMenu(String menuNo) {
		// TODO Auto-generated method stub
		return session.update("setting.updateAdminMenu", menuNo);
	}

	@Override
	public int updateAdminMenuAllN() {
		// TODO Auto-generated method stub
		return session.update("setting.updateAdminMenuAllN");
	}

	@Override
	public int updateLocaleAllN() {
		// TODO Auto-generated method stub
		return session.update("setting.updateLocaleAllN");
	}

	@Override
	public int updateLocaleChoosen(String localeCode) {
		// TODO Auto-generated method stub
		return session.update("setting.updateLocaleChoosen", localeCode);
	}

	@Override
	public int updateLocaleDefault(String localeCode) {
		// TODO Auto-generated method stub
		return session.update("setting.updateLocaleDefault", localeCode);
	}

	@Override
	public SeoSetting selectSeoSetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectSeoSetting");
	}

	@Override
	public int updateSeoSetting(SeoSetting seo) {
		// TODO Auto-generated method stub
		return session.update("setting.updateSeoSetting", seo);
	}
	
	public BillingPgSetting selectPgSetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectPgSetting");
	}

	@Override
	public KgIniSetting selectKgIniSetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectKgIniSetting");
	}

	@Override
	public EximbaySetting selectEximbaySetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectEximbaySetting");
	}

	@Override
	public NaverShoppingSetting selectNaverShoppingSetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectNaverShoppingSetting");
	}

	@Override
	public NaverpaySetting selectNaverpaySetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectNaverpaySetting");
	}

	@Override
	public XpaySetting selectXpaySetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectXpaySetting");
	}

	@Override
	public KcpSetting selectKcpSetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectKcpSetting");
	}

	@Override
	public int updateKgIniSetting(KgIniSetting kg) {
		// TODO Auto-generated method stub
		return session.update("setting.updateKgIniSetting", kg);
	}

	@Override
	public int updateXpaySetting(XpaySetting xpay) {
		// TODO Auto-generated method stub
		return session.update("setting.updateXpaySetting", xpay);
	}

	@Override
	public int updateKcpSetting(KcpSetting kcp) {
		// TODO Auto-generated method stub
		return session.update("setting.updateKcpSetting", kcp);
	}

	@Override
	public int updateBillingPgSetting(BillingPgSetting pg) {
		// TODO Auto-generated method stub
		return session.update("setting.updateBillingPgSetting", pg);
	}

	@Override
	public int updateNaverpaySetting(NaverpaySetting naverpay) {
		// TODO Auto-generated method stub
		return session.update("setting.updateNaverpaySetting", naverpay);
	}

	@Override
	public int updateNaverShoppingSetting(NaverShoppingSetting naverShopping) {
		// TODO Auto-generated method stub
		return session.update("setting.updateNaverShoppingSetting", naverShopping);
	}
	
	@Override
	public SnsSetting selectSnsSetting() {
		// TODO Auto-generated method stub
		return session.selectOne("setting.selectSnsSetting");
	}

	@Override
	public int updateSnsSetting(SnsSetting snsSetting) {
		// TODO Auto-generated method stub
		return session.update("setting.updateSnsSetting", snsSetting);
	}
	
	public int insertStaff(Staff staff) {
		return session.insert("setting.insertStaff", staff);
	}

	@Override
	public List<Staff> selectStaffList() {
		return session.selectList("setting.selectStaffList");
	}

	@Override
	public int totalStaffListCount() {
		return session.selectOne("setting.totalStaffListCount");
	}

	@Override
	public int deleteStaff(int[] staffNo) {
		return session.delete("setting.deleteStaff", staffNo);
	}

	@Override
	public List<Staff> searchStaffList(Map<String, Object> param) {
		return session.selectList("setting.searchStaffList", param);
	}

	@Override
	public int selectsearchStaffListCount(Map<String, Object> param) {
		return session.selectOne("setting.selectsearchStaffListCount", param);
	}

	@Override
	public Staff selectOneStaffByStaffNo(int staffNo) {
		return session.selectOne("setting.selectOneStaffByStaffNo", staffNo);
	}

	@Override
	public Staff selectOneimgUrlBystaffNo(int staffNo) {
		return session.selectOne("setting.selectOneimgUrlBystaffNo", staffNo);
	}

	@Override
	public int deleteStaffImg(int staffNo) {
		return session.update("setting.deleteStaffImg", staffNo);
	}

	@Override
	public int updateStaff(Staff staff) {
		return session.update("setting.updateStaff", staff);
	}



	@Override
	public int updateChangeOrderDown(int staffNo) {
		return session.update("setting.updateChangeOrderDown", staffNo);
	}


	@Override
	public Staff selectMaxOrder() {
		return session.selectOne("setting.selectMaxOrder");
	}

	@Override
	public int updateChangeOrderUp(Staff paramStaff) {
		return session.update("setting.updateChangeOrderUp", paramStaff);
	}

	@Override
	public int updateChangeOrderUpNext(Staff paramStaff) {
		return session.update("setting.updateChangeOrderUpNext", paramStaff);
	}

	@Override
	public Staff selectInputRowOrder(Staff paramStaff) {
		return session.selectOne("setting.selectInputRowOrder", paramStaff);
	}

	@Override
	public Staff selectMinOrder() {
		return session.selectOne("setting.selectMinOrder");
	}

	@Override
	public int updateChangeOrderDown(Staff paramStaff) {
		return session.update("setting.updateChangeOrderDown", paramStaff);
	}

	@Override
	public int updateChangeOrderDownNext(Staff paramStaff) {
		return session.update("setting.updateChangeOrderDownNext", paramStaff);
	}

	



	
	
	
}
