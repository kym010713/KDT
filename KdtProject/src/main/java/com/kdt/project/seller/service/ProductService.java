package com.kdt.project.seller.service;

import com.kdt.project.seller.dto.ProductRegistrationDto;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.ProductOptions;
import com.kdt.project.seller.entity.Sizes;
import com.kdt.project.seller.repository.ProductSellerRepository;
import com.kdt.project.seller.repository.ProductOptionsRepository;
import com.kdt.project.seller.repository.SizesRepository;
import com.kdt.project.seller.entity.TopCategory;
import com.kdt.project.seller.repository.TopCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

// 이미지 업로드를 위한 import 추가
import io.imagekit.sdk.ImageKit;
import io.imagekit.sdk.models.FileCreateRequest;
import io.imagekit.sdk.models.results.Result;

import java.util.List;
import java.util.UUID;
import java.util.Optional;
import java.util.Map;
import java.util.HashMap;
import java.io.IOException;

@Service
public class ProductService {
    
    @Autowired
    private ProductSellerRepository productSellerRepository;
    
    @Autowired
    private ProductOptionsRepository productOptionsRepository;
    
    @Autowired
    private SizesRepository sizesRepository;
    
    @Autowired
    private TopCategoryRepository topCategoryRepository;
    
    // ImageKit 추가
    @Autowired
    private ImageKit imageKit;
    
    public List<TopCategory> getAllCategories() {
        return topCategoryRepository.findAll();
    }
    
    public List<Sizes> getAllSizes() {
        return sizesRepository.findAll();
    }
    
    public List<ProductOptions> getProductOptions(String productId) {
        return productOptionsRepository.findByProductId(productId);
    }
    
    // 상품 상세 정보 조회 
    public Map<String, Object> getProductDetailWithSizes(String productId) {
        Map<String, Object> result = new HashMap<>();
        
        Product product = getProductById(productId);
        if (product == null) {
            result.put("success", false);
            result.put("message", "상품을 찾을 수 없습니다.");
            return result;
        }
        
        List<ProductOptions> options = getProductOptions(productId);
        List<Map<String, Object>> optionDetails = new java.util.ArrayList<>();
        
        for (ProductOptions option : options) {
            Optional<Sizes> sizeOpt = sizesRepository.findById(option.getSizeId());
            if (sizeOpt.isPresent()) {
                Map<String, Object> optionDetail = new HashMap<>();
                optionDetail.put("sizeId", option.getSizeId());
                optionDetail.put("sizeName", sizeOpt.get().getSizeName());
                optionDetail.put("stock", option.getProductStock());
                optionDetails.add(optionDetail);
            }
        }
        
        result.put("success", true);
        result.put("product", product);
        result.put("options", options);
        result.put("optionDetails", optionDetails);
        
        return result;
    }
    
    // ✅ ImageKit 활성화된 상품 등록 메서드
    @Transactional
    public void registerProduct(ProductRegistrationDto dto, MultipartFile productImage) {
        System.out.println("=== ProductService.registerProduct 시작 ===");
        System.out.println("dto: " + dto);
        System.out.println("productImage: " + (productImage != null ? productImage.getOriginalFilename() : "null"));
        
        String productId = generateProductId();
        System.out.println("생성된 상품 ID: " + productId);
        
        Product product = new Product();
        product.setProductId(productId);
        product.setCategory(dto.getCategory());
        product.setProductName(dto.getProductName());
        product.setCompanyName(dto.getCompanyName());
        product.setProductDetail(dto.getProductDetail());
        product.setProductPrice(Long.parseLong(dto.getProductPrice()));
        
        // ✅ ImageKit 업로드 처리 (fileId는 저장 안함)
        String imageFileName = null;
        
        if (productImage != null && !productImage.isEmpty()) {
            try {
                imageFileName = uploadImageToImageKit(productImage, "product");
                System.out.println("ImageKit 업로드 성공: " + imageFileName);
            } catch (IOException e) {
                System.err.println("ImageKit 업로드 실패: " + e.getMessage());
                throw new RuntimeException("이미지 업로드에 실패했습니다.", e);
            }
        } else if (dto.getProductPhoto() != null && !dto.getProductPhoto().trim().isEmpty()) {
            imageFileName = dto.getProductPhoto();
            System.out.println("URL로 이미지 설정: " + imageFileName);
        }
        
        product.setProductPhoto(imageFileName != null ? imageFileName : "");
        System.out.println("상품 저장 시작");
        productSellerRepository.save(product);
        System.out.println("상품 저장 완료");
        
        // 사이즈별 재고 처리
        if (dto.getProductSize() != null && dto.getProductCount() != null) {
            System.out.println("단일 사이즈 재고 처리: " + dto.getProductSize() + " - " + dto.getProductCount());
            Sizes size = sizesRepository.findBySizeName(dto.getProductSize())
                                       .orElseThrow(() -> new RuntimeException(
                                           "존재하지 않는 사이즈입니다: " + dto.getProductSize()
                                       ));
            
            ProductOptions option = new ProductOptions();
            option.setProductId(productId);
            option.setSizeId(size.getSizeId());
            option.setProductStock(dto.getProductCount());
            productOptionsRepository.save(option);
            System.out.println("단일 옵션 저장 완료");
        }
        
        System.out.println("=== ProductService.registerProduct 완료 ===");
    }
    
    // 기존 registerProduct 메서드도 유지 (하위 호환성)
    @Transactional
    public void registerProduct(ProductRegistrationDto dto) {
        registerProduct(dto, null);
    }
    
