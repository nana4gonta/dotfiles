(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(add-hook 'php-mode-hook
	  (lambda ()
	    (defun ywb-php-lineup-arglist-intro (langelem)
	      (save-excursion
		(goto-char (cdr langelem))
		(vector (+ (current-column) c-basic-offset))))
	    (defun ywb-php-lineup-arglist-close (langelem)
	      (save-excursion
		(goto-char (cdr langelem))
		(vector (current-column))))
	    (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
	    (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)
	    (c-set-offset 'arglist-cont-nonempty' 4) ; 配列のインデント関係
	    (c-set-offset 'case-label' 4) ; case はインデントする
	    (make-local-variable 'tab-width)
	    (make-local-variable 'indent-tabs-mode)
	    (c-set-style "stroustrup")
	    (setq tab-width 4
		  indent-tabs-mode nil)



	    (eval-after-load "php-completion"
	      '(progn
		 (php-completion-mode t)
		 (define-key php-mode-map (kbd "\C-co") 'phpcmp-complete) ;php-completionの補完実行キーバインドの設定
;		 (make-local-variable 'ac-sources)
		 (setq ac-sources '(
				    ac-source-words-in-same-mode-buffers
				    ac-source-php-completion
				    ac-source-filename))

		 ))))
