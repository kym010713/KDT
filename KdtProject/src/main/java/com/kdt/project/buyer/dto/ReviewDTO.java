package com.kdt.project.buyer.dto;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewDTO {
    private Long reviewId;
    private String productId;
    private String userId;
    private int score;
    private String content;
    private Date reviewDate;
    private String reviewImageUrl;
    private String imageFileId;
    private String userName;
}
