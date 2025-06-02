package com.kdt.project.buyer.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "SIZES")
@Getter @Setter
public class SizeEntity {
    @Id
    @Column(name = "SIZE_ID")
    private Long sizeId;

    @Column(name = "SIZE_NAME")
    private String sizeName;
}
