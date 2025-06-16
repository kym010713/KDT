<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>상품 등록 - 판매자</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Pretendard Font -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <style>
        :root {
            --primary-color: #333;
            --secondary-color: #666;
            --accent-color: #000;
            --background-color: #f5f5f5;
            --card-background: #fff;
            --border-color: #e0e0e0;
            --hover-color: #f0f0f0;
            --error-color: #dc3545;
            --success-color: #198754;
        }

        body {
            font-family: 'Pretendard', sans-serif;
            background-color: var(--background-color);
            color: var(--primary-color);
            padding: 2rem;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .card {
            background-color: var(--card-background);
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .page-title {
            color: var(--accent-color);
            margin-bottom: 1.5rem;
            font-weight: 600;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: var(--secondary-color);
            text-decoration: none;
            margin-bottom: 2rem;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: var(--accent-color);
        }

        .back-link i {
            margin-right: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            color: var(--primary-color);
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 0.75rem;
            width: 100%;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(0,0,0,0.1);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .error {
            color: var(--error-color);
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .success {
            color: var(--success-color);
            padding: 1rem;
            border-radius: 8px;
            background-color: rgba(25, 135, 84, 0.1);
            margin-bottom: 1rem;
        }

        .error-message {
            color: var(--error-color);
            padding: 1rem;
            border-radius: 8px;
            background-color: rgba(220, 53, 69, 0.1);
            margin-bottom: 1rem;
        }

        .btn {
            background-color: var(--accent-color);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #333;
            color: white;
            transform: translateY(-1px);
        }

        .required-field::after {
            content: " *";
            color: var(--error-color);
        }

        /* 이미지 업로드 관련 스타일 */
        .image-upload-container {
            border: 2px dashed var(--border-color);
            border-radius: 8px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            background-color: #fafafa;
        }

        .image-upload-container:hover {
            border-color: var(--accent-color);
            background-color: #f0f0f0;
        }

        .image-upload-container.dragover {
            border-color: var(--accent-color);
            background-color: rgba(0, 0, 0, 0.05);
        }

        .image-preview {
            max-width: 200px;
            max-height: 200px;
            border-radius: 8px;
            margin: 1rem auto;
            display: none;
            object-fit: cover;
        }

        .upload-text {
            color: var(--secondary-color);
            margin-top: 0.5rem;
        }

        .file-info {
            font-size: 0.875rem;
            color: var(--secondary-color);
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/seller/list" class="back-link">
            <i class="fas fa-arrow-left"></i> 상품 목록으로 돌아가기
        </a>

        <div class="card">
            <h2 class="page-title">상품 등록</h2>
            
            <!-- 성공 메시지 -->
            <c:if test="${not empty successMessage}">
                <div class="success">
                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                </div>
            </c:if>
            
            <!-- 에러 메시지 -->
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                </div>
            </c:if>
            
            <form:form method="post" modelAttribute="productDto" action="/seller/register" enctype="multipart/form-data">
                <!-- 카테고리 선택 -->
                <div class="form-group">
                    <label for="category" class="form-label required-field">카테고리</label>
                    <form:select path="category" id="category" class="form-select">
                        <form:option value="">카테고리를 선택하세요</form:option>
                        <c:forEach items="${categories}" var="category">
                            <form:option value="${category.topName}">${category.topName}</form:option>
                        </c:forEach>
                    </form:select>
                    <form:errors path="category" cssClass="error" />
                </div>
                
                <!-- 상품명 -->
                <div class="form-group">
                    <label for="productName" class="form-label required-field">상품명</label>
                    <form:input path="productName" id="productName" class="form-control" placeholder="상품명을 입력하세요" />
                    <form:errors path="productName" cssClass="error" />
                </div>
                
                <form:hidden path="companyName" />
                
                <!-- 상품 설명 -->
                <div class="form-group">
                    <label for="productDetail" class="form-label required-field">상품 설명</label>
                    <form:textarea path="productDetail" id="productDetail" class="form-control" placeholder="상품 설명을 입력하세요" />
                    <form:errors path="productDetail" cssClass="error" />
                </div>
                
                <!-- 상품 가격 -->
                <div class="form-group">
                    <label for="productPrice" class="form-label required-field">상품 가격</label>
                    <form:input path="productPrice" id="productPrice" class="form-control" placeholder="예: 29000" />
                    <form:errors path="productPrice" cssClass="error" />
                </div>
                
                <!-- 상품 이미지 업로드 - 새로 추가 -->
                <div class="form-group">
                    <label for="productImageFile" class="form-label">상품 이미지</label>
                    <div class="image-upload-container" id="imageUploadContainer">
                        <i class="fas fa-cloud-upload-alt fa-2x mb-2" style="color: var(--secondary-color);"></i>
                        <div>
                            <input type="file" id="productImageFile" name="productImageFile" 
                                   accept="image/*" style="display: none;" onchange="handleImageSelect(this)">
                            <label for="productImageFile" class="btn" style="cursor: pointer;">
                                <i class="fas fa-plus me-2"></i>이미지 선택
                            </label>
                        </div>
                        <div class="upload-text">또는 이미지를 드래그해서 올려주세요</div>
                        <img id="imagePreview" class="image-preview" alt="이미지 미리보기">
                        <div id="fileInfo" class="file-info"></div>
                    </div>
                    
                    <!-- URL 직접 입력 옵션 -->
                    <div class="mt-3">
                        <label for="productPhoto" class="form-label">또는 이미지 URL 직접 입력</label>
                        <form:input path="productPhoto" id="productPhoto" class="form-control" placeholder="이미지 URL을 입력하세요 (선택사항)" />
                        <form:errors path="productPhoto" cssClass="error" />
                    </div>
                </div>
                
                <!-- 상품 사이즈 -->
                <div class="form-group">
                    <label for="productSize" class="form-label required-field">상품 사이즈</label>
                    <form:select path="productSize" id="productSize" class="form-select">
                        <form:option value="">사이즈를 선택하세요</form:option>
                        <form:option value="Free">Free</form:option>
                        <form:option value="XS">XS</form:option>
                        <form:option value="S">S</form:option>
                        <form:option value="M">M</form:option>
                        <form:option value="L">L</form:option>
                        <form:option value="XL">XL</form:option>
                        <form:option value="XXL">XXL</form:option>        
                        <form:option value="220mm">220mm</form:option>
                        <form:option value="230mm">230mm</form:option>
                        <form:option value="240mm">240mm</form:option>
                        <form:option value="250mm">250mm</form:option>
                        <form:option value="260mm">260mm</form:option>
                        <form:option value="270mm">270mm</form:option>
                        <form:option value="280mm">280mm</form:option>
                    </form:select>
                    <form:errors path="productSize" cssClass="error" />
                </div>
                
                <!-- 상품 수량 -->
                <div class="form-group">
                    <label for="productCount" class="form-label required-field">상품 수량</label>
                    <form:input path="productCount" type="number" id="productCount" class="form-control" min="1" placeholder="상품 수량을 입력하세요" />
                    <form:errors path="productCount" cssClass="error" />
                </div>
                
                <!-- 등록 버튼 -->
                <div class="form-group mb-0">
                    <button type="submit" class="btn">
                        <i class="fas fa-plus me-2"></i>상품 등록
                    </button>
                </div>
            </form:form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<<<<<<< HEAD
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
=======
    
    <script>
        // 이미지 선택 처리
        function handleImageSelect(input) {
            const file = input.files[0];
            const preview = document.getElementById('imagePreview');
            const fileInfo = document.getElementById('fileInfo');
            
            if (file) {
                // 파일 크기 체크 (10MB 제한)
                if (file.size > 10 * 1024 * 1024) {
                    alert('파일 크기는 10MB 이하여야 합니다.');
                    input.value = '';
                    return;
                }
                
                // 이미지 파일 타입 체크
                if (!file.type.startsWith('image/')) {
                    alert('이미지 파일만 업로드 가능합니다.');
                    input.value = '';
                    return;
                }
                
                // 파일 정보 표시
                const fileSize = (file.size / 1024 / 1024).toFixed(2);
                fileInfo.innerHTML = `<i class="fas fa-file-image me-1"></i>${file.name} (${fileSize}MB)`;
                
                // 이미지 미리보기
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(file);
                
                // URL 입력 필드 비우기 (파일 업로드 우선)
                document.getElementById('productPhoto').value = '';
            } else {
                preview.style.display = 'none';
                fileInfo.innerHTML = '';
            }
        }
        
        // 드래그 앤 드롭 기능
        const uploadContainer = document.getElementById('imageUploadContainer');
        const fileInput = document.getElementById('productImageFile');
        
        uploadContainer.addEventListener('dragover', function(e) {
            e.preventDefault();
            uploadContainer.classList.add('dragover');
        });
        
        uploadContainer.addEventListener('dragleave', function(e) {
            e.preventDefault();
            uploadContainer.classList.remove('dragover');
        });
        
        uploadContainer.addEventListener('drop', function(e) {
            e.preventDefault();
            uploadContainer.classList.remove('dragover');
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                fileInput.files = files;
                handleImageSelect(fileInput);
            }
        });
        
        // URL 입력 시 파일 입력 비우기
        document.getElementById('productPhoto').addEventListener('input', function() {
            if (this.value.trim() !== '') {
                fileInput.value = '';
                document.getElementById('imagePreview').style.display = 'none';
                document.getElementById('fileInfo').innerHTML = '';
            }
        });
        
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const submitButton = document.querySelector('button[type="submit"]');
            
            console.log('폼 요소:', form);
            console.log('제출 버튼:', submitButton);
            
            if (form) {
                form.addEventListener('submit', function(e) {
                    console.log('=== 폼 제출 시작 ===');
                    
                    // 폼 데이터 확인
                    const formData = new FormData(form);
                    console.log('폼 데이터:');
                    for (let [key, value] of formData.entries()) {
                        if (value instanceof File) {
                            console.log(key + ':', value.name, '(' + value.size + ' bytes)');
                        } else {
                            console.log(key + ':', value);
                        }
                    }
                    
                    // 필수 필드 확인
                    const category = document.getElementById('category').value;
                    const productName = document.getElementById('productName').value;
                    const productDetail = document.getElementById('productDetail').value;
                    const productPrice = document.getElementById('productPrice').value;
                    const productSize = document.getElementById('productSize').value;
                    const productCount = document.getElementById('productCount').value;
                    
                    console.log('필수 필드 확인:');
                    console.log('- 카테고리:', category);
                    console.log('- 상품명:', productName);
                    console.log('- 상품설명:', productDetail);
                    console.log('- 가격:', productPrice);
                    console.log('- 사이즈:', productSize);
                    console.log('- 수량:', productCount);
                    
                    if (!category || !productName || !productDetail || !productPrice || !productSize || !productCount) {
                        console.log('필수 필드 누락!');
                        alert('필수 필드를 모두 입력해주세요.');
                        e.preventDefault();
                        return false;
                    }
                    
                    console.log('폼 제출 계속 진행...');
                });
            }
            
            // 제출 버튼 클릭 이벤트도 확인
            if (submitButton) {
                submitButton.addEventListener('click', function(e) {
                    console.log('제출 버튼 클릭됨');
                });
            }
        });
    </script>
>>>>>>> refs/heads/dev
</body>
</html>