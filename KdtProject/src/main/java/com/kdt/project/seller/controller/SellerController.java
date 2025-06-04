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
import java.util.Optional;

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
    
 // 상품 목록 조회 페이지 (사이즈별 표시)
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
    

    
 // 상품 수정 폼 데이터 조회 
    @GetMapping("/product/edit/{productId}")
    @ResponseBody
    public Map<String, Object> getProductForEdit(@PathVariable("productId") String productId) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            System.out.println("=== 상품 수정 폼 데이터 조회: " + productId + " ===");
            
            Product product = productService.getProductById(productId);
            if (product == null) {
                response.put("success", false);
                response.put("message", "상품을 찾을 수 없습니다.");
                return response;
            }
            
            List<ProductOptions> options = productService.getProductOptions(productId);
            List<Sizes> allSizes = productService.getAllSizes();
            
          
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
            
      
            if (!options.isEmpty()) {
                ProductOptions firstOption = options.get(0);
                Optional<Sizes> sizeOpt = allSizes.stream()
                    .filter(size -> size.getSizeId().equals(firstOption.getSizeId()))
                    .findFirst();
                
                if (sizeOpt.isPresent()) {
                    dto.setProductSize(sizeOpt.get().getSizeName());
                    dto.setProductCount(firstOption.getProductStock());
                }
            }
            
            response.put("success", true);
            response.put("data", dto);
            
            System.out.println("수정 폼 데이터: " + dto);
            return response;
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
            return response;
        }
    }

 // 상품 상세 조회

    @GetMapping("/product/detail/{productId}")
    @ResponseBody
    public Map<String, Object> getProductDetail(@PathVariable("productId") String productId) {
        System.out.println("=== 상품 상세 조회 시작: " + productId + " ===");
        
     
        Map<String, Object> response = productService.getProductDetailWithSizes(productId);
        
        System.out.println("Response: " + response);
        return response;
    }
    
    // 상품 삭제 처리
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
    
    // 배송 상태 변경 )
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
    
 //  상품 수정 처리 메서드 로그 
    @PostMapping("/product/update/{productId}")
    @ResponseBody
    public Map<String, Object> updateProduct(@PathVariable("productId") String productId,
                                           @RequestBody ProductRegistrationDto productDto) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            System.out.println("=== 상품 수정 요청 ===");
            System.out.println("Product ID: " + productId);
            System.out.println("수정 데이터: " + productDto);
            
            productService.updateProduct(productId, productDto);
            response.put("success", true);
            response.put("message", "상품이 성공적으로 수정되었습니다.");
            
            System.out.println("상품 수정 완료");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            e.printStackTrace();
        }
        
        return response;
    }
    
    @PostMapping("/register") 
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
            return "redirect:/seller/register";  
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";  
        }
    }
    
    
}