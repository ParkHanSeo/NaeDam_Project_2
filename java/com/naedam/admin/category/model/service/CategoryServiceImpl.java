package com.naedam.admin.category.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.category.model.dao.CategoryDao;
import com.naedam.admin.category.model.vo.Category;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	private CategoryDao categoryDao;

	@Override
	public List<Category> selectProductCategory(String type) {
		// TODO Auto-generated method stub
		return categoryDao.selectProductCategory(type);
	}

	@Override
	public List<Category> selectProductCategoryChildByParentNo(int cteNo) {
		// TODO Auto-generated method stub
		return categoryDao.selectProductCategoryChildByParentNo(cteNo);
	}

	@Override
	public List<Category> selectProductCategoryByLevel(int level) {
		// TODO Auto-generated method stub
		return categoryDao.selectProductCategoryByLevel(level);
	}

	@Override
	public Category selectOneProductCategoryByCteNo(String cteNo) {
		// TODO Auto-generated method stub
		return categoryDao.selectOneProductCategoryByCteNo(cteNo);
	}

	@Override
	public int updateProductCategoryByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return categoryDao.updateProductCategoryByParam(param);
	}

	@Override
	public int insertProductCategoryByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return categoryDao.insertProductCategoryByParam(param);
	}

	@Override
	public int deleteCategoryByCteNo(String cteNo) {
		// TODO Auto-generated method stub
		return categoryDao.deleteCategoryByCteNo(cteNo);
	}

	@Override
	public int selectCategoryLevel(String cteNo) {
		// TODO Auto-generated method stub
		return categoryDao.selectCategoryLevel(cteNo);
	}

	@Override
	public List<Category> selectRelatedCtegoryByCteNo(String cteNo) {
		// TODO Auto-generated method stub
		return categoryDao.selectRelatedCtegoryByCteNo(cteNo);
	}

	@Override
	public List<Category> selectCategoryNamesByCteLv(int level) {
		// TODO Auto-generated method stub
		return categoryDao.selectCategoryNamesByCteLv(level);
	}


	
	
	
	
	
}
