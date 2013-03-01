(add-to-list 'custom-theme-load-path (concat user-emacs-directory "el-get/color-theme-solarized"))
(if window-system
  (load-theme 'solarized-light t))

