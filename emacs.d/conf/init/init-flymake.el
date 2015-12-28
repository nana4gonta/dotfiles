(require 'flymake)
(eval-after-load "flymake"
'(progn
   ;; GUIの警告は表示しない
   (setq flymake-gui-warnings-enabled nil)

   (setq flymake-run-in-place nil)
   (setq temporary-file-directory "~/.emacs.d/tmp/")))
