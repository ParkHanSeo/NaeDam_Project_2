package com.naedam.admin.category.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.category.model.vo.Category;

@Repository
public class CategoryDaoImpl implements CategoryDao {
	@Autowired
	private SqlSession session;

	@Override
	public List<Category> selectProductCategory(String type) {
		// TODO Auto-generated method stub
		return session.selectList("category.selectProductCategory", type);
	}

	@Override
	public List<Category> selectProductCategoryChildByParentNo(int cteNo) {
		// TODO Auto-generated method stub
		return session.selectList("category.selectProductCategoryChildByParentNo", cteNo);
	}

	@Override
	public List<Category> selectProductCategoryByLevel(int level) {
		// TODO Auto-generated method stub
		return session.selectList("category.selectProductCategoryByLevel", level);
	}

	@Override
	public Category selectOneProductCategoryByCteNo(String cteNo) {
		// TODO Auto-generated method stub
		return session.selectOne("category.selectOneProductCategoryByCteNo",cteNo);
	}

	@Override
	public int updateProductCategoryByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.update("category.updateProductCategoryByParam", param);
	}

	@Override
	public int insertProductCategoryByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.insert("category.insertProductCategoryByParam", param);
	}

	@Override
	public int deleteCategoryByCteNo(String cteNo) {
		// TODO Auto-generated method stub
		return session.delete("category.deleteCategoryByCteNo", cteNo);
	}

	@Override
	public int selectCategoryLevel(String cteNo) {
		// TODO Auto-generated method stub
		return session.selectOne("category.selectCategoryLevel",cteNo);
	}

	@Override
	public List<Category> selectRelatedCtegoryByCteNo(String cteNo) {
		// TODO Auto-generated method stub
		return session.selectList("category.selectRelatedCtegoryByCteNo",cteNo);
	}

	@Override
	public List<Category> selectCategoryNamesByCteLv(int level) {
		// TODO Auto-generated method stub
		return session.selectList("category.selectCategoryNamesByCteLv",level);
	}


	
	
}
