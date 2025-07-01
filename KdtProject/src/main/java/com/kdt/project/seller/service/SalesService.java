package com.kdt.project.seller.service;

import com.kdt.project.seller.dto.SalesDto;
import com.kdt.project.seller.dto.MonthlySalesDto;
import com.kdt.project.seller.dto.SalesAnalyticsDto;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.Delivery;
import com.kdt.project.order.entity.OrderDetailEntity;
import com.kdt.project.order.entity.OrderEntity;
import com.kdt.project.seller.repository.ProductSellerRepository;
import com.kdt.project.seller.repository.DeliveryRepository;
import com.kdt.project.order.repository.OrderDetailRepository;
import com.kdt.project.order.repository.OrderEntityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;

@Service
public class SalesService {
    
    @Autowired
    private ProductSellerRepository productSellerRepository;
    
    @Autowired
    private DeliveryRepository deliveryRepository;
    
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    @Autowired
    private OrderEntityRepository orderEntityRepository;
    
    private SalesDto createSalesDto(OrderEntity order, OrderDetailEntity orderDetail, Product product) {
        try {
            SalesDto salesDto = new SalesDto();
            salesDto.setOrderNumber(order.getOrderGroup());
            salesDto.setUserId(order.getUserId());
            salesDto.setProductName(product.getProductName());
            salesDto.setCompanyName(product.getCompanyName());
            salesDto.setProductPrice(String.valueOf(product.getProductPrice()));
            salesDto.setOrderDate(order.getOrderDate());
            salesDto.setOrderAddress(order.getOrderAddress());
            
            Optional<Delivery> deliveryOpt = deliveryRepository.findByOrderNumber(order.getOrderGroup());
            
            if (deliveryOpt.isPresent()) {
                Delivery delivery = deliveryOpt.get();
                salesDto.setDeliveryState(delivery.getDeliveryState());
                salesDto.setRequestDate(delivery.getRequestDate());
                salesDto.setCompleteDate(delivery.getCompleteDate());
            } else {
                salesDto.setDeliveryState("미등록");
            }
            
            return salesDto;
            
        } catch (Exception e) {
            System.out.println("Error creating SalesDto for order: " + order.getOrderId() + " - " + e.getMessage());
            return null;
        }
    }
    
    public List<SalesDto> getAllSales() {
        List<OrderDetailEntity> orderDetails = orderDetailRepository.findAll();
        List<SalesDto> salesList = new ArrayList<>();
        
        for (OrderDetailEntity orderDetail : orderDetails) {
            Optional<OrderEntity> orderOpt = orderEntityRepository.findByOrderGroup(orderDetail.getOrderGroup());
            if (orderOpt.isEmpty()) continue;
            OrderEntity order = orderOpt.get();
            
            Optional<Product> productOpt = productSellerRepository.findById(orderDetail.getProductId());
            if (productOpt.isEmpty()) continue;
            Product product = productOpt.get();
            
            SalesDto salesDto = createSalesDto(order, orderDetail, product);
            if (salesDto != null) {
                salesList.add(salesDto);
            }
        }
        
        return salesList;
    }
    
    public List<SalesDto> getSalesByCompany(String companyName) {
        List<OrderDetailEntity> allOrderDetails = orderDetailRepository.findAll();
        List<SalesDto> salesList = new ArrayList<>();
        
        for (OrderDetailEntity orderDetail : allOrderDetails) {
            Optional<OrderEntity> orderOpt = orderEntityRepository.findByOrderGroup(orderDetail.getOrderGroup());
            if (orderOpt.isEmpty()) continue;
            OrderEntity order = orderOpt.get();
            
            Optional<Product> productOpt = productSellerRepository.findById(orderDetail.getProductId());
            if (productOpt.isEmpty()) continue;
            Product product = productOpt.get();
            
            if (!companyName.equals(product.getCompanyName())) continue;
            
            SalesDto salesDto = createSalesDto(order, orderDetail, product);
            if (salesDto != null) {
                salesList.add(salesDto);
            }
        }
        
        return salesList;
    }
    
