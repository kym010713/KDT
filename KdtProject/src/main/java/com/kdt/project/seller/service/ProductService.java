package com.kdt.project.seller.service;

import com.kdt.project.seller.dto.ProductRegistrationDto;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.ProductOptions;
import com.kdt.project.seller.entity.Sizes;
import com.kdt.project.seller.repository.ProductRepository;
import com.kdt.project.seller.repository.ProductOptionsRepository;
import com.kdt.project.seller.repository.SizesRepository;
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
    private ProductOptionsRepository productOptionsRepository;
    
    @Autowired
    private SizesRepository sizesRepository;
    
    @Autowired
    private TopCategoryRepository topCategoryRepository;
    
    public List<TopCategory> getAllCategories() {
        return topCategoryRepository.findAll();
    }
    
    public List<Sizes> getAllSizes() {
        return sizesRepository.findAll();
    }
    
    public List<ProductOptions> getProductOptions(String productId) {
        return productOptionsRepository.findByProductId(productId);
    }
    
    @Transactional
    public void registerProduct(ProductRegistrationDto dto) {
        // 고유한 상품 ID 생성
        String productId = generateProductId();
        
        // Product 테이블에 저장
        Product product = new Product();
        product.setProductId(productId);
        product.setCategory(dto.getCategory());
        product.setProductName(dto.getProductName());
        product.setCompanyName(dto.getCompanyName());
        product.setProductPhoto(dto.getProductPhoto() != null ? dto.getProductPhoto() : "");
        product.setProductDetail(dto.getProductDetail());
        product.setProductPrice(Long.parseLong(dto.getProductPrice()));
        
        productRepository.save(product);
        
        // ProductOptions 저장
        if (dto.getProductOptions() != null) {
            for (ProductRegistrationDto.ProductOptionDto optionDto : dto.getProductOptions()) {
                if (optionDto.getStock() != null && optionDto.getStock() > 0) {
                    ProductOptions option = new ProductOptions();
                    option.setProductId(productId);
                    option.setSizeId(optionDto.getSizeId());
                    option.setProductStock(optionDto.getStock());
                    productOptionsRepository.save(option);
                }
            }
        }
    }
    
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }
    
    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategory(category);
    }
    
    public Product getProductById(String productId) {
        return productRepository.findById(productId).orElse(null);
    }
    
    @Transactional
    public void deleteProduct(String productId) {
        // ProductOptions 먼저 삭제
        productOptionsRepository.deleteByProductId(productId);
        
        // Product 삭제
        productRepository.deleteById(productId);
    }
    
    @Transactional
    public void updateProduct(String productId, ProductRegistrationDto dto) {
        // Product 업데이트
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
        
        // 상품명이 변경되었고, 이미 존재하는 상품명인지 체크
        if (!product.getProductName().equals(dto.getProductName()) && 
            productRepository.existsByProductName(dto.getProductName())) {
            throw new RuntimeException("이미 등록된 상품명입니다.");
        }
        
        product.setCategory(dto.getCategory());
        product.setProductName(dto.getProductName());
        product.setCompanyName(dto.getCompanyName());
        product.setProductPhoto(dto.getProductPhoto());
        product.setProductDetail(dto.getProductDetail());
        product.setProductPrice(Long.parseLong(dto.getProductPrice()));
        
        productRepository.save(product);
        
        // 기존 옵션 삭제 후 새로 저장
        productOptionsRepository.deleteByProductId(productId);
        
        if (dto.getProductOptions() != null) {
            for (ProductRegistrationDto.ProductOptionDto optionDto : dto.getProductOptions()) {
                if (optionDto.getStock() != null && optionDto.getStock() > 0) {
                    ProductOptions option = new ProductOptions();
                    option.setProductId(productId);
                    option.setSizeId(optionDto.getSizeId());
                    option.setProductStock(optionDto.getStock());
                    productOptionsRepository.save(option);
                }
            }
        }
    }
    
    private String generateProductId() {
        return "PROD_" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}