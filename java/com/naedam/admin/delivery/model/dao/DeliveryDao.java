package com.naedam.admin.delivery.model.dao;

import java.util.List;
import java.util.Map;

import com.naedam.admin.delivery.model.vo.DeliveryCompany;
import com.naedam.admin.delivery.model.vo.DeliverySetting;
import com.naedam.admin.delivery.model.vo.Doseosangan;

public interface DeliveryDao {

	int selectDoseosanganFeeByZipcode(int zipcode);

	int insertDeliveryCompanyByParam(Map<String, Object> param);

	int deleteDeliveryCompanyByComNo(String comNo);

	DeliveryCompany selectOneDeliveryCompanyByComNo(String comNo);

	int updateDeliveryCompanyByParam(Map<String, Object> param);

	List<DeliveryCompany> selectDeliveryCompanyListByParam(Map<String, Object> param);

	int updateDeliverySettingByVo(DeliverySetting deliSet);

	int updateDoseosanganByVo(Doseosangan doseo);
	

}
