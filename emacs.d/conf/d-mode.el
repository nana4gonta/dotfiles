(autoload 'd-mode "d-mode" 
  "Major mode for editing D code." t)
(setq auto-mode-alist (cons '( "\\.d\\'" . d-mode ) auto-mode-alist ))
(autoload 'dlint-minor-mode "dlint" nil t)
(add-hook 'd-mode-hook (lambda () (dlint-minor-mode 1)))