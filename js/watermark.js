// watermark.js (精准参数识别版)
(function addWatermark() {
  // 核心判断：检查当前页面的 URL 是否包含 ?mode=modal
  const urlParams = new URLSearchParams(window.location.search);
  const isModal = urlParams.get('mode') === 'modal';

  // 如果不是弹窗模式，直接返回，不加水印
  if (!isModal) {
    return;
  }

  function renderWatermark() {
    let activeCoachName = "内部教练";
    try {
      const savedCoach = JSON.parse(localStorage.getItem('football-coaching-authenticated-coach'));
      if (savedCoach && savedCoach.displayName) {
        activeCoachName = savedCoach.displayName;
      }
    } catch (error) {
      // 忽略
    }

    if (document.getElementById('page-security-watermark')) return;

    const watermark = document.createElement('div');
    watermark.id = 'page-security-watermark';
    watermark.setAttribute('aria-hidden', 'true');
    
    const watermarkText = activeCoachName + ' · 内部教学系统  · ' + new Date().toLocaleDateString('zh-CN');
    
    for (let i = 0; i < 12; i += 1) {
      const item = document.createElement('span');
      item.textContent = watermarkText;
      Object.assign(item.style, {
        display: 'block',
        padding: '20px',
        transform: 'rotate(-25deg)',
        whiteSpace: 'nowrap'
      });
      watermark.appendChild(item);
    }
    
    Object.assign(watermark.style, {
      position: 'fixed',
      inset: '0',
      display: 'grid',
      gridTemplateColumns: 'repeat(3, minmax(0, 1fr))',
      alignItems: 'center',
      justifyItems: 'center',
      color: 'rgba(30, 58, 138, 0.10)',
      fontSize: 'clamp(12px, 2vw, 22px)',
      fontWeight: '700',
      letterSpacing: '0.08em',
      textAlign: 'center',
      pointerEvents: 'none',
      userSelect: 'none',
      zIndex: '2147483647'
    });
    
    document.body.appendChild(watermark);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', renderWatermark);
  } else {
    renderWatermark();
  }
})();