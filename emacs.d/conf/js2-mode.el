(add-to-list 'auto-mode-alist '("\\.\\(js\\|js.erb\\)\\'" . js2-mode))
(add-hook 'js2-mode-hook
          #'(lambda ()
              (require 'js)
              (setq js2-basic-offset 2
                    indent-tabs-mode nil)
              (define-key js2-mode-map (kbd "C-m") 'newline-and-indent)
              (define-key js2-mode-map (kbd "<return>") 'newline-and-indent)

	      (require 'node-ac-mode)
	      (local-set-key (kbd "C-.") 'node-ac-auto-complete)
	      (local-set-key (kbd "C-c C-d") 'node-ac-show-document)
	      (local-set-key (kbd "C-c C-j") 'node-ac-jump-to-definition)
              ))
