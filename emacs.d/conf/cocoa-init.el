;; 日本語環境
(set-language-environment 'Japanese)

;; UTF8
(when (memq 'utf-8 coding-system-list)
(prefer-coding-system 'utf-8-unix)
(setenv "LANG" "ja_JP.UTF-8"))
	    
;; 常に新規ファイルは utf-8-unix を使いたい
(when (memq 'utf-8 coding-system-list)
  (setq-default buffer-file-coding-system 'utf-8-unix))

;; 起動時は必ずUSモード
(add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)

;; Macでマウスで選択範囲をコピー
(setq mouse-drag-copy-region t)

;; Emacs休止
(global-set-key (kbd "C-x C-c") 'ns-do-hide-emacs)


;; Option/Command キー を Super/Meta に割当
(setq ns-command-modifier 'meta)
(setq ns-alternate-modifier 'super)
	      
;; システムへ修飾キーを渡さない設定
(setq mac-pass-control-to-system nil)
(setq mac-pass-command-to-system nil)
(setq mac-pass-option-to-system nil)

;; Emacs上にファイルをドラッグ＆ドロップして開く
(define-key global-map [ns-drag-file] 'ns-find-file)

;; ドラッグ＆ドロップで新しくウィンドウを開かない
(setq ns-pop-up-frames nil)

;; Google IME
(setq default-input-method "MacOSX")
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `title "ぐ")
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `cursor-type `box)
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `cursor-color "magenta")
