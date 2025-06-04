package com.kdt.project.seller.service;

import com.kdt.project.seller.dto.ProductRegistrationDto;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.ProductOptions;
import com.kdt.project.seller.entity.Sizes;
import com.kdt.project.seller.repository.ProductSellerRepository;  // 이름 변경
import com.kdt.project.seller.repository.ProductOptionsRepository;
import com.kdt.project.seller.repository.SizesRepository;
import com.kdt.project.seller.entity.TopCategory;
import com.kdt.project.seller.repository.TopCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.Optional;

@Service
public class ProductService {
    
    @Autowired
    private ProductSellerRepository productSellerRepository;  // 이름 변경
    
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
        String productId = generateProductId();
        
        Product product = new Product();
        product.setProductId(productId);
        product.setCategory(dto.getCategory());
        product.setProductName(dto.getProductName());
        product.setCompanyName(dto.getCompanyName());
        product.setProductPhoto(dto.getProductPhoto() != null ? dto.getProductPhoto() : "");
        product.setProductDetail(dto.getProductDetail());
        product.setProductPrice(Long.parseLong(dto.getProductPrice()));
        
        productSellerRepository.save(product);  // 이름 변경
        
        // 기존 방식과 새로운 방식 모두 지원
        if (dto.getProductOptions() != null && !dto.getProductOptions().isEmpty()) {
            // 새로운 방식: 사이즈별 재고
            for (ProductRegistrationDto.ProductOptionDto optionDto : dto.getProductOptions()) {
                if (optionDto.getStock() != null && optionDto.getStock() > 0) {
                    ProductOptions option = new ProductOptions();
                    option.setProductId(productId);
                    option.setSizeId(optionDto.getSizeId());
                    option.setProductStock(optionDto.getStock());
                    productOptionsRepository.save(option);
                }
            }
        } else if (dto.getProductSize() != null && dto.getProductCount() != null) {
            // 기존 방식: 단일 사이즈 + 수량
            Sizes size = sizesRepository.findBySizeName(dto.getProductSize())
                                       .orElseThrow(() -> new RuntimeException(
                                           "존재하지 않는 사이즈입니다: " + dto.getProductSize()
                                       ));
            
            ProductOptions option = new ProductOptions();
            option.setProductId(productId);
            option.setSizeId(size.getSizeId());
            option.setProductStock(dto.getProductCount());
            productOptionsRepository.save(option);
        }
    }
    
    public List<Product> getAllProducts() {
        return productSellerRepository.findAll();  // 이름 변경
    }
    
    public List<Product> getProductsByCategory(String category) {
        return productSellerRepository.findByCategory(category);  // 이름 변경
    }
    
    public Product getProductById(String productId) {
        return productSellerRepository.findById(productId).orElse(null);  // 이름 변경
    }
    
    @Transactional
    public void deleteProduct(String productId) {
        productOptionsRepository.deleteByProductId(productId);
        productSellerRepository.deleteById(productId);  // 이름 변경
    }
    
    @Transactional
    public void updateProduct(String productId, ProductRegistrationDto dto) {
        // Product 업데이트
        Product product = productSellerRepository.findById(productId)  // 이름 변경
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
        
        // 상품명이 변경되었고, 이미 존재하는 상품명인지 체크
        if (!product.getProductName().equals(dto.getProductName()) && 
            productSellerRepository.existsByProductName(dto.getProductName())) {  // 이름 변경
            throw new RuntimeException("이미 등록된 상품명입니다.");
        }
        
        product.setCategory(dto.getCategory());
        product.setProductName(dto.getProductName());
        product.setCompanyName(dto.getCompanyName());
        product.setProductPhoto(dto.getProductPhoto());
        product.setProductDetail(dto.getProductDetail());
        product.setProductPrice(Long.parseLong(dto.getProductPrice()));
        
        productSellerRepository.save(product);  // 이름 변경
        
        // 기존 옵션 삭제 후 새로 저장 (중요!)
        productOptionsRepository.deleteByProductId(productId);
        
        if (dto.getProductOptions() != null && !dto.getProductOptions().isEmpty()) {
            for (ProductRegistrationDto.ProductOptionDto optionDto : dto.getProductOptions()) {
                if (optionDto.getStock() != null && optionDto.getStock() > 0) {
                    ProductOptions option = new ProductOptions();
                    option.setProductId(productId);
                    option.setSizeId(optionDto.getSizeId());
                    option.setProductStock(optionDto.getStock());
                    productOptionsRepository.save(option);
                }
            }
        } else if (dto.getProductSize() != null && dto.getProductCount() != null) {
            // 기존 방식 지원
            Sizes size = sizesRepository.findBySizeName(dto.getProductSize())
                                       .orElseThrow(() -> new RuntimeException(
                                           "존재하지 않는 사이즈입니다: " + dto.getProductSize()
                                       ));
            
            ProductOptions option = new ProductOptions();
            option.setProductId(productId);
            option.setSizeId(size.getSizeId());
            option.setProductStock(dto.getProductCount());
            productOptionsRepository.save(option);
        }
    }
    
    private String generateProductId() {
        return "PROD_" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}