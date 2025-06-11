package com.kdt.project.buyer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.kdt.project.buyer.entity.CartEntity;
import com.kdt.project.user.entity.UserEntity;

@Repository
public interface CartRepository extends JpaRepository<CartEntity, Long> {

    // 유저 기준으로 장바구니 전체 조회
    List<CartEntity> findByUser(UserEntity user);

    // 유저 + 상품 + 사이즈로 이미 담긴 상품인지 확인
    boolean existsByUser_IdAndProduct_ProductIdAndProductSize(String userId, String productId, String productSize);

    // 유저의 특정 상품 조회
    List<CartEntity> findByUser_IdAndProduct_ProductId(String userId, String productId);

    // 유저의 장바구니 전체 삭제
    void deleteByUser(UserEntity user);
    
    CartEntity findByUser_IdAndProduct_ProductIdAndProductSize(String userId, String productId, String productSize);
	
    @Modifying
    @Query("UPDATE CartEntity c SET c.cartCount = :cartCount WHERE c.cartId = :cartId")
    void updateCartCount(@Param("cartId") Long cartId, @Param("cartCount") int cartCount);

}
