package com.naedam.mir9.setting.model.service;

import java.util.List;

import com.naedam.mir9.delivery.model.vo.DeliveryCompany;
import com.naedam.mir9.delivery.model.vo.DeliverySetting;
import com.naedam.mir9.delivery.model.vo.Doseosangan;
import com.naedam.mir9.map.model.vo.Maps;

public interface SettingService {

	List<DeliveryCompany> selectDeliveryCompanyList();

	DeliverySetting selectOneDeliverySetting();

	List<Doseosangan> selectDoseosanganList();

	List<Maps> selectMapList();

}
