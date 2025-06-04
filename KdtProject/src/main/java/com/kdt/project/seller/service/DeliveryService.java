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
public class DeliveryService {
    
    @Autowired
    private OrdersRepository ordersRepository;
    
    @Autowired
    private ProductSellerRepository productSellerRepository;
    
    @Autowired
    private DeliveryRepository deliveryRepository;
    
    // 전체 배송 관리 목록 조회
    public List<SalesDto> getAllDeliveries() {
        List<Orders> orders = ordersRepository.findAllByOrderByOrderDateDesc();
        List<SalesDto> deliveryList = new ArrayList<>();
        
        for (Orders order : orders) {
            SalesDto deliveryDto = createDeliveryDto(order);
            if (deliveryDto != null) {
                deliveryList.add(deliveryDto);
            }
        }
        
        return deliveryList;
    }
    
    // 특정 배송 상태의 주문들만 조회
    public List<SalesDto> getDeliveriesByStatus(String deliveryStatus) {
        List<Orders> orders = ordersRepository.findAllByOrderByOrderDateDesc();
        List<SalesDto> deliveryList = new ArrayList<>();
        
        for (Orders order : orders) {
            SalesDto deliveryDto = createDeliveryDto(order);
            if (deliveryDto != null) {
                // 배송 상태 필터링
                if ("ALL".equals(deliveryStatus) || 
                    (deliveryDto.getDeliveryState() != null && deliveryDto.getDeliveryState().equals(deliveryStatus)) ||
                    ("미등록".equals(deliveryStatus) && "미등록".equals(deliveryDto.getDeliveryState()))) {
                    deliveryList.add(deliveryDto);
                }
            }
        }
        
        return deliveryList;
    }
    
    // 배송 상태 변경
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
                
                // 새로운 DELIVERY_ID 생성
                newDelivery.setDeliveryId(System.currentTimeMillis());
                
                deliveryRepository.save(newDelivery);
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error updating delivery status: " + e.getMessage());
            return false;
        }
    }
    
    private SalesDto createDeliveryDto(Orders order) {
        try {
            // Product 정보 조회
            Optional<Product> productOpt = productSellerRepository.findById(order.getProductId());
            if (productOpt.isEmpty()) {
                return null;
            }
            Product product = productOpt.get();
            
            // Delivery 정보 조회
            Optional<Delivery> deliveryOpt = deliveryRepository.findByOrderNumber(order.getOrderNumber());
            
            SalesDto deliveryDto = new SalesDto();
            deliveryDto.setOrderNumber(order.getOrderNumber());
            deliveryDto.setUserId(order.getUserId());
            deliveryDto.setProductName(product.getProductName());
            deliveryDto.setCompanyName(product.getCompanyName());
            deliveryDto.setProductPrice(String.valueOf(product.getProductPrice())); // Long을 String으로 변환
            deliveryDto.setOrderDate(order.getOrderDate());
            deliveryDto.setOrderAddress(order.getOrderAddress());
            
            if (deliveryOpt.isPresent()) {
                Delivery delivery = deliveryOpt.get();
                deliveryDto.setDeliveryState(delivery.getDeliveryState());
                deliveryDto.setRequestDate(delivery.getRequestDate());
                deliveryDto.setCompleteDate(delivery.getCompleteDate());
            } else {
                deliveryDto.setDeliveryState("미등록");
            }
            
            return deliveryDto;
            
        } catch (Exception e) {
            System.out.println("Error creating DeliveryDto for order: " + order.getOrderNumber() + " - " + e.getMessage());
            return null;
        }
    }
}