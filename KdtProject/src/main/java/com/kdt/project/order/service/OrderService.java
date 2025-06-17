package com.kdt.project.order.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kdt.project.buyer.entity.CartEntity;
import com.kdt.project.order.dto.OrderSummaryDTO;

@Service
public interface OrderService {
    void saveOrder(String userId, List<CartEntity> cartList, String orderAddress);
    List<OrderSummaryDTO> getOrderList(String userId);
    List<OrderSummaryDTO> getOrderListByPeriod(String userId, Date startDate, Date endDate);

}
