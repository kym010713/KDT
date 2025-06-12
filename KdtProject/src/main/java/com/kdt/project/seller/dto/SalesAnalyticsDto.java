package com.kdt.project.seller.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SalesAnalyticsDto {
    
    private BigDecimal totalRevenue;        // 총 매출
    private int totalOrders;                // 총 주문 건수
    private BigDecimal averageOrderValue;   // 평균 주문가
    private int completedDeliveries;        // 배송 완료 건수
    private BigDecimal revenueChangeRate;   // 매출 증감률 (%)
    
    // 포맷된 매출 문자열 반환
    public String getFormattedRevenue() {
        if (totalRevenue == null) return "0원";
        return String.format("%,d원", totalRevenue.longValue());
    }
    
    // 포맷된 평균 주문가 문자열 반환
    public String getFormattedAverageOrderValue() {
        if (averageOrderValue == null) return "0원";
        return String.format("%,d원", averageOrderValue.longValue());
    }
    
    // 포맷된 증감률 문자열 반환
    public String getFormattedChangeRate() {
        if (revenueChangeRate == null) return "0%";
        String sign = revenueChangeRate.compareTo(BigDecimal.ZERO) >= 0 ? "+" : "";
        return sign + String.format("%.1f%%", revenueChangeRate.doubleValue());
    }
    
    // 증감률 상태 반환 (positive, negative, neutral)
    public String getChangeStatus() {
        if (revenueChangeRate == null || revenueChangeRate.compareTo(BigDecimal.ZERO) == 0) {
            return "neutral";
        }
        return revenueChangeRate.compareTo(BigDecimal.ZERO) > 0 ? "positive" : "negative";
    }
}