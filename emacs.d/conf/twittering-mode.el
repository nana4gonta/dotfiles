(add-to-list 'load-path "Gentoo/usr/share/emacs/site-lisp/twittering-mode")
(require 'twittering-mode)

;; 次回からOAuth認証なし
;;(setq twittering-use-master-password t)

;; アイコン表示
(setq twittering-icon-mode t)

;; Twitter APIの残り数を表示
(setq twittering-display-remaining t)