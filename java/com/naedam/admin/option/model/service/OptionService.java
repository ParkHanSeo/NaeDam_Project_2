package com.naedam.admin.option.model.service;

import java.util.List;
import java.util.Map;

import com.naedam.admin.option.model.vo.Option;
import com.naedam.admin.option.model.vo.OptionValue;
import com.naedam.admin.option.model.vo.ProductOption;
import com.naedam.admin.product.model.vo.ProductDetail;

public interface OptionService {

	int insertOption(Map<String, Object> param);

	int insertOptionValue(Map<String, Object> param);

	List<Option> selectOptionList();

	ProductOption selectOneProductOptionByoptionNo(int optionNo);

	List<OptionValue> selectOptionValueListByOptionNo(int optionNo);

	int updateOptionValue(OptionValue ov);

	int updateProductOption(ProductOption pOption);

	List<ProductDetail> selectProductDetailList();

}
