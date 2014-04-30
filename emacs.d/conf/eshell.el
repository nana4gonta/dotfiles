; https://github.com/masaaki1001/.emacs.d/blob/master/config/init-eshell.el
(eval-after-load 'esh-myparser
  '(progn
     (defun eshell-parser/b (str) (eshell-parser/b str "bash"))
  ))

;; eshellでの実行をbashなどのシェルを利用するように変更
(progn
  (defmacro eval-after-load* (name &rest body)
    (declare (indent 1))
    `(eval-after-load ,name '(progn ,@body)))
  (defun eshell-disable-unix-command-emulation ()
    (eval-after-load* "em-ls"
      (fmakunbound 'eshell/ls))
    (eval-after-load* "em-unix"
      (mapc 'fmakunbound '(eshell/agrep
                           eshell/basename
                           eshell/cat
                           eshell/cp
                           eshell/date
                           eshell/diff
                           eshell/dirname
                           eshell/du
                           eshell/egrep
                           eshell/fgrep
                           eshell/glimpse
                           eshell/grep
                           eshell/info
                           eshell/ln
                           eshell/locate
                           eshell/make
                           eshell/man
                           eshell/mkdir
                           eshell/mv
                           eshell/occur
                           eshell/rm
                           eshell/rmdir
                           eshell/su
                           eshell/sudo
                           eshell/git
                           eshell/time
                           eshell/rake
                           eshell/rspec))))
  (eshell-disable-unix-command-emulation))

;; キーバインドをshellらしくする
(progn
  (defun eshell-in-command-line-p ()
    (<= eshell-last-output-end (point)))
  (defmacro defun-eshell-cmdline (key &rest body)
    (let ((cmd (intern (format "eshell-cmdline/%s" key))))
      `(progn
         (add-hook 'eshell-mode-hook
                   (lambda () (define-key eshell-mode-map
                                (read-kbd-macro ,key) ',cmd)))
         (defun ,cmd ()
           (interactive)
           (if (not (eshell-in-command-line-p))
               (call-interactively (lookup-key (current-global-map)
                                               (read-kbd-macro ,key)))
             ,@body)))))
  (defun eshell-history-and-bol (func)
    (delete-region eshell-last-output-end (point-max))
    (funcall func 1)
    (goto-char eshell-last-output-end)))
;; 前のコマンドの履歴取得
(defun-eshell-cmdline "C-p"
  (let ((last-command 'eshell-previous-matching-input-from-input))
    (eshell-history-and-bol 'eshell-previous-matching-input-from-input)))
;; 次のコマンドの履歴取得
(defun-eshell-cmdline "C-n"
  (let ((last-command 'eshell-previous-matching-input-from-input))
    (eshell-history-and-bol 'eshell-next-input)))
;; 直前の履歴を取得
(defadvice eshell-send-input (after history-position activate)
  (setq eshell-history-index -1))

; http://d.hatena.ne.jp/a666666/20110222/1298345699
;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))
;; 補完時にサイクルする
;(setq eshell-cmpl-cycle-completions t)
(setq eshell-cmpl-cycle-completions nil)
;;補完候補がこの数値以下だとサイクルせずに候補表示
;(setq eshell-cmpl-cycle-cutoff-length 5)
;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)
;; prompt 文字列の変更
(setq eshell-prompt-function
      (lambda ()
        (concat "[kyanny@kyanny-laptop2 "
                (eshell/pwd)
                (if (= (user-uid) 0) "]\n# " "]\n$ ")
                )))
;; 変更した prompt 文字列に合う形で prompt の初まりを指定 (C-a で"$ "の次にカーソルがくるようにする)
;; これの設定を上手くしとかないとタブ補完も効かなくなるっぽい
(setq eshell-prompt-regexp "^[^#$]*[$#] ")
;; キーバインドの変更
(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map "\C-a" 'eshell-bol)
;               (yas/minor-mode -1)      ; yasnippet マイナーモードだと eshell-cmpl-cycle-completions がバグるのでオフる。 C-u - M-x yas/minor-mode と等価。
               (define-key eshell-mode-map [up] 'previous-line)
               (define-key eshell-mode-map [down] 'next-line)
               ;(define-key eshell-mode-map [(meta return)] 'ns-toggle-fullscreen)
               (define-key eshell-mode-map [(meta return)] (select-toggle-fullscreen))
               )
             ))
(define-key global-map (kbd "C-z") 'eshell)
;; エスケープシーケンスを処理
;; http://d.hatena.ne.jp/hiboma/20061031/1162277851
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'eshell-load-hook 'ansi-color-for-comint-mode-on)
;; http://www.emacswiki.org/emacs-ja/EshellColor
(require 'ansi-color)
(require 'eshell)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
                              eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)
