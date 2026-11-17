// SNES Compiler Benchmarks: theme toggle, metric tabs, re-basing the
// leaderboard, table sorting. Every page is complete without this file.
(function () {
  "use strict";

  // --- theme toggle ---------------------------------------------------------
  var btn = document.querySelector("button.theme");
  function isDark() {
    var t = document.documentElement.dataset.theme;
    return t ? t === "dark" : window.matchMedia("(prefers-color-scheme: dark)").matches;
  }
  if (btn) {
    var label = function () {
      btn.textContent = isDark() ? "Light" : "Dark";
      btn.setAttribute("aria-label", isDark() ? "Switch to light mode" : "Switch to dark mode");
    };
    btn.hidden = false;
    label();
    btn.addEventListener("click", function () {
      document.documentElement.dataset.theme = isDark() ? "light" : "dark";
      try { localStorage.setItem("scb-theme", document.documentElement.dataset.theme); } catch (e) {}
      label();
    });
  }

  // --- metric tabs: one matrix at a time ------------------------------------
  var tabs = document.querySelector(".tabs");
  if (tabs) {
    var show = function (metric) {
      tabs.querySelectorAll("button").forEach(function (b) {
        b.setAttribute("aria-selected", String(b.dataset.metric === metric));
      });
      document.querySelectorAll(".matrix .table-wrap").forEach(function (w) {
        w.hidden = w.dataset.metric !== metric;
      });
    };
    tabs.hidden = false;
    show("cycles");
    tabs.addEventListener("click", function (e) {
      var b = e.target.closest("button");
      if (b) show(b.dataset.metric);
    });
    tabs.addEventListener("keydown", function (e) {
      if (e.key !== "ArrowLeft" && e.key !== "ArrowRight") return;
      var all = Array.prototype.slice.call(tabs.querySelectorAll("button"));
      var i = all.indexOf(document.activeElement);
      var next = all[(i + (e.key === "ArrowRight" ? 1 : all.length - 1)) % all.length];
      next.focus();
      show(next.dataset.metric);
    });
  }

  // --- leaderboard: language filter and re-basing ---------------------------
  var STEPS = 12;
  var dataEl = document.getElementById("board-data");
  var select = document.getElementById("baseline");
  var seg = document.querySelector(".seg");
  var data = null;
  var state = { lang: "", base: "" };
  if (dataEl && select) {
    data = JSON.parse(dataEl.textContent);
    select.disabled = false;
    select.addEventListener("change", function () { state.base = select.value; render(); });
    if (seg) {
      seg.hidden = false;
      seg.addEventListener("click", function (e) {
        var b = e.target.closest("button");
        if (!b) return;
        state.lang = b.dataset.lang;
        try { history.replaceState(null, "", state.lang ? "#" + state.lang : location.pathname); } catch (err) {}
        render();
      });
      if (location.hash === "#c") { state.lang = "c"; render(); }
    }
  }

  function step(r) {
    var t = Math.min(1, Math.log2(Math.max(r, 1)) / 3);
    return Math.round(t * (STEPS - 1));
  }
  function fmt(r) { return r.toFixed(2) + "×"; }
  function esc(s) {
    return String(s).replace(/[&<>"]/g, function (c) {
      return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c];
    });
  }

  function visible() {
    return data.toolchains.filter(function (t) { return !state.lang || data.languages[t] === state.lang; });
  }

  function denominators(values, shown, base) {
    var out = {};
    data.benches.forEach(function (b) {
      var row = values[b] || {};
      if (base) { out[b] = row[base] || null; return; }
      var best = null;
      shown.forEach(function (t) {
        var v = row[t];
        if (v && (best === null || v < best)) best = v;
      });
      out[b] = best;
    });
    return out;
  }

  function score(values, shown, den) {
    var out = shown.map(function (t) {
      var logs = 0, n = 0;
      data.benches.forEach(function (b) {
        var v = (values[b] || {})[t];
        if (v && den[b]) { logs += Math.log(v / den[b]); n++; }
      });
      return { t: t, g: n ? Math.exp(logs / n) : null, n: n };
    });
    out.sort(function (a, b) {
      if (a.g === null) return 1;
      if (b.g === null) return -1;
      return a.g - b.g;
    });
    return out;
  }

  function render() {
    var shown = visible();
    if (state.base && shown.indexOf(state.base) < 0) state.base = "";
    // the language buttons and the baseline choices
    if (seg) {
      seg.querySelectorAll("button").forEach(function (b) {
        b.setAttribute("aria-checked", String(b.dataset.lang === state.lang));
      });
    }
    Array.prototype.forEach.call(select.options, function (o) {
      o.hidden = o.value !== "" && shown.indexOf(o.value) < 0;
    });
    select.value = state.base;

    Object.keys(data.values).forEach(function (metric) {
      var values = data.values[metric];
      var den = denominators(values, shown, state.base);
      var covered = data.benches.filter(function (b) { return den[b]; }).length;

      // ranked bars
      var scored = score(values, shown, den);
      var top = Math.max.apply(null, scored.map(function (s) { return s.g || 0; })) || 1;
      var html = scored.map(function (s) {
        var k = data.kinds[s.t];
        var cls = k && k !== "65816" ? "k-" + k : "";
        var chip = k === "6502" ? ' <span class="chip">6502</span>' : "";
        var name = '<a href="toolchains/#' + esc(s.t) + '">' + esc(data.labels[s.t]) + "</a>" + chip;
        if (s.g === null) {
          return '<li class="none ' + cls + '"><span class="bl">' + name + '</span><span class="bt">' +
                 '<span class="pill quiet">no shared benchmarks</span></span></li>';
        }
        var cover = s.n === covered ? "" : " · " + s.n + "/" + covered;
        var frac = Math.max(0.005, s.g / top).toFixed(4);
        return '<li class="' + cls + '" title="' + esc(data.labels[s.t]) + ": geomean " + fmt(s.g) + '">' +
               '<span class="bl">' + name + '</span><span class="bt"><span class="bar" style="width:calc((100% - 9rem) * ' +
               frac + ')"></span><span class="bv">' + fmt(s.g) + cover + "</span></span></li>";
      }).join("");
      var board = document.querySelector('.board[data-metric="' + metric + '"]');
      board.querySelector("ol.bars").innerHTML = html;
      var notes = [];
      if (state.lang) notes.push("C compilers only; ratios are against the best C result.");
      if (state.base) {
        notes.push("Divided by " + data.labels[state.base] + ", over the " + covered + " of " +
                   data.benches.length + " benchmarks it passed. Below 1.00× is faster than it.");
      }
      board.querySelector(".cov-note").textContent = notes.join(" ");

      // the matrix
      var table = document.querySelector('table.heat[data-metric="' + metric + '"]');
      var cols = Array.prototype.map.call(table.tHead.rows[0].cells, function (th) { return th.dataset.tc; });
      Array.prototype.forEach.call(table.rows, function (tr) {
        for (var i = 1; i < tr.cells.length; i++) {
          tr.cells[i].classList.toggle("col-off", shown.indexOf(cols[i]) < 0);
        }
      });
      Array.prototype.forEach.call(table.tBodies[0].rows, function (tr) {
        var bench = tr.cells[0].textContent.trim();
        for (var i = 1; i < tr.cells.length; i++) {
          var td = tr.cells[i];
          if (!td.dataset.v) continue;
          var v = Number(td.dataset.v);
          var d = den[bench];
          var r = td.querySelector(".r");
          td.classList.remove("h");
          for (var k = 0; k < STEPS; k++) td.classList.remove("s" + k);
          if (!d) { r.textContent = "–"; continue; }
          var ratio = v / d;
          r.textContent = fmt(ratio);
          if (ratio >= 1) td.classList.add("h", "s" + step(ratio));
          td.title = data.labels[cols[i]] + ", " + bench + ": " + v.toLocaleString("en-US") + " (" + fmt(ratio) + ")";
        }
      });
    });

    // the summary strip
    var cyc = data.values.cycles;
    var lead = score(cyc, shown, denominators(cyc, shown, "")).filter(function (s) {
      return s.g !== null && data.kinds[s.t] === "65816";
    })[0];
    var fastest = document.getElementById("fact-fastest");
    if (fastest) {
      fastest.innerHTML = lead ? esc(data.labels[lead.t]) + ' <span class="muted">' + fmt(lead.g) + "</span>" : "–";
    }
    var ok = 0, tried = 0;
    data.benches.forEach(function (b) {
      shown.forEach(function (t) {
        var st = (data.statuses[b] || {})[t];
        if (st && st !== "unsupported") { tried++; if (st === "ok") ok++; }
      });
    });
    var count = document.getElementById("fact-toolchains");
    if (count) count.textContent = String(shown.length);
    var correct = document.getElementById("fact-correct");
    if (correct) correct.textContent = ok + " of " + tried;
  }

  // --- table sorting --------------------------------------------------------
  document.querySelectorAll("table.heat").forEach(function (table) {
    var buttons = table.querySelectorAll("button.sort");
    buttons.forEach(function (b) {
      b.addEventListener("click", function () {
        var col = b.closest("th").cellIndex;
        var rows = Array.prototype.slice.call(table.tBodies[0].rows);
        rows.sort(function (x, y) {
          var a = Number(x.cells[col].dataset.v || Infinity);
          var c = Number(y.cells[col].dataset.v || Infinity);
          return a - c;
        });
        rows.forEach(function (r) { table.tBodies[0].appendChild(r); });
        buttons.forEach(function (o) { o.removeAttribute("aria-sort"); });
        b.setAttribute("aria-sort", "ascending");
      });
    });
  });
})();
