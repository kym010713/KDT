package com.kdt.project.seller.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "TOP_CATEGORY")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TopCategory {
    
    @Id
    @Column(name = "TOP_NAME")
    private String topName;
}