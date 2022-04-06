package com.naedam.mir9.category.model.service;

import java.util.List;
import java.util.Map;

import com.naedam.mir9.category.model.vo.Category;

public interface CategoryService {

	List<Category> selectProductCategory(String type);

	List<Category> selectProductCategoryChildByParentNo(int cteNo);

	List<Category> selectProductCategoryByLevel(int level);

	Category selectOneProductCategoryByCteNo(String cteNo);

	int updateProductCategoryByParam(Map<String, Object> param);

}