    // ✅ ImageKit 업로드 메서드 - fileName만 반환
    private String uploadImageToImageKit(MultipartFile file, String folder) throws IOException {
        try {
            String originalFilename = file.getOriginalFilename();
            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
            String fileName = UUID.randomUUID().toString() + ext;

            FileCreateRequest fileCreateRequest = new FileCreateRequest(file.getBytes(), fileName);
            fileCreateRequest.setFolder("/" + folder + "/");
            fileCreateRequest.setUseUniqueFileName(false);

            Result result = imageKit.upload(fileCreateRequest);
            return fileName; // fileName만 반환
            
        } catch (Exception e) {
            throw new IOException("ImageKit 업로드 실패", e);
        }
    }
    
    // ✅ 필수 메서드들 추가
    public List<Product> getAllProducts() {
        return productSellerRepository.findAll();
    }
    
    public List<Product> getProductsByCategory(String category) {
        return productSellerRepository.findByCategory(category);
    }
    
    public List<Product> getProductsByCompany(String companyName) {
        return productSellerRepository.findByCompanyName(companyName);
    }
    
    public List<Product> getProductsByCategoryAndCompany(String category, String companyName) {
        return productSellerRepository.findByCategoryAndCompanyName(category, companyName);
    }
    
    public Product getProductById(String productId) {
        return productSellerRepository.findById(productId).orElse(null);
    }
    
    // ✅ 상품 삭제 (ImageKit 삭제 기능 없음)
    @Transactional
    public void deleteProduct(String productId) {
        productOptionsRepository.deleteByProductId(productId);
        productSellerRepository.deleteById(productId);
    }
    
    @Transactional
    public void updateProduct(String productId, ProductRegistrationDto dto) {
        updateProduct(productId, dto, null);
    }
    
    // ✅ 상품 수정 메서드 (fileId 없이)
    @Transactional
    public void updateProduct(String productId, ProductRegistrationDto dto, MultipartFile productImage) {
        System.out.println("=== ProductService.updateProduct 시작 ===");
        System.out.println("productId: " + productId);
        System.out.println("dto: " + dto);
        System.out.println("productImage: " + (productImage != null ? productImage.getOriginalFilename() : "null"));
        
        Product product = productSellerRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
        
        // 상품명 변경, 이미 존재하는 상품명인지 체크
        if (!product.getProductName().equals(dto.getProductName()) && 
            productSellerRepository.existsByProductName(dto.getProductName())) {
            throw new RuntimeException("이미 등록된 상품명입니다.");
        }
        
        product.setCategory(dto.getCategory());
        product.setProductName(dto.getProductName());
        product.setCompanyName(dto.getCompanyName());
        product.setProductDetail(dto.getProductDetail());
        product.setProductPrice(Long.parseLong(dto.getProductPrice()));
        
        // ✅ 새 이미지가 업로드된 경우 ImageKit 업로드
        if (productImage != null && !productImage.isEmpty()) {
            System.out.println("새 이미지 업로드 처리");
            try {
                String newImageFileName = uploadImageToImageKit(productImage, "product");
                product.setProductPhoto(newImageFileName);
                System.out.println("새 이미지 ImageKit 업로드 성공: " + newImageFileName);
            } catch (Exception e) {
                System.out.println("이미지 처리 중 오류: " + e.getMessage());
                throw new RuntimeException("이미지 처리 중 오류가 발생했습니다.", e);
            }
        } else if (dto.getProductPhoto() != null && !dto.getProductPhoto().trim().isEmpty()) {
            // URL로 직접 입력된 경우
            product.setProductPhoto(dto.getProductPhoto());
            System.out.println("URL로 이미지 업데이트: " + dto.getProductPhoto());
        }
        // else: 기존 이미지 유지
        
        System.out.println("상품 정보 저장");
        productSellerRepository.save(product);
        
        // 기존 옵션 삭제 후 새로 저장
        System.out.println("기존 옵션 삭제");
        productOptionsRepository.deleteByProductId(productId);
        
        if (dto.getProductOptions() != null && !dto.getProductOptions().isEmpty()) {
            System.out.println("새 옵션 저장 시작");
            for (ProductRegistrationDto.ProductOptionDto optionDto : dto.getProductOptions()) {
                if (optionDto.getStock() != null && optionDto.getStock() > 0) {
                    ProductOptions option = new ProductOptions();
                    option.setProductId(productId);
                    option.setSizeId(optionDto.getSizeId());
                    option.setProductStock(optionDto.getStock());
                    productOptionsRepository.save(option);
                    System.out.println("옵션 저장: sizeId=" + optionDto.getSizeId() + ", stock=" + optionDto.getStock());
                }
            }
        } else if (dto.getProductSize() != null && dto.getProductCount() != null) {
            System.out.println("단일 사이즈 재고 처리");
            Sizes size = sizesRepository.findBySizeName(dto.getProductSize())
                                       .orElseThrow(() -> new RuntimeException(
                                           "존재하지 않는 사이즈입니다: " + dto.getProductSize()
                                       ));
            
            ProductOptions option = new ProductOptions();
            option.setProductId(productId);
            option.setSizeId(size.getSizeId());
            option.setProductStock(dto.getProductCount());
            productOptionsRepository.save(option);
            System.out.println("단일 옵션 저장 완료");
        }
        
        System.out.println("=== ProductService.updateProduct 완료 ===");
    }
    
    // ✅ generateProductId 메서드 추가
    private String generateProductId() {
        return "PROD_" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}