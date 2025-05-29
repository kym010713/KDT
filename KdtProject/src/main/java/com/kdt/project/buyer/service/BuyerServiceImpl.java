package com.kdt.project.buyer.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kdt.project.buyer.entity.ProductDetailEntity;
import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.buyer.repository.ProductDetailRepository;
import com.kdt.project.buyer.repository.ProductRepository;
import com.kdt.project.buyer.repository.UserRepository;
import com.kdt.project.user.dto.UserDto;
import com.kdt.project.user.entity.UserEntity;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BuyerServiceImpl implements BuyerService {

    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final ProductDetailRepository detailRepository;


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
    public ProductDetailEntity getProductDetailById(String productId) {
        return detailRepository.findByProductId(productId);
    }

}
