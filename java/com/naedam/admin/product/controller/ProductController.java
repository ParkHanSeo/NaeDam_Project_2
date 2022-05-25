package com.naedam.admin.product.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naedam.admin.category.model.service.CategoryService;
import com.naedam.admin.category.model.vo.Category;
import com.naedam.admin.option.model.service.OptionService;
import com.naedam.admin.option.model.vo.Option;
import com.naedam.admin.option.model.vo.ProductOptionDetail;
import com.naedam.admin.product.model.service.ProductService;
import com.naedam.admin.product.model.vo.Product;
import com.naedam.admin.product.model.vo.ProductDetail;
import com.naedam.admin.product.model.vo.ProductDiscription;
import com.naedam.admin.product.model.vo.ProductImg;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/product")
@Slf4j
public class ProductController {
	@Autowired
	private ProductService productService;
	@Autowired
	private OptionService optionService;
	@Autowired
	private CategoryService categoryService;
	
	@GetMapping("/list")
	public String productList() {
		
		return "admin/product/productList";
	}
	
	@GetMapping("/category")
	public String productCategory() {
		
		return "admin/product/productCategory";
	}
	
	@GetMapping("/option")
	public String productOption(Model model) {
		List<Option> optionList = optionService.selectOptionList();
		
		model.addAttribute("optionList", optionList);
		
		
		return "admin/product/option";
	}
	
	@GetMapping("/list_sub")
	public void list_sub(Model model, @RequestParam(defaultValue = "0") String cteNo, @RequestParam(defaultValue = "null") String bne_check, @RequestParam(defaultValue = "null") String v_status) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("cteNo", cteNo);
		param.put("bne", bne_check);
		param.put("v_status", v_status);
		param.put("keyword", "null");

		List<ProductDetail> productList = new ArrayList<ProductDetail>();
		
		productList = productService.selectProductListByParam(param);
		/*
		 * if(cteNo.equals("0")) { productList = productService.selectAllProductList();
		 * }else { productList = productService.selectProductListByCteNo(cteNo); }
		 */
		
		int productListCnt = productList.size();
		
		try {
			int level = categoryService.selectCategoryLevel(cteNo);
			model.addAttribute("level",level);
		} catch (Exception e) {}
		
		List<Category> cteList = categoryService.selectRelatedCtegoryByCteNo(cteNo);
		
