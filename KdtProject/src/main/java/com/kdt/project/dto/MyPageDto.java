package com.kdt.project.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MyPageDto {
    private String id;
    private String name;
    private String email;
    private String address;
}
