/* spec.js — lightweight interactivity for SDD spec documents
 * No external dependencies. Runs after DOMContentLoaded.
 */
(function () {
  'use strict';

  /* --- Table of Contents ---
   * Auto-populates #toc-list from h2/h3 headings in .main-content.
   */
  function buildToc() {
    var container = document.getElementById('toc-list');
    if (!container) return;
    var headings = document.querySelectorAll('.main-content h2, .main-content h3');
    if (!headings.length) return;
    var ul = document.createElement('ul');
    ul.className = 'toc-list';
    headings.forEach(function (h, i) {
      if (!h.id) h.id = 'sec-' + i;
      var li = document.createElement('li');
      if (h.tagName === 'H3') li.className = 'toc-h3';
      var a = document.createElement('a');
      a.href = '#' + h.id;
      a.textContent = h.textContent.replace(/\s*#\s*$/, '');
      li.appendChild(a);
      ul.appendChild(li);
    });
    container.appendChild(ul);
  }

  /* --- Collapsible sections ---
   * Toggles .hidden on .collapse-body and .collapsed on .collapse-btn.
   */
  function initCollapsibles() {
    document.querySelectorAll('.collapse-btn').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var body = btn.nextElementSibling;
        if (!body) return;
        var nowHidden = body.classList.toggle('hidden');
        btn.classList.toggle('collapsed', nowHidden);
      });
    });
  }

  /* --- Tab panels ---
   * Each .tabs block: .tab-btn elements activate the matching .tab-panel by index.
   */
  function initTabs() {
    document.querySelectorAll('.tabs').forEach(function (tabs) {
      var btns   = Array.from(tabs.querySelectorAll('.tab-btn'));
      var panels = Array.from(tabs.querySelectorAll('.tab-panel'));

      function activate(idx) {
        btns.forEach(function (b, i) { b.classList.toggle('active', i === idx); });
        panels.forEach(function (p, i) { p.classList.toggle('active', i === idx); });
      }

      btns.forEach(function (btn, i) {
        btn.addEventListener('click', function () { activate(i); });
      });

      if (btns.length) activate(0);
    });
  }

  document.addEventListener('DOMContentLoaded', function () {
    buildToc();
    initCollapsibles();
    initTabs();
  });
}());
