package com.kdt.project.seller.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "SIZES")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Sizes {
    
    @Id
    @Column(name = "SIZE_ID")
    private Long sizeId;
    
    @Column(name = "SIZE_NAME", nullable = false)
    private String sizeName;
    
    
    public Long getSizeId() {
        return sizeId;
    }
    
    public void setSizeId(Long sizeId) {
        this.sizeId = sizeId;
    }
    
    public String getSizeName() {
        return sizeName;
    }
    
    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }
}