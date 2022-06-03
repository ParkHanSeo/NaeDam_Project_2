package com.naedam.admin.delivery.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.delivery.model.dao.DeliveryDao;
import com.naedam.admin.delivery.model.vo.DeliveryCompany;
import com.naedam.admin.delivery.model.vo.DeliverySetting;
import com.naedam.admin.delivery.model.vo.Doseosangan;

@Service
public class DeliveryServiceImpl implements DeliveryService {
	@Autowired
	private DeliveryDao deliveryDao;

	@Override
	public int selectDoseosanganFeeByZipcode(int zipcode) {
		// TODO Auto-generated method stub
		return deliveryDao.selectDoseosanganFeeByZipcode(zipcode);
	}

	@Override
	public int insertDeliveryCompanyByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return deliveryDao.insertDeliveryCompanyByParam(param);
	}

	@Override
	public int deleteDeliveryCompanyByComNo(String comNo) {
		// TODO Auto-generated method stub
		return deliveryDao.deleteDeliveryCompanyByComNo(comNo);
	}

	@Override
	public DeliveryCompany selectOneDeliveryCompanyByComNo(String comNo) {
		// TODO Auto-generated method stub
		return deliveryDao.selectOneDeliveryCompanyByComNo(comNo);
	}

	@Override
	public int updateDeliveryCompanyByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return deliveryDao.updateDeliveryCompanyByParam(param);
	}

	@Override
	public List<DeliveryCompany> selectDeliveryCompanyListByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return deliveryDao.selectDeliveryCompanyListByParam(param);
	}

	@Override
	public int updateDeliverySettingByVo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		String basicFee = (String)param.get("delivery_price");
		String FreeShippingSettings = (String)param.get("delivery_limit");
		int result = 0;
		
		DeliverySetting deliSet = new DeliverySetting();
		deliSet.setBasicDeliveryFee(Integer.parseInt(basicFee.replace(",", "")));
		deliSet.setExtraDeliFeeYn((String) param.get("delivery_extra_cost_area"));
		deliSet.setFreeShippingSettings(Integer.parseInt(FreeShippingSettings.replace(",", "")));
		
		result = deliveryDao.updateDeliverySettingByVo(deliSet);
		
		
		ArrayList<String> doseoNoList = (ArrayList<String>) param.get("doseo_no");
		ArrayList<String> extraFeeList = (ArrayList<String>) param.get("extra_fee");
		
		for(int i = 0; i < doseoNoList.size(); i++) {
			Doseosangan doseo = new Doseosangan();
			doseo.setDoseoNo(Integer.parseInt(doseoNoList.get(i)));
			doseo.setExtraFee(Integer.parseInt(extraFeeList.get(i).replace(",", "")));
			
			result = deliveryDao.updateDoseosanganByVo(doseo);
		}
		return result;
	}

	@Override
	public int updateDoseosanganByVo(Doseosangan doseo) {
		// TODO Auto-generated method stub
		return deliveryDao.updateDoseosanganByVo(doseo);
	}
	
	
	
	
	
	
}
