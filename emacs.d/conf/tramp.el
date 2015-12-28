;; tramp
(add-to-list 'load-path "~/.emacs.d/el-get/tramp")
(require 'tramp)
(setq-default tramp-default-method "sshx")
(setq tramp-auto-save-directory "~/.emacs.d/tmp")
(add-to-list 'backup-directory-alist
	     (cons tramp-file-name-regexp nil)) ; 自動でバックアップファイルをつくらない

(defadvice tramp-handle-vc-registered (around tramp-handle-vc-registered-around activate)
  (let ((vc-handled-backends '(SVN Git))) ad-do-it))
