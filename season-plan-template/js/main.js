document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.tab-btn[data-target], .segment-tab-btn[data-target]').forEach((tab) => {
    tab.addEventListener('click', () => {
      const target = document.getElementById(tab.dataset.target);
      const group = tab.classList.contains('segment-tab-btn') ? '.segment-tab-btn' : '.tab-btn';
      document.querySelectorAll(group).forEach((item) => item.classList.remove('active'));
      document.querySelectorAll('.tab-content').forEach((content) => content.classList.remove('active'));
      tab.classList.add('active');
      if (target) target.classList.add('active');
    });
  });
});