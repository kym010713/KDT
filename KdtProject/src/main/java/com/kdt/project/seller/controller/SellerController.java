package com.kdt.project.seller.controller;

import com.kdt.project.seller.dto.ProductRegistrationDto;
import com.kdt.project.seller.service.ProductService;
import com.kdt.project.seller.service.SalesService;
import com.kdt.project.seller.service.DeliveryService;
import com.kdt.project.seller.service.SellerRoleService;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.ProductOptions;
import com.kdt.project.seller.entity.Sizes;
import com.kdt.project.seller.dto.SalesDto;
import com.kdt.project.user.entity.UserEntity;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Map;
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
    
    @Autowired
    private SellerRoleService sellerRoleService;
    
    /**
     * 3단계 검증을 수행하는 헬퍼 메서드 (JSP 알림창 사용)
     * @param session HttpSession
     * @return 검증 결과: null(성공), "JSP 경로"(실패)
     */
    private String validateSellerAccessWithAlert(HttpSession session) {
        // 1단계: 로그인 체크
        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "alert/login-required";
        }
        
        // 2단계: 판매자 권한 체크
        if (!"SELLER".equals(loginUser.getRole())) {
            return "alert/seller-auth-required";
        }
        
        // 3단계: 승인된 판매자인지 체크
        String companyName = sellerRoleService.getCompanyNameBySellerId(loginUser.getId());
        if (companyName == null) {
            return "alert/seller-approval-required";
        }
        
        return null; // 모든 검증 통과
    }
    
    /**
     * 3단계 검증을 수행하는 헬퍼 메서드 (JSON 응답용)
     * @param session HttpSession
     * @return 검증 결과: null(성공), "redirect:URL"(실패)
     */
    private String validateSellerAccess(HttpSession session) {
        // 1단계: 로그인 체크
        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        // 2단계: 판매자 권한 체크
        if (!"SELLER".equals(loginUser.getRole())) {
            return "redirect:/seller/apply";
        }
        
        // 3단계: 승인된 판매자인지 체크
        String companyName = sellerRoleService.getCompanyNameBySellerId(loginUser.getId());
        if (companyName == null) {
            return "redirect:/seller/apply";
        }
        
        return null; // 모든 검증 통과
    }
    
    /**
     * 현재 로그인한 판매자의 회사명을 가져오는 헬퍼 메서드
     */
    private String getCurrentSellerCompany(HttpSession session) {
        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
        if (loginUser == null) {
            return null;
        }
        return sellerRoleService.getCompanyNameBySellerId(loginUser.getId());
    }
    
    // 상품 등록 폼 페이지
    @GetMapping("/register")
    public String showProductRegisterForm(Model model, HttpSession session) {
        String validationResult = validateSellerAccessWithAlert(session);
        if (validationResult != null) {
            return validationResult; // alert JSP 페이지 반환
        }
        
        model.addAttribute("productDto", new ProductRegistrationDto());
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("sizes", productService.getAllSizes());
        return "seller/register";
    }
    
    // 상품 목록 조회 페이지 (회사별 필터링)
    @GetMapping("/list")
    public String showProductList(@RequestParam(value = "category", required = false) String category,
                                Model model, HttpSession session) {
        
        String validationResult = validateSellerAccessWithAlert(session);
        if (validationResult != null) {
            return validationResult; // alert JSP 페이지 반환
        }
        
        String companyName = getCurrentSellerCompany(session);
        
        List<Product> products;
        if (category != null && !category.isEmpty()) {
            products = productService.getProductsByCategoryAndCompany(category, companyName);
        } else {
            products = productService.getProductsByCompany(companyName);
        }
        
        model.addAttribute("products", products);
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("selectedCategory", category);
        model.addAttribute("currentCompany", companyName);
        return "seller/list";
    }
    
    // 판매 내역 조회 페이지 (회사별 필터링)
    @GetMapping("/sales")
    public String showSales(Model model, HttpSession session) {
        String validationResult = validateSellerAccessWithAlert(session);
        if (validationResult != null) {
            return validationResult;
        }
        
        String companyName = getCurrentSellerCompany(session);
        List<SalesDto> salesList = salesService.getSalesByCompany(companyName);
        
        model.addAttribute("salesList", salesList);
        model.addAttribute("currentCompany", companyName);
        return "seller/sales";
    }
    
    // 배송 관리 페이지 (회사별 필터링)
    @GetMapping("/delivery")
    public String showDeliveryManagement(@RequestParam(value = "status", required = false, defaultValue = "ALL") String status,
                                       Model model, HttpSession session) {
        String validationResult = validateSellerAccessWithAlert(session);
        if (validationResult != null) {
            return validationResult;
        }
        
        String companyName = getCurrentSellerCompany(session);
        List<SalesDto> deliveryList = deliveryService.getDeliveriesByStatusAndCompany(status, companyName);
        
        model.addAttribute("deliveryList", deliveryList);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("currentCompany", companyName);
        return "seller/delivery";
    }
    
    // 상품 상세 조회 (회사 검증 포함)
    @GetMapping("/product/detail/{productId}")
    @ResponseBody
    public Map<String, Object> getProductDetail(@PathVariable("productId") String productId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        String validationResult = validateSellerAccess(session);
        if (validationResult != null) {
            response.put("success", false);
            response.put("message", "접근 권한이 없습니다.");
            return response;
        }
        
        String companyName = getCurrentSellerCompany(session);
        
        // 상품이 현재 판매자의 것인지 확인
        Product product = productService.getProductById(productId);
        if (product == null || !companyName.equals(product.getCompanyName())) {
            response.put("success", false);
            response.put("message", "해당 상품에 대한 권한이 없습니다.");
            return response;
        }
        
        return productService.getProductDetailWithSizes(productId);
    }
    
    // 상품 수정 폼 데이터 조회 (회사 검증 포함)
    @GetMapping("/product/edit/{productId}")
    @ResponseBody
    public Map<String, Object> getProductForEdit(@PathVariable("productId") String productId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        String validationResult = validateSellerAccess(session);
        if (validationResult != null) {
            response.put("success", false);
            response.put("message", "접근 권한이 없습니다.");
            return response;
        }
        
        String companyName = getCurrentSellerCompany(session);
        
        // 상품이 현재 판매자의 것인지 확인
        Product product = productService.getProductById(productId);
        if (product == null || !companyName.equals(product.getCompanyName())) {
            response.put("success", false);
            response.put("message", "해당 상품에 대한 권한이 없습니다.");
            return response;
        }
        
        try {
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
    
    // 상품 수정 처리 (회사 검증 포함)
    @PostMapping("/product/update/{productId}")
    @ResponseBody
    public Map<String, Object> updateProduct(@PathVariable("productId") String productId,
                                           @RequestBody ProductRegistrationDto productDto,
                                           HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        String validationResult = validateSellerAccess(session);
        if (validationResult != null) {
            response.put("success", false);
            response.put("message", "접근 권한이 없습니다.");
            return response;
        }
        
        String companyName = getCurrentSellerCompany(session);
        
        // 상품이 현재 판매자의 것인지 확인
        Product product = productService.getProductById(productId);
        if (product == null || !companyName.equals(product.getCompanyName())) {
            response.put("success", false);
            response.put("message", "해당 상품에 대한 권한이 없습니다.");
            return response;
        }
        
        try {
            // 회사명을 현재 로그인한 판매자의 회사명으로 고정
            productDto.setCompanyName(companyName);
            productService.updateProduct(productId, productDto);
            response.put("success", true);
            response.put("message", "상품이 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        
        return response;
    }
    
    // 상품 삭제 처리 (회사 검증 포함)
    @DeleteMapping("/product/delete/{productId}")
    @ResponseBody
    public Map<String, Object> deleteProduct(@PathVariable("productId") String productId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        String validationResult = validateSellerAccess(session);
        if (validationResult != null) {
            response.put("success", false);
            response.put("message", "접근 권한이 없습니다.");
            return response;
        }
        
        String companyName = getCurrentSellerCompany(session);
        
        // 상품이 현재 판매자의 것인지 확인
        Product product = productService.getProductById(productId);
        if (product == null || !companyName.equals(product.getCompanyName())) {
            response.put("success", false);
            response.put("message", "해당 상품에 대한 권한이 없습니다.");
            return response;
        }
        
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
    
    // 배송 상태 변경 (회사 검증 포함)
    @PostMapping("/delivery/update")
    @ResponseBody
    public Map<String, Object> updateDeliveryStatus(@RequestParam Long orderNumber, 
                                                   @RequestParam String newStatus,
                                                   HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        String validationResult = validateSellerAccess(session);
        if (validationResult != null) {
            response.put("success", false);
            response.put("message", "접근 권한이 없습니다.");
            return response;
        }
        
        String companyName = getCurrentSellerCompany(session);
        
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
    
    // 상품 등록 처리
    @PostMapping("/register") 
    public String registerProduct(@Valid @ModelAttribute("productDto") ProductRegistrationDto productDto,
                                BindingResult bindingResult,
                                Model model,
                                RedirectAttributes redirectAttributes,
                                HttpSession session) {
        
        String validationResult = validateSellerAccessWithAlert(session);
        if (validationResult != null) {
            return validationResult; // alert JSP 페이지 반환
        }
        
        String companyName = getCurrentSellerCompany(session);
        
        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";
        }
        
        try {
            // 현재 로그인한 판매자의 회사명으로 상품 등록
            productDto.setCompanyName(companyName);
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