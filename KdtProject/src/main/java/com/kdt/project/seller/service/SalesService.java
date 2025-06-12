package com.kdt.project.seller.service;

import com.kdt.project.seller.dto.SalesDto;
import com.kdt.project.seller.entity.Product;
import com.kdt.project.seller.entity.Delivery;
import com.kdt.project.order.entity.OrderDetailEntity;
import com.kdt.project.order.entity.OrderEntity;
import com.kdt.project.seller.repository.ProductSellerRepository;
import com.kdt.project.seller.repository.DeliveryRepository;
import com.kdt.project.order.repository.OrderDetailRepository;
import com.kdt.project.order.repository.OrderEntityRepository; // 새로 생성한 Repository
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.ArrayList;
import java.util.Optional;

@Service
public class SalesService {
    
    @Autowired
    private ProductSellerRepository productSellerRepository;
    
    @Autowired
    private DeliveryRepository deliveryRepository;
    
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    @Autowired
    private OrderEntityRepository orderEntityRepository; // 새로 추가
    
    private SalesDto createSalesDto(OrderEntity order, OrderDetailEntity orderDetail, Product product) {
        try {
            SalesDto salesDto = new SalesDto();
            salesDto.setOrderNumber(order.getOrderGroup()); // ORDER_GROUP 사용
            salesDto.setUserId(order.getUserId());
            salesDto.setProductName(product.getProductName());
            salesDto.setCompanyName(product.getCompanyName());
            salesDto.setProductPrice(String.valueOf(product.getProductPrice()));
            salesDto.setOrderDate(order.getOrderDate());
            salesDto.setOrderAddress(order.getOrderAddress());
            
            // Delivery 정보 조회 (ORDER_GROUP 기준)
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
            // 주문 정보 조회
            Optional<OrderEntity> orderOpt = orderEntityRepository.findByOrderGroup(orderDetail.getOrderGroup());
            if (orderOpt.isEmpty()) continue;
            OrderEntity order = orderOpt.get();
            
            // 상품 정보 조회
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
            // 주문 정보 조회
            Optional<OrderEntity> orderOpt = orderEntityRepository.findByOrderGroup(orderDetail.getOrderGroup());
            if (orderOpt.isEmpty()) continue;
            OrderEntity order = orderOpt.get();
            
            // 상품 정보 조회
            Optional<Product> productOpt = productSellerRepository.findById(orderDetail.getProductId());
            if (productOpt.isEmpty()) continue;
            Product product = productOpt.get();
            
            // 회사명 필터링
            if (!companyName.equals(product.getCompanyName())) continue;
            
            SalesDto salesDto = createSalesDto(order, orderDetail, product);
            if (salesDto != null) {
                salesList.add(salesDto);
            }
        }
        
        return salesList;
    }
    
    public boolean updateDeliveryStatus(Long orderNumber, String newStatus) {
        try {
            // orderNumber는 ORDER_GROUP
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
                newDelivery.setOrderNumber(orderNumber); // ORDER_GROUP
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
}