package com.naedam.mir9.setting.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.mir9.banner.model.vo.Banner;
import com.naedam.mir9.category.model.vo.Category;
import com.naedam.mir9.delivery.model.vo.DeliveryCompany;
import com.naedam.mir9.delivery.model.vo.DeliverySetting;
import com.naedam.mir9.delivery.model.vo.Doseosangan;
import com.naedam.mir9.history.model.vo.History;
import com.naedam.mir9.map.model.vo.Maps;
import com.naedam.mir9.popup.model.vo.Popup;
import com.naedam.mir9.setting.model.dao.SettingDao;

@Service
public class SettingServiceImpl implements SettingService {
	@Autowired
	public SettingDao settingDao;

	@Override
	public List<DeliveryCompany> selectDeliveryCompanyList() {
		// TODO Auto-generated method stub
		return settingDao.selectDeliveryCompanyList();
	}

	@Override
	public DeliverySetting selectOneDeliverySetting() {
		// TODO Auto-generated method stub
		return settingDao.selectOneDeliverySetting();
	}

	@Override
	public List<Doseosangan> selectDoseosanganList() {
		// TODO Auto-generated method stub
		return settingDao.selectDoseosanganList();
	}

	@Override
	public List<Maps> selectMapList() {
		// TODO Auto-generated method stub
		return settingDao.selectMapList();
	}

	@Override
	public List<History> selectHistoryList() {
		// TODO Auto-generated method stub
		return settingDao.selectHistoryList();
	}

	@Override
	public List<Banner> selectBannerList() {
		// TODO Auto-generated method stub
		return settingDao.selectBannerList();
	}

	@Override
	public List<Category> selectMenuCteList() {
		// TODO Auto-generated method stub
		return settingDao.selectMenuCteList();
	}

	@Override
	public List<Popup> selectPopupList() {
		// TODO Auto-generated method stub
		return settingDao.selectPopupList();
	}
	
	
	
	
}
