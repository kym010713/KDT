package com.kdt.project.buyer.service;

import java.util.List;

import com.kdt.project.buyer.dto.CartDto;
import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.buyer.entity.ProductOptionEntity;
import com.kdt.project.user.dto.UserDto;

public interface BuyerService {

    UserDto getMyPage(String userId);

    List<ProductEntity> getAllProducts();

    ProductEntity getProductById(String productId);

    List<ProductOptionEntity> getProductOptionsByProductId(String productId);

    // 🔽 장바구니 관련 기능 추가
    List<CartDto> getCartList(String userId);

    void addToCart(String userId, String productId, String productSize, int count);

    void removeFromCart(Long cartId);
}
