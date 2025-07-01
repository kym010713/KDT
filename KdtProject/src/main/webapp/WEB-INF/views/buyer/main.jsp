<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CLODI - 패션 쇼핑몰</title>
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="${pageContext.request.contextPath}/resources/js/tailwind-config.js"></script>
    
    <!-- Tailwind Config -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        pretendard: ['Pretendard', 'sans-serif'],
                    },
                    colors: {
                        'main-color': {
                            DEFAULT: '#1f2937',
                            'hover': '#111827'
                        }
                    }
                },
            },
        }
    </script>
    
    <!-- Fonts -->
    <link rel="stylesheet" as="style" crossorigin 
          href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" 
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" 
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <!-- Custom Styles -->
    <style>
        .hero-gradient {
            background: linear-gradient(135deg, #1f2937 0%, #111827 100%);
        }
        
        .product-card {
            transition: all 0.3s ease;
        }
        
        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .category-card {
            transition: all 0.3s ease;
        }
        
        .category-card:hover {
            transform: scale(1.05);
        }
        
        .btn-primary {
            background: #1f2937;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: #111827;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(31, 41, 55, 0.3);
        }
        
        .fade-in {
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.6s ease forwards;
        }
        
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .stagger-1 { animation-delay: 0.1s; }
        .stagger-2 { animation-delay: 0.2s; }
        .stagger-3 { animation-delay: 0.3s; }
        .stagger-4 { animation-delay: 0.4s; }
    </style>
</head>

<body class="bg-gray-50 font-pretendard">
    <!-- Navigation -->
    <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

    <!-- Hero Section -->
    <section class="hero-gradient relative overflow-hidden">
        <div class="absolute inset-0 bg-black opacity-20"></div>
        <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 lg:py-32">
            <div class="text-center text-white">
                <h1 class="text-4xl md:text-6xl font-bold mb-6 fade-in">
                    CLODI와 함께하는<br>
                    <span class="bg-gradient-to-r from-gray-300 to-gray-100 bg-clip-text text-transparent">
                        특별한 쇼핑
                    </span>
                </h1>
                <p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto opacity-90 fade-in stagger-1">
                    최신 트렌드부터 클래식까지, 당신만의 스타일을 완성하세요
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center fade-in stagger-2">
                    <a href="#products" 
                       class="btn-primary text-white px-8 py-4 rounded-lg font-semibold text-lg inline-flex items-center justify-center">
                        <i class="fas fa-shopping-bag mr-2"></i>
                        쇼핑 시작하기
                    </a>
                    <a href="${pageContext.request.contextPath}/board/list" 
                       class="bg-white text-gray-800 px-8 py-4 rounded-lg font-semibold text-lg hover:bg-gray-100 transition-colors inline-flex items-center justify-center">
                        <i class="fas fa-bullhorn mr-2"></i>
                        이벤트 보기
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Floating Elements -->
        <div class="absolute top-20 left-10 text-white opacity-30">
            <i class="fas fa-star text-6xl animate-pulse"></i>
        </div>
        <div class="absolute bottom-20 right-10 text-white opacity-30">
            <i class="fas fa-heart text-4xl animate-bounce"></i>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="py-16 bg-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">카테고리별 쇼핑</h2>
                <p class="text-gray-600 text-lg">원하는 스타일을 빠르게 찾아보세요</p>
            </div>
            
            <div class="grid grid-cols-2 md:grid-cols-5 gap-6">
                <a href="${pageContext.request.contextPath}/mypage/category/top" 
                   class="category-card group block">
                    <div class="bg-gradient-to-br from-gray-600 to-gray-800 rounded-xl p-8 text-center text-white">
                        <i class="fas fa-tshirt text-4xl mb-4 group-hover:scale-110 transition-transform"></i>
                        <h3 class="font-semibold text-lg">상의</h3>
                        <p class="text-sm opacity-80">티셔츠, 셔츠</p>
                    </div>
                </a>
                
                <a href="${pageContext.request.contextPath}/mypage/category/bottom" 
                   class="category-card group block">
                    <div class="bg-gradient-to-br from-gray-700 to-gray-900 rounded-xl p-8 text-center text-white">
                        <i class="fas fa-running text-4xl mb-4 group-hover:scale-110 transition-transform"></i>
                        <h3 class="font-semibold text-lg">하의</h3>
                        <p class="text-sm opacity-80">바지, 치마</p>
                    </div>
                </a>
                
                <a href="${pageContext.request.contextPath}/mypage/category/outer" 
                   class="category-card group block">
                    <div class="bg-gradient-to-br from-gray-500 to-gray-700 rounded-xl p-8 text-center text-white">
                        <i class="fas fa-user-tie text-4xl mb-4 group-hover:scale-110 transition-transform"></i>
                        <h3 class="font-semibold text-lg">아우터</h3>
                        <p class="text-sm opacity-80">재킷, 코트</p>
                    </div>
                </a>
                
                <a href="${pageContext.request.contextPath}/mypage/category/shoes" 
                   class="category-card group block">
                    <div class="bg-gradient-to-br from-gray-600 to-gray-800 rounded-xl p-8 text-center text-white">
                        <i class="fas fa-shoe-prints text-4xl mb-4 group-hover:scale-110 transition-transform"></i>
                        <h3 class="font-semibold text-lg">신발</h3>
                        <p class="text-sm opacity-80">스니커즈, 구두</p>
                    </div>
                </a>
                
                <a href="${pageContext.request.contextPath}/mypage/category/accessory" 
                   class="category-card group block">
                    <div class="bg-gradient-to-br from-gray-700 to-gray-900 rounded-xl p-8 text-center text-white">
                        <i class="fas fa-gem text-4xl mb-4 group-hover:scale-110 transition-transform"></i>
                        <h3 class="font-semibold text-lg">액세서리</h3>
                        <p class="text-sm opacity-80">가방, 시계</p>
                    </div>
                </a>
            </div>
        </div>
    </section>

    <!-- Featured Products Section -->
    <section id="products" class="py-16 bg-gray-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">인기 상품</h2>
                <p class="text-gray-600 text-lg">지금 가장 인기있는 상품들을 만나보세요</p>
            </div>

            <c:if test="${empty products}">
                <div class="text-center py-20 bg-white rounded-xl shadow-lg">
                    <div class="max-w-md mx-auto">
                        <div class="bg-gray-100 rounded-full w-24 h-24 flex items-center justify-center mx-auto mb-6">
                            <i class="fas fa-store-slash text-3xl text-gray-400"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-900 mb-2">준비중인 상품</h3>
                        <p class="text-gray-600 mb-6">곧 멋진 상품들로 찾아뵙겠습니다!</p>
                        <a href="${pageContext.request.contextPath}/board/list" 
                           class="btn-primary text-white px-6 py-3 rounded-lg font-semibold">
                            공지사항 확인하기
                        </a>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty products}">
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
                    <c:forEach var="product" items="${products}" varStatus="status">
                        <div class="product-card bg-white rounded-xl shadow-lg overflow-hidden group fade-in stagger-${status.index % 4 + 1}">
                            <a href="${pageContext.request.contextPath}/mypage/product/detail?id=${product.productId}" 
                               class="block">
                                <div class="relative overflow-hidden">
                                    <img src="${imagekitUrl}product/${product.productPhoto}"
                                         alt="${product.productName}" 
                                         class="w-full h-64 object-cover group-hover:scale-110 transition-transform duration-500" />
                                    
                                    <!-- Hover Overlay -->
                                    <div class="absolute inset-0 bg-black bg-opacity-40 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                                        <div class="text-white text-center">
                                            <i class="fas fa-search text-2xl mb-2"></i>
                                            <p class="font-semibold">자세히 보기</p>
                                        </div>
                                    </div>
                                    
                                    <!-- Sale Badge (예시) -->
                                    <c:if test="${status.index % 3 == 0}">
                                        <div class="absolute top-4 left-4 bg-red-500 text-white px-3 py-1 rounded-full text-sm font-semibold">
                                            SALE
                                        </div>
                                    </c:if>
                                    
                                    <!-- New Badge (예시) -->
                                    <c:if test="${status.index % 4 == 0}">
                                        <div class="absolute top-4 right-4 bg-green-500 text-white px-3 py-1 rounded-full text-sm font-semibold">
                                            NEW
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="p-6">
                                    <h3 class="font-semibold text-lg text-gray-900 mb-2 line-clamp-2 group-hover:text-main-color transition-colors">
                                        ${product.productName}
                                    </h3>
                                    
                                    <div class="flex items-center justify-between">
                                        <div>
                                            <p class="text-2xl font-bold text-gray-900">
                                                <fmt:formatNumber value="${product.productPrice}" type="number" groupingUsed="true"/>원
                                            </p>
                                        </div>
                                        
                                        <div class="flex items-center space-x-1">
                                          
                                            <div class="flex text-yellow-400">
                                                <i class="fas fa-star text-sm"></i>
                                                <i class="fas fa-star text-sm"></i>
                                                <i class="fas fa-star text-sm"></i>
                                                <i class="fas fa-star text-sm"></i>
                                                <i class="far fa-star text-sm"></i>
                                            </div>
                                            <span class="text-sm text-gray-500">(4.0)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- View More Button -->
                <div class="text-center mt-12">
                    <a href="${pageContext.request.contextPath}/mypage/category/all" 
                       class="btn-primary text-white px-8 py-4 rounded-lg font-semibold text-lg inline-flex items-center">
                        <i class="fas fa-plus mr-2"></i>
                        더 많은 상품 보기
                    </a>
                </div>
            </c:if>
        </div>
    </section>

    <!-- Footer -->
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>

    <!-- JavaScript for smooth scrolling and animations -->
    <script>
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Intersection Observer for animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('fade-in');
                }
            });
        }, observerOptions);
        
        

        // Observe all elements with fade-in class
        document.querySelectorAll('.fade-in').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>
