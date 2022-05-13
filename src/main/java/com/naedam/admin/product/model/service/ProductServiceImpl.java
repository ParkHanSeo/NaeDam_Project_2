package com.naedam.admin.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naedam.admin.option.model.vo.ProductOptionDetail;
import com.naedam.admin.product.model.dao.ProductDao;
import com.naedam.admin.product.model.vo.Product;
import com.naedam.admin.product.model.vo.ProductDetail;
import com.naedam.admin.product.model.vo.ProductDiscription;
import com.naedam.admin.product.model.vo.ProductExcelForm;
import com.naedam.admin.product.model.vo.ProductImg;

@Service
public class ProductServiceImpl implements ProductService{
	@Autowired
	private ProductDao productDao;

	@Override
	public List<ProductDetail> selectAllProductList() {
		// TODO Auto-generated method stub
		return productDao.selectAllProductList();
	}

	@Override
	public List<ProductExcelForm> selectProductExcelForm() {
		// TODO Auto-generated method stub
		return productDao.selectProductExcelForm();
	}

	@Override
	public int deleteProductByProductNo(String productNo) {
		// TODO Auto-generated method stub
		return productDao.deleteProductByProductNo(productNo);
	}

	@Override
	public Product selectOneProductByProductNo(String productNo) {
		// TODO Auto-generated method stub
		return productDao.selectOneProductByProductNo(productNo);
	}

	@Override
	public List<ProductImg> selectProductImgsByProductNo(String productNo) {
		// TODO Auto-generated method stub
		return productDao.selectProductImgsByProductNo(productNo);
	}

	@Override
	public List<ProductOptionDetail> selectProductOptionDetailByOptionNo(int optionNo) {
		// TODO Auto-generated method stub
		return productDao.selectProductOptionDetailByOptionNo(optionNo);
	}

	@Override
	public List<ProductDiscription> selectProductDiscriptionByProductNo(String productNo) {
		// TODO Auto-generated method stub
		return productDao.selectProductDiscriptionByProductNo(productNo);
	}

	@Override
	public List<ProductDetail> selectProductListByCteNo(String cteNo) {
		// TODO Auto-generated method stub
		return productDao.selectProductListByCteNo(cteNo);
	}

	@Override
	public int updateProduct(Product product) {
		// TODO Auto-generated method stub
		return productDao.updateProduct(product);
	}

	@Override
	public int updateProductImg(ProductImg img) {
		// TODO Auto-generated method stub
		return productDao.updateProductImg(img);
	}

	@Override
	public int updateProductDiscription(ProductDiscription pd) {
		// TODO Auto-generated method stub
		return productDao.updateProductDiscription(pd);
	}

	@Override
	public int insertProduct(Product product) {
		// TODO Auto-generated method stub
		return productDao.insertProduct(product);
	}

	@Override
	public int insertProductImg(ProductImg img) {
		// TODO Auto-generated method stub
		return productDao.insertProductImg(img);
	}

	@Override
	public int insertProductDiscription(ProductDiscription pd) {
		// TODO Auto-generated method stub
		return productDao.insertProductDiscription(pd);
	}

	@Override
	public List<ProductDetail> selectProductListByParam(Map<String, String> param) {
		// TODO Auto-generated method stub
		return productDao.selectProductListByParam(param);
	}
	
	
	
	
}
