package com.kdt.project.buyer.service;

import java.util.List;

import com.kdt.project.buyer.entity.CartEntity;
import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.buyer.entity.ProductOptionEntity;
import com.kdt.project.user.dto.UserDto;

public interface BuyerService {

    UserDto getMyPage(String userId);

    List<ProductEntity> getAllProducts();

    ProductEntity getProductById(String productId);

    List<ProductOptionEntity> getProductOptionsByProductId(String productId);

//    void addToCart(String userId, String productId, Long sizeId, int count);
//
//    List<CartEntity> getCartItems(String userId);
}
