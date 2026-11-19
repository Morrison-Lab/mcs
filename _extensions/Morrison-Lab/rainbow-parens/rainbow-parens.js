/*
 * rainbow-parens: color matching brackets by nesting depth.
 *
 * Depth 1 gets class rp-d1, depth 2 rp-d2, and so on, cycling after
 * rainbow-parens.css's last color (four). An opener and its closer share
 * a depth, whatever their shapes, so the half-open interval [0, 1) pairs
 * its [ with its ). A closer with no opener before it keeps the text color.
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
  var SKIP_CLASSES = ["st", "co", "ch", "sc", "vs", "ss", "do", "an", "cv", "in", "wa"];

  function settings() {
    var meta = document.querySelector('meta[name="rainbow-parens"]');
    if (!meta) {
      return { math: true, code: ["*"] };
    }
    var code = (meta.getAttribute("data-code") || "").split(/\s+/).filter(Boolean);
    return { math: meta.getAttribute("data-math") !== "false", code: code };
  }

  function levelClass(depth) {
    return "rp-d" + (((depth - 1) % LEVELS) + 1);
  }

  /* ---------- math ---------- */

  function addClass(node, cls) {
    var old = node.attributes.get("class");
    node.attributes.set("class", old ? old + " " + cls : cls);
  }

  function colorMath(root) {
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
        if (OPEN[text]) {
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
          if (item.root) {
            colorMath(item.root);
          }
        }
      },
      function (math) {
        if (settings().math && math.root) {
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

  function colorAllCode() {
    var langs = settings().code;
    langs.forEach(function (lang) {
      // "*": every code block Quarto highlighted (class sourceCode), so
      // plain output blocks, whose brackets need not balance, are left alone.
      var sel = lang === "*" ? "pre > code.sourceCode" :
        "pre > code.sourceCode." + CSS.escape(lang);
      document.querySelectorAll(sel).forEach(function (code) {
        if (!code.hasAttribute("data-rainbow-parens")) {
          code.setAttribute("data-rainbow-parens", "");
          colorCode(code);
        }
      });
    });
  }

  installMathJax();
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", colorAllCode);
  } else {
    colorAllCode();
  }

  // Exposed for tests.
  window.rainbowParens = { colorCode: colorCode, colorMath: colorMath };
})();
