package com.kdt.project.buyer.entity;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum CategoryCode {
    TOP("상의"),
    BOTTOM("하의"),
    OUTER("아우터"),
    SHOES("신발"),
    ACCESSORY("액세서리");

    private final String korName;

    // 코드 → 한글명
    public static String toKor(String code) {
        return valueOf(code.toUpperCase()).getKorName();
    }
}