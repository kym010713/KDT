package com.kdt.project.seller.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdt.project.seller.model.ProductModel;
import com.kdt.project.seller.dao.ProductDao;
import com.kdt.project.seller.dao.ProductDetailDao;
import com.kdt.project.seller.dao.CategoryDao;
import com.kdt.project.seller.model.ProductDetailModel;

@Controller
public class ProductController {

    @Autowired
    private ProductDao productDao;
    
    @Autowired
    private ProductDetailDao productDetailDao;
    
    @Autowired
    private CategoryDao categoryDao;

    // 상품 등록 폼 
    @GetMapping("/seller/productInsert")
    public String productInsertForm(Model model) {
        try {
            List<String> categories = categoryDao.getAllTopCategories();
            model.addAttribute("categories", categories);
        } catch (Exception e) {
            // DB에서 카테고리를 못 가져올 경우 기본값 사용
            List<String> categories = List.of("상의", "하의", "아우터", "신발", "액세서리");
            model.addAttribute("categories", categories);
            model.addAttribute("error", "카테고리 목록을 불러오는데 실패했습니다.");
        }
        return "seller/productInsert";
    }
    
    // 상품 등록 처리
    @PostMapping("/seller/productInsert")
    public String insertProduct(ProductModel product, Model model) {
        try {
            // 카테고리 유효성 검사
            if (!categoryDao.categoryExists(product.getCategory())) {
                model.addAttribute("message", "유효하지 않은 카테고리입니다.");
                model.addAttribute("isSuccess", false);
                model.addAttribute("categories", categoryDao.getAllTopCategories());
                return "seller/productInsert";
            }
            
            if (product.getProductPhoto() == null || product.getProductPhoto().trim().isEmpty()) {
                product.setProductPhoto(null);
            }
            
            int result = productDao.insertProduct(product);
            if (result > 0) {
                model.addAttribute("message", "상품이 성공적으로 등록되었습니다!");
                model.addAttribute("isSuccess", true);
            } else {
                model.addAttribute("message", "상품 등록에 실패했습니다.");
                model.addAttribute("isSuccess", false);
            }
        } catch (Exception e) {
            String errorMessage = "오류가 발생했습니다: ";
            if (e.getMessage().contains("ORA-00001")) {
                errorMessage += "이미 존재하는 상품 ID 또는 상품명입니다.";
            } else {
                errorMessage += e.getMessage();
            }
            model.addAttribute("message", errorMessage);
            model.addAttribute("isSuccess", false);
        }
        
        // 다시 카테고리 목록 전달
        try {
            model.addAttribute("categories", categoryDao.getAllTopCategories());
        } catch (Exception e) {
            // 카테고리 로드 실패 시에도 페이지는 보여줌
            model.addAttribute("categories", List.of("상의", "하의", "아우터", "신발", "액세서리"));
        }
        
        return "seller/productInsert";
    }
    
    // 상품 목록 조회
    @GetMapping("/seller/productList")
    public String productList(Model model) {
        try {
            List<ProductModel> products = productDao.getAllProducts();
            List<ProductDetailModel> details = productDetailDao.getAllProductDetails();
            List<String> categories = categoryDao.getAllTopCategories();
            
            model.addAttribute("products", products);
            model.addAttribute("details", details);
            model.addAttribute("categories", categories);
        } catch (Exception e) {
            model.addAttribute("error", "데이터를 불러오는데 실패했습니다: " + e.getMessage());
        }
        return "seller/productList";
    }
    
    // 상품 수정 폼
    @GetMapping("/seller/productEdit")
    public String editForm(@RequestParam("productId") String productId, Model model) {
        try {
            ProductModel product = productDao.getProductById(productId);
            List<String> categories = categoryDao.getAllTopCategories();
            
            if (product != null) {
                model.addAttribute("product", product);
                model.addAttribute("categories", categories);
                return "seller/productEdit";
            } else {
                model.addAttribute("error", "상품을 찾을 수 없습니다.");
                return "redirect:/seller/productList";
            }
        } catch (Exception e) {
            model.addAttribute("error", "상품 정보를 불러오는데 실패했습니다.");
            return "redirect:/seller/productList";
        }
    }
    
