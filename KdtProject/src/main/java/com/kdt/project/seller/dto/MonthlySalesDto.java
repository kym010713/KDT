package com.kdt.project.seller.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MonthlySalesDto {
    
    private int year;                    // 년도
    private int month;                   // 월
    private BigDecimal revenue;          // 매출액
    private int orderCount;              // 주문 건수
    private BigDecimal averageOrderValue; // 평균 주문가
    
    // 월 이름 반환 (1월, 2월, ...)
    public String getMonthName() {
        return month + "월";
    }
    
    // 년월 문자열 반환 (2025년 1월)
    public String getYearMonthName() {
        return year + "년 " + month + "월";
    }
}