package com.kdt.project.buyer.service;
	
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
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

import jakarta.servlet.ServletContext;
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
	    
	    private final ServletContext servletContext;
	    
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
	 // 리뷰 삭제
	    @Override
	    public void deleteReview(Long reviewId) {
	        ReviewEntity review = reviewRepository.findById(reviewId)
	                .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));
	
	        // 🔽 리뷰 이미지 삭제 처리
	        String imageUrl = review.getReviewImageUrl();
	        if (imageUrl != null && !imageUrl.isEmpty()) {
	            try {
	                // 절대 경로 설정
	            	String uploadDir = servletContext.getRealPath("/resources/upload/review/");
	            	
	                // imageUrl에서 파일명만 추출 (경로가 포함되어 있을 경우를 대비)
	                String fileName = imageUrl;
	                if (imageUrl.contains("/")) {
	                    fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
	                }
	                if (imageUrl.contains("\\")) {
	                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
	                }
	                
	                // 완전한 파일 경로 생성
	                Path imagePath = Paths.get(uploadDir + fileName);
	                
	                System.out.println("삭제할 파일 경로: " + imagePath.toString());
	                System.out.println("파일 존재 여부: " + Files.exists(imagePath));
	                
	                if (Files.exists(imagePath)) {
	                    Files.delete(imagePath);
	                    System.out.println("이미지 파일 삭제 완료: " + imagePath);
	                } else {
	                    System.out.println("삭제할 파일이 존재하지 않습니다: " + imagePath);
	                    
	                    // 다른 가능한 경로들도 확인해보기
	                    String[] possiblePaths = {
	                        uploadDir + imageUrl,  // 원본 imageUrl 그대로
	                        uploadDir + imageUrl.replace("/", "\\"),  // 슬래시를 백슬래시로
	                        uploadDir + imageUrl.replace("\\", "/"),  // 백슬래시를 슬래시로
	                    };
	                    
	                    for (String possiblePath : possiblePaths) {
	                        Path altPath = Paths.get(possiblePath);
	                        if (Files.exists(altPath)) {
	                            Files.delete(altPath);
	                            System.out.println("대체 경로에서 이미지 파일 삭제 완료: " + altPath);
	                            break;
	                        }
	                    }
	                }
	            } catch (Exception e) {
	                System.err.println("이미지 파일 삭제 실패: " + e.getMessage());
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
	        
	        // 기존 이미지 삭제 처리
	        String oldImageUrl = review.getReviewImageUrl();
	        
	        // 새 이미지가 업로드되었거나, 기존 이미지를 삭제하려는 경우
	        if (reviewImage != null && !reviewImage.isEmpty()) {
	            // 기존 이미지 삭제
	            deleteOldImage(oldImageUrl);
	            
	            // 새 이미지 저장
	            try {
	                String newImageUrl = saveReviewImage(reviewImage);
	                review.setReviewImageUrl(newImageUrl);
	            } catch (IOException e) {
	                throw new RuntimeException("이미지 저장 중 오류가 발생했습니다.", e);
	            }
	        } else if (reviewDto.getReviewImageUrl() == null || reviewDto.getReviewImageUrl().isEmpty()) {
	            // 이미지를 삭제하려는 경우 (프론트에서 삭제 요청)
	            deleteOldImage(oldImageUrl);
	            review.setReviewImageUrl(null);
	        }
	        // 그 외의 경우는 기존 이미지 유지
	        
	        // 리뷰 내용 수정
	        review.setReviewScore(reviewDto.getScore());
	        review.setReviewContent(reviewDto.getContent());
	        review.setReviewDate(new Date()); // 수정일 갱신
	        
	        reviewRepository.save(review);
	    }
	 // 기존 이미지 삭제 메서드 (경로 통일)
	    private void deleteOldImage(String oldImageUrl) {
	        if (oldImageUrl != null && !oldImageUrl.isEmpty()) {
	            try {
	                // 절대 경로 설정 (기존 삭제 로직과 동일)
	            	String uploadDir = servletContext.getRealPath("/resources/upload/review/");
	                
	                // imageUrl에서 파일명만 추출
	                String fileName = oldImageUrl;
	                if (oldImageUrl.contains("/")) {
	                    fileName = oldImageUrl.substring(oldImageUrl.lastIndexOf("/") + 1);
	                }
	                if (oldImageUrl.contains("\\")) {
	                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
	                }
	                
	                // 완전한 파일 경로 생성
	                Path imagePath = Paths.get(uploadDir + fileName);
	                
	                if (Files.exists(imagePath)) {
	                    Files.delete(imagePath);
	                    System.out.println("기존 이미지 파일 삭제 완료: " + imagePath);
	                } else {
	                    // 다른 가능한 경로들도 확인
	                    String[] possiblePaths = {
	                        uploadDir + oldImageUrl,
	                        uploadDir + oldImageUrl.replace("/", "\\"),
	                        uploadDir + oldImageUrl.replace("\\", "/"),
	                    };
	                    
	                    for (String possiblePath : possiblePaths) {
	                        Path altPath = Paths.get(possiblePath);
	                        if (Files.exists(altPath)) {
	                            Files.delete(altPath);
	                            System.out.println("대체 경로에서 이미지 파일 삭제 완료: " + altPath);
	                            break;
	                        }
	                    }
	                }
	            } catch (IOException e) {
	                System.err.println("기존 이미지 삭제 실패: " + e.getMessage());
	            }
	        }
	    }
	
	    // 이미지 저장 메서드 (기존 리뷰 작성과 동일한 경로 사용)
	    private String saveReviewImage(MultipartFile image) throws IOException {
	        // 기존 리뷰 작성과 동일한 절대 경로 사용
	    	String uploadDir = servletContext.getRealPath("/resources/upload/review/");
	        
	        String originalFilename = image.getOriginalFilename();
	        String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
	        String savedFileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString() + ext;
	        
	        // 디렉토리 생성
	        Path uploadPath = Paths.get(uploadDir);
	        Files.createDirectories(uploadPath);
	        
	        // 파일 저장
	        Path filePath = Paths.get(uploadDir + savedFileName);
	        Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
	        
	        // 파일명만 반환 (기존 로직과 일치)
	        return savedFileName;
	    }
	    
	}
