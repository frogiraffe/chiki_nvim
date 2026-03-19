-- Generated LuaSnip config based on Ejmastnak tutorial
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local in_mathzone = function()
  if vim.fn.exists('*vimtex#syntax#in_mathzone') == 1 then
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
  end
  local syn_name = vim.fn.synIDattr(vim.fn.synID(vim.fn.line('.'), math.max(1, vim.fn.col('.') - 1), 1), 'name')
  if string.match(string.lower(syn_name), "math") then
    return true
  end
  local ok, node = pcall(vim.treesitter.get_node)
  if ok and node then
    while node do
      if string.match(node:type(), "math") or node:type() == "inline_formula" or node:type() == "displayed_equation" then
        return true
      end
      node = node:parent()
    end
  end
  return false
end

-- Function to handle visual selection (mapped to <Tab> in user config usually)
local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local in_text = function()
  return not in_mathzone()
end

return {

  -- ===================== SECTION HEADINGS (line_begin only) =====================

  s({trig = "h1", snippetType = "autosnippet", dscr = "Section heading", condition = line_begin},
    fmta(
      [[\section{<>}]],
      { i(1) }
    )
  ),

  s({trig = "h2", snippetType = "autosnippet", dscr = "Subsection heading", condition = line_begin},
    fmta(
      [[\subsection{<>}]],
      { i(1) }
    )
  ),

  s({trig = "h3", snippetType = "autosnippet", dscr = "Subsubsection heading", condition = line_begin},
    fmta(
      [[\subsubsection{<>}]],
      { i(1) }
    )
  ),

  s({trig = "nn", snippetType = "autosnippet", dscr = "New equation environment", condition = line_begin},
    fmta(
      [[
\begin{equation*}
  <>
\end{equation*}
      ]],
      { i(0) }
    )
  ),

  s({trig = "new", snippetType = "autosnippet", dscr = "Generic new environment", condition = line_begin},
    fmta(
      [[
\begin{<>}
  <>
\end{<>}
      ]],
      { i(1), i(0), rep(1) }
    )
  ),

  -- ===================== TEXT FORMATTING (with visual placeholder) =====================

  s({trig = "tii", snippetType = "autosnippet", dscr = "Italic text", wordTrig = false},
    fmta(
      [[\textit{<>}]],
      { d(1, get_visual) }
    )
  ),

  s({trig = "tbb", snippetType = "autosnippet", dscr = "Bold text", wordTrig = false},
    fmta(
      [[\textbf{<>}]],
      { d(1, get_visual) }
    )
  ),

  s({trig = "tuu", snippetType = "autosnippet", dscr = "Underline text", wordTrig = false},
    fmta(
      [[\underline{<>}]],
      { d(1, get_visual) }
    )
  ),

  s({trig = "tee", snippetType = "autosnippet", dscr = "Emphasis text", wordTrig = false},
    fmta(
      [[\emph{<>}]],
      { d(1, get_visual) }
    )
  ),

  -- ===================== MATH MODE ENTRY =====================

  s({trig = "mk", snippetType = "autosnippet", wordTrig = false, condition = nil},
    fmta(
      [[$<>$]],
      {
        i(0)
      }
    )
  ),

  s({trig = "dm", snippetType = "autosnippet", wordTrig = true, condition = nil},
    fmta(
      [[$$\n<>\n$$]],
      {
        i(0)
      }
    )
  ),

  s({trig = "beg", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{<>}\n<>\n\end{<>}]],
      {
        i(0),
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "@a", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\alpha")
  ),

  s({trig = "@b", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\beta")
  ),

  s({trig = "@g", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\gamma")
  ),

  s({trig = "@G", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\Gamma")
  ),

  s({trig = "@d", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\delta")
  ),

  s({trig = "@D", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\Delta")
  ),

  s({trig = "@e", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\epsilon")
  ),

  s({trig = ":e", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\varepsilon")
  ),

  s({trig = "@z", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\zeta")
  ),

  s({trig = "@t", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\theta")
  ),

  s({trig = "@T", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\Theta")
  ),

  s({trig = ":t", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\vartheta")
  ),

  s({trig = "@i", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\iota")
  ),

  s({trig = "@k", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\kappa")
  ),

  s({trig = "@l", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\lambda")
  ),

  s({trig = "@L", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\Lambda")
  ),

  s({trig = "@s", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\sigma")
  ),

  s({trig = "@S", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\Sigma")
  ),

  s({trig = "@u", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\upsilon")
  ),

  s({trig = "@U", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\Upsilon")
  ),

  s({trig = "@o", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\omega")
  ),

  s({trig = "@O", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\Omega")
  ),

  s({trig = "ome", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\omega")
  ),

  s({trig = "Ome", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\Omega")
  ),

  s({trig = "text", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\text{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "\"", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\text{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "sr", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("^{2}")
  ),

  s({trig = "cb", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("^{3}")
  ),

  s({trig = "rd", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[^{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "_", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[_{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "sts", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[_\text{<>}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "sq", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\sqrt{ <> }<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "//", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\frac{<>}{<>}<>]],
      {
        i(1),
        i(2),
        i(0)
      }
    )
  ),

  s({trig = "ee", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[e^{ <> }<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "invs", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("^{-1}")
  ),

  s({trig = "(?<![a-zA-Z])([A-Za-z])(\\d)", priority = -1, snippetType = "autosnippet", dscr = "Auto letter subscript", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[<>_{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "([^\\\\])(exp|log|ln)", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[<>\<>]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "conj", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("^{*}")
  ),

  s({trig = "Re", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mathrm{Re}")
  ),

  s({trig = "Im", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mathrm{Im}")
  ),

  s({trig = "bf", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\mathbf{<>}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "rm", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\mathrm{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "([^\\\\])(det)", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[<>\<>]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "trace", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mathrm{Tr}")
  ),

  s({trig = "([a-zA-Z])hat", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\hat{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "([a-zA-Z])bar", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\bar{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "([a-zA-Z])dot", priority = -1, snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\dot{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "([a-zA-Z])ddot", priority = 1, snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\ddot{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "([a-zA-Z])tilde", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\tilde{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "([a-zA-Z])und", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\underline{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "([a-zA-Z])vec", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\vec{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "([a-zA-Z]),\\.", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\mathbf{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "([a-zA-Z])\\.,", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\mathbf{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega),\\.", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\boldsymbol{\<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega)\\.,", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\boldsymbol{\<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "hat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\hat{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "bar", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\bar{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "dot", priority = -1, snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\dot{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "ddot", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\ddot{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "cdot", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\cdot")
  ),

  s({trig = "tilde", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\tilde{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "und", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\underline{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "vec", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\vec{<>}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "([A-Za-z])_(\\d\\d)", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[<>_{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "\\\\hat{([A-Za-z])}(\\d)", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\hat{<>}_{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "\\\\vec{([A-Za-z])}(\\d)", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\vec{<>}_{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "\\\\mathbf{([A-Za-z])}(\\d)", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\mathbf{<>}_{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "xnn", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("x_{n}")
  ),

  s({trig = "\\xii", priority = 1, snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("x_{i}")
  ),

  s({trig = "xjj", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("x_{j}")
  ),

  s({trig = "xp1", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("x_{n+1}")
  ),

  s({trig = "ynn", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("y_{n}")
  ),

  s({trig = "yii", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("y_{i}")
  ),

  s({trig = "yjj", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("y_{j}")
  ),

  s({trig = "ooo", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\infty")
  ),

  s({trig = "sum", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\sum")
  ),

  s({trig = "prod", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\prod")
  ),

  s({trig = "\\sum", snippetType = "snippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\sum_{<>=<>}^{<>} <>]],
      {
        i(1, "i"),
        i(2, "1"),
        i(3, "N"),
        i(0)
      }
    )
  ),

  s({trig = "\\prod", snippetType = "snippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\prod_{<>=<>}^{<>} <>]],
      {
        i(1, "i"),
        i(2, "1"),
        i(3, "N"),
        i(0)
      }
    )
  ),

  s({trig = "lim", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\lim_{ <> \to <> } <>]],
      {
        i(1, "n"),
        i(2, "\\infty"),
        i(0)
      }
    )
  ),

  s({trig = "+-", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\pm")
  ),

  s({trig = "-+", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mp")
  ),

  s({trig = "...", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\dots")
  ),

  s({trig = "nabl", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\nabla")
  ),

  s({trig = "del", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\nabla")
  ),

  s({trig = "xx", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\times")
  ),

  s({trig = "**", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\cdot")
  ),

  s({trig = "para", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\parallel")
  ),

  s({trig = "===", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\equiv")
  ),

  s({trig = "!=", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\neq")
  ),

  s({trig = ">=", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\geq")
  ),

  s({trig = "<=", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\leq")
  ),

  s({trig = ">>", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\gg")
  ),

  s({trig = "<<", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\ll")
  ),

  s({trig = "simm", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\sim")
  ),

  s({trig = "sim=", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\simeq")
  ),

  s({trig = "prop", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\propto")
  ),

  s({trig = "<->", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\leftrightarrow ")
  ),

  s({trig = "->", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\to")
  ),

  s({trig = "!>", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mapsto")
  ),

  s({trig = "=>", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\implies")
  ),

  s({trig = "=<", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\impliedby")
  ),

  s({trig = "and", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\cap")
  ),

  s({trig = "orr", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\cup")
  ),

  s({trig = "inn", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\in")
  ),

  s({trig = "notin", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\not\\in")
  ),

  s({trig = "\\\\\\", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\setminus")
  ),

  s({trig = "sub=", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\subseteq")
  ),

  s({trig = "sup=", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\supseteq")
  ),

  s({trig = "eset", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\emptyset")
  ),

  s({trig = "set", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\{ <> \}<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "e\\\\xi sts", priority = 1, snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\exists")
  ),

  s({trig = "LL", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mathcal{L}")
  ),

  s({trig = "HH", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mathcal{H}")
  ),

  s({trig = "CC", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mathbb{C}")
  ),

  s({trig = "RR", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mathbb{R}")
  ),

  s({trig = "ZZ", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mathbb{Z}")
  ),

  s({trig = "NN", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\mathbb{N}")
  ),

  s({trig = "([^\\\\])(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega)", snippetType = "autosnippet", dscr = "Add backslash before Greek letters", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[<>\<>]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "([^\\\\])(infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall)", snippetType = "autosnippet", dscr = "Add backslash before symbols", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[<>\<>]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall|ldots|cdots|vdots|ddots|aleph|hbar|ell|wp|Re|Im|partial|infty|prime|emptyset|nabla|surd|top|bot|angle|triangle|backslash|forall|exists|neg|flat|natural|sharp|clubsuit|diamondsuit|heartsuit|spadesuit)([A-Za-z])", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\<> <>]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall) sr", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\<>^{2}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall) cb", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\<>^{3}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall) rd", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\<>^{<>}<>]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(0),
        i(1)
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall) hat", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\hat{\<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall) dot", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\dot{\<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall) bar", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\bar{\<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall) vec", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\vec{\<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall) tilde", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\tilde{\<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\\\(alpha|beta|gamma|Gamma|delta|Delta|epsilon|varepsilon|zeta|eta|theta|Theta|vartheta|iota|kappa|lambda|Lambda|mu|nu|xi|Xi|pi|Pi|rho|sigma|Sigma|tau|upsilon|Upsilon|phi|Phi|varphi|chi|psi|Psi|omega|Omega|infty|sum|prod|lim|pm|mp|dots|nabla|times|cdot|parallel|equiv|neq|geq|leq|gg|ll|sim|simeq|propto|leftrightarrow|to|mapsto|implies|impliedby|cap|cup|in|notin|setminus|subseteq|supseteq|emptyset|exists|forall) und", snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\underline{\<>}]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "par", snippetType = "snippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\frac{ \partial <> }{ \partial <> } <>]],
      {
        i(1, "y"),
        i(2, "x"),
        i(0)
      }
    )
  ),

  s({trig = "pa([A-Za-z])([A-Za-z])", snippetType = "snippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\frac{ \partial <> }{ \partial <> } ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "ddt", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\frac{d}{dt} ")
  ),

  s({trig = "([^\\\\])int", priority = -1, snippetType = "autosnippet", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[<>\int]],
      {
        f( function(_, snip) return snip.captures[1] end )
      }
    )
  ),

  s({trig = "\\int", snippetType = "snippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\int <> \, d<> <>]],
      {
        i(1, "x"),
        i(0),
        i(2)
      }
    )
  ),

  s({trig = "dint", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\int_{<>}^{<>} <> \, d<> <>]],
      {
        i(0, "0"),
        i(1, "1"),
        i(3, "x"),
        i(2),
        i(4)
      }
    )
  ),

  s({trig = "oint", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\oint")
  ),

  s({trig = "iint", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\iint")
  ),

  s({trig = "iiint", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\iiint")
  ),

  s({trig = "oinf", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\int_{0}^{\infty} <> \, d<> <>]],
      {
        i(1, "x"),
        i(0),
        i(2)
      }
    )
  ),

  s({trig = "infi", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\int_{-\infty}^{\infty} <> \, d<> <>]],
      {
        i(1, "x"),
        i(0),
        i(2)
      }
    )
  ),

  s({trig = "([^\\\\])(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)", snippetType = "autosnippet", dscr = "Add backslash before trig funcs", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[<>\<>]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "\\\\(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)([A-Za-gi-z])", snippetType = "autosnippet", dscr = "Add space after trig funcs. Skips letter h to allow sinh, cosh, etc.", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\<> <>]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "\\\\(sinh|cosh|tanh|coth)([A-Za-z])", snippetType = "autosnippet", dscr = "Add space after hyperbolic trig funcs", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    fmta(
      [[\<> <>]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end )
      }
    )
  ),

  s({trig = "U", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\underbrace{ <> }_{ <> }]],
      {
        d(1, get_visual),
        i(0)
      }
    )
  ),

  s({trig = "O", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\overbrace{ <> }^{ <> }]],
      {
        d(1, get_visual),
        i(0)
      }
    )
  ),

  s({trig = "B", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\underset{ <> }{ <> }]],
      {
        d(1, get_visual),
        i(0)
      }
    )
  ),

  s({trig = "C", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\cancel{ <> }]],
      {
        d(1, get_visual)
      }
    )
  ),

  s({trig = "K", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\cancelto{ <> }{ <> }]],
      {
        d(1, get_visual),
        i(0)
      }
    )
  ),

  s({trig = "S", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\sqrt{ <> }]],
      {
        d(1, get_visual)
      }
    )
  ),

  s({trig = "kbt", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("k_{B}T")
  ),

  s({trig = "msun", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("M_{\\odot}")
  ),

  s({trig = "dag", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("^{\\dagger}")
  ),

  s({trig = "o+", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\oplus ")
  ),

  s({trig = "ox", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("\\otimes ")
  ),

  s({trig = "bra", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\bra{<>} <>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "ket", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\ket{<>} <>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "brk", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\braket{ <> | <> } <>]],
      {
        i(1),
        i(2),
        i(0)
      }
    )
  ),

  s({trig = "outer", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\ket{<>} \bra{<>} <>]],
      {
        i(1, "\\psi"),
        i(1, "\\psi"),
        i(0)
      }
    )
  ),

  s({trig = "pu", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\pu{ <> }]],
      {
        i(0)
      }
    )
  ),

  s({trig = "cee", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\ce{ <> }]],
      {
        i(0)
      }
    )
  ),

  s({trig = "he4", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("{}^{4}_{2}He ")
  ),

  s({trig = "he3", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    t("{}^{3}_{2}He ")
  ),

  s({trig = "iso", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[{}^{<>}_{<>}<>]],
      {
        i(1, "4"),
        i(2, "2"),
        i(0, "He")
      }
    )
  ),

  s({trig = "pmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{pmatrix}\n<>\n\end{pmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "bmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{bmatrix}\n<>\n\end{bmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "Bmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{Bmatrix}\n<>\n\end{Bmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "vmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{vmatrix}\n<>\n\end{vmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "Vmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{Vmatrix}\n<>\n\end{Vmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "matrix", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{matrix}\n<>\n\end{matrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "pmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{pmatrix}<>\end{pmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "bmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{bmatrix}<>\end{bmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "Bmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{Bmatrix}<>\end{Bmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "vmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{vmatrix}<>\end{vmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "Vmat", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{Vmatrix}<>\end{Vmatrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "matrix", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{matrix}<>\end{matrix}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "cases", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{cases}\n<>\n\end{cases}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "align", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{align}\n<>\n\end{align}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "array", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\begin{array}\n<>\n\end{array}]],
      {
        i(0)
      }
    )
  ),

  s({trig = "avg", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\langle <> \rangle <>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "norm", priority = 1, snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\lvert <> \rvert <>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "Norm", priority = 1, snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\lVert <> \rVert <>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "ceil", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\lceil <> \rceil <>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "floor", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\lfloor <> \rfloor <>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "mod", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[|<>|<>]],
      {
        i(1),
        i(0)
      }
    )
  ),

  s({trig = "(", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[(<>)]],
      {
        d(1, get_visual)
      }
    )
  ),

  s({trig = "[", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      "[[<>]]",
      {
        d(1, get_visual)
      }
    )
  ),

  s({trig = "{", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[{<>}]],
      {
        d(1, get_visual)
      }
    )
  ),

  s({trig = "(", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[(<>)<>]],
      {
        i(0),
        i(1)
      }
    )
  ),

  s({trig = "{", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[{<>}<>]],
      {
        i(0),
        i(1)
      }
    )
  ),

  s({trig = "[", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[[<>]<>]],
      {
        i(0),
        i(1)
      }
    )
  ),

  s({trig = "lr(", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\left( <> \right) <>]],
      {
        i(0),
        i(1)
      }
    )
  ),

  s({trig = "lr{", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\left\{ <> \right\} <>]],
      {
        i(0),
        i(1)
      }
    )
  ),

  s({trig = "lr[", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\left[ <> \right] <>]],
      {
        i(0),
        i(1)
      }
    )
  ),

  s({trig = "lr|", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\left| <> \right| <>]],
      {
        i(0),
        i(1)
      }
    )
  ),

  s({trig = "lra", snippetType = "autosnippet", wordTrig = false, condition = in_mathzone},
    fmta(
      [[\left<< <> \right>> <>]],
      {
        i(0),
        i(1)
      }
    )
  ),

  s({trig = "tayl", snippetType = "autosnippet", dscr = "Taylor expansion", wordTrig = false, condition = in_mathzone},
    fmta(
      [[<>(<> + <>) = <>(<>) + <>'(<>)<> + <>''(<>) \frac{<>^{2}}{2!} + \dots<>]],
      {
        i(0, "f"),
        i(1, "x"),
        i(2, "h"),
        i(0, "f"),
        i(1, "x"),
        i(0, "f"),
        i(1, "x"),
        i(2, "h"),
        i(0, "f"),
        i(1, "x"),
        i(2, "h"),
        i(3)
      }
    )
  ),

  s({trig = "iden(\\d)", snippetType = "autosnippet", dscr = "N x N identity matrix", wordTrig = false, regTrig = true, trigEngine = "ecma", hidden = true, condition = in_mathzone},
    d(1, function(_, snip)
            local match = snip.captures[1]
            local n = tonumber(match)
            if not n then return sn(nil, i(1)) end
            local arr = {}
            for j=1,n do
                arr[j] = {}
                for k=1,n do
                    arr[j][k] = (j == k) and "1" or "0"
                end
            end
            local rows = {}
            for j=1,n do
                table.insert(rows, table.concat(arr[j], " & "))
            end
            local content = "\\begin{pmatrix}\n" .. table.concat(rows, " \\\\\n") .. "\n\\end{pmatrix}"
            -- split content by new line for text_node
            local lines = {}
            for line in content:gmatch("[^\r\n]+") do
                table.insert(lines, line)
            end
            return sn(nil, t(lines))
        end)
  ),

}
