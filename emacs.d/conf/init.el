;; スクロールバーの表示を消す
(toggle-scroll-bar nil)

;; スタートアップページを表示しない
(setq inhibit-startup-message t)

;; かな漢字変換入力モードでSpaceを押したとき、半角空白が挿入されるようにする。
(setq anthy-wide-space " ")
; 全角半角キーで日本語切り替え
(global-set-key [zenkaku-hankaku] 'toggle-input-method)

;; C-hをバックスペースに
(global-set-key "\C-h" 'delete-backward-char)

;; ファイルを開いているバッファの左に行番号を5桁で表示する
(global-linum-mode t)
(setq linum-format "%4d ")

;;終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;スクリプトを保存するとき、chmod+xをする。
(add-hook 'after-save-hook
    'executable-make-buffer-file-executable-if-script-p)

;;カッコ対応をハイライト表示
(show-paren-mode t)

;;; cursor の blink を止める
(blink-cursor-mode nil)

;; 文字の色つけ
(global-font-lock-mode t)

;; 表示の行間を拡げる
(setq line-spacing 2)

;; 一行が 80 字以上になった時には自動改行する
(setq fill-column 80)
(setq text-mode-hook 'turn-on-auto-fill)
(setq major-mode 'text-mode)

;; ステータスラインに時間を表示する
(display-time)

;; visible-bell
(setq visible-bell t)

;; 行番号を表示する
(line-number-mode t)

;; 選択範囲に色を付ける
(transient-mark-mode 1)

;; M-x exit で emacs終了
(defalias 'exit 'save-buffers-kill-emacs)

;; ツールバーを表示しない
(tool-bar-mode nil)

;; スクロールバーを表示しない
(set-scroll-bar-mode nil)

;;yankした文字列をハイライト表示する
(when (or window-system (eq emacs-major-version '21))
  (defadvice yank (after ys:highlight-string activate)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.5)
      (delete-overlay ol)))
  (defadvice yank-pop (after ys:highlight-string activate)
    (when (eq last-command 'yank)
      (let ((ol (make-overlay (mark t) (point))))
        (overlay-put ol 'face 'highlight)
        (sit-for 0.5)
        (delete-overlay ol)))))


;; cua-mode
(cua-mode t)
;;; C-xが切り取りになるのを解除
(setq cua-enable-cua-keys nil)

;; バックアップファイル(末尾が~のファイル)を生成しない
(setq make-backup-files nil)

;; eamcsclient
(require 'server)
(unless (server-running-p)
(server-start))
