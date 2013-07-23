;; Helm
(require 'helm-config)

;; popwin連携
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)

;; yasnippet helm interface
(eval-after-load "helm-config"
  '(progn
     (eval-after-load "helm"
       '(progn
	  (helm-mode 1)
	  (require 'helm-descbinds)
;;	  (require 'helm-migemo)
;;	  (setq helm-use-migemo t)
;;	  (define-key global-map [(control ?:)] 'helm-migemo)

	  ;; keybinding
	  (global-set-key (kbd "C-c h") 'helm-mini)
	  (global-set-key (kbd "C-x C-r") 'helm-recentf)
	  (global-set-key (kbd "C-x C-i") 'helm-imenu)
	  
	  ;;(global-set-key (kbd "C-x C-c") 'helm-M-x)
	  (global-set-key (kbd "C-M-s") 'helm-occur)
	  (global-set-key (kbd "C-x b") 'helm-buffers-list)
	  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
     
	  ;; 自動補完を無効
	  (custom-set-variables '(helm-ff-auto-update-initial-value nil))
	  ;; C-hでバックスペースと同じように文字を削除  
	  (define-key helm-map (kbd "C-h") 'delete-backward-char)
	  ;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
	  (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
	  ))

     (eval-after-load "yasnippet"
       '(progn
	  (defun my-yas/prompt (prompt choices &optional display-fn)
	    (let* ((names (loop for choice in choices
				collect (or (and display-fn (funcall display-fn choice))
					    choice)))
		   (selected (helm-other-buffer
			      `(((name . ,(format "%s" prompt))
				 (candidates . names)
				 (action . (("Insert snippet" . (lambda (arg) arg))))))
			      "*helm yas/prompt*")))
	      (if selected
		  (let ((n (position selected names :test 'equal)))
		    (nth n choices))
		(signal 'quit "user quit!"))))
	  (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
	  (define-key helm-command-map (kbd "y") 'yas/insert-snippet)))))
