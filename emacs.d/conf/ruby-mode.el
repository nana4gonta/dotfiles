(require 'ruby-electric)
(require 'cl)
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda () (inf-ruby-keys)))

(add-hook 'ruby-mode-hook 
	  '(lambda () 
	     ;; ruby-electric.el
	     (ruby-electric-mode t)
	     (setq ruby-electric-expand-delimiters-list nil)
	     
	     ;; ruby-block.el
	     (require 'ruby-block)
	     (ruby-block-mode t)
	     (setq ruby-block-highlight-toggle t)
 
	     ;; rubydb
	     (autoload 'rubydb "rubydb3x"
	       "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

	     ;; auto-complete-ruby
	     (require 'auto-complete-ruby)
	     (make-local-variable 'ac-omni-completion-sources)
	     (setq ac-omni-completion-sources '(("\\.\\=" . (ac-source-rcodetools))))
	     ))
 
;; flymake-ruby
(require 'flymake)
(defun flymake-ruby-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "ruby-lint" (list local-file))))
 
(defconst flymake-allowed-ruby-file-name-masks
  '(("\.rb$" flymake-ruby-init)
    ("^Rakefile$" flymake-ruby-init)))
(defvar flymake-ruby-err-line-patterns
  '(("^\(.*\): .+: line \([0-9]+\), .+: \(.*\)$" 1 2 nil 3)))
; /tmp/a.rb: error: line 5, column 15: undefined local variable or method a
 
(defun flymake-ruby-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks
        (append flymake-allowed-file-name-masks flymake-allowed-ruby-file-name-masks))
  (setq flymake-err-line-patterns flymake-ruby-err-line-patterns)
  (flymake-mode t))
 
;(add-hook 'ruby-mode-hook '(lambda () (flymake-ruby-load)))
(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; rhtmlファイルではflymakeしない
    (if (not (null buffer-file-name)) (flymake-ruby-load))
    ))


;; (require 'flymake)
;; (defun flymake-ruby-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;; 	 (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "ruby" (list "-c" local-file))))

;; (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
;; (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

;; (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

;; (add-hook 'ruby-mode-hook
;;           '(lambda ()

;; 	     ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
;; 	     (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
;; 		 (flymake-mode))
;; 	     ))

;; (defun credmp/flymake-display-err-minibuf () 
;;   "Displays the error/warning for the current line in the minibuffer"
;;   (interactive)
;;   (let* ((line-no             (flymake-current-line-no))
;;          (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (count               (length line-err-info-list))
;;          )
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;;                (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;                (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;;           (message "[%s] %s" line text)
;;           )
;;         )
;;       (setq count (1- count)))))

;; (add-hook
;;  'ruby-mode-hook
;;  '(lambda ()
;;     (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)))

;; Smart Compile
;; (require 'smart-compile)
;; (define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
;; (define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))

;; helm-rcodetools
(require 'helm-rcodetools)

;; xmpfilter
(require 'rcodetools)
(define-key ruby-mode-map (kbd "C-c C-d") 'xmp)
