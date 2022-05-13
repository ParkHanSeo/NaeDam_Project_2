package com.naedam.admin.option.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.option.model.dao.OptionDao;
import com.naedam.admin.option.model.vo.Option;
import com.naedam.admin.option.model.vo.OptionValue;
import com.naedam.admin.option.model.vo.ProductOption;
import com.naedam.admin.product.model.vo.ProductDetail;

@Service

public class OptionServiceImpl implements OptionService {
	@Autowired
	private OptionDao optionDao;

	@Override
	public int insertOption(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return optionDao.insertOption(param);
	}

	@Override
	public int insertOptionValue(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return optionDao.insertOptionValue(param);
	}

	@Override
	public List<Option> selectOptionList() {
		// TODO Auto-generated method stub
		return optionDao.selectOptionList();
	}

	@Override
	public ProductOption selectOneProductOptionByoptionNo(int optionNo) {
		// TODO Auto-generated method stub
		return optionDao.selectOneProductOptionByoptionNo(optionNo);
	}

	@Override
	public List<OptionValue> selectOptionValueListByOptionNo(int optionNo) {
		// TODO Auto-generated method stub
		return optionDao.selectOptionValueListByOptionNo(optionNo);
	}

	@Override
	public int updateOptionValue(OptionValue ov) {
		// TODO Auto-generated method stub
		return optionDao.updateOptionValue(ov);
	}

	@Override
	public int updateProductOption(ProductOption pOption) {
		// TODO Auto-generated method stub
		return optionDao.updateProductOption(pOption);
	}

	@Override
	public List<ProductDetail> selectProductDetailList() {
		// TODO Auto-generated method stub
		return optionDao.selectProductDetailList();
	}
	
	
	
	
	
	
	
}
