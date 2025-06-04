<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관리자 대시보드</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Pretendard Font -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/adminMain.css" />
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row mb-5">
            <div class="col text-center">
                <h1 class="display-4 text-main mb-4 fw-semibold">
                    <i class="fas fa-cog me-3"></i>관리자 대시보드
                </h1>
            </div>
        </div>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card admin-card shadow-sm">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-users card-icon"></i>
                        <h3 class="card-title text-main">회원 관리</h3>
                        <p class="card-text">사용자 계정 관리 및 등급 설정</p>
                        <button onclick="location.href='/admin/userList'" class="btn btn-main">
                            바로가기 <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card admin-card shadow-sm">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-store card-icon"></i>
                        <h3 class="card-title text-main">입점 신청 관리</h3>
                        <p class="card-text">새로운 입점 신청 검토 및 관리</p>
                        <button onclick="location.href='/admin/applyList'" class="btn btn-main">
                            바로가기 <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card admin-card shadow-sm">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-question-circle card-icon"></i>
                        <h3 class="card-title text-main">챗봇 관리</h3>
                        <p class="card-text">챗봇 키워드 등록 및 관리</p>
                        <button onclick="location.href='/admin/faq/list'" class="btn btn-main">
                            바로가기 <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
