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