package com.kdt.project.order.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kdt.project.buyer.entity.CartEntity;
import com.kdt.project.order.dto.OrderSummaryDTO;

@Service
public interface OrderService {
    void saveOrder(String userId, List<CartEntity> cartList, String orderAddress);
    List<OrderSummaryDTO> getOrderList(String userId);
}
