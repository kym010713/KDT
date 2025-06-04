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
    <style>
        * {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        }
        :root {
            --main-color: #1f2937;
        }
        body {
            background-color: #f8f9fa;
        }
        .admin-card {
            transition: all 0.3s ease;
            border: none;
            height: 100%;
        }
        .admin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1) !important;
        }
        .text-main {
            color: var(--main-color) !important;
        }
        .btn-main {
            background-color: var(--main-color);
            color: white;
            border: none;
            transition: all 0.3s ease;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            border-radius: 10px;
            font-weight: 500;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            letter-spacing: -0.3px;
            min-width: 180px;
        }
        .btn-main i.fa-arrow-right {
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        .btn-main:hover {
            background-color: #374151;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.15);
        }
        .btn-main:hover i.fa-arrow-right {
            transform: translateX(4px);
        }
        .btn-main:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }
        .card i {
            color: var(--main-color);
        }
        .card-title {
            font-weight: 600;
            margin-top: 1rem;
        }
        .card-text {
            color: #6b7280;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row mb-5">
            <div class="col text-center">
                <h1 class="display-4 text-main mb-4 fw-semibold">
                    <i class="fas fa-user-shield me-3"></i>관리자 대시보드
                </h1>
            </div>
        </div>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card admin-card shadow-sm">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-users mb-3" style="font-size: 2.5rem;"></i>
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
                        <i class="fas fa-store mb-3" style="font-size: 2.5rem;"></i>
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
                        <i class="fas fa-question-circle mb-3" style="font-size: 2.5rem;"></i>
                        <h3 class="card-title text-main">FAQ 관리</h3>
                        <p class="card-text">자주 묻는 질문 등록 및 관리</p>
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
