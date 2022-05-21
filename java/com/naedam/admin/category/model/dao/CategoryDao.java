package com.naedam.admin.category.model.dao;

import java.util.List;
import java.util.Map;

import com.naedam.admin.category.model.vo.Category;

public interface CategoryDao {

	List<Category> selectProductCategory(String type);

	List<Category> selectProductCategoryChildByParentNo(int cteNo);

	List<Category> selectProductCategoryByLevel(int level);

	Category selectOneProductCategoryByCteNo(String cteNo);

	int updateProductCategoryByParam(Map<String, Object> param);

	int insertProductCategoryByParam(Map<String, Object> param);

	int deleteCategoryByCteNo(String cteNo);

	int selectCategoryLevel(String cteNo);

	List<Category> selectRelatedCtegoryByCteNo(String cteNo);

	List<Category> selectCategoryNamesByCteLv(int level);


}