    // 월별 판매 내역 조회
    public List<SalesDto> getSalesByCompanyAndMonth(String companyName, String yearMonth) {
        List<SalesDto> allSales = getSalesByCompany(companyName);
        
        if (yearMonth == null || yearMonth.isEmpty()) {
            return allSales;
        }
        
        String[] parts = yearMonth.split("-");
        int year = Integer.parseInt(parts[0]);
        int month = Integer.parseInt(parts[1]);
        
        return allSales.stream()
            .filter(sales -> {
                if (sales.getOrderDate() == null) return false;
                LocalDate orderDate = sales.getOrderDate().toInstant()
                    .atZone(ZoneId.systemDefault()).toLocalDate();
                return orderDate.getYear() == year && orderDate.getMonthValue() == month;
            })
            .collect(Collectors.toList());
    }
    
    // 상태별 판매 내역 조회
    public List<SalesDto> getSalesByCompanyAndStatus(String companyName, String status) {
        List<SalesDto> allSales = getSalesByCompany(companyName);
        
        if (status == null || status.isEmpty()) {
            return allSales;
        }
        
        return allSales.stream()
            .filter(sales -> status.equals(sales.getDeliveryState()))
            .collect(Collectors.toList());
    }
    
    // 월별 + 상태별 판매 내역 조회
    public List<SalesDto> getSalesByCompanyMonthAndStatus(String companyName, String yearMonth, String status) {
        List<SalesDto> salesList = getSalesByCompanyAndMonth(companyName, yearMonth);
        
        if (status == null || status.isEmpty()) {
            return salesList;
        }
        
        return salesList.stream()
            .filter(sales -> status.equals(sales.getDeliveryState()))
            .collect(Collectors.toList());
    }
    
    // 월별 매출 통계 조회
    public List<MonthlySalesDto> getMonthlySalesByCompany(String companyName, int year) {
        List<SalesDto> allSales = getSalesByCompany(companyName);
        Map<Integer, MonthlySalesDto> monthlyMap = new HashMap<>();
        
        // 1-12월 초기화
        for (int month = 1; month <= 12; month++) {
            monthlyMap.put(month, new MonthlySalesDto(year, month, BigDecimal.ZERO, 0, BigDecimal.ZERO));
        }
        
        // 매출 데이터 집계
        allSales.stream()
            .filter(sales -> sales.getOrderDate() != null)
            .forEach(sales -> {
                LocalDate orderDate = sales.getOrderDate().toInstant()
                    .atZone(ZoneId.systemDefault()).toLocalDate();
                
                if (orderDate.getYear() == year) {
                    int month = orderDate.getMonthValue();
                    MonthlySalesDto monthlyDto = monthlyMap.get(month);
                    
                    BigDecimal price = new BigDecimal(sales.getProductPrice());
                    monthlyDto.setRevenue(monthlyDto.getRevenue().add(price));
                    monthlyDto.setOrderCount(monthlyDto.getOrderCount() + 1);
                    
                    if (monthlyDto.getOrderCount() > 0) {
                        monthlyDto.setAverageOrderValue(
                            monthlyDto.getRevenue().divide(
                                new BigDecimal(monthlyDto.getOrderCount()), 2, BigDecimal.ROUND_HALF_UP
                            )
                        );
                    }
                }
            });
        
        return monthlyMap.values().stream()
            .sorted((a, b) -> Integer.compare(a.getMonth(), b.getMonth()))
            .collect(Collectors.toList());
    }
    
