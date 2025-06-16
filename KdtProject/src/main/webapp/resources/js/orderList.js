document.addEventListener('DOMContentLoaded', () => {
    const startDateInput = document.querySelector('input[name="start"]');
    const endDateInput   = document.querySelector('input[name="end"]');
    const searchForm     = document.getElementById('searchForm');

    // 날짜 yyyy-MM-dd 포맷터
	const formatDate = d =>
        d.getFullYear() + '-' +
        String(d.getMonth() + 1).padStart(2, '0') + '-' +
        String(d.getDate()).padStart(2, '0');

    const urlParams = new URLSearchParams(window.location.search);
    if (!urlParams.has('start') && !urlParams.has('end')) {
        document.querySelector('.date-preset-btn[data-amount="3"]').click();
    }

    // 빠른기간 버튼
    document.querySelectorAll('.date-preset-btn').forEach(btn =>
        btn.addEventListener('click', () => {
            const today  = new Date();
            const amount = Number(btn.dataset.amount);
            const start  = new Date(today);

            if (btn.dataset.period === 'day')   start.setDate(today.getDate() - amount);
            if (btn.dataset.period === 'month') start.setMonth(today.getMonth() - amount, today.getDate());

            startDateInput.value = formatDate(start);
            endDateInput.value   = formatDate(today);
            searchForm.submit();
        }));
});