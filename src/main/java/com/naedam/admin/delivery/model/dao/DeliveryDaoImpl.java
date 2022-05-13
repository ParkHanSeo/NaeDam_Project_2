package com.naedam.admin.delivery.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.delivery.model.vo.DeliveryCompany;
import com.naedam.admin.delivery.model.vo.DeliverySetting;
import com.naedam.admin.delivery.model.vo.Doseosangan;

@Repository
public class DeliveryDaoImpl implements DeliveryDao {
	@Autowired
	private SqlSession session;

	@Override
	public int selectDoseosanganFeeByZipcode(int zipcode) {
		// TODO Auto-generated method stub
		int result = 0;
		if(session.selectOne("delivery.selectDoseosanganFeeByZipcode",zipcode) != null) {
			result = session.selectOne("delivery.selectDoseosanganFeeByZipcode",zipcode);
		}
		
		return result;
	}

	@Override
	public int insertDeliveryCompanyByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.insert("delivery.insertDeliveryCompanyByParam", param);
	}

	@Override
	public int deleteDeliveryCompanyByComNo(String comNo) {
		// TODO Auto-generated method stub
		return session.delete("delivery.deleteDeliveryCompanyByComNo", comNo);
	}

	@Override
	public DeliveryCompany selectOneDeliveryCompanyByComNo(String comNo) {
		// TODO Auto-generated method stub
		return session.selectOne("delivery.selectOneDeliveryCompanyByComNo", comNo);
	}

	@Override
	public int updateDeliveryCompanyByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.update("delivery.updateDeliveryCompanyByParam", param);
	}

	@Override
	public List<DeliveryCompany> selectDeliveryCompanyListByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.selectList("delivery.selectDeliveryCompanyListByParam", param);
	}

	@Override
	public int updateDeliverySettingByVo(DeliverySetting deliSet) {
		// TODO Auto-generated method stub
		return session.update("delivery.updateDeliverySettingByVo", deliSet);
	}

	@Override
	public int updateDoseosanganByVo(Doseosangan doseo) {
		// TODO Auto-generated method stub
		return session.update("delivery.updateDoseosanganByVo", doseo);
	}
	
	
	
	
}
