package com.kdt.project.seller.service;

import com.kdt.project.seller.dto.SalesDto;
import com.kdt.project.seller.entity.Orders;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.Delivery;
import com.kdt.project.seller.repository.OrdersRepository;
import com.kdt.project.seller.repository.ProductSellerRepository;
import com.kdt.project.seller.repository.DeliveryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.ArrayList;
import java.util.Optional;

@Service
public class SalesService {
    
    @Autowired
    private OrdersRepository ordersRepository;
    
    @Autowired
    private ProductSellerRepository productSellerRepository;
    
    private SalesDto createSalesDto(Orders order) {
        try {
            // Product 정보 조회
            Optional<Product> productOpt = productSellerRepository.findById(order.getProductId());  // 이름 변경
            if (productOpt.isEmpty()) {
                return null;
            }
            Product product = productOpt.get();
            
            // Delivery 정보 조회
            Optional<Delivery> deliveryOpt = deliveryRepository.findByOrderNumber(order.getOrderNumber());
            
            SalesDto salesDto = new SalesDto();
            salesDto.setOrderNumber(order.getOrderNumber());
            salesDto.setUserId(order.getUserId());
            salesDto.setProductName(product.getProductName());
            salesDto.setCompanyName(product.getCompanyName());
            salesDto.setProductPrice(String.valueOf(product.getProductPrice())); // Long을 String으로 변환
            salesDto.setOrderDate(order.getOrderDate());
            salesDto.setOrderAddress(order.getOrderAddress());
            
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
            System.out.println("Error creating SalesDto for order: " + order.getOrderNumber() + " - " + e.getMessage());
            return null;
        }
    }
    
    @Autowired
    private DeliveryRepository deliveryRepository;
    
    public List<SalesDto> getAllSales() {
        List<Orders> orders = ordersRepository.findAllByOrderByOrderDateDesc();
        List<SalesDto> salesList = new ArrayList<>();
        
        for (Orders order : orders) {
            SalesDto salesDto = createSalesDto(order);
            if (salesDto != null) {
                salesList.add(salesDto);
            }
        }
        
        return salesList;
    }
    
    public List<SalesDto> getSalesByCompany(String companyName) {
        List<Orders> orders = ordersRepository.findByCompanyNameOrderByOrderDateDesc(companyName);
        List<SalesDto> salesList = new ArrayList<>();
        
        for (Orders order : orders) {
            SalesDto salesDto = createSalesDto(order);
            if (salesDto != null) {
                salesList.add(salesDto);
            }
        }
        
        return salesList;
    }
    
    public boolean updateDeliveryStatus(Long orderNumber, String newStatus) {
        try {
            Optional<Delivery> deliveryOpt = deliveryRepository.findByOrderNumber(orderNumber);
            
            if (deliveryOpt.isPresent()) {
                Delivery delivery = deliveryOpt.get();
                delivery.setDeliveryState(newStatus);
                
                // 배송 완료시 완료일 설정
                if ("COMPLETED".equals(newStatus)) {
                    delivery.setCompleteDate(new java.util.Date());
                }
                
                deliveryRepository.save(delivery);
                return true;
            } else {
                // 배송 정보가 없으면 새로 생성
                Delivery newDelivery = new Delivery();
                newDelivery.setOrderNumber(orderNumber);
                newDelivery.setDeliveryState(newStatus);
                newDelivery.setRequestDate(new java.util.Date());
                
                if ("COMPLETED".equals(newStatus)) {
                    newDelivery.setCompleteDate(new java.util.Date());
                }
                
                // 새로운 DELIVERY_ID 생성 (간단하게 현재 시간 기반)
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