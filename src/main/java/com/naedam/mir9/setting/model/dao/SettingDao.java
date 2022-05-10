package com.naedam.mir9.setting.model.dao;

import java.util.List;
import java.util.Map;

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
import com.naedam.mir9.setting.model.vo.Attachment;
import com.naedam.mir9.setting.model.vo.Locale;
import com.naedam.mir9.setting.model.vo.SeoSetting;
import com.naedam.mir9.setting.model.vo.SnsSetting;
import com.naedam.mir9.setting.model.vo.Staff;
import com.naedam.mir9.setting.model.vo.PGs.BillingPgSetting;
import com.naedam.mir9.setting.model.vo.PGs.EximbaySetting;
import com.naedam.mir9.setting.model.vo.PGs.KcpSetting;
import com.naedam.mir9.setting.model.vo.PGs.KgIniSetting;
import com.naedam.mir9.setting.model.vo.PGs.NaverShoppingSetting;
import com.naedam.mir9.setting.model.vo.PGs.NaverpaySetting;
import com.naedam.mir9.setting.model.vo.PGs.XpaySetting;

public interface SettingDao {

	List<DeliveryCompany> selectDeliveryCompanyList();

	DeliverySetting selectOneDeliverySetting();

	List<Doseosangan> selectDoseosanganList();

	List<Maps> selectMapList();

	List<History> selectHistoryList();

	List<Banner> selectBannerList();

	List<Category> selectMenuCteList();

	List<Popup> selectPopupListByParam(Map<String, Object> param);

	List<Coupon> selectCouponListByParam(Map<String, Object> param);

	Point selectPoint();

	PointUse selectPointUse();

	PointSave selectPointSave();

	List<AdminMenu> selectAdminMenuList();

	List<Locale> selectLocaleList();

	AdminSetting selectAdminSetting();

	DeliveryNotice selectOneDeliveryNotice(String locale);

	int updateAdminSetting(AdminSetting adminSetting);

	int updateDeliveryNotice(DeliveryNotice deliveryNotice);

	int updateAdminMenu(String menuNo);

	int updateAdminMenuAllN();

	int updateLocaleAllN();

	int updateLocaleChoosen(String localeCode);

	int updateLocaleDefault(String localeCode);

	SeoSetting selectSeoSetting();

	int updateSeoSetting(SeoSetting seo);

	BillingPgSetting selectPgSetting();

	KgIniSetting selectKgIniSetting();

	EximbaySetting selectEximbaySetting();

	NaverShoppingSetting selectNaverShoppingSetting();

	NaverpaySetting selectNaverpaySetting();

	XpaySetting selectXpaySetting();

	KcpSetting selectKcpSetting();
	
	SnsSetting selectSnsSetting();
	
	int updateSnsSetting(SnsSetting snsSetting);

	int insertStaff(Staff staff);

	List<Staff> selectStaffList();

	int totalStaffListCount();

	int deleteStaff(int[] staffNo);

	List<Staff> searchStaffList(Map<String, Object> param);

	int selectsearchStaffListCount(Map<String, Object> param);

	int updateKgIniSetting(KgIniSetting kg);

	int updateXpaySetting(XpaySetting xpay);

	int updateKcpSetting(KcpSetting kcp);

	int updateBillingPgSetting(BillingPgSetting pg);

	int updateNaverpaySetting(NaverpaySetting naverpay);

	int updateNaverShoppingSetting(NaverShoppingSetting naverShopping);

	Staff selectOneStaffByStaffNo(int staffNo);

	Staff selectOneimgUrlBystaffNo(int staffNo);

	int deleteStaffImg(int staffNo);

	int updateStaff(Staff staff);

	int updateChangeOrder(int rowOrder);


}
