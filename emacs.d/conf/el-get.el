(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(setq
 el-get-dir (concat user-emacs-directory "el-get")
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
	  color-theme-solarized	  
	  powerline
	  popwin
	  yasnippet
	  helm
	  auto-complete
	  foreign-regexp
	  direx
	  multi-term
	  fold-dwim
	  switch-window
	  htmlize
	  ac-python
	  ProofGeneral
	  gjslint
	  d-mode
	  typescript
	  ruby-mode
	  ;; rdoc-mode
	  inf-ruby
	  ruby-block
	  ruby-electric
	  ;; ruby-style
	  ;; rubydb2x
	  ;; rubydb3x
	  ;; smart-compile
	  rcodetools
	  helm-rcodetools
	  auto-complete-ruby
	  haskell-mode
	  ;; haskell-c
	  ;; hashkell-cabal
	  ;; haskell-decl-scan
	  ;; haskell-doc
	  ;; haskell-font-lock
	  ;; haskell-ghc
	  ;; haskell-indent
	  ;; haskell-indentation
	  ;; haskell-simple-indent
	  ;; haskell-site-file
	  ;; inf-haskell
	  ;; yatex
	  ))
