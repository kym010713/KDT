package com.kdt.project.seller.service;

import com.kdt.project.seller.dto.ProductRegistrationDto;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.ProductDetail;
import com.kdt.project.seller.repository.ProductRepository;
import com.kdt.project.seller.repository.ProductDetailRepository;
import com.kdt.project.seller.entity.TopCategory;
import com.kdt.project.seller.repository.TopCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class ProductService {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private ProductDetailRepository productDetailRepository;
    
    @Autowired
    private TopCategoryRepository topCategoryRepository;
    
    public List<TopCategory> getAllCategories() {
        return topCategoryRepository.findAll();
    }
    
    @Transactional
    public void registerProduct(ProductRegistrationDto dto) {
        // 상품명 중복 체크
        if (productRepository.existsByProductName(dto.getProductName())) {
            throw new RuntimeException("이미 등록된 상품명입니다.");
        }
        
        // 고유한 상품 ID 생성
        String productId = generateProductId();
        
        // Product 테이블에 저장
        Product product = new Product();
        product.setProductId(productId);
        product.setCategory(dto.getCategory());
        product.setProductName(dto.getProductName());
        product.setCompanyName(dto.getCompanyName());
        product.setProductPhoto(dto.getProductPhoto());
        
        productRepository.save(product);
        
        // ProductDetail 테이블에 저장
        ProductDetail productDetail = new ProductDetail();
        productDetail.setProductName(dto.getProductName());
        productDetail.setProductCount(dto.getProductCount());
        productDetail.setProductDetail(dto.getProductDetail());
        productDetail.setProductPrice(dto.getProductPrice());
        productDetail.setProductSize(dto.getProductSize());
        productDetail.setProductPhoto(dto.getProductPhoto());
        productDetail.setProductId(productId);  // PRODUCT_ID 추가
        
        productDetailRepository.save(productDetail);
    }
    
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }
    
    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategory(category);
    }
    
    public ProductDetail getProductDetail(String productName) {
        return productDetailRepository.findById(productName).orElse(null);
    }
    
    private String generateProductId() {
        return "PROD_" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}