package com.kdt.project.buyer.service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.kdt.project.buyer.dto.CartDTO;
import com.kdt.project.buyer.dto.ReviewDTO;
import com.kdt.project.buyer.entity.CartEntity;
import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.buyer.entity.ProductOptionEntity;
import com.kdt.project.buyer.entity.ReviewEntity;
import com.kdt.project.buyer.repository.CartRepository;
import com.kdt.project.buyer.repository.ProductOptionRepository;
import com.kdt.project.buyer.repository.ProductRepository;
import com.kdt.project.buyer.repository.ReviewRepository;
import com.kdt.project.buyer.repository.SizeRepository;
import com.kdt.project.user.dto.UserDto;
import com.kdt.project.user.entity.UserEntity;
import com.kdt.project.user.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BuyerServiceImpl implements BuyerService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final ProductOptionRepository optionRepository;
    private final SizeRepository sizeRepository;
    private final ReviewRepository ReviewRepository;
    
    
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

    // ✅ 장바구니 목록 조회
    @Override
    public List<CartDTO> getCartList(String userId) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        List<CartEntity> carts = cartRepository.findByUser(user);

        return carts.stream().map(cart -> {
            CartDTO dto = new CartDTO();
            dto.setCartId(cart.getCartId());
            dto.setProductId(cart.getProduct().getProductId());
            dto.setProductName(cart.getProduct().getProductName());
            dto.setProductPhoto(cart.getProduct().getProductPhoto());
            dto.setCartCount(cart.getCartCount());
            dto.setProductSize(cart.getProductSize());
            return dto;
        }).toList();
    }

    // ✅ 장바구니 추가
    @Override
    public void addToCart(String userId, String productId, String productSize, int count) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));
        ProductEntity product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));

        // 기존에 같은 상품+사이즈가 있는지 조회
        CartEntity existingCart = cartRepository.findByUser_IdAndProduct_ProductIdAndProductSize(userId, productId, productSize);

        if (existingCart != null) {
            // 있으면 수량 더하기
            existingCart.setCartCount(existingCart.getCartCount() + count);
            cartRepository.save(existingCart);
        } else {
            // 없으면 새로 추가
            CartEntity cart = new CartEntity();
            cart.setUser(user);
            cart.setProduct(product);
            cart.setProductSize(productSize);
            cart.setCartCount(count);
            cart.setCartDate(new Date());

            cartRepository.save(cart);
        }
    }


    // ✅ 장바구니에서 항목 삭제
    @Override
    public void removeFromCart(Long cartId) {
        if (!cartRepository.existsById(cartId)) {
            throw new RuntimeException("장바구니 항목을 찾을 수 없습니다.");
        }
        cartRepository.deleteById(cartId);
    }
    
 // 리뷰 목록 조회
    @Override
    public List<ReviewDTO> getReviewsByProductId(String productId) {
        List<ReviewEntity> reviews = ReviewRepository.findByProduct_ProductId(productId);

        return reviews.stream().map(review -> {
            ReviewDTO dto = new ReviewDTO();
            dto.setReviewId(review.getReviewId());
            dto.setProductId(review.getProduct().getProductId());
            dto.setUserId(review.getUser().getId());
            dto.setContent(review.getReviewContent());
            dto.setScore(review.getReviewScore());
            dto.setReviewDate(review.getReviewDate());
            return dto;
        }).collect(Collectors.toList());
    }

    // 리뷰 등록
    @Override
    public void addReview(ReviewDTO reviewDto) {
        ReviewEntity review = new ReviewEntity();
        review.setReviewContent(reviewDto.getContent());
        review.setReviewScore(reviewDto.getScore());
        review.setReviewDate(new Date());

        ProductEntity product = productRepository.findById(reviewDto.getProductId())
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
        UserEntity user = userRepository.findById(reviewDto.getUserId())
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        review.setProduct(product);
        review.setUser(user);

        ReviewRepository.save(review);
    }
    
    
}
