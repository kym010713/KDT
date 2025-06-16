package com.kdt.project.order.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdt.project.buyer.entity.CartEntity;
import com.kdt.project.order.dto.OrderSummaryDTO;
import com.kdt.project.order.entity.OrderDetailEntity;
import com.kdt.project.order.entity.OrderEntity;
import com.kdt.project.order.repository.OrderDetailRepository;
import com.kdt.project.order.repository.OrderRepository;


@Service
public class OrderServiceImpl implements OrderService{
	
    @Autowired
    private OrderRepository       orderRepository;
    
    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Transactional
    @Override
    public void saveOrder(String userId,
                          List<CartEntity> cartList,
                          String orderAddress) {

        long orderGroup = System.currentTimeMillis();   // 주문 묶음번호

        /* 1) ORDERS 헤더 1줄만 저장 */
        OrderEntity head = new OrderEntity();
        head.setOrderGroup(orderGroup);
        head.setUserId(userId);
        head.setOrderAddress(orderAddress);
        head.setOrderCreated("Y");
        head.setOrderDate(new Date());
        orderRepository.save(head);     // ★ 반드시 한 번만 호출

        /* 2) ORDER_DETAIL 다건 저장 */
        for (CartEntity c : cartList) {
            OrderDetailEntity d = new OrderDetailEntity();
            d.setOrderGroup(orderGroup);
            d.setProductId(c.getProduct().getProductId());
            d.setQuantity(c.getCartCount());
            d.setOptionVal(c.getProductSize());
            orderDetailRepository.save(d);
        }
    }
    
    @Override
    public List<OrderSummaryDTO> getOrderList(String userId) {
        return orderRepository.findOrderSummaries(userId);
    }

    @Override
    public List<OrderSummaryDTO> getOrderListByPeriod(String userId,
                                                      Date startDate,
                                                      Date endDate) {
        return orderRepository.findSummaryByUserIdAndPeriod(userId, startDate, endDate);
    }


}
    
   