		model.addAttribute("bne_check", bne_check);
		model.addAttribute("v_status", v_status);
		model.addAttribute("productList",productList);
		model.addAttribute("productListCnt",productListCnt);
		model.addAttribute("cteNo",cteNo);
		model.addAttribute("cteList",cteList);
		
	}
	
	@PostMapping("/list_sub")
	public String post_list_sub(Model model, HttpServletRequest request ,@RequestParam(defaultValue = "0") String cteNo, @RequestParam(defaultValue = "null") String bne_check, @RequestParam(defaultValue = "null") String v_status) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("cteNo", cteNo);
		param.put("bne", bne_check);
		param.put("v_status", request.getParameter("field"));
		param.put("keyword", request.getParameter("keyword"));
		
		
		List<ProductDetail> productList = new ArrayList<ProductDetail>();
		productList = productService.selectProductListByParam(param);
		
		int productListCnt = productList.size();
		
		try {
			int level = categoryService.selectCategoryLevel(cteNo);
			model.addAttribute("level",level);
		} catch (Exception e) {}
		
		List<Category> cteList = categoryService.selectRelatedCtegoryByCteNo(cteNo);
		
		model.addAttribute("bne_check", bne_check);
		model.addAttribute("v_status", request.getParameter("field"));
		model.addAttribute("productList",productList);
		model.addAttribute("productListCnt",productListCnt);
		model.addAttribute("cteNo",cteNo);
		model.addAttribute("keyword", request.getParameter("keyword"));
		model.addAttribute("cteList",cteList);
		return "admin/product/list_sub";
	}
	
	@GetMapping("/tree_model")
	public void tree_model(HttpServletRequest request,Model model, String stp) {
		StringBuilder sb = new StringBuilder();
		
		String type = "";
		StringBuffer url = request.getRequestURL();
		url.delete(url.indexOf("/tree"), url.indexOf("/tree")+11);
		
		if(stp.equals("pc")) {
			type = "product";
			url.append("/productCategory_sub?cteNo=");
		}else if(stp.equals("pl")) {
			type = "product";
			url.append("/list_sub?cteNo=");
		}
		
		List<Category> categoryList = categoryService.selectProductCategory(type);
		Boolean flag = false;
		sb.append("['Home', '" + url + "'\n");
		
		for(Category c1 : categoryList) {
			if(c1.getLevel() == 1) {
				sb.append(",['"+ c1.getCategoryName() + "','"+ url + c1.getCategoryNo() +"'" );
				for(Category c2 : categoryList) {
					if(c2.getLevel() == 2) {
						if(c1.getCategoryNo() == c2.getParentNo()) {
							sb.append(",\n\t['"+ c2.getCategoryName() + "','"+ url + c2.getCategoryNo() +"'");
							for(Category c3 : categoryList) {
								if(c3.getLevel() == 3) {
									if(c2.getCategoryNo() == c3.getParentNo()) {
										sb.append("\n\t\t,['"+ c3.getCategoryName() + "','"+ url + c3.getCategoryNo() +"&']" );
									}
								}
							}
							sb.append(",]\n");
							flag = true;
						}else {
							sb.append("]");
							flag = false;
							break;
						}
					}
				}
				if(flag) {
					sb.append(",]");					
				}
			}
			
		}
		sb.append(",]");
		
		String result = sb.toString();
		
		
		model.addAttribute("result",result);
		
	}
	
	@PostMapping("/delete")
	public String productDelete(HttpServletRequest request, RedirectAttributes redirectAttr) {
		List<String> productrNoList =  Arrays.asList(request.getParameterValues("list[]"));
		int result = 0;
		for(String productNo : productrNoList) {
			result = productService.deleteProductByProductNo(productNo);
		}
		
		if(result > 0) {
			redirectAttr.addFlashAttribute("msg", "삭제되었습니다.");
		}
		
		return "redirect:/admin/product/list";
	}
	
	@PostMapping("/fillForm")
	@ResponseBody
	public List<Object> fillForm(String productNo) {
		List<Object> productInfo = new ArrayList<Object>();
		Product product = productService.selectOneProductByProductNo(productNo);
		List<ProductImg> productImgs = productService.selectProductImgsByProductNo(productNo);
		List<ProductOptionDetail> option = productService.selectProductOptionDetailByOptionNo(product.getOptionNo());
		List<ProductDiscription> discriptions = productService.selectProductDiscriptionByProductNo(productNo);
		
		productInfo.add(product);
		productInfo.add(productImgs);
		productInfo.add(option);
		productInfo.add(discriptions);
		
		
		
		return productInfo;
	}
	
	@GetMapping("/productCategory_sub")
	public void productCategory_sub(@RequestParam(defaultValue = "0") int cteNo, Model model) {
		List<Category> cteList = new ArrayList<Category>(); 
		List<Category> relatedCteList = categoryService.selectRelatedCtegoryByCteNo(Integer.toString(cteNo));
		if(cteNo == 0) {
			cteList = categoryService.selectProductCategoryByLevel(1);
		}else {
			cteList = categoryService.selectProductCategoryChildByParentNo(cteNo);
		}
		
		model.addAttribute("cteList",cteList);
		model.addAttribute("parentNo",cteNo);
		model.addAttribute("relatedCteList",relatedCteList);
	}
	
	@PostMapping("/insert")
	public String insertProduct(HttpServletRequest request, RedirectAttributes redirectAttr) {
		Enumeration params = request.getParameterNames();
		while(params.hasMoreElements()) {
		  String name = (String) params.nextElement();
		  System.out.print(name + " : " + request.getParameter(name) + "     "); 
		}
		System.out.println();
		
		int result = 0;
		
		Product product = setProduct(request);
		result = productService.insertProduct(product);
		log.debug("product = {}", product);
		
		ProductDiscription brief = setDiscription("brief", product, request);
		ProductDiscription content = setDiscription("content", product, request);
		List<String> urlList = Arrays.asList(request.getParameterValues("url_file"));
		
		
		
		for(int i = 0; i < urlList.size(); i++) {
			ProductImg img = new ProductImg();
			
			try {
				img.setProductNo(product.getProductNo());
				img.setImgLevel(i+1);
				img.setImgUrl(urlList.get(i));
			} catch (Exception e) {}
			
			if(img.getImgUrl() != null) {
				result = productService.insertProductImg(img);
				
			}
		}
		
		result = productService.insertProductDiscription(brief);
		result = productService.insertProductDiscription(content);
		
		redirectAttr.addFlashAttribute("msg", "상품이 등록되었습니다.");
		
		return "redirect:/admin/product/list";
		
	}
	
	@PostMapping("/update")
	public String updateProduct(HttpServletRequest request, RedirectAttributes redirectAttr){
		Product product = setProduct(request);
		int result = productService.updateProduct(product);

		List<String> imgNoList = Arrays.asList(request.getParameterValues("no_file"));
		List<String> urlList = Arrays.asList(request.getParameterValues("url_file"));
		
		for(int i = 0; i < urlList.size(); i++) {
			ProductImg img = new ProductImg();
			
			try {
				img.setProductImgNo(Integer.parseInt(imgNoList.get(i)));
				img.setImgLevel(i+1);
				img.setImgUrl(urlList.get(i));
			} catch (Exception e) {}
			
			if(img.getImgUrl() != null) {
				result = productService.updateProductImg(img);
			}
		}
		
		ProductDiscription brief = setDiscription("brief", product, request);
		ProductDiscription content = setDiscription("content", product, request);
		
		result = productService.updateProductDiscription(brief);
		result = productService.updateProductDiscription(content);
		
		if(result > 0) redirectAttr.addFlashAttribute("msg", "제품정보가 수정되었습니다.");
		return "redirect:/product/list";
		
	}
	
	@PostMapping("/copy_product")
	public String copyProduct(HttpServletRequest request, RedirectAttributes redirectAttr) {
		Enumeration params = request.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +request.getParameter(name));
		}
		System.out.println("----------------------------");
		
		Product product = productService.selectOneProductByProductNo(request.getParameter("code"));
		product.setLangType(request.getParameter("product_locale"));
		int oldProductNo = product.getProductNo();
		int result = productService.insertProduct(product);
		int newProductNo = product.getProductNo();
		List<ProductImg> imgList = productService.selectProductImgsByProductNo(Integer.toString(oldProductNo));
		
		for(ProductImg img : imgList) {
			img.setProductNo(newProductNo);
			result = productService.insertProductImg(img);
		}
		
		redirectAttr.addFlashAttribute("msg", "제품이 복제되었습니다.");
		return "redirect:/admin/product/list";
	}
	
	private Product setProduct(HttpServletRequest request) {
		Product product = new Product();
		product.setProductNo(Integer.parseInt(request.getParameter("product_no")));
		product.setCategoryNo(Integer.parseInt(request.getParameter("category_select_box_2")));
		product.setOptionNo(Integer.parseInt(request.getParameter("option_no")));
		product.setIndividualPoint(Integer.parseInt(request.getParameter("point")));
		product.setLangType(request.getParameter("locale"));
		product.setListTitle(request.getParameter("list_title"));
		product.setModelName(request.getParameter("model"));
		product.setProductName(request.getParameter("title"));
		product.setRetailPrice(Integer.parseInt(request.getParameter("consumer_price").replace(",", "")));
		product.setSalePrice(Integer.parseInt(request.getParameter("sale_price").replace(",", "")));
		product.setStatus(request.getParameter("status"));
		
		
		
		product.setIsSoldOut(request.getParameter("is_sold_out"));
		product.setProductBest(request.getParameter("is_best"));
		product.setProductNew(request.getParameter("is_new"));
		product.setProductEvent(request.getParameter("is_event"));
		
		if(product.getIsSoldOut() == null) product.setIsSoldOut("N");
		if(product.getProductBest() == null) product.setProductBest("N");
		if(product.getProductNew() == null) product.setProductNew("N");
		if(product.getProductEvent() == null) product.setProductEvent("N");
		
		return product;
	}
	
	private ProductDiscription setDiscription(String type, Product product ,HttpServletRequest request) {
		ProductDiscription pd = new ProductDiscription();

		switch(type) {
		
		case "brief" :	
			pd.setDiscriptionLevel(1);
			pd.setContent(request.getParameter("brief"));
			pd.setProductNo(product.getProductNo());
			break;
			
		case "content" :
			pd.setDiscriptionLevel(2);
			pd.setContent(request.getParameter("content"));
			pd.setProductNo(product.getProductNo());
			break;
		}
				
		return pd;
	}

	
	@GetMapping("/img_test")
	public void imgtest() {}
	
}
