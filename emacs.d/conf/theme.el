(add-to-list 'custom-theme-load-path (concat user-emacs-directory "el-get/solarized-theme"))
(if window-system
  (load-theme 'solarized-light t))
