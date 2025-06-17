<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>매출 분석 - 판매자</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Pretendard Font -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary-color: #333;
            --secondary-color: #666;
            --accent-color: #000;
            --background-color: #f5f5f5;
            --card-background: #fff;
            --border-color: #e0e0e0;
            --hover-color: #f0f0f0;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --info-color: #3b82f6;
            --purple-color: #8b5cf6;
        }

        body {
            font-family: 'Pretendard', sans-serif;
            background-color: var(--background-color);
            color: var(--primary-color);
            padding: 2rem;
            padding-top: 5rem;
        }
        
        .main-content {
            margin-top: 100px; 
            padding: 2rem;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .page-title {
            color: var(--accent-color);
            margin-bottom: 2rem;
            font-weight: 600;
            font-size: 2rem;
        }

        .analytics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .large-chart {
            grid-column: span 2;
            height: 500px;
            max-height: 500px;
        }

        .chart-container {
            background-color: var(--card-background);
            border-radius: 15px;
            padding: 1.5rem;
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            height: 450px;
            max-height: 450px;
            overflow: hidden;
        }

        .chart-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--accent-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .chart-content {
            height: calc(100% - 2rem);
            position: relative;
        }

        .stats-overview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: linear-gradient(135deg, var(--card-background) 0%, #f8fafc 100%);
            border-radius: 15px;
            padding: 2rem;
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            color: white;
        }

        .stat-icon.revenue { background: linear-gradient(135deg, var(--success-color), #059669); }
        .stat-icon.orders { background: linear-gradient(135deg, var(--info-color), #2563eb); }
        .stat-icon.average { background: linear-gradient(135deg, var(--warning-color), #d97706); }
        .stat-icon.growth { background: linear-gradient(135deg, var(--purple-color), #7c3aed); }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--secondary-color);
            font-size: 1rem;
            font-weight: 500;
        }

        .stat-change {
            font-size: 0.9rem;
            margin-top: 0.75rem;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-weight: 600;
        }

        .stat-increase {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .stat-decrease {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .period-selector {
            background-color: var(--card-background);
            border-radius: 15px;
            padding: 1.5rem;
            border: 1px solid var(--border-color);
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .period-label {
            font-weight: 600;
            color: var(--secondary-color);
        }

        .form-select, .form-control {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
        }

        .form-select:focus, .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(0,0,0,0.1);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--accent-color), #1f2937);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }





        @media (max-width: 1200px) {
            .large-chart {
                grid-column: span 1;
            }
        }

        @media (max-width: 768px) {
            .analytics-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-overview {
                grid-template-columns: 1fr;
            }
            
            .period-selector {
                flex-direction: column;
                align-items: stretch;
            }
            
            .export-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/seller/nav.jsp" %>
    <div class="main-content">
        <div class="container">
            <h2 class="page-title">
                <i class="fas fa-chart-line me-3"></i>매출 분석 대시보드
            </h2>
            
            <!-- 기간 선택 -->
            <div class="period-selector">
                <span class="period-label">
                    <i class="fas fa-calendar-alt me-2"></i>분석 기간:
                </span>
                <select id="yearSelect" class="form-select">
                    <option value="${currentYear}" selected>${currentYear}년</option>
                    <option value="${currentYear - 1}">${currentYear - 1}년</option>
                </select>
                <button type="button" class="btn btn-primary" onclick="updateAnalytics()">
                    <i class="fas fa-refresh me-2"></i>업데이트
                </button>
            </div>

            <!-- 주요 통계 -->
            <div class="stats-overview">
                <div class="stat-card">
                    <div class="stat-icon revenue">
                        <i class="fas fa-won-sign"></i>
                    </div>
                    <div class="stat-value">${analytics.formattedRevenue}</div>
                    <div class="stat-label">총 매출</div>
                    <div class="stat-change ${analytics.changeStatus == 'positive' ? 'stat-increase' : 'stat-decrease'}">
                        ${analytics.formattedChangeRate} (전월 대비)
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon orders">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stat-value">${analytics.totalOrders}건</div>
                    <div class="stat-label">총 주문</div>
                    <div class="stat-change stat-increase">+8.3% (전월 대비)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon average">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <div class="stat-value">${analytics.formattedAverageOrderValue}</div>
                    <div class="stat-label">평균 주문가</div>
                    <div class="stat-change stat-increase">+3.7% (전월 대비)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon growth">
                        <i class="fas fa-trending-up"></i>
                    </div>
                    <div class="stat-value">24.5%</div>
                    <div class="stat-label">성장률</div>
                    <div class="stat-change stat-increase">+5.2% (전월 대비)</div>
                </div>
            </div>

            <!-- 향상된 차트 영역 -->
            <div class="analytics-grid">
                <!-- 통합 매출 추이 차트 (대형) -->
                <div class="chart-container large-chart">
                    <div class="chart-title">
                        <i class="fas fa-chart-area"></i>
                        ${currentYear}년 월별 매출 & 주문량 분석
                    </div>
                    <canvas id="combinedAnalyticsChart"></canvas>
                </div>
                
                <!-- 매출 성과 분석 -->
                <div class="chart-container">
                    <div class="chart-title">
                        <i class="fas fa-target"></i>
                        분기별 매출 성과
                    </div>
                    <canvas id="quarterlyPerformanceChart"></canvas>
                </div>
                

                
                <!-- 상품 카테고리별 매출 분석 -->
                <div class="chart-container">
                    <div class="chart-title">
                        <i class="fas fa-pie-chart"></i>
                        카테고리별 매출 분포
                    </div>
                    <canvas id="categoryAnalysisChart"></canvas>
                </div>
                
                <!-- 고객 분석 차트 -->
                <div class="chart-container">
                    <div class="chart-title">
                        <i class="fas fa-users"></i>
                        고객 구매 패턴 분석
                    </div>
                    <canvas id="customerAnalysisChart"></canvas>
                </div>
            </div>




        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let combinedAnalyticsChart, quarterlyPerformanceChart, categoryAnalysisChart, customerAnalysisChart;
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            initializeCharts();
        });
        
        function initializeCharts() {
            // 통합 매출 & 주문량 차트
            const combinedCtx = document.getElementById('combinedAnalyticsChart').getContext('2d');
            
            let monthlyRevenueData = [];
            let monthlyOrderData = [];
            
            try {
                monthlyRevenueData = [
                    <c:choose>
                        <c:when test="${not empty currentYearSales}">
                            <c:forEach items="${currentYearSales}" var="monthly" varStatus="status">
                                ${monthly.revenue}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            47200, 94400, 141600, 247200, 288800, 336000, 380000, 420000, 450000, 480000, 520000, 550000
                        </c:otherwise>
                    </c:choose>
                ];
                
                monthlyOrderData = [
                    <c:choose>
                        <c:when test="${not empty currentYearSales}">
                            <c:forEach items="${currentYearSales}" var="monthly" varStatus="status">
                                ${monthly.orderCount}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13
                        </c:otherwise>
                    </c:choose>
                ];
            } catch (e) {
                monthlyRevenueData = [47200, 94400, 141600, 247200, 288800, 336000, 380000, 420000, 450000, 480000, 520000, 550000];
                monthlyOrderData = [1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13];
            }
            
            combinedAnalyticsChart = new Chart(combinedCtx, {
                type: 'line',
                data: {
                    labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                    datasets: [{
                        label: '매출액',
                        data: monthlyRevenueData,
                        borderColor: '#10b981',
                        backgroundColor: 'rgba(16, 185, 129, 0.1)',
                        tension: 0.4,
                        fill: true,
                        yAxisID: 'y'
                    }, {
                        label: '주문 건수',
                        data: monthlyOrderData,
                        borderColor: '#3b82f6',
                        backgroundColor: 'rgba(59, 130, 246, 0.1)',
                        tension: 0.4,
                        fill: false,
                        yAxisID: 'y1'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    layout: {
                        padding: {
                            top: 20,
                            bottom: 20,
                            left: 10,
                            right: 10
                        }
                    },
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                            labels: {
                                padding: 20,
                                font: {
                                    size: 12
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            display: true,
                            title: {
                                display: true,
                                text: '월',
                                padding: 10
                            },
                            ticks: {
                                font: {
                                    size: 11
                                }
                            }
                        },
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            title: {
                                display: true,
                                text: '매출액 (원)',
                                padding: 10
                            },
                            beginAtZero: true,
                            max: function(context) {
                                const data = context.chart.data.datasets[0].data;
                                const maxRevenue = Math.max(...data.filter(v => v !== null && v !== undefined));
                                return maxRevenue + 100000; // 최대값 + 10만원
                            },
                            ticks: {
                                font: {
                                    size: 11
                                },
                                callback: function(value) {
                                    return (value / 1000).toFixed(0) + 'K';
                                }
                            }
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            title: {
                                display: true,
                                text: '주문 건수',
                                padding: 10
                            },
                            beginAtZero: true,
                            max: 20,
                            grid: {
                                drawOnChartArea: false,
                            },
                            ticks: {
                                font: {
                                    size: 11
                                }
                            }
                        }
                    }
                }
            });
            
            // 분기별 성과 차트
            const quarterlyCtx = document.getElementById('quarterlyPerformanceChart').getContext('2d');
            quarterlyPerformanceChart = new Chart(quarterlyCtx, {
                type: 'bar',
                data: {
                    labels: ['1분기', '2분기', '3분기', '4분기'],
                    datasets: [{
                        label: '매출액',
                        data: [283200, 472000, 950000, 1250000],
                        backgroundColor: [
                            'rgba(16, 185, 129, 0.8)',
                            'rgba(59, 130, 246, 0.8)',
                            'rgba(245, 158, 11, 0.8)',
                            'rgba(139, 92, 246, 0.8)'
                        ],
                        borderColor: [
                            '#10b981',
                            '#3b82f6',
                            '#f59e0b',
                            '#8b5cf6'
                        ],
                        borderWidth: 2,
                        borderRadius: 8
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    layout: {
                        padding: {
                            top: 10,
                            bottom: 30,
                            left: 10,
                            right: 10
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        x: {
                            ticks: {
                                font: {
                                    size: 11
                                },
                                maxRotation: 0,
                                minRotation: 0
                            }
                        },
                        y: {
                            beginAtZero: true,
                            ticks: {
                                font: {
                                    size: 11
                                },
                                callback: function(value) {
                                    return (value / 1000).toFixed(0) + 'K원';
                                }
                            }
                        }
                    }
                }
            });
            

            // 카테고리별 매출 차트
            const categoryCtx = document.getElementById('categoryAnalysisChart').getContext('2d');
            categoryAnalysisChart = new Chart(categoryCtx, {
                type: 'doughnut',
                data: {
                    labels: ['의류', '액세서리', '신발', '가방', '기타'],
                    datasets: [{
                        data: [45, 25, 15, 10, 5],
                        backgroundColor: [
                            '#10b981',
                            '#3b82f6', 
                            '#f59e0b',
                            '#ef4444',
                            '#8b5cf6'
                        ],
                        borderWidth: 3,
                        borderColor: '#ffffff'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    layout: {
                        padding: {
                            top: 10,
                            bottom: 40,
                            left: 10,
                            right: 10
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                padding: 20,
                                usePointStyle: true,
                                font: {
                                    size: 11
                                },
                                boxWidth: 12,
                                boxHeight: 12
                            }
                        }
                    }
                }
            });
            
            // 고객 분석 차트
            const customerCtx = document.getElementById('customerAnalysisChart').getContext('2d');
            customerAnalysisChart = new Chart(customerCtx, {
                type: 'radar',
                data: {
                    labels: ['신규고객', '재구매고객', 'VIP고객', '휴면고객', '이탈고객'],
                    datasets: [{
                        label: '고객 분포',
                        data: [85, 65, 90, 45, 25],
                        borderColor: '#3b82f6',
                        backgroundColor: 'rgba(59, 130, 246, 0.2)',
                        pointBackgroundColor: '#3b82f6',
                        pointBorderColor: '#ffffff',
                        pointBorderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    layout: {
                        padding: {
                            top: 10,
                            bottom: 10,
                            left: 10,
                            right: 10
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        r: {
                            beginAtZero: true,
                            max: 100,
                            ticks: {
                                font: {
                                    size: 10
                                }
                            },
                            pointLabels: {
                                font: {
                                    size: 11
                                }
                            }
                        }
                    }
                }
            });
        }
        
        // 분석 데이터 업데이트
        function updateAnalytics() {
            const year = document.getElementById('yearSelect').value;
            console.log('분석 데이터 업데이트:', year);
            
            fetch(`/seller/api/monthly-sales?year=${year}`)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        updateChartsWithData(data);
                        updateStatsWithData(data);
                    } else {
                        alert('데이터 조회에 실패했습니다: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    updateChartsWithSampleData(year);
                });
        }
        
        // 동적 Y축 최대값 계산 함수
        function calculateDynamicMax(data) {
            const validData = data.filter(v => v !== null && v !== undefined && v > 0);
            if (validData.length === 0) return 100000;
            const maxValue = Math.max(...validData);
            return maxValue + 100000; // 최대값 + 10만원
        }
        
        // 차트 데이터 업데이트
        function updateChartsWithData(data) {
            const monthlySales = data.monthlySales || [];
            
            const revenueData = [];
            const orderData = [];
            
            for (let month = 1; month <= 12; month++) {
                const monthData = monthlySales.find(item => item.month === month);
                revenueData.push(monthData ? monthData.revenue : 0);
                orderData.push(monthData ? monthData.orderCount : 0);
            }
            
            if (combinedAnalyticsChart) {
                combinedAnalyticsChart.data.datasets[0].data = revenueData;
                combinedAnalyticsChart.data.datasets[1].data = orderData;
                
                // Y축 최대값 동적으로 업데이트
                const dynamicMax = calculateDynamicMax(revenueData);
                combinedAnalyticsChart.options.scales.y.max = dynamicMax;
                
                combinedAnalyticsChart.update();
            }
            
            // 분기별 데이터 계산 및 업데이트
            const quarterlyData = [
                revenueData.slice(0, 3).reduce((a, b) => a + b, 0),
                revenueData.slice(3, 6).reduce((a, b) => a + b, 0),
                revenueData.slice(6, 9).reduce((a, b) => a + b, 0),
                revenueData.slice(9, 12).reduce((a, b) => a + b, 0)
            ];
            
            if (quarterlyPerformanceChart) {
                quarterlyPerformanceChart.data.datasets[0].data = quarterlyData;
                quarterlyPerformanceChart.update();
            }
        }
        
        // 샘플 데이터로 차트 업데이트
        function updateChartsWithSampleData(year) {
            const sampleRevenueData = [47200, 94400, 141600, 247200, 288800, 336000, 380000, 420000, 450000, 480000, 520000, 550000];
            const sampleOrderData = [1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13];
            
            if (combinedAnalyticsChart) {
                combinedAnalyticsChart.data.datasets[0].data = sampleRevenueData;
                combinedAnalyticsChart.data.datasets[1].data = sampleOrderData;
                
                // Y축 최대값 동적으로 업데이트
                const dynamicMax = calculateDynamicMax(sampleRevenueData);
                combinedAnalyticsChart.options.scales.y.max = dynamicMax;
                
                combinedAnalyticsChart.update();
            }
            
            const quarterlyData = [
                sampleRevenueData.slice(0, 3).reduce((a, b) => a + b, 0),
                sampleRevenueData.slice(3, 6).reduce((a, b) => a + b, 0),
                sampleRevenueData.slice(6, 9).reduce((a, b) => a + b, 0),
                sampleRevenueData.slice(9, 12).reduce((a, b) => a + b, 0)
            ];
            
            if (quarterlyPerformanceChart) {
                quarterlyPerformanceChart.data.datasets[0].data = quarterlyData;
                quarterlyPerformanceChart.update();
            }
        }
        
        // 통계 카드 업데이트
        function updateStatsWithData(data) {
            const analytics = data.analytics;
            
            if (analytics) {
                const statCards = document.querySelectorAll('.stat-value');
                if (statCards.length >= 4) {
                    statCards[0].textContent = formatCurrency(analytics.totalRevenue);
                    statCards[1].textContent = analytics.totalOrders + '건';
                    statCards[2].textContent = formatCurrency(analytics.averageOrderValue);
                    statCards[3].textContent = '24.5%'; // 성장률은 별도 계산 필요
                }
            }
        }
        
        // 통화 포맷팅
        function formatCurrency(amount) {
            if (amount == null || amount == undefined) return '0원';
            return parseInt(amount).toLocaleString() + '원';
        }
        

        // 실시간 업데이트 (10분마다)
        setInterval(function() {
            updateAnalytics();
        }, 10 * 60 * 1000);
        
        // 차트 반응형 크기 조정
        window.addEventListener('resize', function() {
            setTimeout(() => {
                if (combinedAnalyticsChart) combinedAnalyticsChart.resize();
                if (quarterlyPerformanceChart) quarterlyPerformanceChart.resize();
                if (categoryAnalysisChart) categoryAnalysisChart.resize();
                if (customerAnalysisChart) customerAnalysisChart.resize();
            }, 100);
        });
        
        // 초기 로딩 완료 로그
        console.log('매출 분석 대시보드 초기화 완료');
    </script>
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>