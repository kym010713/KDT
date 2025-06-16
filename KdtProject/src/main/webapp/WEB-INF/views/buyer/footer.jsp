<%@ page pageEncoding="UTF-8" %>
<style>
  .page-wrapper {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    margin: 0;
    padding: 0;
  }
  
  .content-wrapper {
    flex: 1 0 auto;
    margin: 0;
    padding: 0;
    margin-bottom: 1rem;
  }
  
  .footer {
    flex-shrink: 0;
    margin: 0;
    padding: 0;
  }
</style>

<div class="page-wrapper">
  <div class="content-wrapper">
    <!-- 콘텐츠 영역 -->
  </div>

  <footer class="footer bg-gray-900 text-gray-400 text-sm">
    <div class="max-w-7xl mx-auto py-3 px-4">
      <!-- 상단 섹션: 로고 및 소셜 링크 -->
      <div class="flex justify-between items-center mb-3">
        <div class="text-xl font-bold text-white">CLODI</div>
        <div class="flex space-x-4">
          <a href="#" class="text-gray-400 hover:text-white transition-colors">
            <i class="fab fa-instagram text-lg"></i>
          </a>
          <a href="#" class="text-gray-400 hover:text-white transition-colors">
            <i class="fab fa-facebook text-lg"></i>
          </a>
          <a href="#" class="text-gray-400 hover:text-white transition-colors">
            <i class="fab fa-youtube text-lg"></i>
          </a>
        </div>
      </div>

      <!-- 중간 섹션: 회사 정보 -->
      <div class="grid grid-cols-2 md:grid-cols-4 gap-3 text-sm leading-snug mb-3">
        <div>
          <p>상호명: 주식회사 클로디</p>
          <p>대표자: 홍길동</p>
          <p>개인정보보호책임자: 홍길동</p>
        </div>
        <div>
          <p>사업자등록번호: 123-45-67890</p>
          <p>통신판매업신고번호:</p>
          <p>제2025-서울강남-0001호</p>
        </div>
        <div>
          <p>주소: 서울특별시 강남구 테헤란로 123</p>
          <p>고객센터: 1588-1234</p>
          <p>이메일: help@clodi.co.kr</p>
        </div>
        <div>
          <p class="text-base font-bold text-white">고객센터 1588-1234</p>
          <p>평일 10:00 - 18:00</p>
          <p>(점심시간 12:30 - 13:30)</p>
        </div>
      </div>

      <!-- 하단 섹션: 약관 링크 및 저작권 -->
      <div class="flex flex-col md:flex-row justify-between items-center gap-2 text-sm border-t border-gray-800 pt-3">
        <div class="flex flex-wrap justify-center md:justify-start gap-4">
          <a href="#" class="hover:text-white transition-colors">이용약관</a>
          <a href="#" class="hover:text-white transition-colors font-semibold">개인정보처리방침</a>
          <a href="#" class="hover:text-white transition-colors">제휴문의</a>
          <a href="#" class="hover:text-white transition-colors">고객센터</a>
        </div>
        <p class="text-sm text-gray-500">&copy; 2025 클로디. All rights reserved.</p>
      </div>
    </div>
  </footer>
</div>