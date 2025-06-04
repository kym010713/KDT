<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FAQ 관리</title>
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
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            background-color: var(--main-color);
            color: white;
            font-weight: 500;
            padding: 1rem;
            border: none;
        }
        .table td {
            padding: 1rem;
            vertical-align: middle;
        }
        .table tr:hover {
            background-color: #f8f9fa;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            padding: 0.5rem 1rem;
            transition: all 0.2s;
        }
        .form-control:focus {
            border-color: var(--main-color);
            box-shadow: 0 0 0 0.2rem rgba(31, 41, 55, 0.1);
        }
        .btn-main {
            background-color: var(--main-color);
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .btn-main:hover {
            background-color: #374151;
            color: white;
            transform: translateY(-1px);
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .btn-danger:hover {
            background-color: #bb2d3b;
            color: white;
            transform: translateY(-1px);
        }
        .add-form {
            background-color: white;
            padding: 2rem;
            border-radius: 15px;
        }
        .add-form textarea {
            min-height: 100px;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row mb-4">
            <div class="col text-center">
                <h1 class="display-4 text-main mb-4 fw-semibold">
                    <i class="fas fa-question-circle me-3"></i>FAQ 관리
                </h1>
            </div>
        </div>

        <div class="card mb-5">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>키워드</th>
                                <th>답변</th>
                                <th style="width: 200px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="faq" items="${faqList}">
                                <tr>
                                    <form action="${pageContext.request.contextPath}/admin/faq/edit/${faq.id}" method="post">
                                        <td hidden>${faq.id}</td>
                                        <td><input type="text" class="form-control" name="keyword" value="${faq.keyword}" required/></td>
                                        <td><input type="text" class="form-control" name="answer" value="${faq.answer}" required/></td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <button type="submit" class="btn btn-main flex-grow-1">수정</button>
                                                <button type="button" class="btn btn-danger flex-grow-1" onclick="if(confirm('삭제할까요?')) document.getElementById('deleteForm${faq.id}').submit();">삭제</button>
                                            </div>
                                            <form id="deleteForm${faq.id}" action="${pageContext.request.contextPath}/admin/faq/delete/${faq.id}" method="post" class="d-none"></form>
                                        </td>
                                    </form>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-body add-form">
                <h3 class="card-title mb-4">FAQ 추가</h3>
                <form action="${pageContext.request.contextPath}/admin/faq/add" method="post">
                    <div class="mb-3">
                        <label for="keyword" class="form-label">키워드</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" required />
                    </div>
                    <div class="mb-3">
                        <label for="answer" class="form-label">답변</label>
                        <textarea class="form-control" id="answer" name="answer" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-main">
                        <i class="fas fa-plus me-2"></i>등록하기
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
