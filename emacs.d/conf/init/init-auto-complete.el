; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")
(global-auto-complete-mode t)
(ac-config-default)
(defvar ac-dir (expand-file-name "~/.emacs.d/el-get/auto-complete"))
(add-to-list 'load-path ac-dir)
(add-to-list 'load-path (concat ac-dir "/lib/ert"))
(add-to-list 'load-path (concat ac-dir "/lib/fuzzy"))
(add-to-list 'load-path (concat ac-dir "/lib/popup"))

(defvar my-ac-sources
              '(ac-source-yasnippet
                ac-source-abbrev
                ac-source-dictionary
                ac-source-words-in-same-mode-buffers))

(add-to-list 'ac-modes 'ruby-mode)
(add-to-list 'ac-modes 'python-mode)
(add-to-list 'ac-modes 'haskell-mode)
(add-to-list 'ac-modes 'js2-mode)

;;; C-n / C-p で選択
(setq ac-use-menu-map t)

;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
(eval-after-load "yasnippet"
  '(progn
     (eval-when-compile (require 'cl))
     (setf (symbol-function 'yas-active-keys)
	   (lambda ()
	     (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))))

;;; M-/ で補完中でも中止
(define-key ac-completing-map "\M-/" 'ac-stop)

;;; RET は改行
(define-key ac-completing-map "\r" nil)

;;; endは補完中止
(add-hook 'ruby-mode-hook
          (lambda ()
            (make-local-variable 'ac-ignores)
            (add-to-list 'ac-ignores "end")))
