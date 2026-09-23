// 1. 禁用右键菜单
document.addEventListener('contextmenu', function (e) {
  e.preventDefault();
  alert("⚠️ 内部教学系统，禁止右键菜单");
});

// 2. 禁用复制与文本选中
document.addEventListener('selectstart', function (e) {
  e.preventDefault();
});

// 3. 拦截常见快捷键 (F12, Ctrl+S, Ctrl+P, Shift+Ctrl+I 等)
document.addEventListener('keydown', function (e) {
  // 禁用 F12
  if (e.key === 'F12' || e.keyCode === 123) {
    e.preventDefault();
    return false;
  }
  // 禁用 Ctrl+S (保存) / Ctrl+P (打印) / Ctrl+U (看源码)
  if (e.ctrlKey && (e.key === 's' || e.key === 'p' || e.key === 'u' || e.key === 'S' || e.key === 'P' || e.key === 'U')) {
    e.preventDefault();
    alert("⚠️ 该功能已被系统管理员禁用");
    return false;
  }
  // 禁用 Ctrl+Shift+I / Ctrl+Shift+C (打开开发者工具)
  if (e.ctrlKey && e.shiftKey && (e.key === 'I' || e.key === 'i' || e.key === 'C' || e.key === 'c')) {
    e.preventDefault();
    return false;
  }
});

// 4. 防截图折中技巧：当页面失去焦点（如用户使用截图软件框选）时，自动将内容模糊化
window.addEventListener('blur', function() {
  document.body.style.filter = 'blur(15px)';
});
window.addEventListener('focus', function() {
  document.body.style.filter = 'none';
});

// 5. 全站动态水印：移动端系统截图无法由网页阻止，水印可明确内容来源并提高外传成本。
(function addWatermark() {
  function renderWatermark() {
    if (document.getElementById('page-security-watermark')) return;

    const watermark = document.createElement('div');
    watermark.id = 'page-security-watermark';
    watermark.setAttribute('aria-hidden', 'true');
    const watermarkText = '内部教学系统 · 仅限授权使用 · ' + new Date().toLocaleDateString('zh-CN');
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