    // 상품 수정 처리
    @PostMapping("/seller/productEdit")
    public String updateProduct(ProductModel product, Model model) {
        try {
            // 카테고리 유효성 검사
            if (!categoryDao.categoryExists(product.getCategory())) {
                model.addAttribute("message", "유효하지 않은 카테고리입니다.");
                model.addAttribute("isSuccess", false);
                model.addAttribute("product", product);
                model.addAttribute("categories", categoryDao.getAllTopCategories());
                return "seller/productEdit";
            }
            
            if (product.getProductPhoto() == null || product.getProductPhoto().trim().isEmpty()) {
                product.setProductPhoto(null);
            }
            
            int result = productDao.updateProduct(product);
            if (result > 0) {
                model.addAttribute("message", "상품이 성공적으로 수정되었습니다!");
                model.addAttribute("isSuccess", true);
            } else {
                model.addAttribute("message", "상품 수정에 실패했습니다.");
                model.addAttribute("isSuccess", false);
            }
            model.addAttribute("product", product);
            model.addAttribute("categories", categoryDao.getAllTopCategories());
        } catch (Exception e) {
            model.addAttribute("message", "오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("isSuccess", false);
            model.addAttribute("product", product);
            try {
                model.addAttribute("categories", categoryDao.getAllTopCategories());
            } catch (Exception ex) {
                model.addAttribute("categories", List.of("상의", "하의", "아우터", "신발", "액세서리"));
            }
        }
        return "seller/productEdit";
    }
    
    // 상품 삭제 처리
    @PostMapping("/seller/productDelete")
    public String deleteProduct(@RequestParam("productId") String productId, Model model) {
        try {
            int result = productDao.deleteProduct(productId);
            if (result > 0) {
                model.addAttribute("message", "상품이 성공적으로 삭제되었습니다!");
            } else {
                model.addAttribute("error", "상품 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("error", "오류가 발생했습니다: " + e.getMessage());
        }
        return "redirect:/seller/productList";
    }
    
    // 상품 상세 정보 등록 폼
    @GetMapping("/seller/productDetailInsert")
    public String productDetailForm(@RequestParam("productName") String productName, Model model) {
        model.addAttribute("productName", productName);
        return "seller/productDetailInsert";
    }
    
    // 상품 상세 정보 등록 처리
    @PostMapping("/seller/productDetailInsert")
    public String insertProductDetail(ProductDetailModel detail, Model model) {
        try {
            int result = productDetailDao.insertProductDetail(detail);
            if (result > 0) {
                model.addAttribute("message", "상품 상세 정보가 성공적으로 등록되었습니다!");
                model.addAttribute("isSuccess", true);
            } else {
                model.addAttribute("message", "상품 상세 정보 등록에 실패했습니다.");
                model.addAttribute("isSuccess", false);
            }
        } catch (Exception e) {
            model.addAttribute("message", "오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("isSuccess", false);
        }
        model.addAttribute("productName", detail.getProductName());
        return "seller/productDetailInsert";
    }
    
    // 상품 상세 정보 목록
    @GetMapping("/seller/productDetailList")
    public String productDetailList(Model model) {
        try {
            List<ProductDetailModel> details = productDetailDao.getAllProductDetails();
            model.addAttribute("details", details);
        } catch (Exception e) {
            model.addAttribute("error", "상품 상세 정보를 불러오는데 실패했습니다.");
        }
        return "seller/productDetailList";
    }
    
    // 상품 상세 정보 수정 처리 (통합 상품 목록에서 사용)
    @PostMapping("/seller/productDetailUpdate")
    public String updateProductDetail(ProductDetailModel detail, 
                                    @RequestParam("originalProductPhoto") String originalPhoto,
                                    Model model) {
        try {
            detail.setProductPhoto(originalPhoto);
            int result = productDetailDao.updateProductDetail(detail);
            if (result > 0) {
                model.addAttribute("message", "상품 상세정보가 성공적으로 수정되었습니다!");
            } else {
                model.addAttribute("error", "상품 상세정보 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("error", "오류가 발생했습니다: " + e.getMessage());
        }
        return "redirect:/seller/productList";
    }
}