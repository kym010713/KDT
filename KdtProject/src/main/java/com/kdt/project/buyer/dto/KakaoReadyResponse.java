package com.kdt.project.buyer.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;

@Getter
public class KakaoReadyResponse {
    private String tid;

    @JsonProperty("next_redirect_pc_url")
    private String nextRedirectPcUrl;
}