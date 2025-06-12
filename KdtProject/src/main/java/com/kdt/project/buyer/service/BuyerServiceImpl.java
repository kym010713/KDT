package com.kdt.project.buyer.service;
   
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.transaction.annotation.Transactional;

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
               dto.setProductPrice(cart.getProduct().getProductPrice().intValue());

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
       @Transactional
       @Override
       public void deleteCartItem(Long cartId) {
           if (!cartRepository.existsById(cartId)) {
               throw new RuntimeException("장바구니 항목을 찾을 수 없습니다.");
           }
           cartRepository.deleteById(cartId);
       }
       
    // 리뷰 목록 조회
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
           review.setReviewImageUrl(reviewDto.getReviewImageUrl());
           
           ProductEntity product = productRepository.findById(reviewDto.getProductId())
                   .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
           UserEntity user = userRepository.findById(reviewDto.getUserId())
                   .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

           review.setProduct(product);
           review.setUser(user);

           reviewRepository.save(review);
       }
       
    // 리뷰 삭제 - ImageKit에서 이미지 삭제
       @Override
       public void deleteReview(Long reviewId) {
           ReviewEntity review = reviewRepository.findById(reviewId)
                   .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));

           // 🔽 ImageKit에서 이미지 삭제 처리
           String imageUrl = review.getReviewImageUrl();
           if (imageUrl != null && !imageUrl.isEmpty()) {
               try {
                   // ImageKit에서 파일 삭제
                   deleteImageFromImageKit(imageUrl);
               } catch (Exception e) {
                   System.err.println("ImageKit 이미지 삭제 실패: " + e.getMessage());
                   e.printStackTrace();
               }
           }

           // 🔽 리뷰 엔티티 삭제
           reviewRepository.deleteById(reviewId);
       }
       
       @Override
       public void updateReview(ReviewDTO reviewDto, MultipartFile reviewImage) {
           ReviewEntity review = reviewRepository.findById(reviewDto.getReviewId())
                   .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));
           
           // 기존 이미지 URL
           String oldImageUrl = review.getReviewImageUrl();
           
           // 새 이미지가 업로드되었거나, 기존 이미지를 삭제하려는 경우
           if (reviewImage != null && !reviewImage.isEmpty()) {
               // 기존 이미지 삭제
               if (oldImageUrl != null && !oldImageUrl.isEmpty()) {
                   deleteImageFromImageKit(oldImageUrl);
               }
               
               // 새 이미지 ImageKit에 저장
               try {
                   String newImageUrl = uploadImageToImageKit(reviewImage, "review");
                   review.setReviewImageUrl(newImageUrl);
               } catch (IOException e) {
                   throw new RuntimeException("이미지 저장 중 오류가 발생했습니다.", e);
               }
           } else if (reviewDto.getReviewImageUrl() == null || reviewDto.getReviewImageUrl().isEmpty()) {
               // 이미지를 삭제하려는 경우 (프론트에서 삭제 요청)
               if (oldImageUrl != null && !oldImageUrl.isEmpty()) {
                   deleteImageFromImageKit(oldImageUrl);
               }
               review.setReviewImageUrl(null);
           }
           // 그 외의 경우는 기존 이미지 유지
           
           // 리뷰 내용 수정
           review.setReviewScore(reviewDto.getScore());
           review.setReviewContent(reviewDto.getContent());
           review.setReviewDate(new Date()); // 수정일 갱신
           
           reviewRepository.save(review);
       }

       // ImageKit에 이미지 업로드
       private String uploadImageToImageKit(MultipartFile file, String folder) throws IOException {
           try {
               String originalFilename = file.getOriginalFilename();
               String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
               String fileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString() + ext;
               
               FileCreateRequest fileCreateRequest = new FileCreateRequest(
                   file.getBytes(), 
                   fileName
               );
               fileCreateRequest.setFolder("/" + folder + "/");
               
               Result result = imageKit.upload(fileCreateRequest);
               
               System.out.println("ImageKit 업로드 성공: " + result.getUrl());
               
               // DB에는 파일명만 저장 (기존 로직과 일치)
               return fileName;
               
           } catch (Exception e) {
               System.err.println("ImageKit 업로드 실패: " + e.getMessage());
               e.printStackTrace();
               throw new IOException("ImageKit 업로드 실패", e);
           }
       }
       
       // ImageKit에서 이미지 삭제
       private void deleteImageFromImageKit(String fileName) {
           try {
               // 파일명으로 ImageKit에서 파일 찾아서 삭제
               // ImageKit의 file list API를 사용하여 파일 ID를 찾고 삭제해야 합니다.
               // 실제 구현 시에는 파일 ID를 별도로 저장하거나, 파일명으로 검색하는 로직이 필요합니다.
               System.out.println("ImageKit에서 파일 삭제 시도: " + fileName);
               // imageKit.deleteFile(fileId); // 실제 삭제 로직
           } catch (Exception e) {
               System.err.println("ImageKit 파일 삭제 실패: " + e.getMessage());
           }
       }
       
       @Transactional
       @Override
       public void updateCartQuantity(Long cartId, int cartCount) {
           cartRepository.updateCartCount(cartId, cartCount);
       }
   }