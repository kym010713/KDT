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
import com.kdt.project.seller.dto.MonthlySalesDto;
import com.kdt.project.seller.dto.SalesAnalyticsDto;
import com.kdt.project.user.entity.UserEntity;
import jakarta.validation.Valid;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.ZoneId;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.stream.Collectors;
import java.text.SimpleDateFormat;
import java.io.IOException;
import java.io.PrintWriter;

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
    
    // 판매 내역 조회 페이지 (회사별 필터링 + 월별 필터링)
    @GetMapping("/sales")
    public String showSales(@RequestParam(value = "month", required = false) String month,
                           @RequestParam(value = "status", required = false) String status,
                           Model model, HttpSession session) {
        String validationResult = validateSellerAccessWithAlert(session);
        if (validationResult != null) {
            return validationResult;
        }
        
        String companyName = getCurrentSellerCompany(session);
        
        // 필터링된 판매 내역 조회
        List<SalesDto> salesList;
        if (month != null && !month.isEmpty() && status != null && !status.isEmpty()) {
            salesList = salesService.getSalesByCompanyMonthAndStatus(companyName, month, status);
        } else if (month != null && !month.isEmpty()) {
            salesList = salesService.getSalesByCompanyAndMonth(companyName, month);
        } else if (status != null && !status.isEmpty()) {
            salesList = salesService.getSalesByCompanyAndStatus(companyName, status);
        } else {
            salesList = salesService.getSalesByCompany(companyName);
        }
        
        // 분석 데이터 조회
        SalesAnalyticsDto analytics = salesService.getSalesAnalytics(companyName);
        
        // 월별 매출 데이터 (현재 연도)
        int currentYear = LocalDate.now().getYear();
        List<MonthlySalesDto> monthlySales = salesService.getMonthlySalesByCompany(companyName, currentYear);
        
        // 상품별 매출 비중
        Map<String, BigDecimal> productRevenueShare = salesService.getProductRevenueShare(companyName);
        
        model.addAttribute("salesList", salesList);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("currentCompany", companyName);
        model.addAttribute("analytics", analytics);
        model.addAttribute("monthlySales", monthlySales);
        model.addAttribute("productRevenueShare", productRevenueShare);
        model.addAttribute("currentYear", currentYear);
        
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
    
    // 매출 분석 대시보드 페이지
    @GetMapping("/analytics")
    public String showAnalytics(Model model, HttpSession session) {
        String validationResult = validateSellerAccessWithAlert(session);
        if (validationResult != null) {
            return validationResult;
        }
        
        String companyName = getCurrentSellerCompany(session);
        
        // 전체 분석 데이터
        SalesAnalyticsDto analytics = salesService.getSalesAnalytics(companyName);
        
        // 최근 12개월 매출 데이터
        int currentYear = LocalDate.now().getYear();
        List<MonthlySalesDto> currentYearSales = salesService.getMonthlySalesByCompany(companyName, currentYear);
        List<MonthlySalesDto> previousYearSales = salesService.getMonthlySalesByCompany(companyName, currentYear - 1);
        
        // 상품별 매출 비중
        Map<String, BigDecimal> productRevenueShare = salesService.getProductRevenueShare(companyName);
        
        // 최근 판매 내역 (최신 10건)
        List<SalesDto> recentSales = salesService.getSalesByCompany(companyName).stream()
            .sorted((a, b) -> {
                if (a.getOrderDate() == null && b.getOrderDate() == null) return 0;
                if (a.getOrderDate() == null) return 1;
                if (b.getOrderDate() == null) return -1;
                return b.getOrderDate().compareTo(a.getOrderDate());
            })
            .limit(10)
            .collect(Collectors.toList());
        
        model.addAttribute("analytics", analytics);
        model.addAttribute("currentYearSales", currentYearSales);
        model.addAttribute("previousYearSales", previousYearSales);
        model.addAttribute("productRevenueShare", productRevenueShare);
        model.addAttribute("recentSales", recentSales);
        model.addAttribute("currentCompany", companyName);
        model.addAttribute("currentYear", currentYear);
        
        return "seller/analytics";
    }
    
    // 월별 매출 데이터 API
    @GetMapping("/api/monthly-sales")
    @ResponseBody
    public Map<String, Object> getMonthlySalesData(@RequestParam(value = "year", defaultValue = "2025") int year,
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
            List<MonthlySalesDto> monthlySales = salesService.getMonthlySalesByCompany(companyName, year);
            SalesAnalyticsDto analytics = salesService.getSalesAnalytics(companyName);
            Map<String, BigDecimal> productRevenueShare = salesService.getProductRevenueShare(companyName);
            
            response.put("success", true);
            response.put("monthlySales", monthlySales);
            response.put("analytics", analytics);
            response.put("productRevenueShare", productRevenueShare);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "데이터 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }
    
    // 특정 월의 일별 매출 데이터 API
    @GetMapping("/api/daily-sales")
    @ResponseBody
    public Map<String, Object> getDailySalesData(@RequestParam("year") int year,
                                                @RequestParam("month") int month,
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
            String yearMonth = String.format("%d-%02d", year, month);
            List<SalesDto> monthlySales = salesService.getSalesByCompanyAndMonth(companyName, yearMonth);
            
            // 일별로 그룹화
            Map<Integer, List<SalesDto>> dailySalesMap = monthlySales.stream()
                .filter(sales -> sales.getOrderDate() != null)
                .collect(Collectors.groupingBy(sales -> {
                    LocalDate orderDate = sales.getOrderDate().toInstant()
                        .atZone(ZoneId.systemDefault()).toLocalDate();
                    return orderDate.getDayOfMonth();
                }));
            
            // 일별 매출 계산
            Map<String, Object> dailyData = new HashMap<>();
            for (int day = 1; day <= 31; day++) {
                List<SalesDto> daySales = dailySalesMap.getOrDefault(day, new ArrayList<>());
                
                BigDecimal dayRevenue = daySales.stream()
                    .map(sales -> new BigDecimal(sales.getProductPrice()))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
                
                int dayOrders = daySales.size();
                
                Map<String, Object> dayInfo = new HashMap<>();
                dayInfo.put("revenue", dayRevenue);
                dayInfo.put("orders", dayOrders);
                
                dailyData.put(String.valueOf(day), dayInfo);
            }
            
            response.put("success", true);
            response.put("dailyData", dailyData);
            response.put("year", year);
            response.put("month", month);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "데이터 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }
    
    // 매출 데이터 Excel/CSV 내보내기
    @GetMapping("/export/sales")
    public void exportSalesData(@RequestParam(value = "month", required = false) String month,
                               @RequestParam(value = "format", defaultValue = "excel") String format,
                               HttpServletResponse response, HttpSession session) {
        String validationResult = validateSellerAccess(session);
        if (validationResult != null) {
            return;
        }
        
        String companyName = getCurrentSellerCompany(session);
        
        try {
            List<SalesDto> salesList;
            if (month != null && !month.isEmpty()) {
                salesList = salesService.getSalesByCompanyAndMonth(companyName, month);
            } else {
                salesList = salesService.getSalesByCompany(companyName);
            }
            
            if ("excel".equals(format)) {
                exportToExcel(salesList, response, month);
            } else if ("csv".equals(format)) {
                exportToCsv(salesList, response, month);
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    private void exportToExcel(List<SalesDto> salesList, HttpServletResponse response, String month) throws IOException {
        // Apache POI를 사용한 Excel 내보내기 구현
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String filename = "sales_data" + (month != null ? "_" + month : "") + ".xlsx";
        response.setHeader("Content-Disposition", "attachment; filename=" + filename);
        
        // Excel 생성 로직은 Apache POI 라이브러리 추가 후 구현
        // 여기서는 기본 구조만 제공
    }
    
    private void exportToCsv(List<SalesDto> salesList, HttpServletResponse response, String month) throws IOException {
        response.setContentType("text/csv; charset=UTF-8");
        String filename = "sales_data" + (month != null ? "_" + month : "") + ".csv";
        response.setHeader("Content-Disposition", "attachment; filename=" + filename);
        
        PrintWriter writer = response.getWriter();
        
        // CSV 헤더
        writer.println("주문번호,구매자,상품명,제조사,가격,주문일,배송주소,배송상태,배송요청일,배송완료일");
        
        // CSV 데이터
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        for (SalesDto sales : salesList) {
            StringBuilder line = new StringBuilder();
            line.append(sales.getOrderNumber()).append(",");
            line.append(sales.getUserId()).append(",");
            line.append("\"").append(sales.getProductName()).append("\",");
            line.append(sales.getCompanyName()).append(",");
            line.append(sales.getProductPrice()).append(",");
            line.append(sales.getOrderDate() != null ? dateFormat.format(sales.getOrderDate()) : "").append(",");
            line.append("\"").append(sales.getOrderAddress()).append("\",");
            line.append(sales.getDeliveryState()).append(",");
            line.append(sales.getRequestDate() != null ? dateFormat.format(sales.getRequestDate()) : "").append(",");
            line.append(sales.getCompleteDate() != null ? dateFormat.format(sales.getCompleteDate()) : "");
            
            writer.println(line.toString());
        }
        
        writer.flush();
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
    public Map<String, Object> updateDeliveryStatus(
        @RequestParam("orderNumber") Long orderNumber,
        @RequestParam("newStatus") String newStatus,
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
    
 // 상품 등록 처리 - 디버그 로그 추가
    @PostMapping("/register") 
    public String registerProduct(@ModelAttribute("productDto") ProductRegistrationDto productDto,
                                @RequestParam(value = "productImageFile", required = false) MultipartFile productImageFile,
                                Model model,
                                RedirectAttributes redirectAttributes,
                                HttpSession session) {
        
        System.out.println("=== 상품 등록 요청 시작 ===");
        System.out.println("productDto (before): " + productDto);
        System.out.println("productImageFile: " + (productImageFile != null ? productImageFile.getOriginalFilename() : "null"));
        
        String validationResult = validateSellerAccessWithAlert(session);
        if (validationResult != null) {
            System.out.println("권한 검증 실패: " + validationResult);
            return validationResult;
        }
        
        String companyName = getCurrentSellerCompany(session);
        System.out.println("현재 회사명: " + companyName);
        
        // ✅ 바인딩 검증 전에 companyName 설정
        productDto.setCompanyName(companyName);
        System.out.println("productDto (after companyName set): " + productDto);
        
        // ✅ 수동으로 검증 수행
        if (productDto.getCategory() == null || productDto.getCategory().trim().isEmpty()) {
            model.addAttribute("errorMessage", "카테고리를 선택해주세요.");
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";
        }
        
        if (productDto.getProductName() == null || productDto.getProductName().trim().isEmpty()) {
            model.addAttribute("errorMessage", "상품명을 입력해주세요.");
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";
        }
        
        if (productDto.getProductDetail() == null || productDto.getProductDetail().trim().isEmpty()) {
            model.addAttribute("errorMessage", "상품 설명을 입력해주세요.");
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";
        }
        
        if (productDto.getProductPrice() == null || productDto.getProductPrice().trim().isEmpty()) {
            model.addAttribute("errorMessage", "상품 가격을 입력해주세요.");
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";
        }
        
        if (productDto.getProductSize() == null || productDto.getProductSize().trim().isEmpty()) {
            model.addAttribute("errorMessage", "상품 사이즈를 선택해주세요.");
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";
        }
        
        if (productDto.getProductCount() == null || productDto.getProductCount() < 1) {
            model.addAttribute("errorMessage", "상품 수량은 1개 이상이어야 합니다.");
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";
        }
        
        try {
            System.out.println("상품 등록 서비스 호출 전");
            productService.registerProduct(productDto, productImageFile);
            System.out.println("상품 등록 서비스 호출 완료");
            redirectAttributes.addFlashAttribute("successMessage", "상품이 성공적으로 등록되었습니다.");
            return "redirect:/seller/register";  
        } catch (Exception e) {
            System.out.println("상품 등록 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("categories", productService.getAllCategories());
            model.addAttribute("sizes", productService.getAllSizes());
            return "seller/register";  
        }
    }

 // 상품 수정 처리 - 단순화된 버전
    @PostMapping("/product/update/{productId}")
    @ResponseBody
    public Map<String, Object> updateProduct(@PathVariable("productId") String productId,
                                           @RequestParam(value = "productImageFile", required = false) MultipartFile productImageFile,
                                           @RequestParam("category") String category,
                                           @RequestParam("productName") String productName,
                                           @RequestParam("companyName") String companyName,
                                           @RequestParam("productDetail") String productDetail,
                                           @RequestParam("productPrice") String productPrice,
                                           @RequestParam(value = "productPhoto", required = false) String productPhoto,
                                           @RequestParam(value = "productOptions", required = false) String productOptionsJson,
                                           HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        System.out.println("=== 상품 수정 요청 시작 ===");
        System.out.println("productId: " + productId);
        System.out.println("category: " + category);
        System.out.println("productName: " + productName);
        System.out.println("productImageFile: " + (productImageFile != null ? productImageFile.getOriginalFilename() : "null"));
        System.out.println("productOptionsJson: " + productOptionsJson);
        
        String validationResult = validateSellerAccess(session);
        if (validationResult != null) {
            response.put("success", false);
            response.put("message", "접근 권한이 없습니다.");
            return response;
        }
        
        String currentCompanyName = getCurrentSellerCompany(session);
        
        // 상품이 현재 판매자의 것인지 확인
        Product product = productService.getProductById(productId);
        if (product == null || !currentCompanyName.equals(product.getCompanyName())) {
            response.put("success", false);
            response.put("message", "해당 상품에 대한 권한이 없습니다.");
            return response;
        }
        
        try {
            // ProductRegistrationDto 생성
            ProductRegistrationDto productDto = new ProductRegistrationDto();
            productDto.setCategory(category);
            productDto.setProductName(productName);
            productDto.setCompanyName(currentCompanyName); // 현재 판매자의 회사명으로 고정
            productDto.setProductDetail(productDetail);
            productDto.setProductPrice(productPrice);
            productDto.setProductPhoto(productPhoto);
            
            // JSON 문자열로 받은 productOptions 파싱
            if (productOptionsJson != null && !productOptionsJson.trim().isEmpty()) {
                try {
                    List<ProductRegistrationDto.ProductOptionDto> optionsList = parseProductOptions(productOptionsJson);
                    productDto.setProductOptions(optionsList);
                    System.out.println("파싱된 옵션: " + optionsList);
                } catch (Exception e) {
                    System.out.println("상품 옵션 JSON 파싱 오류: " + e.getMessage());
                }
            }
            
            // 이미지 파일과 함께 상품 수정
            productService.updateProduct(productId, productDto, productImageFile);
            response.put("success", true);
            response.put("message", "상품이 성공적으로 수정되었습니다.");
            
        } catch (Exception e) {
            System.out.println("상품 수정 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        
        return response;
    }
    // JSON 문자열을 ProductOptionDto 리스트로 파싱하는 헬퍼 메서드
    private List<ProductRegistrationDto.ProductOptionDto> parseProductOptions(String json) {
        List<ProductRegistrationDto.ProductOptionDto> options = new ArrayList<>();
        
        try {
            // 간단한 JSON 파싱 (실제로는 Jackson ObjectMapper 사용 권장)
            // 예: [{"sizeId":1,"stock":10},{"sizeId":2,"stock":5}]
            json = json.trim();
            if (json.startsWith("[") && json.endsWith("]")) {
                json = json.substring(1, json.length() - 1); // 대괄호 제거
                
                if (!json.trim().isEmpty()) {
                    String[] items = json.split("\\},\\{");
                    for (String item : items) {
                        item = item.replace("{", "").replace("}", "").trim();
                        String[] pairs = item.split(",");
                        
                        ProductRegistrationDto.ProductOptionDto option = new ProductRegistrationDto.ProductOptionDto();
                        
                        for (String pair : pairs) {
                            String[] keyValue = pair.split(":");
                            if (keyValue.length == 2) {
                                String key = keyValue[0].trim().replace("\"", "");
                                String value = keyValue[1].trim().replace("\"", "");
                                
                                if ("sizeId".equals(key)) {
                                    option.setSizeId(Long.parseLong(value));
                                } else if ("stock".equals(key)) {
                                    option.setStock(Integer.parseInt(value));
                                }
                            }
                        }
                        
                        if (option.getSizeId() != null && option.getStock() != null) {
                            options.add(option);
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("JSON 파싱 오류: " + e.getMessage());
        }
        
        return options;
    }
}