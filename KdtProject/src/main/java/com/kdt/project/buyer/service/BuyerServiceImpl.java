package com.kdt.project.buyer.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

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

import io.imagekit.sdk.ImageKit;
import io.imagekit.sdk.models.FileCreateRequest;
import io.imagekit.sdk.models.results.Result;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BuyerServiceImpl implements BuyerService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final ProductOptionRepository optionRepository;
    private final SizeRepository sizeRepository;
    private final ReviewRepository reviewRepository;
    private final ImageKit imageKit;

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
        return productRepository.findById(productId).orElse(null);
    }

    @Override
    public List<ProductOptionEntity> getProductOptionsByProductId(String productId) {
        return optionRepository.findByProduct_ProductId(productId);
    }

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
            dto.setProductPrice(cart.getProduct().getProductPrice().intValue());

            return dto;
        }).toList();
    }

    @Override
    @Transactional
    public void addToCart(String userId, String productId, String productSize, int count) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));
        ProductEntity product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));

        CartEntity existingCart = cartRepository.findByUser_IdAndProduct_ProductIdAndProductSize(userId, productId, productSize);

        if (existingCart != null) {
            existingCart.setCartCount(existingCart.getCartCount() + count);
            cartRepository.save(existingCart);
        } else {
            CartEntity cart = new CartEntity();
            cart.setUser(user);
            cart.setProduct(product);
            cart.setProductSize(productSize);
            cart.setCartCount(count);
            cart.setCartDate(new Date());
            cartRepository.save(cart);
        }
    }

    @Transactional
    @Override
    public void deleteCartItem(Long cartId) {
        if (!cartRepository.existsById(cartId)) {
            throw new RuntimeException("장바구니 항목을 찾을 수 없습니다.");
        }
        cartRepository.deleteById(cartId);
    }

    @Override
    public List<ReviewDTO> getReviewsByProductId(String productId) {
        List<ReviewEntity> reviews = reviewRepository.findByProduct_ProductId(productId);

        return reviews.stream().map(review -> {
            ReviewDTO dto = new ReviewDTO();
            dto.setReviewId(review.getReviewId());
            dto.setProductId(review.getProduct().getProductId());
            dto.setUserId(review.getUser().getId());
            dto.setContent(review.getReviewContent());
            dto.setScore(review.getReviewScore());
            dto.setReviewDate(review.getReviewDate());
            dto.setReviewImageUrl(review.getReviewImageUrl());
            dto.setUserName(review.getUser().getName());
            return dto;
        }).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void addReview(ReviewDTO reviewDto, MultipartFile reviewImage) {
        try {
            ProductEntity product = productRepository.findById(reviewDto.getProductId())
                    .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
            UserEntity user = userRepository.findById(reviewDto.getUserId())
                    .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

            String imageUrl = null;
            String fileId = null;

            if (reviewImage != null && !reviewImage.isEmpty()) {
                String[] result = uploadImageToImageKit(reviewImage, "review");
                imageUrl = result[0];
                fileId = result[1];
            }

            ReviewEntity review = ReviewEntity.builder()
                    .reviewContent(reviewDto.getContent())
                    .reviewScore(reviewDto.getScore())
                    .reviewDate(new Date())
                    .reviewImageUrl(imageUrl)
                    .imageFileId(fileId)
                    .product(product)
                    .user(user)
                    .build();

            reviewRepository.save(review);
        } catch (Exception e) {
            throw new RuntimeException("리뷰 저장 중 오류가 발생했습니다.", e);
        }
    }

    

    @Override
    @Transactional
    public void deleteReview(Long reviewId) {
        ReviewEntity review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));

        String fileId = review.getImageFileId(); // 🔁 fileId 가져오기
        if (fileId != null && !fileId.isEmpty()) {
            deleteImageFromImageKit(fileId);
        }

        reviewRepository.deleteById(reviewId);
    }

    @Override
    @Transactional
    public void updateReview(ReviewDTO reviewDto, MultipartFile reviewImage) {
        ReviewEntity review = reviewRepository.findById(reviewDto.getReviewId())
                .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));

        String oldFileId = review.getImageFileId();

        if (reviewImage != null && !reviewImage.isEmpty()) {
            if (oldFileId != null && !oldFileId.isEmpty()) {
                deleteImageFromImageKit(oldFileId);
            }
            try {
                String[] result = uploadImageToImageKit(reviewImage, "review");
                review.setReviewImageUrl(result[0]);
                review.setImageFileId(result[1]);
            } catch (IOException e) {
                throw new RuntimeException("이미지 저장 중 오류가 발생했습니다.", e);
            }
        } else if (reviewDto.getReviewImageUrl() == null || reviewDto.getReviewImageUrl().isEmpty()) {
            if (oldFileId != null && !oldFileId.isEmpty()) {
                deleteImageFromImageKit(oldFileId);
            }
            review.setReviewImageUrl(null);
            review.setImageFileId(null);
        }

        review.setReviewScore(reviewDto.getScore());
        review.setReviewContent(reviewDto.getContent());
        review.setReviewDate(new Date());

        reviewRepository.save(review);
    }

 // ✅ fileName과 fileId 둘 다 리턴 - 수정된 버전
    private String[] uploadImageToImageKit(MultipartFile file, String folder) throws IOException {
        try {
            String originalFilename = file.getOriginalFilename();
            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
            String fileName = UUID.randomUUID().toString() + ext;

            FileCreateRequest fileCreateRequest = new FileCreateRequest(file.getBytes(), fileName);
            fileCreateRequest.setFolder("/" + folder + "/");
            fileCreateRequest.setUseUniqueFileName(false);

            Result result = imageKit.upload(fileCreateRequest);

            // ✅ 수정: result.getUrl() 대신 fileName을 반환 (Controller와 일치)
            // Controller에서는 fileName을 저장하고 있으므로 일관성 유지
            return new String[]{fileName, result.getFileId()};
            
        } catch (Exception e) {
            throw new IOException("ImageKit 업로드 실패", e);
        }
    }

    // 🔁 fileId 기반 삭제
    private void deleteImageFromImageKit(String fileId) {
        try {
            imageKit.deleteFile(fileId);
        } catch (Exception e) {
            System.err.println("ImageKit 파일 삭제 실패: " + e.getMessage());
        }
    }

    @Transactional
    @Override
    public void updateCartQuantity(Long cartId, int cartCount) {
        cartRepository.updateCartCount(cartId, cartCount);
    }
    
    
    @Override
    public List<ProductEntity> getProductsByCategory(String category) {
        return productRepository.findByCategory(category);
    }
}
