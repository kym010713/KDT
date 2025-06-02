package com.kdt.project.buyer.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kdt.project.buyer.entity.CartEntity;
import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.buyer.entity.ProductOptionEntity;
import com.kdt.project.buyer.entity.SizeEntity;
import com.kdt.project.buyer.repository.CartRepository;
import com.kdt.project.buyer.repository.ProductOptionRepository;
import com.kdt.project.buyer.repository.ProductRepository;
import com.kdt.project.buyer.repository.SizeRepository;
import com.kdt.project.buyer.repository.UserRepository;
import com.kdt.project.user.dto.UserDto;
import com.kdt.project.user.entity.UserEntity;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BuyerServiceImpl implements BuyerService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final ProductOptionRepository optionRepository;
    private final SizeRepository sizeRepository;

    @Override
    public UserDto getMyPage(String userId) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        return UserDto.builder()
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .address(user.getAddress())
                .build();
    }

    @Override
    public List<ProductEntity> getAllProducts() {
        return productRepository.findAll();
    }

    @Override
    public ProductEntity getProductById(String productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
    }

    @Override
    public List<ProductOptionEntity> getProductOptionsByProductId(String productId) {
        return optionRepository.findByProduct_ProductId(productId);
    }
//
//    @Override
//    public void addToCart(String userId, String productId, Long sizeId, int count) {
//        UserEntity user = userRepository.findById(userId)
//                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));
//        
//        ProductEntity product = productRepository.findById(productId)
//                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
//        
//        SizeEntity size = sizeRepository.findById(sizeId)
//                .orElseThrow(() -> new RuntimeException("사이즈를 찾을 수 없습니다."));
//
//        CartEntity cart = new CartEntity();
//        cart.setUser(user);
//        cart.setProduct(product);
//        cart.setSize(size);
//        cart.setCartCount(count);
//        cart.setCartDate(new Date());
//
//        cartRepository.save(cart);
//    }
//
//    @Override
//    public List<CartEntity> getCartItems(String userId) {
//        UserEntity user = userRepository.findById(userId)
//                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));
//        return cartRepository.findByUser_Id(user.getId());
//    }
}
