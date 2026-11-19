/*
 * rainbow-parens: color matching brackets by nesting depth.
 *
 * Depth 1 gets class rp-d1, depth 2 rp-d2, and so on, cycling after
 * rainbow-parens.css's last color (four). An opener and its closer share
 * a depth, whatever their shapes, so the half-open interval [0, 1) pairs
 * its [ with its ). A closer with no opener before it keeps the text color.
 * The invisible fences of \left. and \right. are not colored, but they
 * still open and close a level, so cases and set-builder braces pair up.
 *
 * Math: a MathJax render action, run after MathJax compiles the TeX into its
 * internal MathML and before it builds the output, adds the class to each
 * bracket <mo>. MathJax copies a MathML class onto the element it draws, so
 * the stylesheet can switch colors with the page theme. Brackets inside an
 * explicit \color{...} keep the author's color.
 *
 * Code: in highlighted code blocks (every language by default, or the
 * configured ones), each bracket outside a string, comment or character
 * literal is wrapped in a span with the class.
 */
(function () {
  "use strict";

  var LEVELS = 4;
  var OPEN = { "(": ")", "[": "]", "{": "}" };
  var CLOSE = { ")": true, "]": true, "}": true };
  // Pandoc highlighting classes whose text is not code: strings, comments,
  // characters and special characters (Racket's #\( is a character).
  // R's backtick-quoted names are attributes (at), so `f(` is skipped too.
  var SKIP_CLASSES = [
    "st", "co", "ch", "sc", "vs", "ss", "do", "an", "cv", "in", "wa", "at",
  ];
  // Below this relative luminance a page background counts as dark: white
  // text then has more contrast on it than black text does.
  var DARK_LUMINANCE = 0.179;

  function settings() {
    var meta = document.querySelector('meta[name="rainbow-parens"]');
    if (!meta) {
      return { math: true, code: ["*"] };
    }
    var code = (meta.getAttribute("data-code") || "").toLowerCase()
      .split(/\s+/).filter(Boolean);
    return { math: meta.getAttribute("data-math") !== "false", code: code };
  }

  function levelClass(depth) {
    return "rp-d" + (((depth - 1) % LEVELS) + 1);
  }

  /* ---------- math ---------- */

  function addClass(node, cls) {
    var old = node.attributes.get("class") || "";
    if (/(^|\s)rp-d\d/.test(old)) {
      return;
    }
    node.attributes.set("class", old ? old + " " + cls : cls);
  }

  // The empty <mo> that \left. or \right. makes: the first child of its
  // row for \left., the last for \right.
  function invisibleFence(node) {
    var kids = node.parent && node.parent.childNodes;
    if (!kids || node.getText() !== "" || !node.attributes.get("fence")) {
      return null;
    }
    if (kids[0] === node) {
      return "open";
    }
    return kids[kids.length - 1] === node ? "close" : null;
  }

  function colorMath(root) {
    // MathJax.typeset() re-runs document actions over all math on the page;
    // a compiled tree only needs coloring once.
    if (!root || root.rainbowParens) {
      return;
    }
    root.rainbowParens = true;
    var stack = [];
    function walk(node, colored) {
      if (!node) {
        return;
      }
      var own = node.attributes && node.attributes.getExplicit &&
        node.attributes.getExplicit("mathcolor");
      var inColor = colored || Boolean(own);
      if (node.isKind && node.isKind("mo") && node.getText) {
        var text = node.getText();
        var fence = invisibleFence(node);
        if (fence === "open") {
          stack.push(text);
        } else if (fence === "close") {
          stack.pop();
        } else if (OPEN[text]) {
          stack.push(text);
          if (!inColor) {
            addClass(node, levelClass(stack.length));
          }
        } else if (CLOSE[text] && stack.length) {
          if (!inColor) {
            addClass(node, levelClass(stack.length));
          }
          stack.pop();
        }
        return;
      }
      var kids = node.childNodes || [];
      for (var i = 0; i < kids.length; i++) {
        walk(kids[i], inColor);
      }
    }
    walk(root, false);
  }

  function installMathJax() {
    var mj = window.MathJax = window.MathJax || {};
    if (mj.version) {
      // MathJax already loaded: too late to register a render action.
      return;
    }
    // Quarto calls window.MathJax.typeset() whenever window.MathJax exists,
    // e.g. on a cross-reference hover. Until MathJax loads and replaces this
    // configuration object, that call should do nothing rather than throw.
    if (typeof mj.typeset !== "function") {
      mj.typeset = function () {};
    }
    mj.options = mj.options || {};
    mj.options.renderActions = mj.options.renderActions || {};
    // Priority 25: after "compile" (20) builds math.root, before the output
    // jax draws it ("typeset", 150).
    mj.options.renderActions.rainbowParens = [
      25,
      function (doc) {
        if (!settings().math) {
          return;
        }
        for (var item of doc.math) {
          colorMath(item.root);
        }
      },
      function (math) {
        if (settings().math) {
          colorMath(math.root);
        }
      },
    ];
  }

  /* ---------- code ---------- */

  function skipped(el, code) {
    for (var n = el; n && n !== code; n = n.parentNode) {
      if (n.classList) {
        for (var i = 0; i < SKIP_CLASSES.length; i++) {
          if (n.classList.contains(SKIP_CLASSES[i])) {
            return true;
          }
        }
      }
    }
    return false;
  }

  function colorCode(code) {
    var walker = document.createTreeWalker(code, NodeFilter.SHOW_TEXT);
    var texts = [];
    while (walker.nextNode()) {
      texts.push(walker.currentNode);
    }
    var depth = 0;
    texts.forEach(function (textNode) {
      if (skipped(textNode.parentNode, code) || !/[()[\]{}]/.test(textNode.data)) {
        return;
      }
      var frag = document.createDocumentFragment();
      var buf = "";
      var s = textNode.data;
      for (var i = 0; i < s.length; i++) {
        var ch = s[i];
        var cls = null;
        if (OPEN[ch]) {
          depth += 1;
          cls = levelClass(depth);
        } else if (CLOSE[ch] && depth > 0) {
          cls = levelClass(depth);
          depth -= 1;
        }
        if (cls) {
          if (buf) {
            frag.appendChild(document.createTextNode(buf));
            buf = "";
          }
          var span = document.createElement("span");
          span.className = "rp " + cls;
          span.textContent = ch;
          frag.appendChild(span);
        } else {
          buf += ch;
        }
      }
      if (buf) {
        frag.appendChild(document.createTextNode(buf));
      }
      textNode.parentNode.replaceChild(frag, textNode);
    });
  }

  // Whether a code block is in one of the languages, ignoring case.
  function wanted(code, langs) {
    if (langs.indexOf("*") !== -1) {
      return true;
    }
    for (var i = 0; i < code.classList.length; i++) {
      if (langs.indexOf(code.classList[i].toLowerCase()) !== -1) {
        return true;
      }
    }
    return false;
  }

  function colorAllCode() {
    var langs = settings().code;
    if (!langs.length) {
      return;
    }
    // Only blocks Quarto highlighted (class sourceCode), so plain output
    // blocks, whose brackets need not balance, are left alone; and not the
    // page source that code-tools embeds, which is mostly prose.
    document.querySelectorAll("pre > code.sourceCode").forEach(function (code) {
      if (code.hasAttribute("data-rainbow-parens") ||
          code.closest("#quarto-embedded-source-code-modal") ||
          !wanted(code, langs)) {
        return;
      }
      code.setAttribute("data-rainbow-parens", "");
      colorCode(code);
    });
  }

  /* ---------- dark backgrounds ---------- */

  function luminance(color) {
    var m = color.match(/rgba?\(([^)]+)\)/);
    if (!m) {
      return null;
    }
    var parts = m[1].split(/[\s,/]+/).filter(Boolean).map(Number);
    if (parts.length > 3 && parts[3] === 0) {
      return null;
    }
    var lin = parts.slice(0, 3).map(function (v) {
      v /= 255;
      return v <= 0.04045 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
    });
    return 0.2126 * lin[0] + 0.7152 * lin[1] + 0.0722 * lin[2];
  }

  // The stylesheet switches to the dark palette on Quarto's and the qwt
  // slides' dark classes. A page with a single dark theme has neither, so
  // mark it rp-dark whenever its background is dark.
  function syncDark() {
    var body = document.body;
    if (!body) {
      return;
    }
    var lum = luminance(getComputedStyle(body).backgroundColor);
    if (lum === null) {
      lum = luminance(getComputedStyle(document.documentElement).backgroundColor);
    }
    body.classList.toggle("rp-dark", lum !== null && lum < DARK_LUMINANCE);
  }

  function watchTheme() {
    syncDark();
    // Theme pickers change the class of the body or of the root element.
    var observer = new MutationObserver(syncDark);
    [document.body, document.documentElement].forEach(function (el) {
      observer.observe(el, { attributes: true, attributeFilter: ["class"] });
    });
  }

  function onLoad() {
    colorAllCode();
    watchTheme();
  }

  installMathJax();
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", onLoad);
  } else {
    onLoad();
  }

  // Exposed for tests.
  window.rainbowParens = { colorCode: colorCode, colorMath: colorMath };
})();
