// 教练白名单：上线前请将示例账号、显示名称和密码替换为真实信息。
// 纯静态页面无法安全保存密码；如需真正的权限控制，请改用服务端登录验证。
const COACH_ACCOUNTS = [
  { username: 'simon.xie', displayName: '谢子萌simon', password: 'xzm97' },
  { username: 'Fei', displayName: '费小婕', password: 'fxj02' }
];
const LOGIN_STORAGE_KEY = 'football-coaching-authenticated-coach';

function showAccessDenied() {
  document.body.innerHTML = [
    '<main style="min-height:100vh;display:grid;place-items:center;padding:24px;background:#f8fafc;font-family:-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,sans-serif;">',
    '<section style="max-width:440px;padding:32px;border:1px solid #e2e8f0;border-radius:16px;background:#fff;text-align:center;box-shadow:0 10px 24px rgba(15,23,42,.08);">',
    '<h1 style="margin:0 0 12px;color:#1e3a8a;font-size:24px;">访问未授权</h1>',
    '<p style="margin:0;color:#64748b;line-height:1.6;">账号或通行密码不正确，无法查看教学内容。</p>',
    '</section></main>'
  ].join('');
}

function getAuthenticatedCoach() {
  try {
    const savedCoach = JSON.parse(localStorage.getItem(LOGIN_STORAGE_KEY));
    const matchedSavedCoach = savedCoach && COACH_ACCOUNTS.find(function (coach) {
      return coach.username === savedCoach.username;
    });
    if (matchedSavedCoach) return matchedSavedCoach;
  } catch (error) {
    // 本地存储不可用时，仍允许本次页面完成登录。
  }

  const username = window.prompt('请输入教练账号：');
  if (username === null) return null;
  const password = window.prompt('请输入通行密码：');
  if (password === null) return null;

  const matchedCoach = COACH_ACCOUNTS.find(function (coach) {
    return coach.username === username.trim() && coach.password === password;
  });
  if (!matchedCoach) return null;

  try {
    localStorage.setItem(LOGIN_STORAGE_KEY, JSON.stringify({
      username: matchedCoach.username,
      displayName: matchedCoach.displayName
    }));
  } catch (error) {
    // 无痕模式等场景可能禁止本地存储；本页仍可继续访问。
  }
  return matchedCoach;
}

const activeCoach = getAuthenticatedCoach();
if (!activeCoach) showAccessDenied();

function addLogoutButton() {
  if (!activeCoach || document.getElementById('logout-button')) return;

  const button = document.createElement('button');
  button.id = 'logout-button';
  button.type = 'button';
  button.textContent = '退出登录';
  Object.assign(button.style, {
    position: 'fixed',
    top: '12px',
    right: '12px',
    zIndex: '2147483646',
    padding: '7px 10px',
    border: '1px solid #cbd5e1',
    borderRadius: '8px',
    color: '#475569',
    background: 'rgba(255,255,255,.88)',
    fontSize: '12px',
    cursor: 'pointer'
  });
  button.addEventListener('click', function () {
    localStorage.removeItem(LOGIN_STORAGE_KEY);
    window.location.reload();
  });
  document.body.appendChild(button);
}

addLogoutButton();

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
    if (!activeCoach) return;
    if (document.getElementById('page-security-watermark')) return;

    const watermark = document.createElement('div');
    watermark.id = 'page-security-watermark';
    watermark.setAttribute('aria-hidden', 'true');
    const watermarkText = activeCoach.displayName + ' · 内部教学系统  · ' + new Date().toLocaleDateString('zh-CN');
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
