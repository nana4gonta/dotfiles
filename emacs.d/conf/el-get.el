(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(setq
 el-get-dir (concat user-emacs-directory "el-get")
 el-get-emacswiki-base-url "http://raw.github.com/emacsmirror/emacswiki.org/master/"
 el-get-verbose t
 el-get-user-package-directory (concat user-emacs-directory "conf/init"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path (concat user-emacs-directory "recipes"))
(el-get 'sync
	'(el-get
	  solarized-theme	  
	  powerline
	  popwin
	  yasnippet
	  helm
	  helm-descbinds
	  helm-migemo
	  migemo
	  auto-complete
	  foreign-regexp
	  direx
	  multi-term
	  fold-dwim
	  switch-window
	  esh-myparser
	  org-mode
	  htmlize
	  flymake-easy
	  twittering-mode
	  ;; C#
	  csharp-mode
	  ;; Coq
	  ProofGeneral
	  ;; Python
	  ac-python
	  ;; Javascript
	  js2-mode
	  flymake-jshint
	  js2-refactor
	  ;; TypeScript
	  tss
	  ;; JSON
	  json-reformat
	  json-mode
	  ;; D-Lang
	  d-mode
	  ;; Ruby
	  ruby-mode
	  ;; rdoc-mode
	  inf-ruby
	  ruby-block
	  ruby-electric
	  ruby-style
	  ;; rubydb2x
	  ;; rubydb3x
	  ;; smart-compile
	  rcodetools
	  helm-rcodetools
	  auto-complete-ruby
	  ;; Haskell
	  haskell-mode
	  ghc-mod
	  ;; Scala
	  ;; scala-mode
	  ;; Markdown
	  markdown-mode
	  ;; Ocaml
	  ;; ocaml-mode
	  ;; Erlang
	  ;; erlang
	  ;; yatex
	  ;; Sass, SCSS
	  sass-mode
	  scss-mode
	  ;; PHP
	  php-mode
	  php-completion
	  ;; Web-mode
	  web-mode
	  ))