=======
   
   @Service
   @RequiredArgsConstructor
   public class BuyerServiceImpl implements BuyerService {
   
       private final CartRepository cartRepository;
       private final UserRepository userRepository;
       private final ProductRepository productRepository;
       private final ProductOptionRepository optionRepository;
       private final SizeRepository sizeRepository;
       private final ReviewRepository reviewRepository;
       
       private final ServletContext servletContext;
       
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
    // 리뷰 삭제
       @Override
       public void deleteReview(Long reviewId) {
           ReviewEntity review = reviewRepository.findById(reviewId)
                   .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));
   
           // 🔽 리뷰 이미지 삭제 처리
           String imageUrl = review.getReviewImageUrl();
           if (imageUrl != null && !imageUrl.isEmpty()) {
               try {
                   // 절대 경로 설정
                  String uploadDir = servletContext.getRealPath("/resources/upload/review/");
                  
                   // imageUrl에서 파일명만 추출 (경로가 포함되어 있을 경우를 대비)
                   String fileName = imageUrl;
                   if (imageUrl.contains("/")) {
                       fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
                   }
                   if (imageUrl.contains("\\")) {
                       fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                   }
                   
                   // 완전한 파일 경로 생성
                   Path imagePath = Paths.get(uploadDir + fileName);
                   
                   System.out.println("삭제할 파일 경로: " + imagePath.toString());
                   System.out.println("파일 존재 여부: " + Files.exists(imagePath));
                   
                   if (Files.exists(imagePath)) {
                       Files.delete(imagePath);
                       System.out.println("이미지 파일 삭제 완료: " + imagePath);
                   } else {
                       System.out.println("삭제할 파일이 존재하지 않습니다: " + imagePath);
                       
                       // 다른 가능한 경로들도 확인해보기
                       String[] possiblePaths = {
                           uploadDir + imageUrl,  // 원본 imageUrl 그대로
                           uploadDir + imageUrl.replace("/", "\\"),  // 슬래시를 백슬래시로
                           uploadDir + imageUrl.replace("\\", "/"),  // 백슬래시를 슬래시로
                       };
                       
                       for (String possiblePath : possiblePaths) {
                           Path altPath = Paths.get(possiblePath);
                           if (Files.exists(altPath)) {
                               Files.delete(altPath);
                               System.out.println("대체 경로에서 이미지 파일 삭제 완료: " + altPath);
                               break;
                           }
                       }
                   }
               } catch (Exception e) {
                   System.err.println("이미지 파일 삭제 실패: " + e.getMessage());
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
           
           // 기존 이미지 삭제 처리
           String oldImageUrl = review.getReviewImageUrl();
           
           // 새 이미지가 업로드되었거나, 기존 이미지를 삭제하려는 경우
           if (reviewImage != null && !reviewImage.isEmpty()) {
               // 기존 이미지 삭제
               deleteOldImage(oldImageUrl);
               
               // 새 이미지 저장
               try {
                   String newImageUrl = saveReviewImage(reviewImage);
                   review.setReviewImageUrl(newImageUrl);
               } catch (IOException e) {
                   throw new RuntimeException("이미지 저장 중 오류가 발생했습니다.", e);
               }
           } else if (reviewDto.getReviewImageUrl() == null || reviewDto.getReviewImageUrl().isEmpty()) {
               // 이미지를 삭제하려는 경우 (프론트에서 삭제 요청)
               deleteOldImage(oldImageUrl);
               review.setReviewImageUrl(null);
           }
           // 그 외의 경우는 기존 이미지 유지
           
           // 리뷰 내용 수정
           review.setReviewScore(reviewDto.getScore());
           review.setReviewContent(reviewDto.getContent());
           review.setReviewDate(new Date()); // 수정일 갱신
           
           reviewRepository.save(review);
       }
    // 기존 이미지 삭제 메서드 (경로 통일)
       private void deleteOldImage(String oldImageUrl) {
           if (oldImageUrl != null && !oldImageUrl.isEmpty()) {
               try {
                   // 절대 경로 설정 (기존 삭제 로직과 동일)
                  String uploadDir = servletContext.getRealPath("/resources/upload/review/");
                   
                   // imageUrl에서 파일명만 추출
                   String fileName = oldImageUrl;
                   if (oldImageUrl.contains("/")) {
                       fileName = oldImageUrl.substring(oldImageUrl.lastIndexOf("/") + 1);
                   }
                   if (oldImageUrl.contains("\\")) {
                       fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                   }
                   
                   // 완전한 파일 경로 생성
                   Path imagePath = Paths.get(uploadDir + fileName);
                   
                   if (Files.exists(imagePath)) {
                       Files.delete(imagePath);
                       System.out.println("기존 이미지 파일 삭제 완료: " + imagePath);
                   } else {
                       // 다른 가능한 경로들도 확인
                       String[] possiblePaths = {
                           uploadDir + oldImageUrl,
                           uploadDir + oldImageUrl.replace("/", "\\"),
                           uploadDir + oldImageUrl.replace("\\", "/"),
                       };
                       
                       for (String possiblePath : possiblePaths) {
                           Path altPath = Paths.get(possiblePath);
                           if (Files.exists(altPath)) {
                               Files.delete(altPath);
                               System.out.println("대체 경로에서 이미지 파일 삭제 완료: " + altPath);
                               break;
                           }
                       }
                   }
               } catch (IOException e) {
                   System.err.println("기존 이미지 삭제 실패: " + e.getMessage());
               }
           }
       }
   
       // 이미지 저장 메서드 (기존 리뷰 작성과 동일한 경로 사용)
       private String saveReviewImage(MultipartFile image) throws IOException {
           // 기존 리뷰 작성과 동일한 절대 경로 사용
          String uploadDir = servletContext.getRealPath("/resources/upload/review/");
           
           String originalFilename = image.getOriginalFilename();
           String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
           String savedFileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString() + ext;
           
           // 디렉토리 생성
           Path uploadPath = Paths.get(uploadDir);
           Files.createDirectories(uploadPath);
           
           // 파일 저장
           Path filePath = Paths.get(uploadDir + savedFileName);
           Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
           
           // 파일명만 반환 (기존 로직과 일치)
           return savedFileName;
       }
       
   }