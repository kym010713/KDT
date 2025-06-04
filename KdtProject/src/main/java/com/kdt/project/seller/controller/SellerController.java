package com.kdt.project.seller.controller;

import com.kdt.project.seller.dto.ProductRegistrationDto;
import com.kdt.project.seller.service.ProductService;
import com.kdt.project.seller.service.SalesService;
import com.kdt.project.seller.service.DeliveryService;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.ProductOptions;
import com.kdt.project.seller.entity.Sizes;
import com.kdt.project.seller.dto.SalesDto;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/seller")
public class SellerController {
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private SalesService salesService;
    
    @Autowired
    private DeliveryService deliveryService;
    
    // 상품 등록 폼 페이지
    @GetMapping("/register")
    public String showProductRegisterForm(Model model) {
        model.addAttribute("productDto", new ProductRegistrationDto());
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("sizes", productService.getAllSizes());
        return "seller/register";
    }
    
    // 상품 목록 조회 페이지
    @GetMapping("/list")
    public String showProductList(@RequestParam(value = "category", required = false) String category,
                                Model model) {
        List<Product> products;
        if (category != null && !category.isEmpty()) {
            products = productService.getProductsByCategory(category);
        } else {
            products = productService.getAllProducts();
        }
        
        model.addAttribute("products", products);
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("selectedCategory", category);
        return "seller/list";
    }
    

    
 // 상품 수정 폼 데이터 조회 (AJAX) - 수정된 부분
    @GetMapping("/product/edit/{productId}")
    @ResponseBody
    public Map<String, Object> getProductForEdit(@PathVariable("productId") String productId) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            Product product = productService.getProductById(productId);
            if (product == null) {
                response.put("success", false);
                response.put("message", "상품을 찾을 수 없습니다.");
                return response;
            }
            
            List<ProductOptions> options = productService.getProductOptions(productId);
            List<Sizes> allSizes = productService.getAllSizes();
            
            // DTO 생성
            ProductRegistrationDto dto = new ProductRegistrationDto();
            dto.setCategory(product.getCategory());
            dto.setProductName(product.getProductName());
            dto.setCompanyName(product.getCompanyName());
            dto.setProductPhoto(product.getProductPhoto());
            dto.setProductDetail(product.getProductDetail());
            dto.setProductPrice(String.valueOf(product.getProductPrice()));
            
            // 사이즈별 재고 정보 설정
            List<ProductRegistrationDto.ProductOptionDto> optionDtos = allSizes.stream()
                .map(size -> {
                    ProductRegistrationDto.ProductOptionDto optionDto = new ProductRegistrationDto.ProductOptionDto();
                    optionDto.setSizeId(size.getSizeId());
                    optionDto.setSizeName(size.getSizeName());
                    
                    // 해당 사이즈의 재고 찾기
                    options.stream()
                        .filter(option -> option.getSizeId().equals(size.getSizeId()))
                        .findFirst()
                        .ifPresentOrElse(
                            option -> optionDto.setStock(option.getProductStock()),
                            () -> optionDto.setStock(0)
                        );
                    
                    return optionDto;
                })
                .collect(Collectors.toList());
            
            dto.setProductOptions(optionDtos);
            
            response.put("success", true);
            response.put("data", dto);
            return response;
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
            return response;
        }
    }

 // 상품 상세 조회 (AJAX) - Product 정보 + 옵션 정보 포함
    @GetMapping("/product/detail/{productId}")
    @ResponseBody
    public Map<String, Object> getProductDetail(@PathVariable("productId") String productId) {
        Map<String, Object> response = new HashMap<>();
        
        Product product = productService.getProductById(productId);
        if (product == null) {
            response.put("success", false);
            response.put("message", "상품을 찾을 수 없습니다.");
            return response;
        }
        
        List<ProductOptions> options = productService.getProductOptions(productId);
        
        // 사이즈 정보와 함께 옵션 데이터 구성
        List<Map<String, Object>> optionDetails = new ArrayList<>();
        for (ProductOptions option : options) {
            Sizes size = sizesRepository.findById(option.getSizeId()).orElse(null);
            if (size != null) {
                Map<String, Object> optionDetail = new HashMap<>();
                optionDetail.put("sizeId", option.getSizeId());
                optionDetail.put("sizeName", size.getSizeName());
                optionDetail.put("stock", option.getProductStock());
                optionDetails.add(optionDetail);
            }
        }
        
        response.put("success", true);
        response.put("product", product);
        response.put("options", options);
        response.put("optionDetails", optionDetails);  // 사이즈명 포함된 상세 정보
        return response;
    }
    
    // 상품 삭제 처리 (AJAX)
    @DeleteMapping("/product/delete/{productId}")
    @ResponseBody
    public Map<String, Object> deleteProduct(@PathVariable("productId") String productId) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            productService.deleteProduct(productId);
            response.put("success", true);
            response.put("message", "상품이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }
    
    // 판매 내역 조회 페이지
    @GetMapping("/sales")
    public String showSales(Model model) {
        List<SalesDto> salesList = salesService.getAllSales();
        model.addAttribute("salesList", salesList);
        return "seller/sales";
    }
    
    // 배송 상태 변경 (AJAX)
    @PostMapping("/delivery/update")
    @ResponseBody
    public Map<String, Object> updateDeliveryStatus(@RequestParam Long orderNumber, 
                                                   @RequestParam String newStatus) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            boolean success = deliveryService.updateDeliveryStatus(orderNumber, newStatus);
            
            if (success) {
                response.put("success", true);
                String statusText = "";
                switch (newStatus) {
                    case "REQUESTED": statusText = "배송 요청"; break;
                    case "IN_PROGRESS": statusText = "배송 중"; break;
                    case "COMPLETED": statusText = "배송 완료"; break;
                    default: statusText = newStatus;
                }
                response.put("message", "배송 상태가 '" + statusText + "'로 변경되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "배송 상태 변경에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }
    
    // 배송 관리 페이지
    @GetMapping("/delivery")
    public String showDeliveryManagement(@RequestParam(value = "status", required = false, defaultValue = "ALL") String status,
                                       Model model) {
        List<SalesDto> deliveryList = deliveryService.getDeliveriesByStatus(status);
        model.addAttribute("deliveryList", deliveryList);
        model.addAttribute("selectedStatus", status);
        return "seller/delivery";
    }
    
    // 상품 수정 처리 (AJAX)
    @PostMapping("/product/update/{productId}")
    @ResponseBody
    public Map<String, Object> updateProduct(@PathVariable("productId") String productId,
                                           @RequestBody ProductRegistrationDto productDto) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            productService.updateProduct(productId, productDto);
            response.put("success", true);
            response.put("message", "상품이 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        
        return response;
    }
    
    @PostMapping("/register")  // "/product/register"에서 "/register"로 변경
    public String registerProduct(@Valid @ModelAttribute("productDto") ProductRegistrationDto productDto,
                                BindingResult bindingResult,
                                Model model,
                                RedirectAttributes redirectAttributes) {
        
        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";
        }
        
        try {
            productService.registerProduct(productDto);
            redirectAttributes.addFlashAttribute("successMessage", "상품이 성공적으로 등록되었습니다.");
            return "redirect:/seller/register";  // "/seller/product/register"에서 "/seller/register"로 변경
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";  // "seller/product-register"에서 "seller/register"로 변경
        }
    }
}