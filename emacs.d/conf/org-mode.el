(require 'org-install)
;; キーバインドの設定
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-remember)


(setq org-startup-truncated nil)

(setq org-return-follows-link t)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(org-remember-insinuate)

;; org-default-notes-fileのディレクトリ
(setq org-directory "~/org/")

;; org-default-notes-fileのファイル名
(setq org-default-notes-file (concat org-directory "note.org"))

;; org-rememberのテンプレート
(setq org-remember-templates
      '(("Note" ?n "* %?\n  %i\n  %a" nil "Tasks")
	("Todo" ?t "* TODO %?\n  %i\n  %a" nil "Tasks")))


;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)

;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)