    // 전체 판매 분석 데이터
    public SalesAnalyticsDto getSalesAnalytics(String companyName) {
        List<SalesDto> allSales = getSalesByCompany(companyName);
        
        // 총 매출 계산
        BigDecimal totalRevenue = allSales.stream()
            .map(sales -> new BigDecimal(sales.getProductPrice()))
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        // 총 주문 건수
        int totalOrders = allSales.size();
        
        // 평균 주문가
        BigDecimal averageOrderValue = totalOrders > 0 ? 
            totalRevenue.divide(new BigDecimal(totalOrders), 2, BigDecimal.ROUND_HALF_UP) : 
            BigDecimal.ZERO;
        
        // 배송 완료 건수
        long completedDeliveries = allSales.stream()
            .filter(sales -> "COMPLETED".equals(sales.getDeliveryState()))
            .count();
        
        // 현재 월과 이전 월 비교
        LocalDate now = LocalDate.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();
        int previousMonth = currentMonth == 1 ? 12 : currentMonth - 1;
        int previousYear = currentMonth == 1 ? currentYear - 1 : currentYear;
        
        // 현재 월 데이터
        BigDecimal currentMonthRevenue = allSales.stream()
            .filter(sales -> {
                if (sales.getOrderDate() == null) return false;
                LocalDate orderDate = sales.getOrderDate().toInstant()
                    .atZone(ZoneId.systemDefault()).toLocalDate();
                return orderDate.getYear() == currentYear && orderDate.getMonthValue() == currentMonth;
            })
            .map(sales -> new BigDecimal(sales.getProductPrice()))
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        // 이전 월 데이터
        BigDecimal previousMonthRevenue = allSales.stream()
            .filter(sales -> {
                if (sales.getOrderDate() == null) return false;
                LocalDate orderDate = sales.getOrderDate().toInstant()
                    .atZone(ZoneId.systemDefault()).toLocalDate();
                return orderDate.getYear() == previousYear && orderDate.getMonthValue() == previousMonth;
            })
            .map(sales -> new BigDecimal(sales.getProductPrice()))
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        // 증감률 계산
        BigDecimal revenueChangeRate = BigDecimal.ZERO;
        if (previousMonthRevenue.compareTo(BigDecimal.ZERO) > 0) {
            revenueChangeRate = currentMonthRevenue.subtract(previousMonthRevenue)
                .divide(previousMonthRevenue, 4, BigDecimal.ROUND_HALF_UP)
                .multiply(new BigDecimal(100));
        }
        
        return new SalesAnalyticsDto(
            totalRevenue,
            totalOrders,
            averageOrderValue,
            (int) completedDeliveries,
            revenueChangeRate
        );
    }
    
    // 상품별 매출 비중 조회
    public Map<String, BigDecimal> getProductRevenueShare(String companyName) {
        List<SalesDto> allSales = getSalesByCompany(companyName);
        Map<String, BigDecimal> productRevenue = new HashMap<>();
        
        allSales.forEach(sales -> {
            String productName = sales.getProductName();
            BigDecimal price = new BigDecimal(sales.getProductPrice());
            productRevenue.merge(productName, price, BigDecimal::add);
        });
        
        return productRevenue.entrySet().stream()
            .sorted((a, b) -> b.getValue().compareTo(a.getValue()))
            .limit(5) // 상위 5개 상품만
            .collect(Collectors.toMap(
                Map.Entry::getKey,
                Map.Entry::getValue,
                (e1, e2) -> e1,
                LinkedHashMap::new
            ));
    }
    
    public boolean updateDeliveryStatus(Long orderNumber, String newStatus) {
        try {
            Optional<Delivery> deliveryOpt = deliveryRepository.findByOrderNumber(orderNumber);
            
            if (deliveryOpt.isPresent()) {
                Delivery delivery = deliveryOpt.get();
                delivery.setDeliveryState(newStatus);
                
                if ("COMPLETED".equals(newStatus)) {
                    delivery.setCompleteDate(new java.util.Date());
                }
                
                deliveryRepository.save(delivery);
                return true;
            } else {
                Delivery newDelivery = new Delivery();
                newDelivery.setOrderNumber(orderNumber);
                newDelivery.setDeliveryState(newStatus);
                newDelivery.setRequestDate(new java.util.Date());
                
                if ("COMPLETED".equals(newStatus)) {
                    newDelivery.setCompleteDate(new java.util.Date());
                }
                
                newDelivery.setDeliveryId(System.currentTimeMillis());
                
                deliveryRepository.save(newDelivery);
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error updating delivery status: " + e.getMessage());
            return false;
        }
    }
}