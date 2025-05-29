package com.kdt.project.buyer.service;

import java.util.List;

import com.kdt.project.buyer.entity.ProductDetailEntity;
import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.user.dto.UserDto;

public interface BuyerService {
	UserDto getMyPage(String userId);
	
	List<ProductEntity> getAllProducts();
	
	ProductDetailEntity getProductDetailById(String productId);

}
