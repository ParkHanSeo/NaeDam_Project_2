package com.naedam.admin.product.model.service;

import java.util.List;
import java.util.Map;

import com.naedam.admin.option.model.vo.ProductOptionDetail;
import com.naedam.admin.product.model.vo.Product;
import com.naedam.admin.product.model.vo.ProductDetail;
import com.naedam.admin.product.model.vo.ProductDiscription;
import com.naedam.admin.product.model.vo.ProductExcelForm;
import com.naedam.admin.product.model.vo.ProductImg;

public interface ProductService {

	List<ProductDetail> selectAllProductList();

	List<ProductExcelForm> selectProductExcelForm();

	int deleteProductByProductNo(String productNo);

	Product selectOneProductByProductNo(String productNo);

	List<ProductImg> selectProductImgsByProductNo(String productNo);

	List<ProductOptionDetail> selectProductOptionDetailByOptionNo(int optionNo);

	List<ProductDiscription> selectProductDiscriptionByProductNo(String productNo);

	List<ProductDetail> selectProductListByCteNo(String cteNo);

	int updateProduct(Product product);

	int updateProductImg(ProductImg img);

	int updateProductDiscription(ProductDiscription pd);

	int insertProduct(Product product);

	int insertProductImg(ProductImg img);

	int insertProductDiscription(ProductDiscription brief);

	List<ProductDetail> selectProductListByParam(Map<String, String> param);

}
