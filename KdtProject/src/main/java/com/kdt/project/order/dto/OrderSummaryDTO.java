package com.kdt.project.order.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;

import com.kdt.project.order.entity.DeliveryState;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderSummaryDTO {

	private Long orderGroup;
	private LocalDateTime orderDate;
	private String address;
	private BigDecimal totalPrice;
	private DeliveryState deliveryState;

	public OrderSummaryDTO(Long orderGroup, java.util.Date orderDate, String deliveryState) { // ← String 으로 받음
		this.orderGroup = orderGroup;
		this.orderDate = orderDate == null ? null
				: LocalDateTime.ofInstant(orderDate.toInstant(), ZoneId.systemDefault());
		this.deliveryState = DeliveryState.valueOf(deliveryState == null ? "REQUESTED" : deliveryState);
	}


	public OrderSummaryDTO(Long orderGroup, java.util.Date orderDate, String address, BigDecimal totalPrice,
			DeliveryState deliveryState) {
		this(orderGroup,
				orderDate == null ? null : LocalDateTime.ofInstant(orderDate.toInstant(), ZoneId.systemDefault()),
				address, totalPrice, deliveryState);
	}

	public String getFormattedOrderDate() {
		return orderDate == null ? ""
				: orderDate.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
	}

	public String getDeliveryStateText() { // 헬퍼
		return deliveryState == null ? "배송 준비중" : switch (deliveryState) {
		case REQUESTED -> "배송 준비중";
		case IN_PROGRESS -> "배송 중";
		case COMPLETED -> "배송 완료";
		};
	}

}
