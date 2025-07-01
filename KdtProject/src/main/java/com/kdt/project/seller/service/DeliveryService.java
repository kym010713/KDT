package com.kdt.project.seller.service;

import com.kdt.project.seller.dto.SalesDto;
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

import java.util.List;
import java.util.ArrayList;
import java.util.Optional;

@Service
public class DeliveryService {
    
    @Autowired
    private ProductSellerRepository productSellerRepository;
    
    @Autowired
    private DeliveryRepository deliveryRepository;
    
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    @Autowired
    private OrderEntityRepository orderEntityRepository; // 새로 추가
    
    // 전체 배송 관리 목록 조회
    public List<SalesDto> getAllDeliveries() {
        List<OrderDetailEntity> orderDetails = orderDetailRepository.findAll();
        List<SalesDto> deliveryList = new ArrayList<>();
        
        for (OrderDetailEntity orderDetail : orderDetails) {
            SalesDto deliveryDto = createDeliveryDto(orderDetail);
            if (deliveryDto != null) {
                deliveryList.add(deliveryDto);
            }
        }
        
        return deliveryList;
    }
    
    // 특정 배송 상태의 주문들만 조회
    public List<SalesDto> getDeliveriesByStatus(String deliveryStatus) {
        List<OrderDetailEntity> orderDetails = orderDetailRepository.findAll();
        List<SalesDto> deliveryList = new ArrayList<>();
        
        for (OrderDetailEntity orderDetail : orderDetails) {
            SalesDto deliveryDto = createDeliveryDto(orderDetail);
            if (deliveryDto != null) {
                if ("ALL".equals(deliveryStatus) || 
                    (deliveryDto.getDeliveryState() != null && deliveryDto.getDeliveryState().equals(deliveryStatus)) ||
                    ("미등록".equals(deliveryStatus) && "미등록".equals(deliveryDto.getDeliveryState()))) {
                    deliveryList.add(deliveryDto);
                }
            }
        }
        
        return deliveryList;
    }
    
    // 특정 회사의 배송 상태별 주문들만 조회
    public List<SalesDto> getDeliveriesByStatusAndCompany(String deliveryStatus, String companyName) {
        List<OrderDetailEntity> allOrderDetails = orderDetailRepository.findAll();
        List<SalesDto> deliveryList = new ArrayList<>();
        
        for (OrderDetailEntity orderDetail : allOrderDetails) {
            SalesDto deliveryDto = createDeliveryDto(orderDetail);
            if (deliveryDto != null && companyName.equals(deliveryDto.getCompanyName())) {
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
            System.out.println("=== 배송 상태 변경 시작 ===");
            System.out.println("주문번호(ORDER_GROUP): " + orderNumber + ", 새 상태: " + newStatus);
            
            // ORDER_GROUP 기준으로 배송 정보 조회
            Optional<Delivery> deliveryOpt = deliveryRepository.findByOrderNumber(orderNumber);
            
            if (deliveryOpt.isPresent()) {
                Delivery delivery = deliveryOpt.get();
                String oldStatus = delivery.getDeliveryState();
                delivery.setDeliveryState(newStatus);
                
                // 배송 완료시 완료일 설정
                if ("COMPLETED".equals(newStatus)) {
                    delivery.setCompleteDate(new java.util.Date());
                }
                
                deliveryRepository.save(delivery);
                System.out.println("배송 상태 업데이트: " + oldStatus + " → " + newStatus);
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
                
                newDelivery.setDeliveryId(System.currentTimeMillis());
                
                deliveryRepository.save(newDelivery);
                System.out.println("새 배송 정보 생성: " + newStatus);
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error updating delivery status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private SalesDto createDeliveryDto(OrderDetailEntity orderDetail) {
        try {
            // 주문 정보 조회
            Optional<OrderEntity> orderOpt = orderEntityRepository.findByOrderGroup(orderDetail.getOrderGroup());
            if (orderOpt.isEmpty()) {
                System.out.println("주문을 찾을 수 없음: ORDER_GROUP = " + orderDetail.getOrderGroup());
                return null;
            }
            OrderEntity order = orderOpt.get();
            
            // 상품 정보 조회
            Optional<Product> productOpt = productSellerRepository.findById(orderDetail.getProductId());
            if (productOpt.isEmpty()) {
                System.out.println("상품을 찾을 수 없음: " + orderDetail.getProductId());
                return null;
            }
            Product product = productOpt.get();
            
            // Delivery 정보 조회 (ORDER_GROUP 기준)
            Optional<Delivery> deliveryOpt = deliveryRepository.findByOrderNumber(order.getOrderGroup());
            
            SalesDto deliveryDto = new SalesDto();
            deliveryDto.setOrderNumber(order.getOrderGroup()); // ORDER_GROUP 사용
            deliveryDto.setUserId(order.getUserId());
            deliveryDto.setProductName(product.getProductName());
            deliveryDto.setCompanyName(product.getCompanyName());
            deliveryDto.setProductPrice(String.valueOf(product.getProductPrice()));
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
            System.out.println("Error creating DeliveryDto for orderDetail: " + orderDetail.getDetailId() + " - " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}