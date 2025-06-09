package com.kdt.project.buyer.dto;

import lombok.Getter;

@Getter
public class KakaoApproveResponse {
    private String aid;
    private String tid;
    private String cid;
    private String partner_order_id;
    private String partner_user_id;
    private Amount amount;

    @Getter
    public static class Amount {
        private int total;
        private int tax_free;
        private int vat;
    }
}